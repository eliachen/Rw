Imports Microsoft.Reporting.WebForms
Imports Rw.RwEntityData
Imports System.Data.Linq
Imports System.Globalization
Imports Rw.EntityData

Namespace Rep.Water
    Public Class RepWater
        Private Property Rep As ReportViewer
        Private Property Cig As RepWaterConfig

        Sub New(ByRef _Rep As ReportViewer, ByVal _Cig As RepWaterConfig)
            Me.Rep = _Rep
            Me.Cig = _Cig
        End Sub

        Private Sub SetData(ByVal DataSetName As String, ByVal Dt As DataTable)
            Dim rds As New ReportDataSource(DataSetName, Dt)
            Me.Rep.LocalReport.DataSources.Clear()
            Me.Rep.LocalReport.DataSources.Add(rds)
            Me.Rep.LocalReport.Refresh()
        End Sub

        Public Sub DoData()
            Select Case Me.Cig.WaterShType
                Case RepWaterConfig.SearchWaterType.time0 '时段水位
                    SetData("Dt", GetTime0Data(Cig.TimePars(0), Cig.TimePars(1)))
                Case RepWaterConfig.SearchWaterType.day_EveHour '日逐时水位
                    SetData("Dt", Getday_EveHour(Cig.TimePars(0)))
                Case RepWaterConfig.SearchWaterType.month_EveDay
                    SetData("Dt", Getmonth_EveDay(Cig.TimePars(0)))
                Case RepWaterConfig.SearchWaterType.year_EveMonth
                    SetData("Dt", Getyear_EveMonth(Cig.TimePars(0).Year))
                Case RepWaterConfig.SearchWaterType.q_time0
                    SetData("Dt", Get_q_time0())
                Case RepWaterConfig.SearchWaterType.wth_time0
                    SetData("Dt", Getwth_time0(Cig.TimePars(0), Cig.TimePars(1)))
            End Select
        End Sub

        '时段水位表
        Private Function GetTime0Data(ByVal st As Date, ByVal et As Date) As DataTable
            Dim dt As DataTable = New DataSetWater.WaterTime0DataTable
            If Me.Cig.RepShType = RepWaterConfig.RepType.pic Then
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Pic\PicWaterTime0.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Model\ReportWaterTime0.rdlc"
            End If


            '设置标题
            Dim title As String = st.ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "至" & _
                                  et.ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "水位"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            Using db As New DataRwDataContext
                Dim Rel = From s2 In (From s1 In Cig.STCDs
                                         Where Not String.IsNullOrEmpty(s1)
                                                    Group Join p In db.ST_RSVR_R On s1.Trim Equals p.STCD.Trim
                                                                             Into Grps = Group
                                                                        Select stcd = s1, grp = Grps)
                                       Let R = IIf(s2.grp.Count = 0, _
                                                  New With {.STCD = s2.stcd, .RZAVG = Nothing, .RZMAX = Nothing, .RZMIN = Nothing}, _
                                                      Function()
                                                          Dim r = Aggregate q In s2.grp
                                                                        Where q.TM >= st And q.TM <= et
                                                                                            Into avg = Average(q.RZ), _
                                                                                                 max = Max(q.RZ), _
                                                                                                 min = Min(q.RZ)
                                                          'Return New With {.STCD = s2.stcd, .RZAVG = exNumberStr(r.avg), .RZMAX = exNumberStr(r.max), .RZMIN = exNumberStr(r.min)}
                                                          Return New With {.STCD = s2.stcd, .RZAVG = r.avg, .RZMAX = r.max, .RZMIN = r.min}
                                                      End Function())
                                                                   Select R
                                           Group Join p2 In db.ST_STBPRP_B On p2.STCD Equals R.STCD
                                               Into STNMGrps = Group
                                                From q In STNMGrps.DefaultIfEmpty
                                                           Select d = R, n = q.STNM

                For Each ea In Rel
                    Dim tmpRow As DataSetWater.WaterTime0Row = dt.NewRow
                    tmpRow.STCD = ea.d.STCD
                    tmpRow.STNM = ea.n
                    tmpRow.RZAVG = ea.d.RZAVG
                    tmpRow.RZMAX = ea.d.RZMAX
                    tmpRow.RZMIN = ea.d.RZMIN
                    dt.Rows.Add(tmpRow)
                Next

                'For index = 0 To 10
                '    Dim tmpRow As DataSetWater.WaterTime0Row = dt.NewRow
                '    tmpRow.STNM = index.ToString
                '    tmpRow.RZAVG = index + 2
                '    tmpRow.RZMAX = index + 10
                '    tmpRow.RZMIN = 1
                '    dt.Rows.Add(tmpRow)
                'Next

            End Using

            Return dt
        End Function

        '日逐时水位
        Private Function Getday_EveHour(ByVal t As Date) As DataTable

            If Me.Cig.RepShType = RepWaterConfig.RepType.pic Then
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Pic\PicWaterDayEveHour.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Model\ReportWaterDayEveHour.rdlc"
            End If

            Dim stnm As String = Rw.EntityData.ST_STBPRP_B.getSTNM(Cig.STCDs(0))

            Dim title As String = stnm & "(" & Cig.STCDs(0) & ")" & t.ToString("yyyy-MM-dd", DateTimeFormatInfo.InvariantInfo) & "逐时水位"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            '收到的事件参数
            ' Dim RecvT As Date = Date.Parse(Cig.TimePars(0)).Date
            Dim TimeList As New List(Of Date)

            For index = 8 To 23
                With t
                    TimeList.Add(New Date(.Year, .Month, .Day, index, 0, 0))
                End With
            Next

            For index = 0 To 7
                With t
                    TimeList.Add(New Date(.Year, .Month, .Day, index, 0, 0))
                End With
            Next

            Using db As New Rw.EntityData.DataRwDataContext
                Dim rel = From s2 In TimeList
                            Group Join p In (From s1 In db.ST_RSVR_R
                                             Where s1.STCD = Cig.STCDs(0) And s1.TM.Date = t.Date
                                              Select s1) On s2.Hour Equals p.TM.Hour
                                          Into Grp = Group
                                              Select IIf(Grp.Count = 0, New With {.h = s2.Hour, .d = Nothing}, New With {.h = s2.Hour, .d = Grp.FirstOrDefault})


                Dim dt As DataTable = New DataSetWater.WaterDayEveHourDataTable
                For Each ea In rel
                    Dim tmpR As DataSetWater.WaterDayEveHourRow = dt.NewRow
                    tmpR.STCD = Cig.STCDs(0)
                    tmpR.STNM = stnm
                    tmpR.HOUR = Math.Round(ea.h, 0)
                    If ea.d IsNot Nothing Then
                        tmpR.RZ = ea.d.RZ
                    End If

                    dt.Rows.Add(tmpR)
                Next
                Return dt
            End Using
        End Function

        '月逐日平均水位
        Private Function Getmonth_EveDay(ByVal _t As Date) As DataTable
            Dim dt As DataTable = New DataSetWater.WaterMonthEveDayDataTable
            If Me.Cig.RepShType = RepWaterConfig.RepType.pic Then
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Pic\PicWaterMonthEveDay.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Model\ReportWaterMonthEveDay.rdlc"
            End If

            '获取测站名称
            Dim Stnm As String = Rw.EntityData.ST_STBPRP_B.getSTNM(Cig.STCDs(0))


            Dim title As String = Stnm & "(" & Cig.STCDs(0) & ")" & "于" & Cig.TimePars(0).ToString("yyyy-MM", DateTimeFormatInfo.InvariantInfo) & "逐日水位"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            '收到的事件参数
            'Dim RecvT As Date = Date.Parse(Cig.TimePars(0)).Date

            Dim TimeList As New List(Of Date)

            For index = 1 To Date.DaysInMonth(_t.Year, _t.Month)
                TimeList.Add(New Date(_t.Year, _t.Month, index, 0, 0, 0))
            Next

            Using db As New Rw.EntityData.DataRwDataContext

                Dim rel = From s2 In TimeList
                             Group Join p In
                                (From s1 In db.ST_RSVR_R
                                    Where (s1.TM.Year = _t.Year And s1.TM.Month = _t.Month) _
                                             And s1.STCD = Cig.STCDs(0)
                                    Let t = New Date(s1.TM.Year, s1.TM.Month, s1.TM.Day, 0, 0, 0)
                                      Select t, d = s1) On p.t Equals s2
                                            Into Grp = Group
                                                     Select r = IIf(Grp.Count = 0, _
                                                                     Function()
                                                                         Return New With {.stcd = Cig.STCDs(0), .day = s2.Day, .rzavg = 0, .rzmax = 0, .rzmin = 0}
                                                                     End Function(), Function()

                                                                                         Return New With {.stcd = Cig.STCDs(0), _
                                                                                                          .day = s2.Day, _
                                                                                                          .rzavg = Grp.Average(Function(s)
                                                                                                                                   Return s.d.RZ
                                                                                                                               End Function), _
                                                                                                         .rzmax = Grp.Max(Function(s)
                                                                                                                              Return s.d.RZ
                                                                                                                          End Function), _
                                                                                                         .rzmin = Grp.Min(Function(s)
                                                                                                                              Return s.d.RZ
                                                                                                                          End Function)
                                                                                                                           }
                                                                                     End Function())




                For Each ea In rel
                    Dim tmpR As DataSetWater.WaterMonthEveDayRow = dt.NewRow
                    tmpR.STCD = ea.stcd
                    tmpR.STNM = Stnm
                    tmpR.DAY = ea.day.ToString & "号"
                    tmpR.RZAVG = Math.Round(ea.rzavg, 2)
                    tmpR.RZMAX = Math.Round(ea.rzmax, 2)
                    tmpR.RZMIN = Math.Round(ea.rzmin, 2)
                    dt.Rows.Add(tmpR)
                Next

            End Using

            Return dt
        End Function

        '年逐月平均水位
        Private Function Getyear_EveMonth(ByVal y As Integer) As DataTable

            Using dt As DataTable = New DataSetWater.WaterYearEveMonthDataTable

                Dim Stnm As String = Rw.EntityData.ST_STBPRP_B.getSTNM(Cig.STCDs(0))

                If Me.Cig.RepShType = RepWaterConfig.RepType.pic Then
                    Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Pic\PicWaterYearEveMonth.rdlc"
                Else
                    Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Model\ReportWaterYearEveMonth.rdlc"
                End If

                Dim title As String = Stnm & "(" & Cig.STCDs(0) & ")" & "于" & Cig.TimePars(0).ToString("yyyy", DateTimeFormatInfo.InvariantInfo) & "年" & "逐月平均水位"
                Dim rp As New ReportParameter("RepPar_Title", title)


                Dim TimerList As New List(Of Date)

                For index = 1 To 12
                    TimerList.Add(New Date(y, index, 1))
                Next


                Using db As New DataRwDataContext

                    Dim Rel = From s2 In TimerList
                                 Group Join q In
                                    (From s1 In db.ST_RSVR_R
                                         Where s1.TM.Year = y And s1.STCD = Cig.STCDs(0)
                                            Select s1) On s2.Month Equals q.TM.Month
                                        Into Grp = Group
                             Select r = IIf(Grp.Count = 0, Function()
                                                               Return New With {.month = s2.Month, .r = New With {.min = New With {.tm = Nothing, .rz = Nothing}, .max = New With {.tm = Nothing, .rz = Nothing}}, _
                                                                                                .rzavg = Nothing}
                                                           End Function(), Function()
                                                                               Dim tmpRel = From k In Grp
                                                                                              Order By k.RZ
                                                                                                  Select tm = k.TM, rz = k.RZ
                                                                               Return New With {.month = s2.Month, .r = New With {.min = tmpRel.FirstOrDefault, .max = tmpRel.LastOrDefault}, _
                                                                                                .rzavg = Grp.Average(Function(s)
                                                                                                                         Return s.RZ
                                                                                                                     End Function)}
                                                                           End Function())



                    For Each ea In Rel
                        Dim tmpRow As DataSetWater.WaterYearEveMonthRow = dt.NewRow
                        tmpRow.STCD = Cig.STCDs(0)
                        tmpRow.STNM = Stnm
                        tmpRow.MONTH = ea.month & "月"
                        tmpRow.RZAVG = Math.Round(ea.rzavg, 2)
                        tmpRow.RZMAX = Math.Round(ea.r.max.rz, 2)
                        tmpRow.RZMAXTIME = ea.r.max.tm
                        tmpRow.RZMIN = Math.Round(ea.r.min.rz, 2)
                        tmpRow.RZMINTIME = ea.r.min.tm
                        dt.Rows.Add(tmpRow)
                    Next

                    Dim relavg = Aggregate p In Rel
                                  Where p.rzavg IsNot Nothing
                                      Into Average(DirectCast(p.rzavg, Decimal)), _
                                                 Max(DirectCast(p.rzavg, Decimal)), _
                                                 Min(DirectCast(p.rzavg, Decimal))


                    Dim RpAvg As New ReportParameter("RepPar_Avg", Math.Round(relavg.Average, 2))
                    Dim RpMax As New ReportParameter("RepPar_Max", Math.Round(relavg.Max, 2))
                    Dim RpMin As New ReportParameter("RepPar_Min", Math.Round(relavg.Min, 2))
                    Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp, RpAvg, RpMax, RpMin})
                End Using
                Return dt
            End Using
        End Function

        '时段流量
        Private Function Get_q_time0() As DataTable



            If Me.Cig.RepShType = RepWaterConfig.RepType.pic Then
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Pic\PicWaterQTime.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Model\ReportWaterQTime.rdlc"
            End If

            Dim title As String = Cig.TimePars(0).ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "至" & Cig.TimePars(1).ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "流量统计"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            Using db As New DataRwDataContext
                Dim Rel = From s2 In Cig.STCDs
                          Where Not String.IsNullOrEmpty(s2)
                             Group Join q In (From s1 In db.ST_RSVR_R
                                    Where s1.TM >= Cig.TimePars(0) And s1.TM <= Cig.TimePars(1) Select s1)
                                        On s2 Equals q.STCD
                                            Into Grp = Group
                                                Select R = IIf(Grp.Count = 0, _
                                                             Function() As Object
                                                                 Return New With {.stcd = s2, .sta = New With {.inq_max = Nothing, .otq_max = Nothing, .inq_min = Nothing, .otq_min = Nothing, _
                                                                                 .inq_avg = Nothing, .otq_avg = Nothing}}
                                                             End Function(), _
                                                                            Function() As Object
                                                                                Dim exrel = Aggregate q In Grp
                                                                                            Into inq_max = Max(q.INQ), otq_max = Max(q.OTQ), _
                                                                                                 inq_min = Min(q.INQ), otq_min = Min(q.OTQ), _
                                                                                                 inq_avg = Average(q.INQ), otq_avg = Average(q.OTQ)
                                                                                Return New With {.stcd = s2, .sta = exrel}
                                                                            End Function())
                                                                        Group Join p In db.ST_STBPRP_B
                                                                           On p.STCD Equals R.stcd
                                                                               Into GrpN = Group
                                                                                 From k In GrpN.DefaultIfEmpty
                                                                                    Select n = k.STNM.Trim, d = R

                Using dt As DataTable = New DataSetWater.WaterQTimeDataTable
                    For Each ea In Rel
                        Dim tmp As DataSetWater.WaterQTimeRow = dt.NewRow
                        tmp.STCD = ea.d.stcd
                        tmp.STNM = ea.n
                        tmp.INQAVG = ea.d.sta.inq_avg
                        tmp.INQMAX = ea.d.sta.inq_max
                        tmp.INQMIN = ea.d.sta.inq_min
                        tmp.OTQAVG = ea.d.sta.otq_avg
                        tmp.OTQMAX = ea.d.sta.otq_max
                        tmp.OTQMIN = ea.d.sta.otq_min
                        dt.Rows.Add(tmp)
                    Next
                    Return dt
                End Using

            End Using
        End Function

        '时段蓄水量
        Private Function Getwth_time0(ByVal st As Date, ByVal et As Date) As DataTable

            If Me.Cig.RepShType = RepWaterConfig.RepType.pic Then
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Pic\PicWaterWthTime.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Water\Model\ReportWaterWthTime.rdlc"
            End If

            Dim title As String = st.ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "至" & et.ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "蓄水量统计"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            Using db As New DataRwDataContext
                Dim Rel = From s2 In Cig.STCDs
                          Where Not String.IsNullOrEmpty(s2)
                             Group Join q In (From s1 In db.ST_RSVR_R
                                    Where s1.TM >= st And s1.TM <= et Select s1)
                                        On s2 Equals q.STCD
                                            Into Grp = Group
                                                Select R = IIf(Grp.Count = 0, _
                                                             Function() As Object
                                                                 Return New With {.stcd = s2, .sta = New With {.w_max = Nothing, .w_min = Nothing, _
                                                                                                               .w_avg = Nothing}}
                                                             End Function(), _
                                                                            Function() As Object
                                                                                Dim exrel = Aggregate q In Grp
                                                                                            Into w_max = Max(q.W), _
                                                                                                 w_min = Min(q.W), _
                                                                                                 w_avg = Average(q.W)
                                                                                Return New With {.stcd = s2, .sta = exrel}
                                                                            End Function())
                                                                        Group Join p In db.ST_STBPRP_B
                                                                           On p.STCD Equals R.stcd
                                                                               Into GrpN = Group
                                                                                 From k In GrpN.DefaultIfEmpty
                                                                                    Select n = k.STNM.Trim, d = R

                Using dt As DataTable = New DataSetWater.WaterWthTimeDataTable
                    For Each ea In Rel
                        Dim tmp As DataSetWater.WaterWthTimeRow = dt.NewRow
                        tmp.STCD = ea.d.stcd
                        tmp.STNM = ea.n
                        tmp.WAVG = Math.Round(ea.d.sta.w_avg, 2)
                        tmp.WMAX = Math.Round(ea.d.sta.w_max, 2)
                        tmp.WMIN = Math.Round(ea.d.sta.w_min, 2)
                        dt.Rows.Add(tmp)
                    Next
                    Return dt
                End Using

            End Using
        End Function
    End Class
End Namespace



Imports Microsoft.Reporting.WebForms
Imports Rw.EntityData
Imports System.Data.Linq
Imports System.Globalization
Imports Rw.DAL.Rep.Rain.DataSetRain

Namespace Rep.Rain
    Public Class RepRain

        Private Property Rep As ReportViewer
        Private Property Cig As RepRainConfig

        Sub New(ByRef _Rep As ReportViewer, ByVal _Cig As RepRainConfig)
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
            Select Case Me.Cig.RainShType
                Case RepRainConfig.SearchRainType.time0
                    SetData("Dt", GetTime0Data(Cig.TimePars(0), Cig.TimePars(1)))
                Case RepRainConfig.SearchRainType.day '日逐时水位
                    SetData("Dt", GetDay())
                Case RepRainConfig.SearchRainType.month_EveDay

                    If Cig.RepShType = RepRainConfig.RepType.rep Then
                        Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Model\ReportMonth_EveDay.rdlc"
                    Else
                        Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Pic\PicMonth_EveDay.rdlc"
                    End If

                    Dim rel As Rep.RepRel(Of Month_EveDayDataTable, Object) = Getmonth_EveDay(Cig.TimePars(0).Year, Cig.TimePars(0).Month)

                    Dim dtSrc As DataTable = rel.Dt
                    SetData("Dt", dtSrc)

                    '设置参数
                    '设置标题
                    Dim stnm As String = Rw.EntityData.ST_STBPRP_B.getSTNM(Cig.STCDs(0))
                    Dim title As String = stnm & "(" & Cig.STCDs(0) & ")" & "于" & Cig.TimePars(0).ToString("yyyy年MM月", DateTimeFormatInfo.InvariantInfo) & "降雨量"
                    Dim ListRpPar As New List(Of ReportParameter)
                    ListRpPar.Add(New ReportParameter("RepPar_Title", title))
                    '设置参数
                    Me.Rep.LocalReport.SetParameters(ListRpPar.ToArray)
                    If rel.Par.Count > 0 Then
                        ListRpPar.Add(New ReportParameter("RepPar_MaxDay", rel.Par(0).day.ToString))
                        ListRpPar.Add(New ReportParameter("RepPar_MaxVal", rel.Par(0).r.drpsum.ToString))
                    End If
                    Me.Rep.LocalReport.SetParameters(ListRpPar.ToArray)
                Case RepRainConfig.SearchRainType.year_EveMonth
                    If Cig.RepShType = RepRainConfig.RepType.rep Then
                        Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Model\ReportYear_EveMonth.rdlc"
                    Else
                        Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Pic\PicYear_EveMonth.rdlc"
                    End If

                    Dim rel As Rep.RepRel(Of Year_EveMonthDataTable, List(Of Year_EveMonthRow)) = Getyear_EveMonth(Cig.TimePars(0).Year)

                    SetData("Dt", rel.Dt)

                    Dim stnm As String = Rw.EntityData.ST_STBPRP_B.getSTNM(Cig.STCDs(0))

                    '设置参数
                    '设置标题
                    Dim title As String = stnm & "(" & Cig.STCDs(0) & ")" & "于" & Cig.TimePars(0).ToString("yyyy年", DateTimeFormatInfo.InvariantInfo) & "逐月降雨量"
                    Dim ListRpPar As New List(Of ReportParameter)
                    ListRpPar.Add(New ReportParameter("RepPar_Title", title))
                    ListRpPar.Add(New ReportParameter("RepPar_MaxMonth", rel.Par(0).MONTH))
                    ListRpPar.Add(New ReportParameter("RepPar_MaxVal", rel.Par(0).DRPSUM))
                    Me.Rep.LocalReport.SetParameters(ListRpPar.ToArray)

            End Select
        End Sub

        '时段雨量
        Private Function GetTime0Data(ByVal st As Date, ByVal et As Date) As RainTime0DataTable

            If Cig.RepShType = RepRainConfig.RepType.rep Then
                'Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Model\ReportRainTime0.rdlc"
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Model\ReportRainTime0.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Pic\PicRainTime0.rdlc"
            End If

            '设置标题
            Dim title As String = Cig.TimePars(0).ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "至" & _
                                  Cig.TimePars(1).ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo) & "降雨量"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            Using db As New DataRwDataContext
                Dim Rel = From s2 In Cig.STCDs
                            Where Not String.IsNullOrEmpty(s2)
                                Group Join q In (From s1 In db.ST_PPTN_R
                                    Where s1.TM >= st And s1.TM <= et Select s1) On s2 Equals q.STCD
                                        Into Grp = Group
                                    Select r = If(Grp.Count = 0, New With {.stcd = s2, .drpsum = Nothing}, _
                                                            Function()
                                                                Return New With {.stcd = s2, .drpsum = Aggregate q In Grp Into Sum(q.DRP)}
                                                            End Function())
                                                        Group Join k In db.ST_STBPRP_B
                                                            On k.STCD Equals r.stcd
                                                               Into Grpk = Group
                                                                  Select n = Grpk.FirstOrDefault.STNM.Trim, _
                                                                         d = r
                Using dt As New DataSetRain.RainTime0DataTable
                    For Each ea In Rel
                        Dim tmp As DataSetRain.RainTime0Row = dt.NewRow
                        tmp.STCD = ea.d.stcd
                        tmp.STNM = ea.n
                        tmp.DRPSUM = ea.d.drpsum
                        dt.Rows.Add(tmp)
                    Next
                    Return dt
                End Using
            End Using
        End Function

        '日降雨量
        Private Function GetDay() As RainDayDataTable

            If Cig.RepShType = RepRainConfig.RepType.rep Then
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Model\ReportRainDay.rdlc"
            Else
                Me.Rep.LocalReport.ReportPath = My.MySettings.Default.RepPath & "\Report\Rain\Pic\PicRainDay.rdlc"
            End If

            '设置标题
            Dim title As String = Cig.TimePars(0).ToString("yyyy-MM-dd", DateTimeFormatInfo.InvariantInfo) & "日各站降雨量"
            Dim rp As New ReportParameter("RepPar_Title", title)
            Me.Rep.LocalReport.SetParameters(New ReportParameter() {rp})

            Using db As New DataRwDataContext
                Dim Rel = From s2 In Cig.STCDs
                            Where Not String.IsNullOrEmpty(s2)
                                Group Join q In (From s1 In db.ST_PPTN_R
                                    Where s1.TM.Date = Cig.TimePars(0).Date Select s1) On s2 Equals q.STCD
                                        Into Grp = Group
                                    Select r = If(Grp.Count = 0, New With {.stcd = s2, .drpsum = Nothing, .drptype = "无雨"}, _
                                                            Function()
                                                                Dim tmp_ds As Decimal = Aggregate q In Grp Into Sum(q.DRP)
                                                                Return New With {.stcd = s2, .drpsum = tmp_ds, .drptype = Rain.RepRainConfig.GetRainType(tmp_ds)}
                                                            End Function())
                                                        Group Join k In db.ST_STBPRP_B
                                                            On k.STCD Equals r.stcd
                                                               Into Grpk = Group
                                                                  Select n = Grpk.FirstOrDefault.STNM.Trim, _
                                                                         d = r


                Using dt As New DataSetRain.RainDayDataTable
                    For Each ea In Rel
                        Dim tmp As Rain.DataSetRain.RainDayRow = dt.NewRow
                        tmp.STCD = ea.d.stcd
                        tmp.STNM = ea.n
                        tmp.DRPSUM = ea.d.drpsum
                        tmp.DRPTYPE = ea.d.drptype
                        dt.Rows.Add(tmp)
                    Next
                    Return dt
                End Using
            End Using
        End Function

        '月逐日雨量
        Private Function Getmonth_EveDay(ByVal y As Integer, ByVal m As Integer) As RepRel(Of Month_EveDayDataTable, Object)

            Dim tmS As Date = New Date(y, m, 1)
            Dim tmE As Date = New Date(y, m, Date.DaysInMonth(y, m))

            Dim TimeList As New List(Of Integer)

            For index = 1 To Date.DaysInMonth(y, m)
                TimeList.Add(index)
            Next

            Using db As New DataRwDataContext
                Dim Rel = From s2 In TimeList
                         Group Join q In
                   (From s1 In db.ST_PPTN_R
                                    Where (s1.TM >= tmS And s1.TM <= tmE) _
                                             And s1.STCD = Cig.STCDs(0)
                                                  Group By gday = s1.TM.Day Into Grp = Group
                                                        Select gday, drpsum = Aggregate q In Grp Into Sum(q.DRP)) On q.gday Equals s2
                                                                 Into fGrp = Group
                                                                        Select IIf(fGrp.Count = 0, New With {.day = s2, .r = New With {.gday = Nothing, .drpsum = Nothing}},
                                                                                   Function()
                                                                                       Return New With {.day = s2, .r = fGrp.FirstOrDefault}
                                                                                   End Function())




                '最大降雨日的降雨信息（）
                Dim Rel2 = From s In Rel.ToList
                               Where s.r.drpsum IsNot Nothing
                                   Order By s.r.drpsum Descending
                                     Select s



                Using dt As New Month_EveDayDataTable
                    For Each ea In Rel
                        '降雨类型
                        Dim tmp As Month_EveDayRow = dt.NewRow
                        tmp.DAY = ea.day.ToString & "日"
                        tmp.DRPSUM = Math.Round(ea.r.drpsum, 2)
                        tmp.DRPTYPE = RepRainConfig.GetRainType(ea.r.drpsum)
                        dt.AddMonth_EveDayRow(tmp)
                    Next

                    Return New RepRel(Of Month_EveDayDataTable, Object) With {.Dt = dt, .Par = Rel2.ToList}
                End Using

            End Using
        End Function

        '年逐月雨量
        Private Function Getyear_EveMonth(ByVal y As Integer) As RepRel(Of Year_EveMonthDataTable, List(Of Year_EveMonthRow))

            Dim MonthList As New List(Of Integer)
            For index = 1 To 12
                MonthList.Add(index)
            Next

            Using db As New Rw.EntityData.DataRwDataContext
                Dim Rel = From s2 In MonthList
                          Group Join q In
                   (From s1 In db.ST_PPTN_R
                           Where s1.STCD = Cig.STCDs(0) And s1.TM.Year = y
                               Group By mths = s1.TM.Month Into Grp = Group
                                  Select mth = mths,
                                         drp = Aggregate q In Grp Into Sum(q.DRP))
                                On s2 Equals q.mth
                                             Into fgrp = Group
                                         Select IIf(fgrp.Count = 0, New With {.mth = s2, .r = New With {.mth = Nothing, .drp = Nothing}, .exr = Nothing},
                                                    Function()
                                                        Dim exr = From s In Getmonth_EveDay(y, s2).Dt
                                                                  Group By name = s.DRPTYPE Into Grps = Group
                                                                          Select New With {Key .Key = name, Key .Value = Grps.Count}

                                                        Return New With {.mth = s2, .r = fgrp.FirstOrDefault, .exr = exr}
                                                    End Function())



                '临时的队列处理
                Dim tmpDeal = Function(dic As Dictionary(Of String, Integer), KeyName As String) As Integer
                                  If dic.Count = 0 Then
                                      Return 0
                                  Else
                                      Try
                                          Return dic(KeyName)
                                      Catch
                                          Return 0
                                      End Try
                                  End If
                              End Function

                Using dt As New Year_EveMonthDataTable
                    For Each ea In Rel
                        Dim tmpr As Year_EveMonthRow = dt.NewRow
                        tmpr.MONTH = ea.mth & "月"
                        tmpr.DRPSUM = ea.r.drp
                        If ea.exr IsNot Nothing Then

                            Dim tmpDic As New Dictionary(Of String, Integer)
                            For Each ea2 In ea.exr
                                tmpDic.Add(ea2.Key, ea2.Value)
                            Next

                            tmpr.NODRP = tmpDeal(tmpDic, "无雨")
                            tmpr.MIDDRP = tmpDeal(tmpDic, "中雨")
                            tmpr.BIGDRP1 = tmpDeal(tmpDic, "大雨")
                            tmpr.BIGDRP2 = tmpDeal(tmpDic, "暴雨")
                            tmpr.BIGDRP3 = tmpDeal(tmpDic, "大暴雨")
                            tmpr.BIGDRP4 = tmpDeal(tmpDic, "特大暴雨")
                        End If
                        dt.Rows.Add(tmpr)
                    Next

                    Dim exRel = From s In dt
                                       Order By s.DRPSUM Descending
                                                        Select s

                    Return New RepRel(Of Year_EveMonthDataTable, List(Of Year_EveMonthRow)) With {.Dt = dt, .Par = exRel.ToList}
                End Using
            End Using
        End Function
    End Class
End Namespace



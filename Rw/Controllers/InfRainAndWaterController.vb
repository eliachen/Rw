Imports Rw.Common
Imports Rw.EntityData
Imports System.Linq
Imports System.Data
Imports System.Web.UI.DataVisualization.Charting
Imports System.IO
Imports System.Globalization
Imports Rw.Common.LigerUIDataSt.Grid

Namespace Rw
    Public Class InfRainAndWaterController
        Inherits DefaultController

    

        Private Sub TestST()
            Dim rd As New Random
            Dim db As New DataRwDataContext

            For y = 0 To 9
                Try
                    Dim tmp As New ST_STBPRP_B
                    tmp.STCD = "0000000" & y
                    tmp.STNM = "测试站点" & y
                    tmp.ADMAUTH = "管理机构" & y
                    tmp.LOCALITY = "单位" & y
                    tmp.LGTD = Math.Round(116.22 + rd.NextDouble * 0.2, 3)
                    tmp.LTTD = Math.Round(30.932 + rd.NextDouble * 0.2, 3)
                    db.ST_STBPRP_B.InsertOnSubmit(tmp)
                    db.SubmitChanges()

                Catch ex As Exception

                End Try
            Next
        End Sub


        Private Sub TestPPTN()
            Dim rd As New Random
            Dim db As New DataRwDataContext
            Dim drp As New List(Of ST_PPTN_R)

            Dim y As Integer = 2012
            For m = 1 To 12
                For d = 1 To Date.DaysInMonth(y, m)
                    For h = 0 To 23
                        Dim tmprd As Integer = rd.Next(0, 59)
                        For mm = 0 To tmprd
                            Dim tmp As New ST_PPTN_R
                            tmp.STCD = "0000" & "0001"
                            tmp.TM = New Date(y, m, d, h, mm, 0)
                            tmp.DRP = 0.5
                            tmp.INTV = 1
                            drp.Add(tmp)
                            db.ST_PPTN_R.InsertOnSubmit(tmp)
                            db.SubmitChanges()
                        Next
                    Next
                Next
            Next
        End Sub

        Private Sub TestRsvr()
            Dim rd As New Random
            Dim db As New DataRwDataContext
            Dim drp As New List(Of ST_PPTN_R)

            Dim y As Integer = 2013
            For m = 1 To 12
                For d = 1 To Date.DaysInMonth(y, m)
                    For h = 0 To 23
                        Dim tmprd As Integer = rd.Next(0, 59)
                        For mm = 0 To tmprd
                            Dim tmp As New ST_RSVR_R
                            tmp.STCD = "0000" & "0001"
                            tmp.TM = New Date(y, m, d, h, mm, 0)
                            tmp.RZ = rd.Next(20, 300)
                            tmp.INQ = rd.Next(5, 200)
                            tmp.OTQ = rd.Next(5, 100)
                            db.ST_RSVR_R.InsertOnSubmit(tmp)

                        Next
                    Next
                Next
            Next

            db.SubmitChanges()
        End Sub

        Private Sub UpdatRsvr()
            Dim db As New DataRwDataContext
            Dim rd As New Random
            Dim rel = From s In db.ST_RSVR_R
                      Select s

            For Each ea In rel
                ea.W = rd.Next(20, 300)
            Next
            db.SubmitChanges()
        End Sub

        ' GET: /InfRain
        'Overrides Function Index(ByVal id As String) As ActionResult
        '    Return View(id)
        'End Function

        '主题界面：返回页面
        Function RainAndWater() As ActionResult
            ViewData("FlashTime") = Global.Rw.My.Rw.Default.DataFlush
            ViewData("MapTitle") = Global.Rw.My.Rw.Default.MapTitle
            ViewData("MapAddr") = Global.Rw.My.Rw.Default.MapAddrName
            Return View()
        End Function


#Region "雨情"
        '查询逐日降雨信息:页面返回
        <HttpGet()> _
        Function RainQuery(ByVal _stcd As String, ByVal _stnm As String) As ActionResult
            ViewData("stcd") = _stcd
            ViewData("stnm") = _stnm
            '时间跨度为10天
            ViewData("timediff") = 10
            Return View("Rain/RainQuery")
        End Function

        '返回降雨信息:全站(用于监视图树显示)
        <HttpGet()> _
        Function InfRainAllQuery(ByVal _startTime As String, ByVal _endTime As String) As Common.AjaxResult
            '时间参量皆为本日
            Using RainData As New DataRwDataContext
                Dim Rel = From st In RainData.ST_STBPRP_B
                            Where st.STTP.ToUpper = "PP" Or st.STTP.ToUpper = "RR" _
                                  Or st.STTP.ToUpper = "ZZ" Or st.STTP.ToUpper = "DD" _
                                Group Join r In RainData.ST_PPTN_R On st.STCD Equals r.STCD
                                                        Into Grp = Group
                                                                    Select New With {.STCD = st.STCD, _
                                                                                     .STNM = st.STNM.Trim, _
                                                                                     .SumDrp = Aggregate p In Grp
                                                                                               Where p.TM.Date = Now.Date
                                                                                               Into Sum(p.DRP)}




                Return Common.AjaxResult.Success(Rel.ToList)
            End Using
        End Function

        '查询逐日降雨信息:json数据
        <HttpGet()> _
        Function InfRainQuery(ByVal _stcd As String, ByVal _startTime As String, ByVal _endTime As String) As Common.AjaxResult
            Dim RainInf As New DataRwDataContext
            '

            Dim neRel = From s In RainInf.ST_PPTN_R Where s.STCD = _stcd _
                                                         And (s.TM >= _startTime And s.TM <= _endTime)
                                                            Group By eTm = s.TM.Date Into Grp = Group
                                                                Select New With {.Date = eTm.ToString, _
                                                                                 .SumDrp = Aggregate p In Grp Into Sum(p.DRP)}


            If neRel.ToList.Count > 0 Then
                Return Common.AjaxResult.Success(neRel.ToList)
            Else
                Return Common.AjaxResult.Error("该时段无数据,请重新查询")
            End If
        End Function


#Region "雨情表格与表单"
        Function RainDetail() As ActionResult
            Return View("Rain/RainDetail")
        End Function

        <HttpGet()> _
        Function InfRainDetail() As Common.AjaxResult
            Dim RelRecv As New Common.FormData(Request.QueryString)
            Dim db As New DataRwDataContext
            Try
                Select Case RelRecv.FormType
                    Case FormData.FormTypeModel.new
                        Dim RecvNew As ST_PPTN_R = RelRecv.GetFormData(Of ST_PPTN_R)()
                        db.ST_PPTN_R.InsertOnSubmit(RecvNew)
                        db.SubmitChanges()
                        Return Common.AjaxResult.Success("新建信息成功！")
                    Case (FormData.FormTypeModel.delete)
                        Dim RecvDb As List(Of ST_PPTN_R) = RelRecv.GetFormData(Of List(Of ST_PPTN_R))()
                        RecvDb = RecvDb.Distinct(New STCD_TM_Compare).ToList

                        '先要去重复,一个STCD在一个时间点只有一条记录
                        'Dim willDel = From s In RecvDb
                        '                 Group Join p In db.ST_PPTN_R
                        '                    On s.STCD Equals p.STCD
                        '                            Into leftGrp = Group
                        '                                 From q In leftGrp
                        '                                    Where q.TM = s.TM
                        '                                            Select q

                        Dim willDel =
                                From s In RecvDb
                                   From p In db.ST_PPTN_R
                                  Where s.STCD = p.STCD And s.TM = p.TM
                                    Select p


                        Dim DelCount As Integer = willDel.Count

                        If DelCount = 0 Then
                            Return Common.AjaxResult.Success("删除数据成功！" & "无需删除数据")
                        Else
                            db.ST_PPTN_R.DeleteAllOnSubmit(willDel)
                            db.SubmitChanges()
                            Return Common.AjaxResult.Success("删除数据成功！共:" & DelCount & "条")
                        End If

                    Case FormData.FormTypeModel.edit
                        Dim RecvDb As List(Of ST_PPTN_R) = RelRecv.GetFormData(Of List(Of ST_PPTN_R))()
                        RecvDb = RecvDb.Distinct(New STCD_TM_Compare).ToList

                        '先要去重复,一个STCD在一个时间点只有一条记录
                        'Dim willDel = From s In RecvDb
                        '                 Group Join p In db.ST_PPTN_R
                        '                    On s.STCD Equals p.STCD
                        '                            Into leftGrp = Group
                        '                                 From q In leftGrp
                        '                                    Where q.TM = s.TM
                        '                                            Select q

                        Dim willDel =
                                From s In RecvDb
                                   From p In db.ST_PPTN_R
                                  Where s.STCD = p.STCD And s.TM = p.TM
                                    Select p


                        If willDel.Count > 0 Then
                            db.ST_PPTN_R.DeleteAllOnSubmit(willDel)
                            db.ST_PPTN_R.InsertAllOnSubmit(RecvDb)
                            db.SubmitChanges()
                            Return Common.AjaxResult.Success("修改数据成功！共:" & RecvDb.Count & "条")
                        Else
                            Return Common.AjaxResult.Success("修改数据成功！" & "无需修改数据")
                        End If
                End Select
            Catch ex As Exception
                Return Common.AjaxResult.Error("错误:" & ex.Message)
            End Try

            Return Common.AjaxResult.Error("错误:未知请求")
        End Function
        <HttpPost()> _
        Function InfRainGridData() As JsonResult
            Dim dt As New DataRwDataContext

            Dim RelGridData As New GridData(Of Object)(Request.Params)
            RelGridData.DataSee = From s In dt.ST_PPTN_R
                                        Where s.STCD IsNot Nothing
                                                Order By s.TM Descending
                                                        Select s

            '
            If RelGridData.GridParm.PageType = GridParm.PagePostType.search Then
                Dim sp = JSONHelper.FromJson(Of Object)(RelGridData.GridParm.SearchParm)
                Dim STCD As String = sp("STCD")
                Dim ST As Date = Date.Parse(sp("STime"))
                Dim ET As Date = Date.Parse(sp("ETime"))

                RelGridData.DataSearch = From s In dt.ST_PPTN_R
                                            Where s.STCD = STCD _
                                                And (s.TM >= ST And s.TM <= ET)
                                                    Select s

            End If
            Return RelGridData.GetJsonResult
        End Function
#End Region

#End Region

#Region "水情"
#Region "水情表格与表单"
        Function WaterDetail() As ActionResult
            Return View("Water/WaterDetail")
        End Function

        <HttpGet()> _
        Function InfWaterDetail() As Common.AjaxResult
            Dim RelRecv As New Common.FormData(Request.QueryString)
            Dim db As New DataRwDataContext
            Try
                Select Case RelRecv.FormType
                    Case FormData.FormTypeModel.new
                        Dim RecvNew As ST_RSVR_R = RelRecv.GetFormData(Of ST_RSVR_R)()
                        db.ST_RSVR_R.InsertOnSubmit(RecvNew)
                        db.SubmitChanges()
                        Return Common.AjaxResult.Success("新建信息成功！")
                    Case (FormData.FormTypeModel.delete)
                        Dim RecvDb As List(Of ST_RSVR_R) = RelRecv.GetFormData(Of List(Of ST_RSVR_R))()
                        RecvDb = RecvDb.Distinct(New STCD_TM_Compare).ToList

                        Dim willDel = From s In RecvDb
                                         From p In db.ST_RSVR_R
                                             Where s.STCD = p.STCD And s.TM = p.TM
                                                Select p



                        'Dim willDel1 = From s In RecvDb
                        '                Group Join p In db.ST_RSVR_R On s.TM Equals p.TM
                        '                             Into leftGrp = Group
                        '                                           From q In leftGrp.DefaultIfEmpty
                        '                                              Where q IsNot Nothing
                        '                                                 Select q


                        'Dim willDel2 = From s In RecvDb
                        '                 Group Join p In willDel1 On s.STCD Equals p.STCD
                        '                    Into Grp = Group
                        '                            From q In Grp.DefaultIfEmpty
                        '                               Where q IsNot Nothing
                        '                                    Select q

                        Dim DelCount As Integer = willDel.Count

                        If DelCount = 0 Then
                            Return Common.AjaxResult.Success("删除数据成功！" & "无需删除数据")
                        Else
                            db.ST_RSVR_R.DeleteAllOnSubmit(willDel)
                            db.SubmitChanges()
                            Return Common.AjaxResult.Success("删除数据成功！共:" & DelCount & "条")
                        End If

                    Case FormData.FormTypeModel.edit
                        Dim RecvDb As List(Of ST_RSVR_R) = RelRecv.GetFormData(Of List(Of ST_RSVR_R))()
                        RecvDb = RecvDb.Distinct(New STCD_TM_Compare).ToList


                        Dim willDel = From s In RecvDb
                                         From p In db.ST_RSVR_R
                                             Where s.STCD = p.STCD And s.TM = p.TM
                                                Select p
                        '先要去重复, 一个STCD在一个时间点只有一条记录
                        'Dim willDel1 = From s In RecvDb
                        '                Group Join p In db.ST_RSVR_R On s.TM Equals p.TM
                        '                             Into leftGrp = Group
                        '                                           From q In leftGrp.DefaultIfEmpty
                        '                                              Where q IsNot Nothing
                        '                                                 Select q


                        'Dim willDel2 = From s In RecvDb
                        '                 Group Join p In willDel1 On s.STCD Equals p.STCD
                        '                    Into Grp = Group
                        '                            From q In Grp.DefaultIfEmpty
                        '                               Where q IsNot Nothing
                        '                                    Select q

                        If willDel.Count > 0 Then
                            db.ST_RSVR_R.DeleteAllOnSubmit(willDel)
                            db.ST_RSVR_R.InsertAllOnSubmit(RecvDb)
                            db.SubmitChanges()
                            Return Common.AjaxResult.Success("修改数据成功！共:" & RecvDb.Count & "条")
                        Else
                            Return Common.AjaxResult.Success("修改数据成功！" & "无需修改数据")
                        End If
                End Select
            Catch ex As Exception
                Return Common.AjaxResult.Error("错误:" & ex.Message)
            End Try

            Return Common.AjaxResult.Error("错误:未知请求")
        End Function

        <HttpPost()> _
        Function InfWaterGridData() As JsonResult
            Dim dt As New DataRwDataContext

            Dim RelGridData As New GridData(Of Object)(Request.Params)
            RelGridData.DataSee = From s In dt.ST_RSVR_R
                                        Where s.STCD IsNot Nothing
                                                Order By s.TM Descending
                                                        Select s

            '
            If RelGridData.GridParm.PageType = GridParm.PagePostType.search Then
                Dim sp = JSONHelper.FromJson(Of Object)(RelGridData.GridParm.SearchParm)
                Dim STCD As String = sp("STCD")
                Dim ST As Date = Date.Parse(sp("STime"))
                Dim ET As Date = Date.Parse(sp("ETime"))

                RelGridData.DataSearch = From s In dt.ST_RSVR_R
                                            Where s.STCD = STCD _
                                                And (s.TM >= ST And s.TM <= ET)
                                                    Select s

            End If
            Return RelGridData.GetJsonResult
        End Function

#End Region

#Region "水情图表"
        '查询每日水位信息:页面返回
        <HttpGet()> _
        Function WaterQuery(ByVal _stcd As String, ByVal _stnm As String) As ActionResult
            ViewData("stcd") = _stcd
            ViewData("stnm") = _stnm
            '时间跨度为3天
            ViewData("timediff") = 3
            Return View("Water/WaterQuery")
        End Function

        '查询时段水位信息:json数据
        <HttpGet()> _
        Function InfWaterQuery(ByVal _stcd As String, ByVal _startTime As String, ByVal _endTime As String) As Common.AjaxResult
            Try
                Dim WaterInf As New DataRwDataContext
                '
                '_stcd = "70113900"
                '_startTime = Now.AddMonths(-5)
                '_endTime = Now
                Dim neRel = From s In WaterInf.ST_RSVR_R Where s.STCD = _stcd _
                                                             And (s.TM >= _startTime And s.TM <= _endTime)
                                                                    Group By eTmDate = s.TM.Date Into Grp = Group
                                                                            From p In Grp
                                                                              Group By eTmHour = p.TM.Hour Into pGrp = Group
                                                                                    Order By pGrp.FirstOrDefault.p.TM Ascending
                                                                                        Select New With {.Date = pGrp.FirstOrDefault.p.TM.ToString("yyyy-MM-dd HH时", DateTimeFormatInfo.InvariantInfo), _
                                                                                                         .WaterLevel = pGrp.FirstOrDefault.p.RZ}



                If neRel.ToList.Count > 0 Then
                    Return Common.AjaxResult.Success(neRel.ToList)
                Else
                    Return Common.AjaxResult.Error("该时段无数据,请重新查询")
                End If
            Catch ex As Exception
                Return Common.AjaxResult.Error("错误：" & ex.Message)
            End Try
        End Function

#End Region

        '返回水位信息:全站(用于监视图树显示)
        <HttpGet()> _
        Function InfWaterAllQuery() As Common.AjaxResult
            '时间参量皆为本日
            Using WaterData As New DataRwDataContext
                Dim Rel = From st In WaterData.ST_STBPRP_B
                            Where st.STTP.ToUpper = "ZG" Or st.STTP.ToUpper = "ZB" _
                                  Or st.STTP.ToUpper = "ZZ" Or st.STTP.ToUpper = "RR" _
                                Group Join r In WaterData.ST_RSVR_R On st.STCD Equals r.STCD
                                           Into Grp = Group
                                           Select New With {.STCD = st.STCD, .STNM = st.STNM,
                                                            .RZ = (From p In Grp
                                                                    Where p.TM.Date = Now.Date
                                                                      Order By p.TM Descending
                                                                       Select p.RZ).FirstOrDefault}


            
                Return Common.AjaxResult.Success(Rel.ToList)
            End Using
        End Function


#End Region

    End Class
End Namespace




'Dim DelList As New List(Of ST_PPTN_R)

'Dim x = RecvDb.FirstOrDefault.TM.ToString("yyyy-MM-dd HH", DateTimeFormatInfo.InvariantInfo)

'Dim r = From s In db.ST_PPTN_R
'          Where s.STCD = "70149007"
'             Order By s.TM
'                Select s

'Dim rx = From s In r
'          Group Join p In db.ST_PPTN_R
'                On s.STCD Equals p.STCD
'                    Into grp = Group
'                          Select grp

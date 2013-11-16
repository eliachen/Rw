Imports Rw.EntityData
Imports Rw.Common
Imports Rw.Common.LigerUIDataSt.Grid


Imports System.Globalization
Namespace Rw
    Public Class InfBasicDataController
        Inherits DefaultController


#Region "页面请求"
        ' GET: /InfBasicData 简单页面跳转
        '<HttpGet()> _
        'Function Index(ByVal id As String) As ActionResult
        '    Return View(id)
        'End Function

        <HttpGet()> _
        Function StationDetail()
            ViewData("formtype") = Request.QueryString("formtype")
            ViewData("formdata") = Request.QueryString("formdata")
            Return View()
        End Function
#End Region


#Region "测站表格及其表单"
        '请求数据
        <HttpGet()> _
        Function InfStationDetail()
            Dim RecvData As New FormData(Request.QueryString)
           
            Dim db As New DataRwDataContext()
            Try
                Select Case RecvData.FormType
                    Case FormData.FormTypeModel.new
                        Dim newData As ST_STBPRP_B = RecvData.GetFormData(Of ST_STBPRP_B)()
                        If Not (String.IsNullOrEmpty(newData.BGFRYM) And String.IsNullOrEmpty(newData.ESSTYM)) Then
                            '处理下时间
                            newData.BGFRYM = Date.Parse(newData.BGFRYM).ToString("yyyyMM", DateTimeFormatInfo.InvariantInfo)
                            newData.ESSTYM = Date.Parse(newData.ESSTYM).ToString("yyyyMM", DateTimeFormatInfo.InvariantInfo)
                        End If

                        db.ST_STBPRP_B.InsertOnSubmit(newData)

                        db.SubmitChanges()
                        Return Common.AjaxResult.Success("新建测站信息成功")
                    Case FormData.FormTypeModel.edit
                        Dim newData As ST_STBPRP_B = RecvData.GetFormData(Of ST_STBPRP_B)()
                        Dim oldData = (From s In db.ST_STBPRP_B
                                            Where s.STCD = newData.STCD
                                                Select s).SingleOrDefault
                        '删除旧数据
                        db.ST_STBPRP_B.DeleteOnSubmit(oldData)
                        '插入新数据
                        db.ST_STBPRP_B.InsertOnSubmit(newData)
                        '处理下时间
                        If newData.BGFRYM IsNot Nothing Then
                            newData.BGFRYM = Date.Parse(newData.BGFRYM).ToString("yyyyMM", DateTimeFormatInfo.InvariantInfo)
                        End If

                        If newData.ESSTYM IsNot Nothing Then
                            newData.ESSTYM = Date.Parse(newData.ESSTYM).ToString("yyyyMM", DateTimeFormatInfo.InvariantInfo)
                        End If
                        db.SubmitChanges()
                        Return Common.AjaxResult.Success("保存测站信息成功")
                    Case FormData.FormTypeModel.delete
                        Dim DeleteStcd As String = RecvData.GetFormData(Of String)()
                        Dim DeleteStation = From s In db.ST_STBPRP_B
                                 Where s.STCD = DeleteStcd
                                   Select s

                        db.ST_STBPRP_B.DeleteAllOnSubmit(DeleteStation)
                        db.SubmitChanges()
                        Return Common.AjaxResult.Success("删除测站信息成功")
                    Case FormData.FormTypeModel.data
                        Dim Rel = From s In db.ST_STBPRP_B
                                   Where s.STCD = Common.JSONHelper.FromJson(Of String)(RecvData.FormData)
                                        Select s

                        For Each ea In Rel
                            If ea.BGFRYM IsNot Nothing And ea.ESSTYM IsNot Nothing Then
                                ea.BGFRYM = IIf(ea.BGFRYM.Length >= 6, ea.BGFRYM.Substring(0, 4) + "-" + ea.BGFRYM.Substring(4, 2), ea.BGFRYM)
                                ea.ESSTYM = IIf(ea.ESSTYM.Length >= 6, ea.ESSTYM.Substring(0, 4) + "-" + ea.ESSTYM.Substring(4, 2), ea.ESSTYM)
                            End If
                        Next

                        Return Common.AjaxResult.Success(Rel.ToList.FirstOrDefault)
                    Case Else
                        Return Common.AjaxResult.Error("没有所需请求！")
                End Select
            Catch ex As Exception
                Return Common.AjaxResult.Error(ex.Message)
            End Try
        End Function

        '查询测站信息：返回测站的所有信息(用于数据编辑)
        <HttpPost()> _
        Function InfStationGridData() As JsonResult

            '站点信息
            Dim StInf As New DataRwDataContext()

            Dim RelGridData As New GridData(Of Object)(Request.Params)

            RelGridData.DataSee = From s In StInf.ST_STBPRP_B
                                        Where s.STCD IsNot Nothing
                                                           Select s

            '如有查找再初始化查找语句
            If RelGridData.GridParm.PageType = GridParm.PagePostType.search Then
                Dim sp As ST_STBPRP_B = JSONHelper.FromJson(Of ST_STBPRP_B)(RelGridData.GridParm.SearchParm)
                RelGridData.DataSearch = From s In StInf.ST_STBPRP_B Where s.STCD IsNot Nothing
                                                Where s.STCD.Contains(sp.STCD) Or s.STNM.Contains(sp.STNM)
                                                            Select s


            End If
            Return RelGridData.GetJsonResult()
        End Function
#End Region


        '查询测站信息：返回测站的基本信息（用于地图显示）
        <HttpGet()> _
        Function InfStation() As Common.AjaxResult
            '站点信息
            Dim StInf As New DataRwDataContext()
            '查询结果:
            Dim Rel = From s In StInf.ST_STBPRP_B Where s.LTTD IsNot Nothing _
                                                          And s.LGTD IsNot Nothing
                                                                      Select New With {.STCD = s.STCD, .LGTD = s.LGTD,
                                                                                       .LTTD = s.LTTD, .STNM = s.STNM.Trim,
                                                                                       .STLC = s.STLC, .ADMAUTH = s.ADMAUTH,
                                                                                       .exSTTP = ST_STBPRP_B.GetTypeShow(s.STTP).ToString}



            Return Common.AjaxResult.Success(Rel.ToList, "测站信息加载成功")
        End Function
    End Class
End Namespace
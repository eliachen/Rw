Imports Microsoft.Reporting.WebForms
Imports Rw.DAL.Rep.Rain
Imports Rw.Common
Public Class ReportRain
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("rep")) Then
                Dim RecvCig As RepRainConfig = JSONHelper.FromJson(Of RepRainConfig)(Request.QueryString("rep"))
                Dim repwater As New RepRain(Me.ReportViewerForRain, RecvCig)
                repwater.DoData()
                '设置大小
                Me.ReportViewerForRain.Height = RecvCig.H - 15
                Me.ReportViewerForRain.Width = RecvCig.W - 35
            End If
        End If
    End Sub

End Class
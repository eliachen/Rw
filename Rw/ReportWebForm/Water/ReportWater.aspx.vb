Imports Microsoft.Reporting.WebForms
Imports Rw.DAL.Rep.Water
Imports Rw.Common


Public Class ReportWater
    Inherits System.Web.UI.Page


    Private Sub ReportWater_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("rep")) Then
                Dim RecvCig As RepWaterConfig = JSONHelper.FromJson(Of RepWaterConfig)(Request.QueryString("rep"))
                Dim repwater As New RepWater(Me.ReportViewerForWater, RecvCig)
                repwater.DoData()
                '设置大小
                Me.ReportViewerForWater.Height = RecvCig.H - 15
                Me.ReportViewerForWater.Width = RecvCig.W - 35
            End If
        End If
    End Sub
End Class
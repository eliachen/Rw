Imports System.Globalization
Imports Rw.Rw



Public Class InfPumpStationController
    Inherits DefaultController

    <MTAThread> _
    Sub PumpVideoData()
        Response.ContentType = "video/mp4 mp4"
        Response.Clear()
        Response.WriteFile("~\App_Data\test.m4v")
        Response.Flush()
    End Sub
End Class
'     Using fs As New IO.FileStream("C:\MrLin\RainAndWater\Rw\Rw\App_Data\test.m4v", IO.FileMode.Open, IO.FileAccess.Read, IO.FileShare.Read)
'            Response.Clear()
''Response.Cache.SetCacheability(HttpCacheability.Public)
''Response.Cache.SetLastModified(DateTime.Now)

'            Response.ContentType = "video/mp4 mp4"
'' Response.AppendHeader("Content-Type", "video/mp4 mp4")
''Response.AppendHeader("Content-Length", length.ToString())


'Dim buffer As Byte()
'            ReDim buffer(fs.Length - 1)


'            If Response.IsClientConnected Then
''Response.OutputStream.Write(buffer, 0, fs.Length)
''Response.WriteFile()
''Response.Flush()
'            End If

'        End Using
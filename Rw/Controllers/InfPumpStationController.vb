Imports System.Globalization
Imports Rw.Rw



Public Class InfPumpStationController
    Inherits DefaultController

    Sub PumpVideoData()
        Response.ContentType = "video/mp4 mp4"
        Response.Clear()
        Response.WriteFile("~\App_Data\test.m4v")
        Response.Flush()
    End Sub
End Class

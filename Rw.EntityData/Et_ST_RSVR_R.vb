



Partial Public Class ST_STBPRP_B
    Public Shared Function getSTNM(ByVal _stcd As String) As String
        Using db As New DataRwDataContext
            Dim rel = From s In db.ST_STBPRP_B
                      Where s.STCD = _stcd
                         Select s.STNM

            If rel.Count > 0 Then
                Return rel.First.Trim
            Else
                Return "未知测站"
            End If
        End Using
    End Function
    '针对水情与水情的显示
    Public Shared Function GetTypeShow(ByVal SttpStr As String) As ShowInfType
        If SttpStr IsNot Nothing Then
            Select Case True
                Case SttpStr.ToUpper.Contains("PP")
                    Return ShowInfType.rain
                Case Else
                    Return ShowInfType.rainandwater
            End Select
        Else
            Return ShowInfType.unknown
        End If
    End Function

    Public Shared Function GetRainShow(ByVal SttpStr As String) As Boolean
        If SttpStr = "PP" Then
            Return True
        Else
            Return False
        End If
    End Function

    Enum ShowInfType
        rain
        water
        rainandwater
        unknown
    End Enum

End Class


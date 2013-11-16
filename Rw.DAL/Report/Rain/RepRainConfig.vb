
Namespace Rep.Rain
    Public Class RepRainConfig
        Inherits RepConfigvb

        Property RainShType As SearchRainType



        Public Enum SearchRainType
            '时段雨量表
            time0 = 0
            '每日降雨量
            day = 1
            month_EveDay = 2
            year_EveMonth = 3
            '时段流量
            q_time0 = 4
            '时段蓄水量
            wth_time0 = 5
        End Enum



        '限制在24小时
        Public Shared Function GetRainType(ByVal _drp As Decimal?) As String
            If _drp Is Nothing Or _drp = 0 Then
                Return "无雨"
            Else
                Select Case True
                    Case _drp > 0 And _drp <= 10
                        Return "小雨"
                    Case _drp > 10 And _drp <= 25
                        Return "中雨"
                    Case _drp > 25 And _drp <= 50
                        Return "大雨"
                    Case _drp > 50 And _drp <= 100
                        Return "暴雨"
                    Case _drp > 100 And _drp <= 250
                        Return "大暴雨"
                    Case _drp > 250
                        Return "特大暴雨"
                    Case Else
                        Return "未知"
                End Select
            End If
        End Function
  
    End Class
End Namespace


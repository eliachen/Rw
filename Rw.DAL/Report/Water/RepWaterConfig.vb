
Namespace Rep.Water
    Public Class RepWaterConfig
        Inherits Rep.RepConfigvb

    

        Property WaterShType As SearchWaterType


        Public Enum SearchWaterType
            '时段水位表
            time0 = 0
            day_EveHour = 1
            month_EveDay = 2
            year_EveMonth = 3
            '时段流量
            q_time0 = 4
            '时段蓄水量
            wth_time0 = 5
        End Enum

    End Class
End Namespace


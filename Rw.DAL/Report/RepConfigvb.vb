Namespace Rep
    Public Class RepConfigvb


        Property STCDs As IEnumerable(Of String)

        Property TimePars As IEnumerable(Of Date)

        Property RepShType As RepType


        Property H As Integer
        Property W As Integer

        Public Enum RepType
            rep = 0
            pic = 1
        End Enum
    End Class
End Namespace


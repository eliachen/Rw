
Public Class STCD_TM_Compare
    Implements IEqualityComparer(Of Object)

    Public Function myEquals(x As Object, y As Object) As Boolean Implements System.Collections.Generic.IEqualityComparer(Of Object).Equals
        If x.STCD = y.STCD And x.TM = y.TM Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function myGetHashCode(obj As Object) As Integer Implements System.Collections.Generic.IEqualityComparer(Of Object).GetHashCode
        Return MyBase.GetHashCode()
    End Function
End Class


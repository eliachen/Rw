Imports System.Runtime.Serialization
<DataContract()> _
Public Class RwDataState(Of T)
    <DataMember()> _
    Public Property status As String
    <DataMember()> _
    Public Property data As T

End Class

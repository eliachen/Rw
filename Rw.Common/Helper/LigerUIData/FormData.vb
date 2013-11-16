Imports System.Runtime.Serialization
Imports Rw.Common
<DataContract()> _
Public Class FormData

    <DataMember()> _
    Public Property FormType As FormTypeModel
    <DataMember()> _
    Public Property FormData As String

   
    Sub New()
        MyBase.New()
    End Sub

    Sub New(ByVal _Rel As System.Collections.Specialized.NameValueCollection)
        Me.FormData = _Rel("formdata")
        Select Case _Rel("formtype")
            Case "new"
                Me.FormType = FormTypeModel.new
            Case "see"
                Me.FormType = FormTypeModel.see
            Case "edit"
                Me.FormType = FormTypeModel.edit
            Case "delete"
                Me.FormType = FormTypeModel.delete
            Case "data"
                Me.FormType = FormTypeModel.data
            Case "save"
                Me.FormType = FormTypeModel.save
        End Select
    End Sub

    Public Function GetFormData(Of T)() As T
        Return JSONHelper.FromJson(Of T)(Me.FormData)
    End Function
    Public Enum FormTypeModel
        [new]
        see
        edit
        delete
        data
        save
    End Enum
End Class

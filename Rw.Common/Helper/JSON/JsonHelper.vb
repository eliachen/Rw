Imports System.Collections
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Data.Common
Imports System.IO
Imports System.Runtime.Serialization.Json
Imports System.Web.Mvc
Imports System
Public Class JSONHelper
    ''' <summary>
    ''' 类对像转换成json格式
    ''' </summary> 
    ''' <returns></returns>
    Public Shared Function ToJson(ByVal t As Object) As String
        Return New JavaScriptSerializer().Serialize(t)
    End Function

    ''' <summary>
    ''' json格式转换
    ''' </summary>
    ''' <typeparam name="T"></typeparam>
    ''' <param name="strJson"></param>
    ''' <returns></returns>
    Public Shared Function FromJson(Of T)(ByVal strJson As String) As T
        Return New JavaScriptSerializer().Deserialize(Of T)(strJson)
    End Function

    'Public Shared Function FromJson(Of T As Class)(ByVal strJson As String) As T
    '    Return New JavaScriptSerializer().Deserialize(Of T)(strJson)
    'End Function

    Public Shared Function FromJsonTo(Of T)(ByVal jsonString As String) As T
        Dim ser As New DataContractJsonSerializer(GetType(T))

        Using ms As New MemoryStream(Encoding.UTF8.GetBytes(jsonString))
            Dim jsonObject As T = DirectCast(ser.ReadObject(ms), T)

            ms.Close()

            Return jsonObject
        End Using

    End Function

    Public Shared Function ToJsJson(ByVal item As Object) As String

        Dim serializer As New DataContractJsonSerializer(item.[GetType]())

        Using ms As New MemoryStream()

            serializer.WriteObject(ms, item)

            Dim sb As New StringBuilder()

            sb.Append(Encoding.UTF8.GetString(ms.ToArray()))
            Return sb.ToString()
        End Using

    End Function

    Public Shared Function ToJsonResult(ByVal Obj As Object) As JsonResult
        Dim RelJson As New JsonResult With {.Data = Obj}
    End Function

    ' ''' <summary>
    ' ''' 获取树格式对象的JSON
    ' ''' </summary>
    ' ''' <param name="commandText">commandText</param>
    ' ''' <param name="id">ID的字段名</param>
    ' ''' <param name="pid">PID的字段名</param>
    ' ''' <returns></returns>
    'Public Shared Function GetArrayJSON(ByVal commandText As String, ByVal id As String, ByVal pid As String) As String
    '    Dim o = ArrayToTreeData(commandText, id, pid)
    '    Return ToJson(o)
    'End Function
    ' ''' <summary>
    ' ''' 获取树格式对象的JSON
    ' ''' </summary>
    ' ''' <param name="command">command</param>
    ' ''' <param name="id">ID的字段名</param>
    ' ''' <param name="pid">PID的字段名</param>
    ' ''' <returns></returns>
    'Public Shared Function GetArrayJSON(ByVal command As DbCommand, ByVal id As String, ByVal pid As String) As String
    '    Dim o = ArrayToTreeData(command, id, pid)
    '    Return ToJson(o)
    'End Function

    ' ''' <summary>
    ' ''' 获取树格式对象的JSON
    ' ''' </summary>
    ' ''' <param name="list">线性数据</param>
    ' ''' <param name="id">ID的字段名</param>
    ' ''' <param name="pid">PID的字段名</param>
    ' ''' <returns></returns>
    'Public Shared Function GetArrayJSON(ByVal list As IList(Of Hashtable), ByVal id As String, ByVal pid As String) As String
    '    Dim o = ArrayToTreeData(list, id, pid)
    '    Return ToJson(o)
    'End Function

    ' ''' <summary>
    ' ''' 获取树格式对象
    ' ''' </summary>
    ' ''' <param name="command">command</param>
    ' ''' <param name="id">id的字段名</param>
    ' ''' <param name="pid">pid的字段名</param>
    ' ''' <returns></returns>
    'Public Shared Function ArrayToTreeData(ByVal command As DbCommand, ByVal id As String, ByVal pid As String) As Object
    '    Dim reader = DbHelper.Db.ExecuteReader(command)
    '    Dim list = DbReaderToHash(reader)
    '    Return JSONHelper.ArrayToTreeData(list, id, pid)
    'End Function

    ' ''' <summary>
    ' ''' 获取树格式对象
    ' ''' </summary>
    ' ''' <param name="commandText">sql</param>
    ' ''' <param name="id">ID的字段名</param>
    ' ''' <param name="pid">PID的字段名</param> 
    ' ''' <returns></returns>
    'Public Shared Function ArrayToTreeData(ByVal commandText As String, ByVal id As String, ByVal pid As String) As Object
    '    Dim reader = DbHelper.Db.ExecuteReader(commandText)
    '    Dim list = DbReaderToHash(reader)
    '    Return JSONHelper.ArrayToTreeData(list, id, pid)
    'End Function

    ' ''' <summary>
    ' ''' 获取树格式对象
    ' ''' </summary>
    ' ''' <param name="list">线性数据</param>
    ' ''' <param name="id">ID的字段名</param>
    ' ''' <param name="pid">PID的字段名</param>
    ' ''' <returns></returns>
    'Public Shared Function ArrayToTreeData(ByVal list As IList(Of Hashtable), ByVal id As String, ByVal pid As String) As Object
    '    Dim h = New Hashtable()
    '    '数据索引 
    '    Dim r = New List(Of Hashtable)()
    '    '数据池,要返回的 
    '    For Each item As var In list
    '        If Not item.ContainsKey(id) Then
    '            Continue For
    '        End If
    '        h(item(id).ToString()) = item
    '    Next
    '    For Each item As var In list
    '        If Not item.ContainsKey(id) Then
    '            Continue For
    '        End If
    '        If Not item.ContainsKey(pid) OrElse item(pid) Is Nothing OrElse Not h.ContainsKey(item(pid).ToString()) Then
    '            r.Add(item)
    '        Else
    '            Dim pitem = TryCast(h(item(pid).ToString()), Hashtable)
    '            If Not pitem.ContainsKey("children") Then
    '                pitem("children") = New List(Of Hashtable)()
    '            End If
    '            Dim children = TryCast(pitem("children"), List(Of Hashtable))
    '            children.Add(item)
    '        End If
    '    Next
    '    Return r
    'End Function


    ' ''' <summary>
    ' ''' 执行SQL 返回json
    ' ''' </summary>
    ' ''' <param name="command"></param>
    ' ''' <returns></returns>
    'Public Shared Function ExecuteCommandToJSON(ByVal command As DbCommand) As String
    '    Dim o = ExecuteReaderToHash(command)
    '    Return ToJson(o)
    'End Function

    ' ''' <summary>
    ' ''' 执行SQL 返回json
    ' ''' </summary>
    ' ''' <param name="commandText"></param>
    ' ''' <returns></returns>
    'Public Shared Function ExecuteCommandToJSON(ByVal commandText As String) As String
    '    Dim o = ExecuteReaderToHash(commandText)
    '    Return ToJson(o)
    'End Function

    ' ''' <summary>
    ' ''' 将db reader转换为Hashtable列表
    ' ''' </summary>
    ' ''' <param name="commandText"></param>
    ' ''' <returns></returns>
    'Public Shared Function ExecuteReaderToHash(ByVal commandText As String) As List(Of Hashtable)
    '    Dim reader = DbHelper.Db.ExecuteReader(commandText)
    '    Return DbReaderToHash(reader)
    'End Function

    ' ''' <summary>
    ' ''' 将db reader转换为Hashtable列表
    ' ''' </summary>
    ' ''' <param name="command"></param>
    ' ''' <returns></returns>
    'Public Shared Function ExecuteReaderToHash(ByVal command As DbCommand) As List(Of Hashtable)
    '    Dim reader = DbHelper.Db.ExecuteReader(command)
    '    Return DbReaderToHash(reader)
    'End Function

    ' ''' <summary>
    ' ''' 将db reader转换为Hashtable列表
    ' ''' </summary>
    ' ''' <param name="reader"></param>
    ' ''' <returns></returns>
    'Private Shared Function DbReaderToHash(ByVal reader As IDataReader) As List(Of Hashtable)
    '    Dim list = New List(Of Hashtable)()
    '    While reader.Read()
    '        Dim item = New Hashtable()

    '        For i As var = 0 To reader.FieldCount - 1
    '            Dim name = reader.GetName(i)
    '            Dim value = reader(i)
    '            item(name) = value
    '        Next
    '        list.Add(item)
    '    End While
    '    Return list
    'End Function
End Class

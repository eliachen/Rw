

Imports System.Web.Mvc
Imports System.Runtime.Serialization

Namespace LigerUIDataSt.Grid
    <DataContract()> _
    Public Class GridParm
        '页面类型：数据查看或者数据搜索
        <DataMember()> _
        Public Property PageType As PagePostType
        '页码
        <DataMember()> _
        Public Property Page As Decimal
        '单页数
        <DataMember()> _
        Public Property PageSize As Decimal
        '页排序名称
        <DataMember()> _
        Public Property SortName As String
        '页排序命令
        <DataMember()> _
        Public Property SortOrder As String
        '页搜索条件
        <DataMember()> _
        Public Property SearchParm As String

        Sub New()
            MyBase.New()
        End Sub

        Sub New(ByVal _RecvPost As System.Collections.Specialized.NameValueCollection)
            Dim DecodeGridParma As GridParm = GetGridParm(_RecvPost)
            Me.PageType = DecodeGridParma.PageType
            Me.Page = DecodeGridParma.Page
            Me.PageSize = DecodeGridParma.PageSize
            Me.SortName = DecodeGridParma.SortName
            Me.SearchParm = DecodeGridParma.SearchParm
        End Sub

        Public Shared Function GetGridParm(ByVal _Form As System.Collections.Specialized.NameValueCollection) As GridParm
            Dim gp As New GridParm With {.Page = _Form("page"), .PageSize = _Form("pagesize"), _
                                      .SortName = _Form("sortname"), .SortOrder = _Form("sortorder"), _
                                      .SearchParm = _Form("searchparm")}

            Select Case _Form("pagetype")
                Case "data"
                    gp.PageType = PagePostType.data
                Case "search"
                    gp.PageType = PagePostType.search
                Case Else
                    gp.PageType = PagePostType.unknown
            End Select
            Return gp
        End Function

        'Public Shared Function GetGridRel(

        ''' <summary>
        ''' 页面的类型，用于标定结果
        ''' </summary>
        ''' <remarks></remarks>
        Public Enum PagePostType

            data
            search
            unknown
        End Enum
    End Class

    <DataContract()> _
    Public Class GridData(Of T)

        <DataMember()> _
        Public Property Rows As Object

        <DataMember()> _
        Public Property Total As Integer

        <DataMember()> _
        Public Property GridParm As GridParm

        '<DataMember(isRequired:=False)> _
        Public Property DataSearch As IQueryable(Of T)

        '<DataMember(isRequired:=False)> _
        Public Property DataSee As IQueryable(Of T)

        Sub New()
            'MyBase.New()
        End Sub

        Sub New(ByVal _GridParm As GridParm)
            MyBase.New()
            Me.GridParm = _GridParm
        End Sub

        Sub New(ByVal _NameVal As System.Collections.Specialized.NameValueCollection)
            MyBase.New()
            Me.GridParm = GridParm.GetGridParm(_NameVal)
        End Sub

        ''json的输出
        Public Function GetJsonResult() As JsonResult
            If Me.DataSee Is Nothing Then
                Throw New Exception("至少要指定表格的基本数据选项！")
                Return Nothing
            End If

            '数据处理
            Select Case Me.GridParm.PageType
                Case Grid.GridParm.PagePostType.data
                    Return New JsonResult() With {.Data = GetGridDivData(Of T)(Me.GridParm, Me.DataSee, Me.DataSee.Count)}
                Case Grid.GridParm.PagePostType.search
                    '搜索全部重新由第一页开始
                    Return New JsonResult() With {.Data = GetGridDivData(Of T)(Me.GridParm, Me.DataSearch, Me.DataSearch.Count)}
                Case Else
                    Return New JsonResult() With {.Data = GetGridDivData(Of T)(Me.GridParm, Me.DataSee, Me.DataSee.Count)}
            End Select
        End Function

        Private Shared Function GetGridData(Of mT)(ByVal _Rel As Object, ByVal _Total As Integer) As GridData(Of mT)
            Return New GridData(Of mT) With {.Rows = _Rel, .Total = _Total}
        End Function

        Private Shared Function GetGridDivData(Of mT)(ByVal _GridParm As GridParm, ByVal _IqList As IQueryable(Of T), ByVal _Total As Integer) As GridData(Of mT)
            Dim _DivRel As IQueryable(Of T) = _IqList.Skip(_GridParm.PageSize * (_GridParm.Page - 1)).Take(_GridParm.PageSize)
            Return GetGridData(Of mT)(_DivRel.ToList, _Total)
        End Function
    End Class
End Namespace


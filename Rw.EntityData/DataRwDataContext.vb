Option Strict On
Option Explicit On

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Data
Imports System.Data.Linq
Imports System.Data.Linq.Mapping
Imports System.Linq
Imports System.Linq.Expressions
Imports System.Reflection
Imports System.Runtime.Serialization


<Global.System.Data.Linq.Mapping.DatabaseAttribute(Name:="RwData")> _
Partial Public Class DataRwDataContext
    Inherits System.Data.Linq.DataContext

    Private Shared mappingSource As System.Data.Linq.Mapping.MappingSource = New AttributeMappingSource()

#Region "可扩展性方法定义"
    Partial Private Sub OnCreated()
    End Sub
#End Region

    Public Sub New()
        MyBase.New(Global.Rw.EntityData.My.MySettings.Default.RwDataConnectionString, mappingSource)
        OnCreated()
    End Sub

    Public Sub New(ByVal connection As String)
        MyBase.New(connection, mappingSource)
        OnCreated()
    End Sub

    Public Sub New(ByVal connection As System.Data.IDbConnection)
        MyBase.New(connection, mappingSource)
        OnCreated()
    End Sub

    Public Sub New(ByVal connection As String, ByVal mappingSource As System.Data.Linq.Mapping.MappingSource)
        MyBase.New(connection, mappingSource)
        OnCreated()
    End Sub

    Public Sub New(ByVal connection As System.Data.IDbConnection, ByVal mappingSource As System.Data.Linq.Mapping.MappingSource)
        MyBase.New(connection, mappingSource)
        OnCreated()
    End Sub

    Public ReadOnly Property ST_STBPRP_B() As System.Data.Linq.Table(Of ST_STBPRP_B)
        Get
            Return (Me.GetTable(Of ST_STBPRP_B)())
        End Get
    End Property

    Public ReadOnly Property ST_PPTN_R() As System.Data.Linq.Table(Of ST_PPTN_R)
        Get
            Return Me.GetTable(Of ST_PPTN_R)()
        End Get
    End Property

    Public ReadOnly Property ST_RSVR_R() As System.Data.Linq.Table(Of ST_RSVR_R)
        Get
            Return Me.GetTable(Of ST_RSVR_R)()
        End Get
    End Property
End Class





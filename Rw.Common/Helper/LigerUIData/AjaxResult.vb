Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Script.Serialization
Imports System.Web.Mvc

''' <summary>
''' 前台Ajax请求的统一返回结果类
''' </summary>
Public Class AjaxResult
    Private Sub New()
    End Sub

    Private m_iserror As Boolean = False

    ''' <summary>
    ''' 是否产生错误
    ''' </summary>
    Public Property IsError() As Boolean


    ''' <summary>
    ''' 错误信息，或者成功信息
    ''' </summary>
    Public Property Message() As String
        Get
            Return m_Message
        End Get
        Set(ByVal value As String)
            m_Message = value
        End Set
    End Property
    Private m_Message As String

    ''' <summary>
    ''' 成功可能时返回的数据
    ''' </summary>
    Public Property Data() As Object
        Get
            Return m_Data
        End Get
        Set(ByVal value As Object)
            m_Data = value
        End Set
    End Property
    Private m_Data As Object

#Region "Error"
    Public Shared Function [Error]() As AjaxResult
        Return New AjaxResult() With { _
          .IsError = True _
        }
    End Function
    Public Shared Function [Error](ByVal message As String) As AjaxResult
        Return New AjaxResult() With { _
          .IsError = True, _
          .Message = message _
        }
    End Function
#End Region

#Region "Success"
    Public Shared Function Success() As AjaxResult
        Return New AjaxResult() With { _
          .IsError = False _
        }
    End Function
    Public Shared Function Success(ByVal message As String) As AjaxResult
        Return New AjaxResult() With { _
          .IsError = False, _
          .Message = message _
        }
    End Function
    Public Shared Function Success(ByVal data As Object) As AjaxResult
        Return New AjaxResult() With { _
          .IsError = False, _
          .Data = data _
        }
    End Function
    Public Shared Function Success(ByVal data As Object, ByVal message As String) As AjaxResult
        Return New AjaxResult() With { _
          .IsError = False, _
          .Data = data, _
          .Message = message _
        }
    End Function
#End Region

    Public Overrides Function ToString() As String
        Return JSONHelper.ToJson(Me)
    End Function
End Class


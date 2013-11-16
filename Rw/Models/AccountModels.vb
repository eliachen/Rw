Imports System.ComponentModel
Imports System.ComponentModel.DataAnnotations
Imports System.Globalization

#Region "Models"
<PropertiesMustMatch("NewPassword", "ConfirmPassword", ErrorMessage:="新密码和确认密码不匹配。")> _
Public Class ChangePasswordModel
    Private oldPasswordValue As String
    Private newPasswordValue As String
    Private confirmPasswordValue As String

    <Required()> _
    <DataType(DataType.Password)> _
    <DisplayName("当前密码")> _
    Public Property OldPassword() As String
        Get
            Return oldPasswordValue
        End Get
        Set(ByVal value As String)
            oldPasswordValue = value
        End Set
    End Property

    <Required()> _
    <ValidatePasswordLength()> _
    <DataType(DataType.Password)> _
    <DisplayName("新密码")> _
    Public Property NewPassword() As String
        Get
            Return newPasswordValue
        End Get
        Set(ByVal value As String)
            newPasswordValue = value
        End Set
    End Property

    <Required()> _
    <DataType(DataType.Password)> _
    <DisplayName("确认新密码")> _
    Public Property ConfirmPassword() As String
        Get
            Return confirmPasswordValue
        End Get
        Set(ByVal value As String)
            confirmPasswordValue = value
        End Set
    End Property
End Class

Public Class LogOnModel
    Private userNameValue As String
    Private passwordValue As String
    Private rememberMeValue As Boolean

    <Required()> _
    <DisplayName("用户名")> _
    Public Property UserName() As String
        Get
            Return userNameValue
        End Get
        Set(ByVal value As String)
            userNameValue = value
        End Set
    End Property

    <Required()> _
    <DataType(DataType.Password)> _
    <DisplayName("密码")> _
    Public Property Password() As String
        Get
            Return passwordValue
        End Get
        Set(ByVal value As String)
            passwordValue = value
        End Set
    End Property

    <DisplayName("记住我?")> _
    Public Property RememberMe() As Boolean
        Get
            Return rememberMeValue
        End Get
        Set(ByVal value As Boolean)
            rememberMeValue = value
        End Set
    End Property
End Class

<PropertiesMustMatch("Password", "ConfirmPassword", ErrorMessage:="密码和确认密码不匹配。")> _
Public Class RegisterModel
    Private userNameValue As String
    Private passwordValue As String
    Private confirmPasswordValue As String
    Private emailValue As String

    <Required()> _
    <DisplayName("用户名")> _
    Public Property UserName() As String
        Get
            Return userNameValue
        End Get
        Set(ByVal value As String)
            userNameValue = value
        End Set
    End Property

    <Required()> _
    <DataType(DataType.EmailAddress)> _
    <DisplayName("电子邮件地址")> _
    Public Property Email() As String
        Get
            Return emailValue
        End Get
        Set(ByVal value As String)
            emailValue = value
        End Set
    End Property

    <Required()> _
    <ValidatePasswordLength()> _
    <DataType(DataType.Password)> _
    <DisplayName("密码")> _
    Public Property Password() As String
        Get
            Return passwordValue
        End Get
        Set(ByVal value As String)
            passwordValue = value
        End Set
    End Property

    <Required()> _
    <DataType(DataType.Password)> _
    <DisplayName("确认密码")> _
    Public Property ConfirmPassword() As String
        Get
            Return confirmPasswordValue
        End Get
        Set(ByVal value As String)
            confirmPasswordValue = value
        End Set
    End Property
End Class
#End Region

#Region "服务"
' FormsAuthentication 类型是密封的且包含静态成员，因此很难对
' 调用其成员的代码进行单元测试。下面的接口和 Helper 类演示
' 如何围绕这种类型创建一个抽象包装，以便可以对 AccountController
' 代码进行单元测试。

Public Interface IMembershipService
    ReadOnly Property MinPasswordLength() As Integer

    Function ValidateUser(ByVal userName As String, ByVal password As String) As Boolean
    Function CreateUser(ByVal userName As String, ByVal password As String, ByVal email As String) As MembershipCreateStatus
    Function ChangePassword(ByVal userName As String, ByVal oldPassword As String, ByVal newPassword As String) As Boolean
End Interface

Public Class AccountMembershipService
    Implements IMembershipService

    Private ReadOnly _provider As MembershipProvider

    Public Sub New()
        Me.New(Nothing)
    End Sub

    Public Sub New(ByVal provider As MembershipProvider)
        _provider = If(provider, Membership.Provider)
    End Sub

    Public ReadOnly Property MinPasswordLength() As Integer Implements IMembershipService.MinPasswordLength
        Get
            Return _provider.MinRequiredPasswordLength
        End Get
    End Property

    Public Function ValidateUser(ByVal userName As String, ByVal password As String) As Boolean Implements IMembershipService.ValidateUser
        If String.IsNullOrEmpty(userName) Then Throw New ArgumentException("值不能为 null 或为空。", "userName")
        If String.IsNullOrEmpty(password) Then Throw New ArgumentException("值不能为 null 或为空。", "password")

        Return _provider.ValidateUser(userName, password)
    End Function

    Public Function CreateUser(ByVal userName As String, ByVal password As String, ByVal email As String) As MembershipCreateStatus Implements IMembershipService.CreateUser
        If String.IsNullOrEmpty(userName) Then Throw New ArgumentException("值不能为 null 或为空。", "userName")
        If String.IsNullOrEmpty(password) Then Throw New ArgumentException("值不能为 null 或为空。", "password")
        If String.IsNullOrEmpty(email) Then Throw New ArgumentException("值不能为 null 或为空。", "email")

        Dim status As MembershipCreateStatus
        _provider.CreateUser(userName, password, email, Nothing, Nothing, True, Nothing, status)
        Return status
    End Function

    Public Function ChangePassword(ByVal userName As String, ByVal oldPassword As String, ByVal newPassword As String) As Boolean Implements IMembershipService.ChangePassword
        If String.IsNullOrEmpty(userName) Then Throw New ArgumentException("值不能为 null 或为空。", "username")
        If String.IsNullOrEmpty(oldPassword) Then Throw New ArgumentException("值不能为 null 或为空。", "oldPassword")
        If String.IsNullOrEmpty(newPassword) Then Throw New ArgumentException("值不能为 null 或为空。", "newPassword")

        ' 在某些出错情况下，基础 ChangePassword() 将引发异常，
        ' 而不是返回 false。
        Try
            Dim currentUser As MembershipUser = _provider.GetUser(userName, True)
            Return currentUser.ChangePassword(oldPassword, newPassword)
        Catch ex As ArgumentException
            Return False
        Catch ex As MembershipPasswordException
            Return False
        End Try
    End Function
End Class

Public Interface IFormsAuthenticationService
    Sub SignIn(ByVal userName As String, ByVal createPersistentCookie As Boolean)
    Sub SignOut()
End Interface

Public Class FormsAuthenticationService
    Implements IFormsAuthenticationService

    Public Sub SignIn(ByVal userName As String, ByVal createPersistentCookie As Boolean) Implements IFormsAuthenticationService.SignIn
        If String.IsNullOrEmpty(userName) Then Throw New ArgumentException("值不能为 null 或为空。", "userName")

        FormsAuthentication.SetAuthCookie(userName, createPersistentCookie)
    End Sub

    Public Sub SignOut() Implements IFormsAuthenticationService.SignOut
        FormsAuthentication.SignOut()
    End Sub
End Class
#End Region

#Region "验证"
Public NotInheritable Class AccountValidation
    Public Shared Function ErrorCodeToString(ByVal createStatus As MembershipCreateStatus) As String
        ' 请参见 http://go.microsoft.com/fwlink/?LinkID=177550 以查看
        ' 状态代码的完整列表。
        Select Case createStatus
            Case MembershipCreateStatus.DuplicateUserName
                Return "用户名已存在。请另输入一个用户名。"

            Case MembershipCreateStatus.DuplicateEmail
                Return "已存在与该电子邮件地址对应的用户名。请另输入一个电子邮件地址。"

            Case MembershipCreateStatus.InvalidPassword
                Return "提供的密码无效。请输入有效的密码值。"

            Case MembershipCreateStatus.InvalidEmail
                Return "提供的电子邮件地址无效。请检查该值并重试。"

            Case MembershipCreateStatus.InvalidAnswer
                Return "提供的密码取回答案无效。请检查该值并重试。"

            Case MembershipCreateStatus.InvalidQuestion
                Return "提供的密码取回问题无效。请检查该值并重试。"

            Case MembershipCreateStatus.InvalidUserName
                Return "提供的用户名无效。请检查该值并重试。"

            Case MembershipCreateStatus.ProviderError
                Return "身份验证提供程序返回了错误。请验证您的输入并重试。如果问题仍然存在，请与系统管理员联系。"

            Case MembershipCreateStatus.UserRejected
                Return "已取消用户创建请求。请验证您的输入并重试。如果问题仍然存在，请与系统管理员联系。"

            Case Else
                Return "发生未知错误。请验证您的输入并重试。如果问题仍然存在，请与系统管理员联系。"
        End Select
    End Function
End Class

<AttributeUsage(AttributeTargets.Class, AllowMultiple:=True, Inherited:=False)> _
Public NotInheritable Class PropertiesMustMatchAttribute
    Inherits ValidationAttribute

    Private Const _defaultErrorMessage As String = "'{0}' 和 '{1}' 不匹配。"
    Private ReadOnly _confirmProperty As String
    Private ReadOnly _originalProperty As String
    Private ReadOnly _typeId As New Object()

    Public Sub New(ByVal originalProperty As String, ByVal confirmProperty As String)
        MyBase.New(_defaultErrorMessage)

        _originalProperty = originalProperty
        _confirmProperty = confirmProperty
    End Sub

    Public ReadOnly Property ConfirmProperty() As String
        Get
            Return _confirmProperty
        End Get
    End Property

    Public ReadOnly Property OriginalProperty() As String
        Get
            Return _originalProperty
        End Get
    End Property

    Public Overrides ReadOnly Property TypeId() As Object
        Get
            Return _typeId
        End Get
    End Property

    Public Overrides Function FormatErrorMessage(ByVal name As String) As String
        Return String.Format(CultureInfo.CurrentUICulture, ErrorMessageString, OriginalProperty, ConfirmProperty)
    End Function

    Public Overrides Function IsValid(ByVal value As Object) As Boolean
        Dim properties As PropertyDescriptorCollection = TypeDescriptor.GetProperties(value)
        Dim originalValue = properties.Find(OriginalProperty, True).GetValue(value)
        Dim confirmValue = properties.Find(ConfirmProperty, True).GetValue(value)
        Return Object.Equals(originalValue, confirmValue)
    End Function
End Class

<AttributeUsage(AttributeTargets.Field Or AttributeTargets.Property, AllowMultiple:=False, Inherited:=True)> _
Public NotInheritable Class ValidatePasswordLengthAttribute
    Inherits ValidationAttribute

    Private Const _defaultErrorMessage As String = "'{0}' 必须至少包含 {1} 个字符。"
    Private ReadOnly _minCharacters As Integer = Membership.Provider.MinRequiredPasswordLength

    Public Sub New()
        MyBase.New(_defaultErrorMessage)
    End Sub

    Public Overrides Function FormatErrorMessage(ByVal name As String) As String
        Return String.Format(CultureInfo.CurrentUICulture, ErrorMessageString, name, _minCharacters)
    End Function

    Public Overrides Function IsValid(ByVal value As Object) As Boolean
        Dim valueAsString As String = TryCast(value, String)
        Return (valueAsString IsNot Nothing) AndAlso (valueAsString.Length >= _minCharacters)
    End Function
End Class
#End Region

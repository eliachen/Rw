<%@ Control Language="VB" Inherits="System.Web.Mvc.ViewUserControl" %>
<%-- 下面一行代码用来迂回解决一个ASP.NET的编译警告 --%>
<%: ""%>
<%
    If Request.IsAuthenticated Then
    %>
        欢迎您，<b><%: Page.User.Identity.Name %></b>!
        [ <%: Html.ActionLink("注销", "LogOff", "Account")%> ]
    <%
    Else
    %>
        [ <%: Html.ActionLink("登录", "LogOn", "Account")%> ]
    <%        
    End If
%>
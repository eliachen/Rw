<HandleError()> _
Public Class HomeController
    Inherits System.Web.Mvc.Controller

    Function Index() As ActionResult
        ViewData("Message") = "欢迎使用 ASP.NET MVC!"
        Return View()
    End Function

    Function About() As ActionResult
        Return View()
    End Function
End Class

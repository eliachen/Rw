Namespace Rw
    Public Class DefaultController
        Inherits System.Web.Mvc.Controller
        '
        ' GET: /Default
        Public Overridable Function Index(ByVal id As String) As ActionResult
            Return View(id)
        End Function
    End Class
End Namespace
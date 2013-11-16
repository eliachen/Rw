' 注意: 有关启用 IIS6 或 IIS7 经典模式的说明，
' 请访问 http://go.microsoft.com/?LinkId=9394802

Imports Rw.EntityData.RwEntitySettings.MySettings

Imports Rw.DAL.My

Public Class MvcApplication
    Inherits System.Web.HttpApplication

    Shared Sub RegisterRoutes(ByVal routes As RouteCollection)
        routes.IgnoreRoute("{resource}.axd/{*pathInfo}")
        routes.IgnoreRoute("Report/test/{weform}")
        routes.IgnoreRoute("ReportWebForm/Water/{weform}")
        ' MapRoute 按顺序采用以下参数:
        ' (1) 路由名称
        ' (2) 带参数的 URL
        ' (3) 参数默认值
        routes.MapRoute( _
            "Default", _
            "{controller}/{action}/{id}", _
            New With {.controller = "Home", .action = "Index", .id = UrlParameter.Optional} _
        )

    End Sub

    Sub Application_Start()
        AreaRegistration.RegisterAllAreas()
        RegisterRoutes(RouteTable.Routes)
        '设置数据库字符串
        EntityData.RwEntitySettings.MySettings.Default.RwConnectionString = My.Rw.Default.DbConnStr
        '报表地址配置
        DAL.My.MySettings.Default.RepPath = My.Rw.Default.RepPath
    End Sub
End Class

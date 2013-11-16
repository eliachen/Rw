<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportRain.aspx.vb" Inherits="Rw.ReportRain" %>

<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms,Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManagerForRep" runat="server"/>
     <rsweb:ReportViewer ID="ReportViewerForRain" runat="server" 
         Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(集合)" 
         WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="609px" 
         Width="920px">
         <LocalReport ReportPath="ReportWebForm\Rain\Report1.rdlc">
         </LocalReport>
     </rsweb:ReportViewer>
    </form>
</body>
</html>

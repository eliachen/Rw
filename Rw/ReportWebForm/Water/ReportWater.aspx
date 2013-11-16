<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReportWater.aspx.vb" Inherits="Rw.ReportWater" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="formRep" runat="server">
    <asp:ScriptManager ID="ScriptManagerForRep" runat="server"/>
    <rsweb:ReportViewer ID="ReportViewerForWater" runat="server" 
        Font-Names="Verdana" Font-Size="8pt" InteractiveDeviceInfos="(集合)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="640px" 
        Width="1000px">
        <LocalReport ReportPath="ReportWebForm\Water\Model\ReportWaterDay.rdlc">
        </LocalReport>
    </rsweb:ReportViewer>
    </form>
</body>

<script type="text/javascript">
   
    //var g = document.getElementById("ReportViewerForWater");
    //g.setAttribute("ClientHeight", 100);
    //g.setAttribute("ClientWidth", 100);
</script>
</html>

<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Views/Master/BaiduMap.Master" CodeBehind="WebForm1.aspx.vb" Inherits="Rw.WebForm1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="js" runat="server">
   <script type="text/javascript">

       $(function () {
           Initial("测试");
           getBoundary(bdmap, "安徽省巢湖市");
       });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="content" runat="server">
    <img src="../lib/images/weather/309.png" />
    <img src="../lib/ligerUI/skins/icons/map-marker/map-marker-bubble-pink.png" />
    <img src="../lib/ligerUI/skins/icons/busy.gif" />

     <div><p style="color:red; text-align: center;">降雨量报警：暴雨！</p></div>
</asp:Content>



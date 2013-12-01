<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Views/Master/BaiduMap.Master" CodeBehind="WebFormTestMap.aspx.vb" Inherits="Rw.WebFormTestMap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="js" runat="server">
    <script type="text/javascript">
        $(function () {
            InitialLayout(200, "xx");
            Initial('yes');
            bdmap.centerAndZoom(new BMap.Point(116.404, 39.915), 14);

            var pt = new BMap.Point(116.417, 39.909);
            var myIcon = new BMap.Icon("../lib/ligerUI/skins/icons/maker/pin-location-blue.png", new BMap.Size(25, 25));
            var marker2 = new BMap.Marker(pt, { icon: myIcon });  // 创建标注
            bdmap.addOverlay(marker2);              // 将标注添加到地图中
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="nav" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="content" runat="server">

</asp:Content>

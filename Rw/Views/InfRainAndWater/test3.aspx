<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" MasterPageFile= "~/Views/Master/SiteTest.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="js">
    
    <script type="text/javascript">
        $(function () {

            // 百度地图API功能
            var map = new BMap.Map("allmap");
            map.centerAndZoom(new BMap.Point(116.404, 39.915), 14);
            //var marker1 = new BMap.Marker(new BMap.Point(116.384, 39.925));  // 创建标注
            //map.addOverlay(marker1);              // 将标注添加到地图中
            addMaker(map, new BMap.Point(116.384, 39.925), { label: 'ss', img: '../../lib/ligerUI/skins/icons/maker/pin-location-blue.png' });

        });
    </script>
</asp:Content>

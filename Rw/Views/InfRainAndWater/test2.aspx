<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Views/Master/BaiduMap.Master" %>

<asp:Content runat ="server" ContentPlaceHolderID="content">
  
</asp:Content>

<asp:Content runat ="server" ContentPlaceHolderID= "js">
      <script type="text/javascript">
          $(function () {

              InitialLayout(260, "ss");
              Initial("xx");
              //bdmap.centerAndZoom(new BMap.Point(116.404, 39.915), 14);
              var marker1 = new BMap.Marker(new BMap.Point(116.384, 39.925));  // 创建标注
              bdmap.addOverlay(marker1);              // 将标注添加到地图中
              //getBoundary(bdmap, '北京市');
              //addMaker(bdmap, new BMap.Point(116.404, 39.915), null);


          });


    </script>
</asp:Content>

<asp:Content runat ="server" ContentPlaceHolderID="nav">

</asp:Content>





<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
       <style>
      body, html, #allmap {
          width: 100%;
          height: 100%;
          overflow: hidden;
          margin: 0;
      }

  </style>
    <script src="../../Scripts/BaiduMap/BaiduMapHelper.js"></script>
    <script src="../lib/jquery/jquery-1.6.2.min.js"></script>

    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=79911baf0e80c70c7e77e5654b4a8204"></script>

    <script type="text/javascript">

        $(function () {
            // 百度地图API功能
            var map = new BMap.Map("allmap");
            map.centerAndZoom(new BMap.Point(116.404, 39.915), 14);
            var marker1 = new BMap.Marker(new BMap.Point(116.384, 39.925));  // 创建标注
            map.addOverlay(marker1);              // 将标注添加到地图中

            //创建信息窗口
            var infoWindow1 = new BMap.InfoWindow("普通标注");
            marker1.addEventListener("click", function () { this.openInfoWindow(infoWindow1); });


            //创建小狐狸
            var pt = new BMap.Point(116.417, 39.909);
            var myIcon = new BMap.Icon("../lib/ligerUI/skins/icons/maker/pin-location-blue.png", new BMap.Size(300, 157));
            var marker2 = new BMap.Marker(pt, { icon: myIcon });  // 创建标注
            map.addOverlay(marker2);              // 将标注添加到地图中

            addMaker(map,new BMap.Point(116.420, 39.910),{label:'ss',img:"../lib/ligerUI/skins/icons/maker/pin-location-blue.png",animation:BMAP_ANIMATION_BOUNCE});


        });

    </script>
</head>
<body>
      <div id="allmap">


    </div>
</body>
</html>

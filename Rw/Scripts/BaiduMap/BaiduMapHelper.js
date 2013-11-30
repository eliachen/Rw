
//map
//point:(BMap.Point)
//cig.img(String)图片地址
//cig.label(String)显示标签
//cig.animation(enum:BMAP_ANIMATION_DROP:坠落,BMAP_ANIMATION_BOUNCE:跳动)
//作用:添加标注
function addMaker(map, point, cig) {
    if (!cig) {
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);              // 将标注添加到地图中
        return marker;
    } else {
        //    Size(width:Number, height:Number)
        var _size = new BMap.Size(24, 24);
        var _icon = new BMap.Icon(cig.img, _size);
        var MarkerOptions = { icon: _icon };
        var marker = new BMap.Marker(point, MarkerOptions);
        //var marker = new BMap.Marker(point);
        //设置label
        if (cig.label) {
            var _label = new BMap.Label("");
            _label.setContent(cig.label);
            _label.setStyle({ color: "black", border: "0" });
            var off_x = cig.label.length;
            _label.setOffset(new BMap.Size(-3.5 * (off_x - 1), 25));
            marker.setLabel(_label);
          
        };
        map.addOverlay(marker);
        //动画
        if (cig.animation) {
            marker.setAnimation(cig.animation);
        };
        return marker;
    };

};


/// <reference path="../../lib/ligerUI/skins/icons/true.gif" />

//map:地图
//addr:行政区地名
//作用:行政区划分
function getBoundary(map, addr) {
    var bdary = new BMap.Boundary();
    bdary.get(addr, function (rs) {
        //map.clearOverlays();        //清除地图覆盖物       
        var count = rs.boundaries.length; //行政区域的点有多少个
        for (var i = 0; i < count; i++) {
            var ply = new BMap.Polygon(rs.boundaries[i], { strokeWeight: 2, strokeColor: "#3410e6" }); //建立多边形折线
            map.addOverlay(ply);  //添加覆盖物
            map.setViewport(ply.getPath());    //调整视野 
        }
    });
};

//map
//makers:需要聚合的maker数组
//作用:聚合数组
function MakerClusterer(map, makersdata) {
    //最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
    var markerClusterer = new BMapLib.MarkerClusterer(map,{markers:makersdata});
};

//map:(BMap)
//id:(String)
//Anchor:(Enum)  BMAP_ANCHOR_TOP_LEFT	    控件将定位到地图的左上角。
        //       BMAP_ANCHOR_TOP_RIGHT	    控件将定位到地图的右上角。
        //       BMAP_ANCHOR_BOTTOM_LEFT	控件将定位到地图的左下角。
        //       BMAP_ANCHOR_BOTTOM_RIGHT   控件将定位到地图的右下角。
//Offset:(BMap.Size)
function addCtrl(map,id,Anchor,Offset) {

    function AddDoc(id) {
        // 设置默认停靠位置和偏移量  
        this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
        this.defaultOffset = new BMap.Size(10, 10);
        this.id = id;
    };

    AddDoc.prototype = new BMap.Control();

    AddDoc.prototype.initialize = function (map) {
        // 创建一个DOM元素  
        var div = document.getElementById(this.id);
        map.getContainer().appendChild(div);
        // 将DOM元素返回  
        return div;
    };

    // 创建控件实例
    var newCtrl = new AddDoc(id);
    newCtrl.setAnchor(Anchor);
    newCtrl.setOffset(Offset);
    // 添加到地图当中
    map.addControl(newCtrl);
};

//BMAP_NORMAL_MAP	此地图类型展示普通街道视图。
//BMAP_PERSPECTIVE_MAP	此地图类型展示透视图像视图。
//BMAP_SATELLITE_MAP	此地图类型展示卫星视图。(自 1.2 新增)
//BMAP_HYBRID_MAP	此地图类型展示卫星和路网的混合视图。(自 1.2 新增）






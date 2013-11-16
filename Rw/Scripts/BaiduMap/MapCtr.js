// 定义一个控件类，即function  
function ZoomControl(id) {
    // 设置默认停靠位置和偏移量  
    this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
    this.defaultOffset = new BMap.Size(10, 10);
    this.id = id;
};

// 通过JavaScript的prototype属性继承于BMap.Control  
ZoomControl.prototype = new BMap.Control();  


// 自定义控件必须实现initialize方法，并且将控件的DOM元素返回  
// 在本方法中创建个div元素作为控件的容器，并将其添加到地图容器中
ZoomControl.prototype.initialize = function (map) {
    // 创建一个DOM元素  
    var div = document.getElementById(this.id);
    map.getContainer().appendChild(div);
    // 将DOM元素返回  
    return div;
};
   
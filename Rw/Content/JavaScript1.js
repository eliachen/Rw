

//maker
//
var eliachenBdMaker = function (_bdmaker, _cig) {
    this.bdmaker = _bdmaker;
    this.cig = _cig;
};



var eliachenBdMakersManager = function (_bdmakers, _cig) {
    this.bdmakers = _bdmakers;
    this.cig = _cig;

    //添加到地图
    this.addtoMap = function (map) {
        for (var mk in _bdmakers) {
            map.addOverlay(mk);
        };
    };
};



var xx = new eliachenBdMaker();







var makersHelper = function (makers, cig) {
    $.each(makers, function (index, item) {
        item.addEventListener('mouseover', function (e) {
            cig.mouseoverEvent(e)
            var tmpid = $.ligerTip({ content: tmpcontent, width: 200, x: e.Pa.x, y: e.Pa.y }).id;

            //鼠标移走
            item.addEventListener('mouseout', function (e) {
                if (cig.mouseoutEvent) {
                    cig.mouseoutEvent(e);
                };
                $('#' + tmpid).remove();
            });

            //鼠标点击
            item.addEventListener('click', function (e) {
                if (cig.clickEvent) {
                    cig.clickEvent(e);
                };
                $('#' + tmpid).remove();
            });

            //菜单关联
            var ContextMenu = new BMap.ContextMenu;

            ContextMenu.addItem(new BMap.MenuItem("泵站信息", function () {
                openDetailDialog({ type: 'p', title: '泵站监测信息' });
            }));

            ContextMenu.addItem(new BMap.MenuItem("闸门信息", function () {
                openDetailDialog({ type: 'g', title: '闸门监测信息' });
            }));

            item.addContextMenu(ContextMenu);
        });
    });
};

var eliachenBdMaker = function (_cig) {
    this.bdmaker = _bdmaker;
    this.cig = _cig;

    //设置属性
    if (!this.cig) {
        this.bdmaker = new BMap.Marker(this.cig.point);  // 创建标注
    } else {
        //Size(width:Number, height:Number)
        var _size = new BMap.Size(24, 24);
        var _icon = new BMap.Icon(this.cig.img, _size);
        var MarkerOptions = { icon: _icon };
        var marker = new BMap.Marker(point, MarkerOptions);
        //var marker = new BMap.Marker(point);
        //设置label
        if (this.cig.label) {
            var _label = new BMap.Label("");
            _label.setContent(this.cig.label);
            _label.setStyle({ color: "black", border: "0" });
            var off_x = this.cig.label.length;
            _label.setOffset(new BMap.Size(-3.5 * (off_x - 1), 25));
            marker.setLabel(_label);
        };

        //return marker;
    };

    //绑定事件
    //tip的id
    var tmpid;
    if (_cig.mouseover) {
        emk.bdmaker.addEventListener('mouseover', function (e) {
            _cig.mouseover(e, emk);
            tmpid = $.ligerTip({
                content: emk.cig.content,
                width: emk.cig.tip.width || 200,
                x: e.Pa.x, y: e.Pa.y
            }).id;
            emk.bdmaker.addEventListener('mouseout', function (e) {
                $('#' + tmpid).remove();
                if (_cig.mouseout) {
                    _cig.mouseout(e, emk);
                }
            });
        });
    };

    if (_cig.click) {
        emk.bdmaker.addEventListener('click', function (e) {
            $('#' + tmpid).remove();
            _cig.click(e, emk);
        });
    };

    //菜单关联
    if (emk.cig.contexmenu) {
        var ContextMenu = new BMap.ContextMenu;
        for (ct in emk.cig.contexmenu) {
            ContextMenu.addItem(new BMap.MenuItem(ct.name, function () {
                ct.event();
            }));
        };
        emk.bdmaker.addContextMenu(ContextMenu);
    };


    var ss = function () {
        this.cig = 1;

        var k = function () {
            cig = 2;
        }
    }
};


<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />

 <!--百度地图相关-->
    <script src="../../Scripts/BaiduMap/BaiduMapHelper.js?new Date()" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=79911baf0e80c70c7e77e5654b4a8204"></script>

     <%--<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>--%>
    <%-- <script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
     <script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>--%>

    
<link href="../../lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<%--<link href="../../lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />--%>

    <script src="../../lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/core/base.js" type="text/javascript"></script>


    <script src="../../lib/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script> 
    <script src="../../lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>

    <script src="../../lib/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerAccordion.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="../../lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="../../Scripts/LigerUI/AjaxHelper.js" type="text/javascript"></script>

    <script src="../../Scripts/BaiduMap/MapCtr.js" type="text/javascript"></script>
   <%-- <script src="../../Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>--%>
   
<title>雨情</title>
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
</style>

<script type ="text/javascript">
    $.ligerui.controls.Dialog.prototype._borderX = 2;
    $.ligerui.controls.Dialog.prototype._borderY = 0;
</script>

<%--地图数据处理--%>
<script type="text/javascript">
    //地图信息加载
    //获取站点信息:站点编号，站点名称,经度，纬度，附加信息
    var MapDeal = function (data) {
        $.each(data, function (index, item) {
            //正常测站
            var makersrc = "../../lib/ligerUI/skins/icons/maker/pin-location-green.png";
            var makersrcAlm= "../../lib/ligerUI/skins/icons/maker/pin-location-red.png";


            //演示~~~！！！
            if(index%4==0){
                var tmpmaker = addMaker(map, new BMap.Point(item.LGTD, item.LTTD), {img:makersrc,label:item.STNM,animation:BMAP_ANIMATION_DROP});
            }else{
                var tmpmaker = addMaker(map, new BMap.Point(item.LGTD, item.LTTD), {img:makersrcAlm,label:item.STNM,animation:BMAP_ANIMATION_BOUNCE});
            };

            //添加maker
            //var tmpmaker = addMaker(map, new BMap.Point(item.LGTD, item.LTTD), {img:makersrc,label:item.STNM,animation:BMAP_ANIMATION_DROP});

            //修饰maker:
            //信息显示：鼠标移动动作
            var tipid = null;
            tmpmaker.addEventListener("mouseover", function (e) {
                //演示over的还原
                //var content =     "<div><p style=color:black>站名:" + item.STNM + "</p></div>"
                //                + "<div><p style=color:black>站址:" + item.STLC + "</p></div>"
                //                + "<div><p style=color:black>管理单位：" + item.ADMAUTH + "</p></div>";

                //演示~~~！！！
                var content;
                if(index%4==0){
                    content =     "<div><p style=color:black>站名:" + item.STNM + "</p></div>"
                                + "<div><p style=color:black>站址:" + item.STLC + "</p></div>"
                                + "<div><p style=color:black>管理单位：" + item.ADMAUTH + "</p></div>";

                }else{
                    content=        "<div><p style=color:black;text-align:center>站名:" + item.STNM + "</p></div>"+
                                   "<div><p style=color:black;text-align:center>站址:" + item.STLC + "</p></div>" + 
                                   "<div><p style=color:black;text-align:center>管理单位：" + item.ADMAUTH + "</p></div>"+
                                   "<div><p style=color:red;text-align:center>----------</p></div>" +
                                   "<div><p style=color:red;text-align:center>!!!降雨量报警!!!</p></div>" +
                                   "<div><p style=color:red;text-align:center>类型:暴雨</p></div>" +
                                   "<div><p style=color:red;text-align:center>----------</p></div>" +
                                   "<div><p style=color:red;text-align:center>!!!水位超限报警!!!</p></div>"+
                                   "<div><p style=color:red;text-align:center>类型:超历史水位(+1.5m)</p></div>"
                }
                tipid = $.ligerTip({ content: content, width: 200, x: e.clientX, y: e.clientY }).id;
            });

            tmpmaker.addEventListener("mouseout", function (e) {
                $('#' + tipid).remove();
            });

            //每日降雨量显示
            tmpmaker.addEventListener("click", function (e) {
                $('#' + tipid).remove();
                //地图居中显示
                map.centerAndZoom(new BMap.Point(e.point.lng, e.point.lat), 14);
            });



            //关联右键菜单
            var ContextMenu = new BMap.ContextMenu;
            switch (item.exSTTP) {
                case "rain":
                    ContextMenu.addItem(new BMap.MenuItem("雨情信息", function () {
                        OpenRainDialog("rain", item);
                    }));
                    break;
                case "water":
                    ContextMenu.addItem(new BMap.MenuItem("水情信息", function () {
                        OpenRainDialog("water", item);
                    }));
                    break;
                case "rainandwater":
                    ContextMenu.addItem(new BMap.MenuItem("雨情信息", function () {
                        OpenRainDialog("rain", item);
                    }));
                    ContextMenu.addItem(new BMap.MenuItem("水情信息", function () {
                        OpenRainDialog("water", item);
                    }));
                    break;

            };
            tmpmaker.addContextMenu(ContextMenu);

            //makers添加
            makers.push(tmpmaker);
        }, null);

        //地图点聚合
        //MakerClusterer(map, makers);

        //绘制边界（外设）
        getBoundary(map, MapAddr);
    };

  
</script>
<%--雨情树处理--%>
<script type="text/javascript">
    //设置图标:雨情
        var icon_right = "../../lib/ligerUI/skins/icons/ok.gif";
        var icon_false = "../../lib/ligerUI/skins/icons/busy.gif";

        var icon_StaYes = "../../lib/ligerUI/skins/icons/rain/yesSta.png";
        var icon_StaNo = "../../lib/ligerUI/skins/icons/rain/noSta.png";

    //雨情树处理
   var TreeRainDeal=  function  (data) {

        //加载数据
        var rainData = [];
        var rightData = [];
        var falseData = [];

        $.each(data, function (index, item) {
            if (item.SumDrp == null) {
                falseData.push({ STCD: item.STCD, STNM: item.STNM, icon: icon_false, text: item.STNM });
            } else {
                rightData.push({ STCD: item.STCD, STNM: item.STNM, icon: icon_right, text: item.STNM + '...' + item.SumDrp + 'mm' });
                //var txt = " <table><tr><td>" + "t1" + "</td><td>" + "t2" + "</td></tr></table>";

                //rightData.push({ STCD: item.STCD, STNM: item.STNM, icon: icon_right, text: item.STNM +"..."+ item.SumDrp+"(mm)" });
            }
        });

        rainData.push({ icon: icon_StaYes, text: "正常测站", isExpand: true, children: rightData });
        rainData.push({ icon: icon_StaNo, text: "故障测站", isExpand: true, children: falseData });

        $("#treeInfRain").ligerTree({
            treeLine: false,
            checkbox: false,
            nodeWidth: 140,
            data: rainData,
            onClick: onRainTreeNodeClick
        });

        };

        //点击树节点事件
    var onRainTreeNodeClick = function (note) {
            if (note.data.STCD != undefined) {
                var opts = { STCD: note.data.STCD, STNM: note.data.STNM };
                OpenRainDialog("rain", opts);
            };
        };

</script>
<%--水情树处理--%>
<script type="text/javascript">
    //设置图标:水情
    var icon_right = "../../lib/ligerUI/skins/icons/ok.gif";
    var icon_false = "../../lib/ligerUI/skins/icons/busy.gif";

    var icon_StaYes = "../../lib/ligerUI/skins/icons/rain/yesSta.png";
    var icon_StaNo = "../../lib/ligerUI/skins/icons/rain/noSta.png";

    //水树处理
   var TreeWaterDeal= function (data) {
        //加载数据
        var rainData = [];
        var rightData = [];
        var falseData = [];

        $.each(data, function (index, item) {
            if (item.RZ == null) {
                falseData.push({ STCD: item.STCD, STNM: item.STNM, icon: icon_false, text: item.STNM });
            } else {
                rightData.push({ STCD: item.STCD, STNM: item.STNM, icon: icon_right, text: item.STNM + '...' + item.RZ + 'm' });
                //var txt = " <table><tr><td>" + "t1" + "</td><td>" + "t2" + "</td></tr></table>";

                //rightData.push({ STCD: item.STCD, STNM: item.STNM, icon: icon_right, text: item.STNM +"..."+ item.SumDrp+"(mm)" });
            }
        });

        rainData.push({ icon: icon_StaYes, text: "正常测站", isExpand: true, children: rightData });
        rainData.push({ icon: icon_StaNo, text: "故障测站", isExpand: true, children: falseData });

        $("#treeInfWater").ligerTree({
            treeLine: false,
            checkbox: false,
            nodeWidth: 140,
            data: rainData,
            onClick: onWaterTreeNodeClick
        });

    };

    //点击树节点事件
   var onWaterTreeNodeClick= function (note) {
        if (note.data.STCD != undefined) {
            var opts = { STCD: note.data.STCD, STNM: note.data.STNM };
            OpenRainDialog("water", opts);
        };
    };

</script>
<%--Initial--%>
<script type="text/javascript">
//-----服务器数据设置-----
    var MapAddr;

 //------------------------   
    //地图变量
    var map;
    // 获取站点信息地址
    var urlstation = "/InfBasicData/InfStation";

    //聚合的makers
    var makers = [];
    
    //已经打开的对话框
    var openDialogs = [];

   
    //初始化地图
    $(function () {

        //初始化布局
        InitialLayout();

        //初始化参数
        MapAddr = $("#MapAddr").val();


        try {

            //全局地图
            map = new BMap.Map("allmap", { mapType: BMAP_HYBRID_MAP });                        // 创建Map实例
            map.centerAndZoom(new BMap.Point(118.0, 30.0), 12);     // 初始化地图,设置中心点坐标和地图级别
            //map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
            map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
            map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
            map.enableScrollWheelZoom();                            //启用滚轮放大缩小
            map.addControl(new BMap.MapTypeControl());          //添加地图类型控件


             //初始化地图标题
              $("#maptitle").html('<%:ViewData("MapTitle") %>');
              addCtrl(map, "DivTitle", BMAP_ANCHOR_TOP_LEFT, new BMap.Size(25, 15));

            LigerUIHelper.tip("如果地图显示有误,请检测检测网络状况或刷新该页面!");

            //加载地图数据
            LigerUIHelper.ajax({ loading: "加载地图数据信息.....",
                url: "/InfBasicData/InfStation",
                success: MapDeal
            });

        } catch (err) {
            LigerUIHelper.tip("无法加载百度地图,请检测检测网络状况或刷新该页面!");
        }


        //树节点加载
        LigerUIHelper.ajax({ loading: "加载雨水情测站信息.....",
            url: "/InfRainAndWater/infrainAllQuery",
            success: TreeRainDeal
        });

        LigerUIHelper.ajax({ loading: "加载雨水情测站信息.....",
            url: "/InfRainAndWater/InfWaterAllQuery",
            success: TreeWaterDeal
        });


        //刷新数据
        setInterval(function () {
            //树节点加载
            LigerUIHelper.ajax({ loading: "加载雨水情测站信息.....",
                url: "/InfRainAndWater/infrainAllQuery",
                success: TreeRainDeal
            });

            LigerUIHelper.ajax({ loading: "加载雨水情测站信息.....",
                url: "/InfRainAndWater/InfWaterAllQuery",
                success: TreeWaterDeal
            });

        }, <%:ViewData("FlashTime")%>);


    });
</script>
<%--数据窗口处理--%>
<script type="text/javascript">
    //雨情查看信息窗:通过STCD作为主键进行避免查找
    //type: -rain -water
    //stationstate:{string:STCD,string:STNM}
  var OpenRainDialog =  function (type,stationstate) {


                    //查找窗体索引
                    var windowindex = -1;
                    $.each(openDialogs, function (indexDlg, stationstateDlg) {
                        if (stationstateDlg.dialog.opener == ('R' + stationstate.STCD) || stationstateDlg.dialog.opener == ('W' + stationstate.STCD)) {
                            windowindex = indexDlg;
                            return false;
                        } 
                    });

                    if (windowindex > -1) {
                        openDialogs[windowindex].active()
                    } else {

                        var DlgOpts = { height: 500, width: 700, left: 0, top: 0,
                            url: '/infRainAndWater/RainQuery?_stcd=' + stationstate.STCD + '&_stnm=' + stationstate.STNM,
                            opener: 'R'+stationstate.STCD, title: stationstate.STNM + "(" + stationstate.STCD + ")",
                            showMax: false,
                            showToggle: true, showMin: true, isResize: false,
                            modal: false,
                            onClose: function () {
                                //窗口数组中删除该项
                                openDialogs.splice(tmpindex, 1);
                            }
                        };

                        switch (type) {

                            case "rain":
                                DlgOpts.url = '/infRainAndWater/RainQuery?_stcd=' + stationstate.STCD + '&_stnm=' + stationstate.STNM;
                                DlgOpts.opener = 'R' + stationstate.STCD;
                                DlgOpts.title = stationstate.STNM + "(" + stationstate.STCD + ")"+"每日降雨过程";
                                break;
                    case "water":
                        DlgOpts.url = '/infRainAndWater/WaterQuery?_stcd=' + stationstate.STCD + '&_stnm=' + stationstate.STNM;
                        DlgOpts.opener = 'W' + stationstate.STCD;
                        DlgOpts.title = stationstate.STNM + "(" + stationstate.STCD + ")" + "每日整点水位过程";
                        break;
                    case "":

                        break;
                    default:

                };

                        //利用STCD作为唯一的窗口编码
                        var openedDialog = $.ligerDialog.open(DlgOpts);
                        //加入窗口数组
                        openDialogs.push(openedDialog);
                        //新近窗口索引
                        var tmpindex = openDialogs.length - 1;
                       
                        //隐藏上一个窗口
                        if (openDialogs.length > 1) {
                            openDialogs[openDialogs.length - 2].min();
                        }
                    }
    };


 
</script>



<script type="text/javascript">
    var InitialLayout = function () {
        //布局
        var acrdwidth = 250;
        $("#layoutShow").ligerLayout({ rightWidth: acrdwidth, onHeightChanged: f_heightChanged });
        //初始化Accordion高度
        var height = $(".l-layout-center").height();
        var acrd = $("#accordioninf").ligerAccordion({ height: height - 24 });
        //动态更新Accordion的高度
        function f_heightChanged(options) {
            if (acrd && options.middleHeight - 24 > 0)
                acrd.setHeight(options.middleHeight - 24);
        };
    };

    var InitialNav = function () {
        var data = [];

        data.push({ id: 2, text: 100 });

        $("#treeNav").ligerTree({
            treeLine: false,
            checkbox: false,
            nodeWidth: 140,
            data: data,
            onClick: function () { }
        });
    };

</script>
</head>
<body>

<input id="MapAddr" type="hidden" value= <%:ViewData("MapAddr") %> />
<div id="layoutShow">

<div id="DivTitle" style="height:50px;width:500px">
              <p id="maptitle" 
                  style="font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 30px; font-weight: bold; color: #FFFF00;">yes</p>
        </div>
    <div id="allmap" position="center" ></div>
        
        <div id="rightInf" position="right" title="信息查看"> 
                        <div id="accordioninf" class="liger-accordion"> 
                                 <div id="rain" title="雨情信息">
                                        <ul id="treeInfRain"></ul>
                                 </div>
                                 <div id="water" title="水情信息">
                                        <ul id="treeInfWater"></ul>
                                 </div>
                        </div>
        </div>
</div>
  
</body>
</html>


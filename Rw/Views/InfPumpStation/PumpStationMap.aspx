<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Views/Master/BaiduMap.Master" %>


<asp:content runat="server" contentplaceholderid="js">
    <style>
        .imgmid {
            margin-bottom: 10px;
            margin-top: 2px;
            margin-left: auto;
            margin-right: auto;
            height: 100%;
            width: 100%;
        }

        .imgweather {
            width: 40px;
            height: 35px;
        }

        .pweather {
            text-align: center;
        }

        .title {
            font-weight: bold;
            text-align: center;
            font-size: 15px;
        }

        .tb {
            border: 1px;
            width: 100%;
            height:100%;
            text-align: center;
            border-color: #FFC340;
        }
    </style>
    <script type="text/javascript">
        $(function () {


            InitialLayout(260, '泵闸测点信息');
            Initial('安徽省泵闸监视信息图');
            getBoundary(bdmap, "安徽省");

            var makers = [];
            imgpath = "../../lib/ligerUI/skins/icons/maker/pin-location-orange.png";
            makers.push(addMaker(bdmap, new BMap.Point(117.272306, 32.066323), { img: imgpath, label: '测试站1', animation: BMAP_ANIMATION_DROP }));
            makers.push(addMaker(bdmap, new BMap.Point(116.252306, 31.166323), { img: imgpath, label: '测试站2', animation: BMAP_ANIMATION_DROP }));
            makers.push(addMaker(bdmap, new BMap.Point(117.302306, 33.036323), { img: imgpath, label: '测试站3', animation: BMAP_ANIMATION_DROP }));
            makers.push(addMaker(bdmap, new BMap.Point(118.302306, 31.036323), { img: imgpath, label: '测试站4', animation: BMAP_ANIMATION_DROP }));

            $.each(makers, function (index, item) {
                var s = new BMap.Marker('', '');
                //鼠标移动上去
                item.addEventListener('mouseover', function (e) {
                    var tmpcontent = "<div class=\"imgmid\" style=\" width:180px; height:110px\">" +
                   "            <table border=1 class=\"tb\">" +
                   "                <tr>" +
                   "                     <td width:25%>名称</td>" +
                   "                     <td colspan=\"3\">某测试泵站名称</td>" +
                   "                </tr>" +
                   "                <tr>" +
                   "                     <td width:25%>编号</td>" +
                   "                     <td colspan=\"3\">95270001</td>" +
                   "                </tr>" +
                   "                <tr>" +
                   "                     <td width:25%>类型</td>" +
                   "                     <td colspan=\"3\">泵站</td>" +
                   "                </tr>" +
                   "                 <tr>" +
                   "                     <td width:25%>管理单位</td>" +
                   "                     <td colspan=\"3\">安徽省泵群协会</td>" +
                   "                </tr>" +
                   "                <tr>" +
                   "                    <td rowspan=\"2\" width:25%>数据信息</td>" +
                   "                    <td width:25%>水位</td>" +
                   "                    <td width:25%>用电量</td>" +
                   "                    <td width:25%>流量</td>" +
                   "                </tr>" +
                   "                <tr>" +
                   "                    <%--<td width:25%>泵站</td>--%>" +
                   "                    <td width:25%>132m</td>" +
                   "                    <td width:25%>300kw•h</td>" +
                   "                    <td width:25%>11m³/h</td>" +
                   "                </tr>" +
                   "            </table>" +
                   "        </div>";


                    var tmpid = $.ligerTip({ content: tmpcontent, width: 200, x: e.Pa.x, y: e.Pa.y }).id;

                    //鼠标移走
                    item.addEventListener('mouseout', function (e) {
                        $('#' + tmpid).remove();
                    });

                    //鼠标点击
                    item.addEventListener('click', function (e) {
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


            var data1 = [];

            data1.push({ id: 1, text: "合肥市" });
            data1.push({ id: 2, pid: 1, text: "地点1" });
            data1.push({ id: 3, pid: 1, text: "地点2" });
            data1.push({ id: 4, pid: 1, text: "地点3" });


            data1.push({ id: 10, text: "宿州市" });
            data1.push({ id: 11, pid: 10, text: "地点1" });
            data1.push({ id: 11, pid: 10, text: "地点2" });

            $("#station1").ligerTree({
                treeLine: false,
                checkbox: false,
                idFieldName: 'id',
                parentIDFieldName: "pid",
                nodeWidth: 140,
                data: data1,
                onClick: function (node) {

                }
            });

            $("#station2").ligerTree({
                treeLine: false,
                checkbox: false,
                idFieldName: 'id',
                parentIDFieldName: "pid",
                nodeWidth: 140,
                data: data1,
                onClick: function (node) {

                }
            });



        });

    </script>
    <script type="text/javascript">

        var openDetailDialog = function (cig) {
            switch (cig.type) {
                case 'p':
                   
                    break;
                case 'g':
                    
                    break;
            }

            $.ligerDialog.open({
                height: 540, width: 830, left: 0, top: 0, url: '/InfPumpStation?id=PumpStation',
                showMax: true, showToggle: false, showMin: true, isResize: true,
                modal: false, title: cig.title
            });
        };
    </script>
    
</asp:content>


<asp:content runat="server" contentplaceholderid="content">
        
</asp:content>
<asp:content runat="server" contentplaceholderid="nav">
    <div id="station1" title="闸门信息">

    </div>

    <div id="station2" title="泵站信息">

    </div>
</asp:content>


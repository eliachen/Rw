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
        .auto-style1 {
            width: 40px;
        }
    </style>
    <script type="text/javascript">
        $(function () {


            InitialLayout(260, '河道与水库测点信息');
            Initial('安徽省河道与水库监视信息图');
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

                    var tmpcontent =
                    "       <div class=\"imgmid\" style=\"width:180px; height:180px\">" +
                    "            <table border=\"1\" class=\"tb\">" +
                    "                 <tr>" +
                    "                    <td width:20% >测站编号</td>" +
                    "                    <td colspan=\"3\" width:20%>00009527</td>" +
                    "                </tr>" +
                    "                <tr>" +
                    "                    <td width:20% >名称</td>" +
                    "                    <td colspan=\"3\" width:20%>XXX河道</td>" +
                    "                </tr>" +
                    "                <tr>" +
                    "                    <td width:20% >类型</td>" +
                    "                    <td colspan=\"3\" width:20%>河道</td>" +
                    "                </tr>" +
                    "                <tr>" +
                    "                    <td width:20% colspan=\"2\" rowspan=\"2\" >河道信息</td>" +
                    "                    <td width:20%>流量</td>" +
                    "                    <td width:20%>水位</td>" +
                    "                </tr>" +
                    "               " +
                    "                 <tr>" +
                    "                    <td width:20%>2000m³/s</td>" +
                    "                    <td width:20%>132m</td>" +
                    "                </tr>" +
                    "            </table>" +
                    "       </div>";



                    var tmpid = $.ligerTip({ content: tmpcontent, width: 190, x: e.Pa.x, y: e.Pa.y }).id;

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

                    ContextMenu.addItem(new BMap.MenuItem("流量与水位信息", function () {
                        openDetailDialog({ type: '1', title: '流量与水位信息' });
                    }));

                    ContextMenu.addItem(new BMap.MenuItem("库容与水位信息", function () {
                        openDetailDialog({ type: '2', title: '库容与水位信息' });
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
                case '1':
                    $.ligerDialog.open({
                        height: 430, width: 650, left: 0, top: 0, url: 'InfRiverAndReservoir?id=swAndkrQuery',
                        showMax: false, showToggle: false, showMin: true, isResize: true,
                        modal: false, title: cig.title
                    });
                    break;
                case '2':
                    $.ligerDialog.open({
                        height: 430, width: 650, left: 0, top: 0, url: 'InfRiverAndReservoir?id=swAndllQuery',
                        showMax: false, showToggle: false, showMin: true, isResize: true,
                        modal: false, title: cig.title
                    });
                    break;
            }

           
        };
    </script>
    
</asp:content>

<asp:content runat="server" contentplaceholderid="content">
    <div style="width:210px; height:200px">
       <div class="imgmid" style="width:180px; height:180px">
            <table border="1" class="tb">
                 <tr>
                    <td width:20% >测站编号</td>
                    <td colspan="3" width:20%>00009527</td>
                </tr>
                <tr>
                    <td width:20% >名称</td>
                    <td colspan="3" width:20%>XXX河道</td>
                </tr>
                <tr>
                    <td width:20% >类型</td>
                    <td colspan="3" width:20%>河道</td>
                </tr>
                <tr>
                    <td width:20% colspan="2" rowspan="2" >河道信息</td>
                    <td width:20%>流量</td>
                    <td width:20%>水位</td>
                </tr>
               
                 <tr>
                    <td width:20%>2000m³/s</td>
                    <td width:20%>132m</td>
                </tr>
            </table>
       </div>
   </div>
</asp:content>
<asp:content runat="server" contentplaceholderid="nav">
    <div id="station1" title="河道信息">

    </div>

    <div id="station2" title="水库信息">

    </div>
</asp:content>


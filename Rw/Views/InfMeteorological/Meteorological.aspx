<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Views/Master/BaiduMap.Master" %>


<asp:Content runat="server" ContentPlaceHolderID="js">
    <style>
        .imgmid {
            margin-bottom:10px;
            margin-top:2px;
            margin-left:auto;
            margin-right:auto;
            height:120px;
            width:220px
        }
        .imgweather{
            width:40px;
            height:35px;
        }
        .pweather {
            text-align:center
        }

        .title {
            font-weight: bold;
            text-align:center;
            font-size:15px;
            
        }
       
        .tb{
           border:1px;
           width:100%; 
           text-align:center;
           border-color:#FFC340;
        }
    </style>
    <script type="text/javascript">
        $(function () {

            InitialLayout(260, '气象测点信息');
            Initial('安徽省测站卫星云图信息');
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
                    var tmpcontent = "<div><p class=title>测试气象测站1</p></div>" +
                                     "<div class=imgmid><img class=imgmid src=../../lib/images/demo/pic_yt.jpg alt=点击查看大图 /></div>"+
                                      "<table class=tb border=1>" +
                                      "<tr>"+
                                        "<td width:20% rowspan=2 >气象信息</td>"+
                                        "<td width:20%>天气</td>" +
                                        "<td width:20%>气温</td>"+
                                        "<td width:20%>风向</td>"+
                                        "<td width:20%>风力</td>"+
                                     "</tr>" +
                                     "<tr>" +
                                     "<td><img class=imgweather src=../../lib/images/weather/320.png /><p class=pweather>晴</p></td>" +
                                     "<td>12℃~0℃</td>"+
                                     "<td>东风</td>"+
                                     "<td>微风</td>"+
                                     "</tr>"+
                                     "</table>";
                  
                    var tmpid = $.ligerTip({ content: tmpcontent, width: 250, x: e.Pa.x, y: e.Pa.y }).id;

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
                  
                            ContextMenu.addItem(new BMap.MenuItem("气象云图查询", function () {
                                openDetailDialog({ type: 'm', title: '气象云图信息' });
                            }));

                            ContextMenu.addItem(new BMap.MenuItem("天气查询", function () {
                                openDetailDialog({type:'w',title:'天气信息'});
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



        });

    </script>

    <script type="text/javascript">

        var openDetailDialog = function (cig) {
            switch (cig.type) {
                case 'w':
                    $.ligerDialog.open({
                        height: 500, width: 830, left:0,top:0, url: '/InfMeteorological/index?id=WeatherQuery',
                        showMax: false, showToggle: false, showMin: true, isResize: false,
                        modal: false, title: cig.title,
                        cls: "overflow-y:hidden"
                    });
                    break;
                case 'm':
                    $.ligerDialog.open({
                        height: 520, width: 830, left: 0, top: 0, url: '/InfMeteorological/index?id=MeteorologicalQuery',
                        showMax: false, showToggle: false, showMin: true, isResize: false,
                        modal: false, title: cig.title,
                        cls: "overflow-y:hidden"
                    });
                    break;
            }
        };
    </script>
</asp:Content>


<%--<asp:Content runat="server" ContentPlaceHolderID="content">
   <div style="width:230px; height:220px">
       <div><p  style="font-weight: bold;text-align:center; font-size: 15px;">测试气象测站1</p></div>
       <div class="imgmid style="width:180px; height:180px">
            <img class="imgmid"  src="../../lib/images/demo/pic_yt.jpg"  />
            <table border="1" style="width:100%; text-align:center">
                <tr>
                    <td width:20% rowspan="2">气象信息</td>
                    <td width:20%>天气</td>
                    <td width:20%>气温</td>
                    <td width:20%>风力</td>
                    <td width:20%>风力</td>
                </tr>
                <tr>
                    
                    <td><img class="imgweather" src="../../lib/images/weather/320.png" alt="点击查看大图" /><p class=pweather>晴</p></td>
                    <td>12℃~0℃</td>
                    <td>东风</td>
                    <td>微风</td>
                </tr>
            </table>
       </div>

       <div class=imgmid style="height:1px;width:95%;background-color:black""></div>
   </div>

    
</asp:Content>--%>
<asp:Content runat="server" ContentPlaceHolderID="nav">
    <div id="station1" title="分区1">

    </div>

     <div id="station2" title="分区2">

    </div>
</asp:Content>


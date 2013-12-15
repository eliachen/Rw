<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage"  %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <style>
        .mytip span {
            color:#005268;
            font-size:15px;
        }
        .querymid {
           margin:0 auto;
           width:100px
        }
        html, body {
            margin:0 auto;
            width:100%;
            height:100%;
            overflow-x:hidden;
            overflow-y:hidden
        }

        table, td {
            border-color:#dfe5ed
        }
    </style>
    <script src="../../lib/jquery/jquery-1.6.2.min.js"></script>
    <link href="../../lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" />
   <%-- <link href="../../lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" />--%>
    <script src="../../lib/ligerUI/js/ligerui.min.js"></script>


    <script src="../../ichartjs/ichart.1.2.min.js"></script>
   
    <script type="text/javascript">
        $(function () {
            initialWeatherChart();
            initialQueryBar();
           
        });
    </script>
    <script type="text/javascript">
        var initialWeatherChart = function () {

            var data = [
						{ name: '周一', value: '23', color: '#53b8b1' },
						{ name: '周二', value: '33', color: '#53b8b1' },
						{ name: '周三', value: '20', color: '#53b8b1' },
						{ name: '周四', value: '29', color: '#53b8b1' },
						{ name: '周五', value: '31', color: '#53b8b1' },
						{ name: '周六', value: '34', color: '#53b8b1' },
						{ name: '周天', value: '17', color: '#53b8b1' }
            ];

            var data1 = [
				        	{
				        	    name: '',
				        	    value: [0, 3, 8, 11, 7, 2, 13, 1, 2],
				        	    color: '#34a1d9',
				        	    line_width: 5
				        	}
            ];

            var chart = new iChart.Column2D({
                render: 'canvasDiv',
                data: data,
                tip: {
                    enable: true,
                    shadow: true,
                    listeners: {
                        //tip:提示框对象、name:数据名称、value:数据值、text:当前文本、i:数据点的索引
                        parseText: function (tip, name, value, text, i) {
                            var weather = '晴';
                            var f1 = '12';
                            var f2 = '西北风';
                            return "<div class='mytip'>" +
                                   "<span>气温:" + value + "℃" + "</br></span>" +
							       "<span>天气状况:" + weather + "</br></span>" +
                                   "<span>风力:" + f1 + "级" + "</br></span>" +
                                   "<span>风向:" + f2 + "</br></span>" +
                                   "</div>";
                        }
                    }
                },
                title: {
                    text: '测试气象测站' + '于' + new Date().getMonth() + '月' + '第二周气象数据',
                    color: '#4572a7',
                    textAlign: 'center',
                    padding: '0 40',
                    border: {
                        enable: true,
                        width: [0, 0, 4, 0],
                        color: '#4572a7'
                    },
                    height: 40
                },
                width: 800,
                height: 400,
                padding: 0,
                label: {
                    fontsize: 11,
                    fontweight: 600,
                    color: '#666666'
                },
                shadow: true,
                shadow_blur: 2,
                shadow_color: '#aaaaaa',
                shadow_offsetx: 1,
                shadow_offsety: 0,
                background_color: '#f7f7f7',
                column_width: 62,
                sub_option: {
                    label: {
                        color: '#31e0d4'
                    },
                    border: {
                        width: 2,
                        radius: '5 5 0 0',//上圆角设置
                        color: '#ffffff'
                    },
                    listeners: {
                        parseText: function (r, t) {
                            //自定义柱形图上方label的格式。
                            return t + '℃';
                        }
                    }
                },
                coordinate: {
                    background_color: null,
                    grid_color: '#c0c0c0',
                    width: '90%',
                    height: '78%',
                    axis: {
                        color: '#c0d0e0',
                        width: [0, 0, 1, 0]
                    },
                    scale: [{
                        position: 'left',
                        start_scale: 0,
                        end_scale: 40,
                        scale_space: 5,
                        scale_enable: false,
                        label: {
                            fontsize: 11,
                            fontweight: 600,
                            color: '#666666'
                        }
                    }, {
                        position: 'right',
                        start_scale: 0,
                        scale_space: 3,
                        end_scale: 13,
                        scale_enable: false,
                        scaleAlign: 'right',
                        label: {
                            fontsize: 11,
                            fontweight: 600,
                            color: '#666666'
                        }
                    }]
                }
            });
            //构造折线图
            var line = new iChart.LineBasic2D({
                z_index: 1000,
                data: data1,
                label: {
                    color: '#4c4f48'
                },
                point_space: chart.get('column_width') + chart.get('column_space'),
                scaleAlign: 'right',
                sub_option: {
                    label: {
                        color: '#f7f70d'
                    },
                    listeners: {
                        parseText: function (r, t) {
                            //自定义柱形图上方label的格式。
                            return t + '级';
                        }
                    },
                    point_size: 22
                },
                coordinate: chart.coo//共用坐标系
            });

            chart.plugin(line);


            //利用自定义组件构造左侧说明文本
            chart.plugin(new iChart.Custom({
                drawFn: function () {
                    //计算位置
                    var coo = chart.getCoordinate(),
                        x = coo.get('originx'),
                        y = coo.get('originy');
                    //在左上侧的位置，渲染一个单位的文字
                    chart.target.textAlign('start')
                    .textBaseline('bottom')
                    .textFont('600 16px Verdana')
                    .fillText('气温(℃)', x - 20, y - 20, false, '#53b8b1')
                    .textFont('600 11px Verdana');
                    //.fillText('℃', x - 20, y - 10, false, '#c52120');

                    //在右上侧的位置，渲染一个单位的文字
                    chart.target.textAlign('end')
                    .textBaseline('bottom')
                    .textFont('600 16px Verdana')
                    .fillText('风力等级', x + 20 + coo.width, y - 20, false, '#34a1d9')
                    .textFont('600 11px Verdana');
                    //.fillText('in thousands', x + 20 + coo.width, y - 10, false, '#34a1d9');

                }
            }));

            chart.draw();
        };
    </script>
    <script type="text/javascript">
        var initialQueryBar = function () {
            var datayear = [];
            for (var index = new Date().getFullYear() ; index > new Date().getFullYear() - 10; index--) {
                datayear.push({text:index+'年', id:index});
            }

            comboxSet("#year", datayear);

            var datamonth = [];
            for (var index = 1 ; index < 13; index++) {
                datamonth.push({ text: index + '月', id: index });
            }

            comboxSet("#month", datamonth);

            var dataweek = [];
            for (var index = 1 ; index < 5; index++) {
                dataweek.push({ text: index + '周', id: index });
            }

            comboxSet("#week", dataweek);

            $('#querybtn').ligerButton({
                click: function () {
                    
                }
            })
            
        };

        var comboxSet = function (id, dt) {

         $(id).ligerComboBox(
           {
               data: dt,
               width:100
           });
        };

    </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
        <table border="1" style="width:800px;margin:0 auto">
            <tr style="height:400px">
                <td colspan="4"><div id="canvasDiv"/></td>
            </tr>
            <tr style="text-align:center;height:60px">
                <td style="width:25%">选择年份:<div class="querymid" ><input  id="year" type="text" /></div></td>
                <td style="width:25%">选择月份:<div class="querymid" ><input id="month" type="text" /></div></td>
                <td style="width:25%">选择自然周:<div class="querymid" ><input id="week" type="text" /></div></td>
                <td style="width:25%">查询信息: <div class="querymid" ><input id="querybtn" type="button" value="查询" /></div></td>
            </tr>
        </table>
     

</body>
</html>

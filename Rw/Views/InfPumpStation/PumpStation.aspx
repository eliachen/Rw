<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/LayoutNavRight.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="jq" runat="server">
	<script src="../../lib/jquery/jquery-1.6.2.min.js"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="js" runat="server">

    <script type="text/javascript">
        var treeinf;
        var f_water;
        var f_mainelc;
        var f_temperature;
        var f_pump = [];

        $(function () {
            //初始化树
            InitialpumpstaTree();
            InitialLayout(260, "泵站信息");
            //初始化表单结构及其数据
            InitialpumpstaForm();
            //设置初始标题
            settitle(treeinf.getDataByID(2).text);
            //设置表格样式
            $("#dtmain").width($("#RDContent").width() * 0.8);
            $("#dtmain").height($("#RDContent").height() - 60);

            simulateData();
            setInterval(function () {
                simulateData();
                LigerUIHelper.tiptm("加载数据成功", 1500);
            }, 3000)

        });

</script>
    <script type="text/javascript">
        var InitialpumpstaTree = function () {
            var location = [];
            var data = [];
            for (var index = 1; index < 10; index++) {
                //data.push({ id: index, pid: 1, text: "测试泵站"+index });
            }

            //data.push({ id:1, text: "地点1" });
            data.push({ id: 1, text: "地点1" });
            data.push({ id: 2, pid: 1, text: "地点1-测试泵站1" });
            data.push({ id: 3, pid: 1, text: "地点1-测试泵站2" });
            data.push({ id: 4, pid: 1, text: "地点1-测试泵站3" });
            data.push({ id: 5, pid: 1, text: "地点1-测试泵站4" });
            data.push({ id: 6, pid: 1, text: "地点1-测试泵站5" });
            data.push({ id: 7, pid: 1, text: "地点1-测试泵站6" });
            data.push({ id: 8, pid: 1, text: "地点1-测试泵站7" });
            data.push({ id: 9, pid: 1, text: "地点1-测试泵站8" });

            data.push({ id: 10, text: "地点2" });
            data.push({ id: 11, pid: 10, text: "地点2-测试泵站1" });
            data.push({ id: 11, pid: 10, text: "地点2-测试泵站2" });

            treeinf = $("#treeinfpumpstation").ligerTree({
                treeLine: false,
                checkbox: false,
                idFieldName: 'id',
                parentIDFieldName: "pid",
                nodeWidth: 140,
                data: data,
                onClick: function (node) {
                    settitle(node.data.text);
                }
            });


        };

        var InitialpumpstaForm = function () {

            f_water = $("#f_water").ligerForm({
                inputWidth: 80, labelWidth: 80, space: 1,
                fields: [
                { display: "流量(m³/h)", name: "flow", type: "number" },
                { display: "闸上水位(m)", name: "uprz", type: "number" },
                { display: "闸下水位(m)", name: "downrz", type: "number" }
                ]
            });

            f_mainelc = $("#f_mainelc").ligerForm({
                inputWidth: 80, labelWidth: 110, space: 30,
                fields: [
                { display: "电压(KV)", name: "v", type: "number" },
                { display: "电流(A)", name: "a", type: "number" },
                { display: "有功功率(KW/H)", name: "activep", type: "number" },
                { display: "无功功率(Kavr/H)", name: "reactivep", type: "number" },
                { display: "功率因素", name: "par", type: "number" }
                ]
            });

            f_temperature = $("#f_temperature").ligerForm({
                inputWidth: 80, labelWidth: 110, space: 30,
                fields: [
                { display: "推子温度(℃)", name: "ttz", type: "number" },
                { display: "定子温度(℃)", name: "tdz", type: "number" },
                { display: "上导温度(℃)", name: "tsd", type: "number" },
                { display: "下导温度(℃)", name: "txd", type: "number" }
                ]
            });

            f_pump.push(pumpform("#f_pump1"));
            f_pump.push(pumpform("#f_pump2"));
            f_pump.push(pumpform("#f_pump3"));
        };

        var pumpform = function (f) {
            return $(f).ligerForm({
                inputWidth: 80, labelWidth: 110, space: 30,
                fields: [
                { display: "运行状态", name: "runstate", type: "text", width: 35 },
                { display: "电压(KV)", name: "v", type: "number" },
                { display: "电流(A)", name: "a", type: "number" },
                { display: "有功功率(KW/H)", name: "activep", type: "number" },
                { display: "无功功率(Kavr/H)", name: "reactivep", type: "number" },
                { display: "功率因素", name: "par", type: "number" },
                { display: "闸门开度(m)", name: "kd", type: "number" },
                { display: "流量(m³/h)", name: "flow", type: "number" }
                ]
            });
        };

        var setdatastate = function (t) {
            var td = $("#datastate");
            if (t) {
                td.css("color", "green");
                td.html("数据状态:正常");
            } else {
                td.css("color", "red");
                td.html("数据状态:异常");
            };
        };

        var settitle = function (t) {
            $("#title").html(t);
        };
    </script>

    <script type="text/javascript">
        var simulateData = function () {
            f_water.setData({ flow: randomnum(100, 210), uprz: randomnum(10, 15), downrz: randomnum(5, 10) });
            f_mainelc.setData({
                v: randomnum(100, 210), a: randomnum(10, 15), activep: randomnum(5, 10),
                reactivep: randomnum(100, 210), par: randomnum(0, 1)
            });

            f_temperature.setData({
                ttz: randomnum(10, 30), tdz: randomnum(10, 30),
                tsd: randomnum(10, 30), txd: randomnum(10, 30)
            });

            $.each(f_pump, function (index, item) {
                item.setData({
                    runstate: '运行', v: randomnum(100, 210),
                    a: randomnum(10, 15), activep: randomnum(5, 10),
                    reactivep: randomnum(100, 210), par: randomnum(0, 1),
                    kd: randomnum(0, 15), flow: randomnum(0, 110)
                });
            });

        };
        var randomnum = function (min, max) {
            return (Math.random() * max + min).toFixed(2);
        };
    </script>
	    <style type="text/css">

        th {
          text-align:center;
          font-size:medium
        }
        .pumpsta {
            width:200px;
            margin:0 auto
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="content" runat="server">
	<div>
    <table id="dtmain" border="2" style=" margin: 30px auto;border-color:#aecaf0;font-variant: normal; ">
        <tr>
            <td colspan="3">
                <p id="title" style="text-align: center; font-size: xx-large; font-variant: normal;">某地+泵站名称</p>
            </td>
        </tr>
        <tr>
            <td  style="text-align:left;font-size:medium" colspan="3"><p id="datastate" style="color:green">数据状态:正常</p></td>
        </tr>
        <tr>
            <th>水文数据</th>
            <th colspan="2">36KV母线数据</th>
        </tr>
        <tr>
            <td>
                <div id="f_water" class="pumpsta">
                  <%--  @*f_water*@--%>
                </div>
            </td>
            <td>
                <div id="f_mainelc" class="pumpsta">
                  <%--  @*f_mainelc*@--%>
                </div>
            </td>
            <td>
                <div id="f_temperature" class="pumpsta">
                   <%-- @*f_temperature*@--%>
                </div>
            </td>
        </tr>
        <tr>
            <th colspan="3">
                6KV干线数据
            </th>
        </tr>
        <tr>
            <th>
                1#机组
            </th>
            <th>
                2#机组
            </th>
            <th>
                3#机组
            </th>
        </tr>
        <tr>
            <td>
                <div id="f_pump1" class="pumpsta">
                  <%--  @*f_pump1*@--%>
                </div>
            </td>
            <td>
                <div id="f_pump2" class="pumpsta">
                   <%-- @*f_pump2*@--%>
                </div>
            </td>
            <td>
                <div id="f_pump3" class="pumpsta">
                  <%--  @*f_pump3*@--%>
                </div>
            </td>
        </tr>
    </table>
</div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="nav" runat="server">
	<div id="pumpstation" title="泵站信息" >
    <ul id="treeinfpumpstation" style="margin-top:3px;" />
</div>
</asp:Content>




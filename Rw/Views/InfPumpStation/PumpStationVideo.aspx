<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/LayoutNavRight.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="jq" runat="server">
	<script src="../../lib/jquery/jquery-1.6.2.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="js" runat="server">

<link href="../jQuery.jPlayer/css/jplayer.blue.monday.css" rel="stylesheet" />
<script src="../jQuery.jPlayer/jquery.jplayer.min.js"></script>

<script src="../Scripts/Video/VideoHelper.js?new Date()"></script>
    <script type="text/javascript">
        $(function () {
            InitialLayout(260, "地点信息");
            eliaVideo({ div: "#v1", path: "/InfPumpStation/PumpVideoData", foot: "测试监控1" });
            eliaVideo({ div: "#v2", path: "/InfPumpStation/PumpVideoData", foot: "测试监控2" });
            eliaVideo({ div: "#v3", path: "/InfPumpStation/PumpVideoData", foot: "测试监控3" });
            eliaVideo({ div: "#v4", path: "/InfPumpStation/PumpVideoData", foot: "测试监控4" });


            var data = [];
            data.push({ id: 2, text: "测试泵站1" });
            data.push({ id: 3, text: "测试泵站2" });
            data.push({ id: 4, text: "测试泵站3" });
            data.push({ id: 5, text: "测试泵站4" });
            data.push({ id: 6, text: "测试泵站5" });
            data.push({ id: 7, text: "测试泵站6" });
            data.push({ id: 8, text: "测试泵站7" });
            data.push({ id: 9, text: "测试泵站8" });


            var s = $("#tree1").ligerTree({
                treeLine: false,
                checkbox: false,
                idFieldName: 'id',
                parentIDFieldName: 'pid',
                nodeWidth: 140,
                data: data,
                isexpand: true,
                onClick: function (node) {
                    //settitle(node.data.text);
                }
            });


            $("#tree2").ligerTree({
                treeLine: false,
                checkbox: false,
                idFieldName: 'id',
                parentIDFieldName: "pid",
                nodeWidth: 140,
                data: data,
                onClick: function (node) {
                    //settitle(node.data.text);
                }
            });

            $("#tree3").ligerTree({
                treeLine: false,
                checkbox: false,
                idFieldName: 'id',
                parentIDFieldName: "pid",
                nodeWidth: 140,
                data: data,
                onClick: function (node) {
                    //settitle(node.data.text);
                }
            });
        });

    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="content" runat="server">
   <table style="width:100%">
    <tr>
        <td><div id="v1"></div></td>
        <td><div id="v2"></div></td>
    </tr>
    <tr>
        <td height="20px"></td>
        <td height="20px"></td>
    </tr>
    <tr>
        <td><div id="v3"></div></td>
        <td><div id="v4"></div></td>
    </tr>
</table>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="nav" runat="server">
    <div id="l1" title="地点1">
        <ul id="tree1">
        </ul>
    </div>
    <div id="l2" title="地点2">
        <ul id="tree2">
        </ul>
    </div>
    <div id="l3" title="地点3">
        <ul id="tree3">
        </ul>
    </div>
</asp:Content>




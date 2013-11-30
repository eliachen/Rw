<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/LayoutNavRight.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="jq" runat="server">
	<script src="../../lib/jquery/jquery-1.6.2.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="js" runat="server">

    <style>
        .video {
            width:100%;
            height:100%;
            margin: 0px 0px 0px 0px;

        }
    </style>
<%--<link href="../jQuery.jPlayer/css/jplayer.blue.monday.css" rel="stylesheet" />
<script src="../jQuery.jPlayer/jquery.jplayer.min.js"></script>--%>

<%--<script src="../Scripts/Video/VideoHelper.js?new Date()"></script>--%>
    <script type="text/javascript">
        $(function () {
            //InitialLayout(260, "地点信息");

            setVideo({ id: '#v1', src: '/InfPumpStation/PumpVideoData', loop: true });
            setVideo({ id: '#v2', src: '/InfPumpStation/PumpVideoData', loop: true });
            setVideo({ id: '#v3', src: '/InfPumpStation/PumpVideoData', loop: true });
            setVideo({ id: '#v4', src: '/InfPumpStation/PumpVideoData', loop: true });
            setVideo({ id: '#v5', src: '/InfPumpStation/PumpVideoData', loop: true });
            setVideo({ id: '#v6', src: '/InfPumpStation/PumpVideoData', loop: true });

           
            InitialLayout(260, "视频监控信息");
           

            var data = [];
            data.push({ id: 2, text: "测试名称1" });
            data.push({ id: 3, text: "测试名称2" });
            data.push({ id: 4, text: "测试名称3" });
            data.push({ id: 5, text: "测试名称4" });
            data.push({ id: 6, text: "测试名称5" });
            data.push({ id: 7, text: "测试名称6" });
            data.push({ id: 8, text: "测试名称7" });
            data.push({ id: 9, text: "测试名称8" });

            for (var index = 1; index < 5; index++)
            {
                var s = $("#tree"+index).ligerTree({
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
            }
           
        });

    </script>

    <script type="text/javascript">
        var setVideo = function (cig) {
            $(cig.id).attr("src", cig.src);
            if (cig.loop) {
                //$(cig.loop).attr("loop", '20');
            } else {
                //$(cig.loop).attr("loop", '20');
            }
        };
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="content" runat="server">
    <table border="1" style="width:100%;height:100%;margin:0px 0px 0px 0px; border-color:#aecaf0">
            <tr style="height:30%;">
                <td colspan="2" rowspan="2"><embed class="video" id="v1"/></td>
                <td><embed class="video" id="v2"/></td>
            </tr>
            <tr style="height:30%;">
                <td><embed class="video" id="v3"/></td>
                
            </tr>
            <tr style="height:40%;">
                <td style="width:30%"><embed class="video" id="v4"/></td>
                <td style="width:30%"><embed class="video" id="v5"/></td>
                <td style="width:40%"><embed class="video" id="v6"/></td>
            </tr>
        </table>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="nav" runat="server">
    <div id="l1" title="泵站视频监控">
        <ul id="tree1">
        </ul>
    </div>
    <div id="l2" title="闸门视频监控">
        <ul id="tree2">
        </ul>
    </div>
    <div id="l3" title="取水点">
        <ul id="tree3">
        </ul>
    </div>
     <div id="l4" title="排污口">
        <ul id="tree4">
        </ul>
    </div>
</asp:Content>




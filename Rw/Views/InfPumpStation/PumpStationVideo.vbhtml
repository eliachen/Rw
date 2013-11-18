@Code
    Layout = "~/Views/Master/LayoutNavRight.vbhtml"
End Code

@section JQUERY
<script src="../../lib/jquery/jquery-1.4.4.min.js"></script>
@*<script src="../../lib/jquery/jquery-1.3.2.min.js"></script>*@
End Section

@section JSCODE
<link href="../jQuery.jPlayer/css/jplayer.blue.monday.css" rel="stylesheet" />
<script src="../jQuery.jPlayer/jquery.jplayer.min.js"></script>

<script src="../Scripts/Video/VideoHelper.js"></script>
    <script type="text/javascript">
        $(function () {
            InitialLayout(260, "");
            eliaVideo({ div: "#v1", path: "../tokyo.m4v", foot: "测试监控1" });
            eliaVideo({ div: "#v2", path: "../tokyo.m4v", foot: "测试监控2" });
            eliaVideo({ div: "#v3", path: "../tokyo.m4v", foot: "测试监控3" });
            eliaVideo({ div: "#v4", path: "../tokyo.m4v", foot: "测试监控4" });


            var data = [];

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


           $("#tree1").ligerTree({
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
End Section

@section CONTENT 
<table style="width:100%">
    <tr>
        <td><div id="v1"></div></td>
        <td><div id="v2"></div></td>
    </tr>
    <tr>
        <td><div id="v3"></div></td>
        <td><div id="v4"></div></td>
    </tr>
</table>

End Section

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



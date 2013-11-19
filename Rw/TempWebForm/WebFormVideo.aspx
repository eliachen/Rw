<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebFormVideo.aspx.vb" Inherits="Rw.WebFormVideo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../jQuery.jPlayer/css/jplayer.blue.monday.css" rel="stylesheet" />
  
    <script src="../Scripts/jquery-1.4.4.min.js"></script>
  <%--  <script src="../lib/jquery/jquery-1.3.2.min.js"></script>--%>
    <script src="../jQuery.jPlayer/jquery.jplayer.min.js"></script>
    
    <script type="text/javascript">

        $(function () {
            eliaVideo({ div: "#v1", path: "../tokyo.m4v", foot: "测试监控1" });
            eliaVideo({ div: "#v2", path: "../tokyo.m4v", foot: "测试监控2" });
            eliaVideo({ div: "#v3", path: "../tokyo.m4v", foot: "测试监控3" });
            eliaVideo({ div: "#v4", path: "../tokyo.m4v", foot: "测试监控4" });
        });

        var eliaVideo = function (cig) {
            var tmpid = new Date().getMilliseconds();

            $(cig.div).append("<div class=\"jp-video jp-video-270p\">" +
          "                <div class=\"jp-type-single\">"+
          "                    <div id=\"videomain\" class=\"jp-jplayer\"></div>" +
          "                    <div id=\"jp_interface_" + tmpid + "\" class=\"jp-interface\">" +
          "                        <div class=\"jp-video-play\"></div>"+
          "                        <ul class=\"jp-controls\">"+
          "                            <li><a href=\"#\" class=\"jp-play\" tabindex=\"1\">play</a></li>"+
          "                            <li><a href=\"#\" class=\"jp-pause\" tabindex=\"1\">pause</a></li>"+
          "                            <li><a href=\"#\" class=\"jp-stop\" tabindex=\"1\">stop</a></li>"+
          "                            <li><a href=\"#\" class=\"jp-mute\" tabindex=\"1\">mute</a></li>"+
          "                            <li><a href=\"#\" class=\"jp-unmute\" tabindex=\"1\">unmute</a></li>"+
          "                        </ul>"+
          "                        <div class=\"jp-progress\">"+
          "                            <div class=\"jp-seek-bar\">"+
          "                                <div class=\"jp-play-bar\"></div>"+
          "                            </div>"+
          "                        </div>"+
          "                        <div class=\"jp-volume-bar\">"+
          "                            <div class=\"jp-volume-bar-value\"></div>"+
          "                        </div>"+
          "                        <div class=\"jp-current-time\"></div>"+
          "                        <div class=\"jp-duration\"></div>"+
          "                    </div>"+
          "                    <div id=\"jp_playlist_2\" class=\"jp-playlist\">"+
          "                        <ul>"+
          "                           <li style=\"text-align:center\">" + cig.foot + "</li>" +
          "                        </ul>"+
          "                    </div>"+
          "                </div>"+
          "            </div>");

            $('#videomain',$(cig.div)).jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: cig.path,
                        ogv: "http://localhost:1979/tokyo.ogv",
                        mp4: cig.path,
                        poster:"../lib/images/loading.gif"
                    });
                    //直接开始播放
                    $('#videomain', $(cig.div)).jPlayer("play", 0);
                },
                ended: function (event) {
                    $('#videomain', $(cig.div)).jPlayer("play", 0);
                },
                swfPath: "swf",
                supplied: "m4v, ogv, mp4",
                cssSelectorAncestor: "#jp_interface_" + tmpid
            })
       .bind($.jPlayer.event.play, function () { // pause other instances of player when current one play
           //$(this).jPlayer("pauseOthers");
                });
        };

    </script>
</head>
 
<body>
    <table style="width:100%;">
        <tr>
            <td><div id="v1"></div></td>
            <td><div id="v2"></div></td>
        </tr>
        <tr>
            <td><div id="v3"></div></td>
            <td><div id="v4"></div></td>
        </tr>
    </table>

</body>
</html>

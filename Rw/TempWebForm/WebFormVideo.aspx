<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebFormVideo.aspx.vb" Inherits="Rw.WebFormVideo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
   <%-- <link href="../jQuery.jPlayer/css/jPlayer.css" rel="stylesheet" />--%>
    <link href="../jQuery.jPlayer/css/jplayer.blue.monday.css" rel="stylesheet" />
    <script src="../lib/jquery/jquery-1.6.2.min.js"></script>
   <%-- <script src="../lib/jquery/jquery-1.10.2.min.js"></script>--%>
    <%--<script src="../Scripts/jquery-1.4.4.min.js"></script>--%>
  <%--  <script src="../lib/jquery/jquery-1.3.2.min.js"></script>--%>
    <script src="../jQuery.jPlayer/jquery.jplayer.min.js"></script>
    <script src="../jQuery.jPlayer/jquery.jplayer.inspector.js"></script>
    <script type="text/javascript">

        $(function () {

            $("#jquery_jplayer_1").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: "http://www.jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v",
                        ogv: "http://www.jplayer.org/video/ogv/Big_Buck_Bunny_Trailer.ogv",
                        webmv: "http://www.jplayer.org/video/webm/Big_Buck_Bunny_Trailer.webm",
                        poster: "http://www.jplayer.org/video/poster/Big_Buck_Bunny_Trailer_480x270.png"
                    });

                    $(this).jPlayer("play", 0);
                },
                swfPath: "../js",
                supplied: "webmv, ogv, m4v"
            });
            $("#jquery_jplayer_2").jPlayer({
                ready: function () {
                    $(this).jPlayer("setMedia", {
                        m4v: "http://www.jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v",
                        ogv: "http://www.jplayer.org/video/ogv/Big_Buck_Bunny_Trailer.ogv",
                        webmv: "http://www.jplayer.org/video/webm/Big_Buck_Bunny_Trailer.webm",
                        poster: "http://www.jplayer.org/video/poster/Big_Buck_Bunny_Trailer_480x270.png"
                    });

                    $(this).jPlayer("play", 0);
                },
                swfPath: "../js",
                supplied: "webmv, ogv, m4v"
            });
            //$("#v_cotain").jPlayerInspector({ jPlayer: $("#jquery_jplayer_1") });            //<a href="../App_Data/test.m4v">../App_Data/test.m4v</a>
            //eliaVideo1({ div: "#jp_container_1", id: 1, path: "../App_Data/test.m4v", foot: "测试监控1" });
            //eliaVideo1({ div: "#jp_container_2", id: 2, path: "/InfPumpStation/PumpVideoData", foot: "测试监控2" });

            //eliaVideo({ div: "#v2", path: "/InfPumpStation/PumpVideoData", foot: "测试监控2" });
            //eliaVideo({ div: "#v3", path: "/InfPumpStation/PumpVideoData", foot: "测试监控3" });
            //eliaVideo({ div: "#v4", path: "/InfPumpStation/PumpVideoData", foot: "测试监控4" });
        });

        var eliaVideo = function (cig) {
            var tmpid = new Date().getMilliseconds();
            //class=\"jp-video jp-video-270p\"
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
                        mp4: cig.path,
                        poster:"../lib/images/loading.gif"
                    });
                    //直接开始播放
                    $(this).jPlayer("play", 0);
                },
                ended: function (event) {
                    $('#videomain', $(cig.div)).jPlayer("play", 0);
                },
                swfPath: "swf",
                supplied: "m4v, ogv, mp4",
                size: { width: cig.width || 480, height: cig.height || 270 },
                cssSelectorAncestor: "#jp_interface_" + tmpid
            })
                .bind($.jPlayer.event.play, function () { // pause other instances of player when current one play
           //$(this).jPlayer("pauseOthers");
                });
        };

        var eliaVideo1 = function (cig) {
            var tmpid = new Date().getSeconds() + 'k' + new Date().getMilliseconds();
            
            //"					<div class=\"jp-video-play\">" +
            //"						<a href=\"#\" class=\"jp-video-play-icon\" tabindex=\"1\">play</a>" +
            //"					</div>" +
            
            //"								<li><a href=\"#\" class=\"jp-repeat\" tabindex=\"1\" title=\"repeat\">repeat</a></li>" +
            //"								<li><a href=\"#\" class=\"jp-repeat-off\" tabindex=\"1\" title=\"repeat off\">repeat off</a></li>" +

            $(cig.div).append("<div class=\"jp-type-single\">"+
"				<div id=\"jquery_jplayer_"+cig.id+"\" class=\"jp-jplayer\"></div>"+
"				<div class=\"jp-gui\">"+
"					<div class=\"jp-video-play\">"+
"						<a href=\"javascript:;\" class=\"jp-video-play-icon\" tabindex=\"1\">play</a>"+
"					</div>"+
"					<div id=\"jp_interface_" + tmpid + "\" class=\"jp-interface\" >" +
"						<div class=\"jp-progress\">"+
"							<div class=\"jp-seek-bar\">"+
"								<div class=\"jp-play-bar\"></div>"+
"							</div>"+
"						</div>"+
"						<div class=\"jp-current-time\"></div>"+
"						<div class=\"jp-duration\"></div>"+
"						<div class=\"jp-controls-holder\">"+
"							<ul class=\"jp-controls\">"+
"								<li><a href=\"javascript:;\" class=\"jp-play\" tabindex=\"1\">play</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-pause\" tabindex=\"1\">pause</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-stop\" tabindex=\"1\">stop</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-mute\" tabindex=\"1\" title=\"mute\">mute</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-unmute\" tabindex=\"1\" title=\"unmute\">unmute</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-volume-max\" tabindex=\"1\" title=\"max volume\">max volume</a></li>"+
"							</ul>"+
"							<div class=\"jp-volume-bar\">"+
"								<div class=\"jp-volume-bar-value\"></div>"+
"							</div>"+
"							<ul class=\"jp-toggles\">"+
"								<li><a href=\"javascript:;\" class=\"jp-full-screen\" tabindex=\"1\" title=\"full screen\">full screen</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-restore-screen\" tabindex=\"1\" title=\"restore screen\">restore screen</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-repeat\" tabindex=\"1\" title=\"repeat\">repeat</a></li>"+
"								<li><a href=\"javascript:;\" class=\"jp-repeat-off\" tabindex=\"1\" title=\"repeat off\">repeat off</a></li>"+
"							</ul>"+
"						</div>"+
"						<div class=\"jp-title\">"+
"							<ul>"+
"								<li>Big Buck Bunny Trailer</li>"+
"							</ul>"+
"						</div>"+
"					</div>"+
"				</div>"+
"				<div class=\"jp-no-solution\">"+
"					<span>Update Required</span>"+
"					To play the media you will need to either update your browser to a recent version or update your <a href=\"http://get.adobe.com/flashplayer/\" target=\"_blank\">Flash plugin</a>."+
"				</div>"+
"			</div>");

       $("#jquery_jplayer_"+cig.id).jPlayer({
          ready: function () {
              $(this).jPlayer("setMedia", {
                  m4v: cig.path,
                  mp4: cig.path,
                  poster: "http://www.jplayer.org/video/poster/Big_Buck_Bunny_Trailer_480x270.png"
              });

              $(this).jPlayer("play", 0);
          },
          swfPath: "swf",
          supplied: "m4v, mp4",
          size: {
              width: "480px",
              height: "270px",
              cssClass: "jp-video-270p"
          },
          smoothPlayBar: true,
          keyEnabled: true,
          cssSelectorAncestor: "#jp_interface_" + tmpid
            });
        };

    </script>
</head>
 
<body>
    <%--<table style="width:100%;">
        <tr>
            <td><div id="v1"></div></td>
            <td><div id="v2"></div></td>
        </tr>
        <tr>
            <td><div id="v3"></div></td>
            <td><div id="v4"></div></td>
        </tr>
    </table>--%>
    <%--<div id="playcontain" style="height:100px;width:200px">
        <div  id="play" class="jp-jplayer"></div>
    </div>--%>
<%--    <div id="v1" class="jp-video"></div>--%>

    <%--<div id="jp_container_1" class="jp-video jp-video-270p" >

    </div>
    <div id="jp_container_2" class="jp-video jp-video-270p">

    </div>--%>

    	<%--<div id="jp_container_1" class="jp-video">
			<div class="jp-type-single">
				<div id="jquery_jplayer_1" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time"></div>
						<div class="jp-duration"></div>
						<div class="jp-controls-holder">
							<ul class="jp-controls">
								<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
								<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
								<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
								<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
								<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
							</ul>
							<div class="jp-volume-bar">
								<div class="jp-volume-bar-value"></div>
							</div>
							<ul class="jp-toggles">
								<li><a href="javascript:;" class="jp-full-screen" tabindex="1" title="full screen">full screen</a></li>
								<li><a href="javascript:;" class="jp-restore-screen" tabindex="1" title="restore screen">restore screen</a></li>
							</ul>
						</div>
						<div class="jp-title">
							<ul>
								<li>Big Buck Bunny Trailer</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>--%>    <%--<div id="jp_container_1" class="jp-video jp-video-360p">
			<div class="jp-type-single">
				<div id="jquery_jplayer_1" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div class="jp-video-play">
						<a href="javascript:;" class="jp-video-play-icon" tabindex="1">play</a>
					</div>
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time"></div>
						<div class="jp-duration"></div>
						<div class="jp-controls-holder">
							<ul class="jp-controls">
								<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
								<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
								<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
								<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
								<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
							</ul>
							<div class="jp-volume-bar">
								<div class="jp-volume-bar-value"></div>
							</div>
							<ul class="jp-toggles">
								<li><a href="javascript:;" class="jp-full-screen" tabindex="1" title="full screen">full screen</a></li>
								<li><a href="javascript:;" class="jp-restore-screen" tabindex="1" title="restore screen">restore screen</a></li>
								<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
								<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
							</ul>
						</div>
						<div class="jp-title">
							<ul>
								<li>Big Buck Bunny Trailer</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>--%>        <table border="1" cellpadding="0" cellspacing="1" style="width: 300px; height:400px; border-color: black">
        <tr>
            <td colspan="2" rowspan="2">
                <div style="background-color:red;width:50px;height:50px">
                    <embed src="http://www.jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"; units="en" autostart="true" loop="true"  style="width:100%;height:inherit" >
                </div>
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</body>

</html>

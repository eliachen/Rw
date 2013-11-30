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
            width:100%;
            height:100%;
        }
    </style>
    <script src="../../lib/jquery/jquery-1.6.2.min.js"></script>
    <link href="../../lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" />
   <%-- <link href="../../lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet" />--%>
    <script src="../../lib/ligerUI/js/ligerui.min.js"></script>


<%--    <script src="../../ichartjs/ichart.1.2.min.js"></script>--%>
   
    <script type="text/javascript">
        $(function () {
            initialQueryBar();
            $('#pictitle').html("气象测站于2013-12-1云图信息");
        });
    </script>
    <script type="text/javascript">
      
    </script>
    <script type="text/javascript">
        var initialQueryBar = function () {
           var t= $("#mydate").ligerDateEditor(
               {
                   format: "yyyy-MM-dd",
                  labelWidth: 100,
                  labelAlign: 'center',
                  cancelable : true
               });

            $('#querybtn').ligerButton({
                click: function () {
                    $('#pictitle').html("气象测站于2013-12-1云图信息");
                }
            })
        };
    </script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>

    
        <table border="1" style="width:800px;">
             <tr>
                <td colspan="4"><p id="pictitle" style="text-align:center;font-size:24px"></p></td>
            </tr>
            <tr>
                <td colspan="4"><img src="../../lib/images/demo/pic_yt.jpg" style="height:400px;width:100%" /></td>
            </tr>
            <tr style="text-align:center">
                <td style="width:25%">选择日期:<div class="querymid" ><input id="mydate" type="text"  /></div></td>
                <td style="width:25%">查询信息: <div class="querymid" ><input id="querybtn" type="button" value="查询" /></div></td>
            </tr>
        </table>
     

</body>
</html>

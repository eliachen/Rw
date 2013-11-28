<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Views/Master/BaiduMap.Master" %>


<asp:Content runat="server" ContentPlaceHolderID="js">
    <script type="text/javascript">
        $(function () {
            InitialLayout(260, '测站信息');
            Initial('安徽省测站卫星云图信息');
            getBoundary(bdmap,"安徽省");
        });

    </script>
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="content">
   
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="nav">
    <div id="station1" title="地点1">

    </div>

     <div id="station2" title="地点2">

    </div>
</asp:Content>


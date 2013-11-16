<%@ Page Title="" Language="VB" MasterPageFile="~/Views/MAster/Query.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="JSDO" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    Initial(function () {
        var Opts = {
            url: '/infRainAndWater/infRainQuery',
            title: stnm + "(" + stcd + ")" + "每日雨量图",
            xname: "时间",
            yname: "雨量",
            DealData: function (recvdata) {
                var tmpData = { xdata: [], ydata: [] };
                $.each(recvdata, function (index, item) {
                    tmpData.xdata.push(item.Date);

                    var s = { value: item.SumDrp,
                        tooltip: {
                            formatter: function (params, ticket, callback) {
                                var showStr = "时间:" + params[1] + '</br>' +
                                              "雨量:" + params[2] + 'mm';
                                return showStr;
                            }
                        }
                    };
                    tmpData.ydata.push(s);
                });
                return tmpData;
            }
        };

        //加载初始画面
        QueryAndDraw(Opts);

        //设置鼠标事件
        InitialQueryButton(function () {
            QueryAndDraw(Opts);
        });


    });
    </script>
</asp:Content>

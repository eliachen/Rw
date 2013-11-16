<%@ Page Title="" Language="VB" MasterPageFile="~/Views/MAster/Query.Master" Inherits="System.Web.Mvc.ViewPage" %>

<%--<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>--%>

<asp:Content ID="JSDO" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    Initial(function () {
        var Opts = {
            url: '/infRainAndWater/infWaterQuery',
            title: stnm + "(" + stcd + ")" + "定点水位图",
            xname: "时间",
            yname: "水位",
            DealData: function (recvdata) {
                var tmpData = { xdata: [], ydata: [] };
                $.each(recvdata, function (index, item) {
                    tmpData.xdata.push(item.Date);

                    var s = { value: item.WaterLevel,
                        tooltip: {
                            formatter: function (params, ticket, callback) {
                                var showStr = "时间:" + params[1] + '</br>' +
                                              "水位:" + params[2] + 'm';
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



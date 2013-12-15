<%@ Page Language="VB" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Views/Master/QueryNew.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="jq" runat="server">
    <script src="../lib/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="js" runat="server">
    <script type ="text/javascript">
        $(function () {
            InitialLayOut(null);
            var chartopt = {
                title: {
                    text: '河道水位与流量变化曲线',
                    x: 'center'
                },
                tooltip: {
                    show: true,
                    trigger: 'axis',
                    formatter: function (params, ticket, callback) {
                        var showStr = "时间:" + params[0][1] + '</br>' +
                                      "水位:" + params[0][2] + 'm' + '</br>' +
                                      "流量:" + params[1][2] + 'm³/s';
                        return showStr;
                    }
                },
                legend: {
                    data: ['河道水位', '河道流量'],
                    orient: 'horizontal',
                    x: '95',
                    y: '40'
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: false,
                        restore: true,
                        magicType: ['bar', 'line'],
                        saveAsImage: true
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['2013-12-1', '2013-12-2', '2013-12-3', '2013-12-4', '2013-12-5', '2013-12-6', '2013-12-7']
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        axisLabel: {
                            formatter: '{value}'
                        },
                        splitArea: { show: true }
                    }
                ],
                series: [
                    {
                        name: '河道水位',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: 'rgba(30, 144, 255, 0.6)'
                            }
                        },
                        data: [112, 131, 121, 142, 113, 131, 121]
                    },
                    {
                        name: '河道流量',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    color: 'rgba(252, 195, 153, 0.6)'
                                }
                            }
                        },
                        data: [1230, 800, 1400, 780, 1100, 1200, 1800]
                    }
                ]
            };
            DrawChart(chartopt);
        });
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="content" runat="server">
    <%--<div position="right" id="ss" title="ssd">bbs </div>--%>
</asp:Content>
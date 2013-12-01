<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Views/Master/QueryNew.Master" CodeBehind="WebForm2.aspx.vb" Inherits="Rw.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="jq" runat="server">
    <script src="../lib/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="js" runat="server">
    <script type ="text/javascript">
        $(function () {
            InitialLayOut(null);
            var chartopt = {
                title: {
                    text: '水库水位与库容变化',
                    x: 'center'
                },
                tooltip: {
                    show: true,
                    trigger: 'axis',
                    formatter: function (params, ticket, callback) {
                        var showStr = "时间:" + params[0][1] + '</br>' +
                                      "水位:" + params[0][2] + 'm' + '</br>' +
                                      "库容:" + params[1][2] + 'x10^5 m³';;
                        return showStr;
                    }
                },
                legend: {
                    data: ['水库水位', '水库库容'],
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
                        name: '水库水位',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: 'rgba(30, 144, 255, 0.6)'
                        }
                        },
                        data: [112, 131, 121, 142,113, 131, 121]
                    },
                    {
                        name: '水库库容',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    color: 'rgba(252, 195, 153, 0.6)'
                                }
                            }
                        },
                        data: [3000, 2100, 2300, 3200, 1200, 1300, 1800]
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

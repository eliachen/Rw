//生成eChart
function eChartsHelper_GetChart(initialFn) {
    //初始化图表相关
    require.config({
        paths: {
            echarts: '../../eCharts/echarts',
            'echarts/chart/bar': '../../eCharts/echarts',
            'echarts/chart/line': '../../eCharts/echarts'
        }
    });

    require([
                  'echarts',
                  'echarts/chart/bar',
                  'echarts/chart/line'
            ],
                    function (ec) {
                        ECharts = ec;
                        initialFn(ec);
                    });

};




//绘制简单的直方图
function eChartsHelper_DrawEasyBar(chart, eoption) {
    //清空图表
    chart.clear();

    //图表选项
    var tmpoption = {
        tooltip: {
        show: true,
        trigger: 'item'
    },
    title: {
            text: eoption.title,
            x: 'center'
        },
        legend: {
            orient: 'horizontal',
            x: '95',
            y: '40',
            data: [eoption.Y.yname || '']
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
        dataZoom: {
            show: true,
            realtime: true,
            start: 0,
            end: 20
        },
        xAxis: [
                    {
                        type: 'category',
                        boundaryGap: true,
                        data: eoption.X.xdata
                    }
                ],
        yAxis: [
                    {
                        type: 'value',
                        splitArea: { show: true }
                    }
                ],
        series: [
                    {
                        name: eoption.Y.yname || '',
                        type: eoption.type || 'bar',
                        data: eoption.Y.ydata || [],
                        itemStyle: {
                            normal: {                   // 系列级个性化，横向渐变填充
                                color: (function () {
                                    var zrColor = require('zrender/tool/color');
                                    return zrColor.getLinearGradient(
                                             0, 0, 1000, 0,
                                            [[0, 'rgba(30,144,255,0.8)'], [1, 'rgba(138,43,226,0.8)']]
                                             )
                                })()
                            }
                        }
                    }
                ]
                };

                //加载图表信息
                chart.setOption(tmpoption);
                return chart;
};



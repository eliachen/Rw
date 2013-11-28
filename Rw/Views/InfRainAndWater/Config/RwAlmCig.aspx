<%@ Page Language="VB" MasterPageFile ="~/Views/Master/Grid.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        //标题栏和编辑都开启
        GridVisual.directedit = true;
        GridVisual.searchForm = true;
        //表单大小
        FormOption.width = 830;
        FormOption.height = 450;


        var cigData = {
            Rows: [{ TIMETYPE: 'h', ACTIVETIME: '2', DRPSUM: '300', DIYINF: '2小时降雨超过300mm报警', CIG: 'h;2;300;2小时降雨超过300mm报警' },
                   { TIMETYPE: 'd', ACTIVETIME: '2', DRPSUM: '200', DIYINF: '2天降雨超过200mm报警', CIG: 'd;2;200;2天降雨超过200mm报警' }]
        };

        var diygrid = { 
            columns: [
            {
                display: '时间类型', name: 'TIMETYPE',
                editor: {
                    type: 'select', valueField: 'TIMETYPE', textField: 'text',
                    data: [{ TIMETYPE: 'h', text: '小时' }, { TIMETYPE: 'd', text: '天' }]
                },
                render:
                    function (item) {
                        switch(item.TIMETYPE){
                            case 'h':
                                return '小时';
                                break;
                            case 'd':
                                return '天';
                                break;
                        }
                    },
                width: 75
            },
            {
                display: '持续时间', name: 'ACTIVETIME',
                editor: {
                    type: 'int', valueField: 'ACTIVETIME'
                },
                type: 'int', minwidth: 30, width: 75
            },
            {
                display: '降雨量(mm)', name: 'DRPSUM',
                editor: {
                    type: 'number', valueField: 'DRPSUM'
                }, minwidth: 60, width: 80
            },
            {
                display: '自定义信息', name: 'DIYINF',
                editor: {
                    type: 'text', valueField: 'DIYINF'
                },
                minwidth: 50, width: 150
            },
            {
                display: '配置字符串', name: 'CIG',width:100, type:'text'
            },
            ],
            switchPageSizeApplyComboBox: false,
            enabledEdit:true,
            data: cigData,
            pageSize: 10, 
            checkbox: true,
            isMultiSelect: true,
            onEndEdit: function (dr) {
                var tmp = dr.record;
                this.updateRow(dr.rowindex, { CIG: tmp.TIMETYPE + ';' + tmp.ACTIVETIME + ';' + tmp.DRPSUM + ';' + tmp.DIYINF })
            }
        };


        GridColumns.mapcolums = [
            { display: '测站基本信息',fronze:true, columns:
                    [
                        { display: '测站编号', name: 'STCD', width: 140, fronze: true },
                        { display: '测站名称', name: 'STNM', width: 140, fronze: true }
                    ]
            },
            { display: '水情报警设置', columns:
                [
                    {
                        display: '警戒水位', name: 'WARNINGWATERLEVEL', width: 140,
                        editor: {
                            type: 'number', valueField: 'WARNINGWATERLEVEL'
                        }
                    },
                    {
                        display: '保证水位', name: 'GUARWATERLEVEL', width: 140,
                        editor: {
                            type: 'number', valueField: 'GUARWATERLEVEL'
                        }
                    },
                    {
                        display: '超出水位', name: 'BEYONDWATERLEVEL', width: 140,
                        editor: {
                            type: 'number', valueField: 'BEYONDWATERLEVEL'
                        }
                    }
                ]
            },
            { display: '雨情报警设置', columns: [
                       {
                           display: '降雨级别', name: 'RAINLEVEL', width: 100,
                           editor: { type: 'select', valueField: 'RAINLEVEL', data: [{ RAINLEVEL: 1, text: '小雨' }, { RAINLEVEL: 2, text: '中雨' }, { RAINLEVEL: 3, text: '大雨' }] },
                           render: function (item) {
                               switch (parseInt(item.RAINLEVEL,10)) {
                                   case 1:
                                       return '小雨';
                                       break;
                                   case 2:
                                       return '中雨';
                                       break;
                                   case 3:
                                       return '大雨';
                                       break;
                               }
                           }
                       },
                       {
                           display: '自定义',name: 'RAINDIY', type: "text", width: 400,
                           editor: {
                               type: 'select', valueField: 'CIG', textField: 'DIYINF', selectBoxWidth: 450, selectBoxHeight: 240,
                               grid: diygrid
                           }
                       }
                ]
            }

        ];

        //render: function (item) {
        //    var x = this;
        //    alert(item.RAINLEVEL);
        //    return item;
        //}
        //无设置服务器地址则是本地
        GridColumns.griddata = {
            Rows: [{ STCD: '00000001', STNM: "测试站1", WARNINGWATERLEVEL: "101.23", GUARWATERLEVEL: "123.21", BEYONDWATERLEVEL: "113.2", RAINLEVEL: 1, RAINDIY: "2小时降雨超过300mm报警" },
                   { STCD: '00000002', STNM: "测试站2", WARNINGWATERLEVEL: "101.23", GUARWATERLEVEL: "123.21", BEYONDWATERLEVEL: "113.2", RAINLEVEL: 1, RAINDIY: "2小时降雨超过300mm报警" },
                   { STCD: '00000003', STNM: "测试站3", WARNINGWATERLEVEL: "101.23", GUARWATERLEVEL: "123.21", BEYONDWATERLEVEL: "113.2", RAINLEVEL: 1, RAINDIY: "2小时降雨超过300mm报警" }]
        };


       

        //排序列                                    
        GridColumns.sortName = "CustomerID";

        //查找栏
        SearchField.fields = [{ display: "测站编码", name: "STCD", newline: true, type: "text", validate: { required: true } },
                              { display: "测站名称", name: "STNM", newline: false, type: "text" }
        ];
        //查找的处理
        SearchField.searchCallBack = function (data) {
            alert(data);
        };


        //设置数据地址
        //GridUrl.gdata = "/infBasicData/InfStationGridData";
        //GridUrl.gform = "/infBasicData/StationDetail";
        //GridUrl.gforminf = "/infBasicData/infStationDetail";
        //GridUrl.gdata = "";
        GridUrl.gform = "";
        GridUrl.gforminf = "";
        GridDataDeal.See = function (data) {
            return data.STCD;
        };

        GridDataDeal.Edit = function (data) {
            return data.STCD;
        };

        GridDataDeal.Delete = function (data) {
            return data.STCD;
        };


        $(function () {
            InitialGridSet();
            //Grid.setData({ data: CustomersData });
            //Grid.loadData(null, false, CustomersData);

        });

    </script>
</asp:Content>

<%--  var diygrid = { 
            columns: [
            {
                display: '时间类型', name: 'TIMETYPE',
                editor: {
                    type: 'select', valueField: 'TIMETYPE', textField: 'text',
                    data: [{ TIMETYPE: 'h', text: '小时' }, { TIMETYPE: 'd', text: '天' }]
                },
                render:
                    function (item) {
                        switch(item.TIMETYPE){
                            case 'h':
                                return '小时';
                                break;
                            case 'd':
                                return '天';
                                break;
                        }
                    },
                width: 75
            },
            {
                display: '持续时间', name: 'ACTIVETIME',
                editor: {
                    type: 'int', valueField: 'ACTIVETIME'
                },
                type: 'int', minwidth: 30, width: 75
            },
            {
                display: '降雨量(mm)', name: 'DRPSUM',
                editor: {
                    type: 'number', valueField: 'DRPSUM'
                }, minwidth: 60, width: 80
            },
            {
                display: '自定义信息', name: 'DIYINF',
                editor: {
                    type: 'text', valueField: 'DIYINF'
                },
                minwidth: 50, width: 150
            },
            {
                display: '', name: 'CIG',width:1, type:'text'
            },
            ],
            switchPageSizeApplyComboBox: false,
            enabledEdit:true,
            data: { Rows: [{TIMETYPE:'h',ACTIVETIME:'2',DRPSUM:'300',DIYINF:'2小时降雨超过300mm报警'}]},
            pageSize: 10, 
            checkbox: true,
            isMultiSelect:true
        };--%>
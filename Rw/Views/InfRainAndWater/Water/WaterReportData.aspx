<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/ReportData.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        #ReportViewerForWater {width: 100%;height: 100%;margin:0;}
    </style>
<script type="text/javascript">
  
    //差补
    var diffWidth = 50;
    //基本变化比
    var exbool = true;


    $(function () {

        var GridRows = { Rows: [], Total: 1 };

        //原始宽度
        var oldWidth = $('.l-layout-right').width();

        //布局及其标题
        InitialLayout(310, "水情图表");


        SetTitle("水情图表查询");

        //加载测站数据
        LigerUIHelper.ajax({
            url: "/InfBasicData/InfStation",
            success: function (data) {
                GridRows.Rows = data;
                GridRows.Total = data.length;
                InitialForms();

            }
        });




        var InitialForms = function () {


            var InitialForm = function (form, myOpt) {

                var f = null;

                //选择测站表单
                var Gridoptions = {
                    columns: [
                { display: '测站名称', name: 'STNM', align: 'left', width: 65, minWidth: 60, clickToEdit: false },
                { display: '测站编码', name: 'STCD', minWidth: 120, width: 75, clickToEdit: false }
                ],
                    switchPageSizeApplyComboBox: true,
                    data: GridRows,
                    pageSize: 10,
                    checkbox: true,
                    showTableToggleBtn: false
                };


                //myOpt.g_single = myOpt.g_single || true;
                //表格处理
                if (myOpt.g_single == true) {
                    Gridoptions.checkbox = false;
                } else {
                    Gridoptions.checkbox = true;
                };



                //表单options
                var opts = {
                    inputWidth: 130, labelWidth: 90, space: 40,
                    fields: [
                { display: "开始时间", name: "STime", type: "date", options: myOpt.time || { showTime: true, format: "yyyy-MM-dd hh:mm" }, validate: { required: true }, group: "基础信息选择" },
                { display: "结束时间", name: "ETime", type: "date", options: myOpt.time || { showTime: true, format: "yyyy-MM-dd hh:mm" }, validate: { required: true} },
                { display: "测站选择", name: "STCD", type: "select", validate: { required: true }, options: {
                    hideGridOnLoseFocus:true,	
                    isMultiSelect: true, isShowCheckBox: true,
                    selectBoxWidth: 280,
                    selectBoxHeight: 240,
                    valueField: 'STCD',
                    textField: 'STNM',
                    grid: Gridoptions
                }
                },
                { display: "类型", name: "SelectType", type: "select", options: { data: [{ id: 1, text: '报表输出' }, { id: 2, text: "图表输出"}], initValue: 1, initText: '报表输出', selectBoxHeight: 50 }, validate: { required: true }, group: "输出类型选择" }
                ],
                    buttons: [{ text: '提交', width: 60, newline: false, click: function () {
                        if ($(form).valid()) {
                            myOpt.fnclk(f.getData());
                            LigerUIHelper.tip("正在生成报表,请稍后");
                        } else {
                            //$.ligerDialog.warn("初始条件错误!");
                            LigerUIHelper.tip("查询条件错误!");
                        }
                    }
                    }
                ]
                };

                //处理时间选择
                if (myOpt.t_single == true) {
                    opts.fields[0] = { display: "时间", name: "Time", type: "date", options: myOpt.time || { showTime: true, format: "yyyy-MM-dd hh:mm" }, validate: { required: true }, group: "基础信息选择" };
                    opts.fields.splice(1, 1);
                };

                //时间自定义
                if (myOpt.TimeEx) {
                    opts.fields.splice(0, 2);
                    opts.fields = myOpt.TimeEx.concat(opts.fields);
                    //opts.fields.unshift(myOpt.TimeEx);
                };

                // opts.fields.
                f = $(form).ligerForm(opts);

                //表单验证
                $.metadata.setType("attr", "validate");
                LigerUIHelper.validate(form);

            };

            var RepUrl = "/ReportWebForm/Water/ReportWater.aspx";




            var RepSet = function (data) {
                RemoveTitle();
                $("#framecontent").attr("src", "/ReportWebForm/Water/ReportWater.aspx?rep=" + JSON2.stringify(data));
            };



            //时段水位
            InitialForm("#form_time", { g_single: false, t_single: false,
                time: { showTime: true, format: "yyyy-MM-dd hh", onChangeDate: function (val) { this.setValue(val + ':00'); } },
                fnclk: function (d) {
                    if (d.SelectType == 1) {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.STime, d.ETime], repshtype: 0, watershtype: 0, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    } else {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.STime, d.ETime], repshtype: 1, watershtype: 0, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    };

                }
            });


            //日逐时水位
            InitialForm("#form_day_avg", { t_single: true, g_single:true,
                time: { showTime: false, format: "yyyy-MM-dd" },
                fnclk: function (d) {
                    if (d.SelectType == 1) {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.Time], repshtype: 0, watershtype: 1, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    } else {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.Time], repshtype: 1, watershtype: 1, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    };

                }
            });

            var data_y = [];
            for (var i = new Date().getFullYear(); i > (new Date().getFullYear() - 10); i--) {
                data_y.push({ id: i, text: i + '年' });
            };


            var data_m = [];
            for (var i = 1; i < 13; i++) {
                data_m.push({ id: i, text: i + '月' });
            }

            //月逐日水位
            InitialForm("#form_month_avg", { t_single: false, g_single: true,
                TimeEx: [{ display: "年份", name: "YTime", type: "select", validate: { required: true },
                    options: { data: data_y, initValue: new Date().getFullYear(), initText: new Date().getFullYear() + '年', selectBoxHeight: 100 }, group: "基础信息选择"
                },
                       { display: "月份", name: "MTime", type: "select", validate: { required: true },
                           options: { data: data_m, initValue: 1, initText: '1月', selectBoxHeight: 260 }
                       }],
                       fnclk: function (d) {
                       var t = new Date();
                       t.setFullYear(d.YTime);
                       t.setMonth(d.MTime - 1);

                    if (d.SelectType == 1) {
                        var sd = { stcds: d.STCD.split(";"), timepars: [t], repshtype: 0, watershtype: 2, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    } else {
                        var sd = { stcds: d.STCD.split(";"), timepars: [t], repshtype: 1, watershtype: 2, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    };

                }
            });


            //年逐月水位
            InitialForm("#form_year_avg", { t_single: false, g_single: true,
                TimeEx: [{ display: "年份", name: "YTime", type: "select", validate: { required: true },
                    options: { data: data_y, initValue: new Date().getFullYear(), initText: new Date().getFullYear() + '年', selectBoxHeight: 100 }, group: "基础信息选择"
                }],
                fnclk: function (d) {
                    var t = new Date();
                    t.setFullYear(d.YTime);
                    if (d.SelectType == 1) {
                        var sd = { stcds: d.STCD.split(";"), timepars: [t], repshtype: 0, watershtype: 3, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    } else {
                        var sd = { stcds: d.STCD.split(";"), timepars: [t], repshtype: 1, watershtype: 3, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    };

                }
            });

            //时段流量
            InitialForm("#form_q_time", { g_single: false, t_single: false,
                time: { showTime: true, format: "yyyy-MM-dd hh", onChangeDate: function (val) { this.setValue(val + ':00'); } },
                fnclk: function (d) {
                    if (d.SelectType == 1) {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.STime, d.ETime], repshtype: 0, watershtype: 4, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    } else {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.STime, d.ETime], repshtype: 1, watershtype: 4, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    };

                }
            });

            //时段蓄水量
            InitialForm("#form_wth_time", { g_single: false, t_single: false,
                time: { showTime: true, format: "yyyy-MM-dd hh", onChangeDate: function (val) { this.setValue(val + ':00'); } },
                fnclk: function (d) {
                    if (d.SelectType == 1) {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.STime, d.ETime], repshtype: 0, watershtype: 5, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    } else {
                        var sd = { stcds: d.STCD.split(";"), timepars: [d.STime, d.ETime], repshtype: 1, watershtype: 5, H: $(".l-layout-center").height(), W: $(".l-layout-center").width() };
                        RepSet(sd);
                    };

                }
            });

        };
    });

</script>
</asp:Content>

<%--项目--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ArccordingIndex" runat="server">
                               
                                 <div id="Div1" title="时段水位检索">
                                       <form id="form_time" ></form> 
                                 </div>
                                 <div id="Div2" title="日逐时水位检索">
                                        <form id="form_day_avg"></form>
                                 </div>
                                  <div id="Div3" title="月逐日平均水位检索">
                                      <form id="form_month_avg"></form>
                                 </div>
                                  <div id="Div4" title="年逐月平均水位检索">
                                      <form id="form_year_avg"></form>
                                 </div>
                                 <div id="Div5" title="时段流量检索">
                                      <form id="form_q_time"></form>
                                 </div>
                                  <div id="Div6" title="时段蓄水量检索">
                                      <form id="form_wth_time"></form>
                                 </div>
</asp:Content>




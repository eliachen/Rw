
<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/Form.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../../../Scripts/RwData/RwDataHelper.js" type="text/javascript"></script>
    <script type ="text/javascript">
        $(function () {
            formType = "new";

            formDealUrl = "/InfRainAndWater/InfRainDetail";

            //数据设计
            var WthData = [];
            $.each(Helper_Data_WTHEnum, function (index, item) {
                WthData.push({ id: index, text: item });
            });

            //表单设计
            formfields = [{ display: '测站编码', name: 'STCD', validate: { required: true, maxlength: 8 }, newline: true, type: "text", group: "数据" },
                           { display: '时段降水量', name: 'DRP', newline: true, type: "number", validate: { required: true} }, { display: '时段长', name: 'INTV', type: "int", newline: true },
                           { display: '降水历时', name: 'PDR', newline: true, type: "int" }, { display: '日降水量', name: 'DYP', type: "number", newline: true },
                            { display: '天气状况', name: 'WTH', type: 'select', editor: { data: WthData }, newline: true },
                           { display: '时间', name: 'TM', newline: true, type: "date", options: { showTime: true, format: "yyyy-MM-dd hh",onChangeDate: function (value) {this.setValue(value+':00:00') } }, validate: { required: true, date: true} }
                          ];


            //

            //信息修改后的刷新
            var GridFresh = function (data) {
                if (parent.Fresh) {
                    parent.Fresh();
                };
            };

            CallBack["delete"] = GridFresh;
            CallBack["new"] = GridFresh;
            CallBack["edit"] = GridFresh;
            CallBack["close"] = function () {
                //Dialog形式打开的,关闭上一个对话框
                if (parent.GridDialog) parent.GridDialog.close();
            };
            InitialFormSet();
        });

    
    </script>

</asp:Content>


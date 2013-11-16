<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/Form.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../../../Scripts/RwData/RwDataHelper.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            formType = "new";

            formDealUrl = "/InfRainAndWater/InfWaterDetail";

            //库水特征映射
            var RwData = [];
            $.each(Helper_Data_RWEnum, function (index, item) {
                RwData.push({ id: index, text: item });
            });


            //库水水势特征映射
            var RwptnData = [];
            $.each(Helper_Data_RWPEnum, function (index, item) {
                RwptnData.push({ id: index, text: item });
            });

            //测流方法映射
            var MsqmtData = [];
            $.each(Helper_Data_MSQEnum, function (index, item) {
                MsqmtData.push({ id: index, text: item });
            });

            //表单设计
            formfields = [{ display: '测站编码', name: 'STCD', validate: { required: true, maxlength: 8 }, type: "text", group: "数据" },
                                               { display: '库水位', name: 'RZ', type: 'number', validate: { required: true } },
                                               { display: '入库流量', name: 'INQ', type: 'number' }, { display: '蓄水量', name: 'W', type: 'number' },
                                               { display: '出库流量', name: 'OTQ', type: 'number' }, { display: '库水特征码', name: 'RWCHRCD', type: "select", editor: { data: RwData } },
                                               { display: '库水水势', name: 'RWPTN', type: "select", editor: { data: RwptnData } }, { display: '入流时段长', name: 'INQDR', type: 'number' },
                                               { display: '测流方法', name: 'MSQMT', type: "select", editor: { data: MsqmtData } },
                                               { display: '时间', name: 'TM', type: "date", options: { showTime: true, format: "yyyy-MM-dd hh:mm" }, validate: { required: true, date: true } }
            ];


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

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

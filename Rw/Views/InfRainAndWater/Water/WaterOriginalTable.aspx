<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/Grid.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Water
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <script src="../../../Scripts/RwData/RwDataHelper.js" type="text/javascript"></script>
    <script type="text/javascript">
        //标题栏和编辑都开启
        //GridVisual.edit = true;
        GridVisual.directedit = true;
        GridVisual.searchForm = true;
        //
        FormOption.width = 830;
        FormOption.height = 450;

        //库水特征映射
        var RwData = [];
        $.each(Helper_Data_RWEnum, function (index, item) {
            RwData.push({ RWCHRCD: index, text: item });
        });

        var RwEditor = { type: 'select', data: RwData, valueColumnName: 'RWCHRCD' };

        var RwRender = function (item) {
            return Helper_Data_RWEnum[item.RWCHRCD];
        };

        //库水水势特征映射
        var RwptnData = [];
        $.each(Helper_Data_RWPEnum, function (index, item) {
            RwptnData.push({ RWPTN: index, text: item });
        });

        var RwptnEditor = { type: 'select', data: RwptnData, valueColumnName: 'RWPTN' };

        var RwptnRender = function (item) {
            return Helper_Data_RWPEnum[item.RWPTN];
        };

        //测流方法映射
        var MsqmtData = [];
        $.each(Helper_Data_MSQEnum, function (index, item) {
            MsqmtData.push({ MSQMT: index, text: item });
        });

        var MsqmtEditor = { type: 'select', data: MsqmtData, valueColumnName: 'MSQMT' };

        var MsqmtRender = function (item) {
            return Helper_Data_MSQEnum[item.MSQMT];
        };

      


        //映射列
        GridColumns.mapcolums = [{ display: '测站编码', name: 'STCD', width: 80 },
                                              { display: '时间', name: 'TM', width: 170 },
                                              { display: '库水位', name: 'RZ', editor: { type: 'number' }, width: 80 },
                                              { display: '入库流量', name: 'INQ', editor: { type: 'number' }, width: 80 }, { display: '蓄水量', name: 'W', editor: { type: 'number' }, width: 80 },
                                              { display: '出库流量', name: 'OTQ', editor: { type: 'number' }, width: 80 }, { display: '库水特征码', name: 'RWCHRCD', editor: RwEditor, render: RwRender, width: 80 },
                                              { display: '库水水势', name: 'RWPTN', editor: RwptnEditor, render: RwptnRender, width: 80 }, { display: '入流时段长', name: 'INQDR', editor: { type: 'number' }, width: 80 },
                                              { display: '测流方法', name: 'MSQMT', width: 150, editor: MsqmtEditor, render: MsqmtRender, width: 150 }
                                  ];
        //排序列                                    
        GridColumns.sortName = "TM";

        //查找栏
        SearchField.fields = [{ display: "测站编码", name: "STCD", newline: true, type: "text", validate: { required: true} },
                              { display: "起始时间", name: "STime", newline: false, type: "date", options: { showTime: true }, validate: { required: true} },
                              { display: "结束时间", name: "ETime", newline: false, type: "date", options: { showTime: true }, validate: { required: true} }
        ];
        //
        GridDataDeal.Success = function (data) {
            data = $.map(data.Rows, function (item) {
                item.TM = LigerUIHelper.FormatTime(item.TM, "YYYY-MM-dd HH:mm:ss");
                return item;
            });
        };

        //查找的处理
        SearchField.searchCallBack = function (data) {
            alert(data);
        };
        //设置数据地址
        GridUrl.gdata = "/infRainAndWater/InfWaterGridData";
        GridUrl.gform = "/infRainAndWater/WaterDetail";
        GridUrl.gforminf = "/infRainAndWater/infWaterDetail";


        GridDataDeal.Delete = function (data) {
            return data;
        };

        GridDataDeal.Edit = function (data) {
            return data;
        };
        GridDataDeal.Save = function (data) {
            return data;
        };


        $(function () {
            InitialGridSet();
        });
    
    </script>

</asp:Content>

<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/Grid.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Rain
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../../../Scripts/RwData/RwDataHelper.js" type="text/javascript"></script>
<script type="text/javascript">
        //标题栏和编辑都开启
    //GridVisual.edit = true;
    GridVisual.directedit = true;
    GridVisual.searchForm = true;
    //
    FormOption.width = 840;
    FormOption.height = 350;
    //编辑天气映射
    var WthData=[];
    $.each(Helper_Data_WTHEnum, function (index, item) {
        WthData.push({ WTH: index, text: item });
    });

    var WthEditor = { type: 'select', data: WthData, valueColumnName: 'WTH' };

    var WthRender = function (item) {
        return Helper_Data_WTHEnum[item.WTH];
    };

  
        //映射列
    GridColumns.mapcolums = [{ display: '测站编码', name: 'STCD', width: 80 },
                                              { display: '时间', name: 'TM', edit: false,options:{showTime:true,format:"yyyy-MM-dd hh:mm"}, width: 170 },
                                              { display: '时段降水量', name: 'DRP', editor: { type: 'number' }, width: 80 },
                                              { display: '时段长', name: 'INTV', editor: { type: 'number' }, width: 80 }, { display: '降水历时', name: 'PDR', editor: { type: 'number' }, width: 80 },
                                              { display: '日降水量', name: 'DYP', editor: { type: 'number' }, width: 80 }, { display: '天气状况', name: 'WTH', editor: WthEditor,render:WthRender, width: 80 }

                                  ];
        //排序列                                    
        GridColumns.sortName = "TM";

        //查找栏
        SearchField.fields = [{ display: "测站编码", name: "STCD", newline: true, type: "text", validate: {required:true} },
                              { display: "起始时间", name: "STime",  newline: false, type: "date",options:{showTime:true},validate: {required:true} },
                              { display: "结束时间", name: "ETime", newline: false, type: "date", options: { showTime: true }, validate: { required: true} }
        ];
        //查找的处理
        SearchField.searchCallBack = function (data) {
            alert(data);
        };
        //设置数据地址
        GridUrl.gdata = "/infRainAndWater/InfRainGridData";
        GridUrl.gform = "/infRainAndWater/RainDetail";
        GridUrl.gforminf = "/infRainAndWater/infRainDetail";

        //时间数据处理
        GridDataDeal.Success = function (data) {
            data = $.map(data.Rows, function (item) {
                item.TM = LigerUIHelper.FormatTime(item.TM, "YYYY-MM-dd HH:mm:ss");
                return item;
            });
        };

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

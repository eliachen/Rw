<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/Grid.Master" Inherits="System.Web.Mvc.ViewPage(Of Rw.EntityData.ST_PPTN_R)" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Station
</asp:Content>

<asp:Content ID="JSDO" ContentPlaceHolderID="MainContent" runat="server">
   <script src="../../Scripts/RwData/RwDataHelper.js" type="text/javascript"></script>
   <script type="text/javascript">

       //水文测站类型:STTP
       var SttpData = [];
       $.each(Helper_Data_STTPEnum, function (dicindex, item) {
           SttpData.push({ STTP: dicindex, text: dicindex + '(' + item + ')' });
       });

       var SttpEditor = { type: 'select', data: SttpData, valueColumnName: 'STTP' };

       var SttpRender = function (item) {
           return Helper_GetSTTP(item.STTP) + '(' + item.STTP + ')';
       };
   </script>
   
    <script type="text/javascript">

        //标题栏和编辑都开启
        GridVisual.edit = true;
        GridVisual.searchForm = true;
        //表单大小
        FormOption.height = 540;

        //映射列
        GridColumns.mapcolums = [{ display: '测站编码', name: 'STCD', width: 80 },
                                              { display: '测站名称', name: 'STNM', width: 80 }, { display: '河流名称', name: 'RVNM', width: 80 },
                                              { display: '水系名称', name: 'HNNM', width: 80 }, { display: '流域名称', name: 'BSNM', width: 80 },
                                              { display: '经度', name: 'LGTD', width: 80 }, { display: '纬度', name: 'LTTD', width: 80 },
                                              { display: '站址', name: 'STLC', width: 200 }, { display: '行政区划码', name: 'ADDVCD', width: 80 },
                                              { display: '修正基值', name: 'MDBZ', width: 80 }, { display: '修正参数', name: 'MDPR', width: 80 },
                                              { display: '基面名称', name: 'DTMNM', width: 80 }, { display: '拍报段次', name: 'DFRTMS', width: 80 },
                                              { display: '基面高程', name: 'DTMEL', width: 80 }, { display: '站类', name: 'STTP', width: 150,  render: SttpRender },
                                              { display: '拍报项目', name: 'FRITM', width: 80 }, { display: '报汛等级', name: 'FRGRD', width: 80 },
                                              { display: '始报年月', name: 'BGFRYM', width: 80 }, { display: '建站年月', name: 'ESSTYM', width: 80 },
                                              { display: '管理机构', name: 'ADMAUTH', width: 80 }, { display: '测站岸别', name: 'STBK', width: 80 },
                                              { display: '集水面积', name: 'DRNA', width: 80 }, { display: '拼音码', name: 'PHCD', width: 80 }
                                  ];
        //排序列                                    
        GridColumns.sortName = "STCD";

        //查找栏
        SearchField.fields = [{ display: "测站编码", name: "STCD", newline: true, type: "text", validate: {required:true} },
                              { display: "测站名称", name: "STNM", newline: false, type: "text"}
        ];
        //查找的处理
        SearchField.searchCallBack = function (data) {
                                  alert(data);
                              };


        //设置数据地址
                              GridUrl.gdata = "/infBasicData/InfStationGridData";
                              GridUrl.gform = "/infBasicData/StationDetail";
                              GridUrl.gforminf = "/infBasicData/infStationDetail";
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
                              });

    </script>
</asp:Content>

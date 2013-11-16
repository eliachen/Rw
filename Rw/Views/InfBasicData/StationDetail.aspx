<%@ Page Title="" Language="VB" MasterPageFile="~/Views/Master/Form.Master" Inherits="System.Web.Mvc.ViewPage(Of Rw.EntityData.ST_STBPRP_B)" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <script src="../../Scripts/RwData/RwDataHelper.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {

            //表单类型
            formType = '<%= ViewData("formtype") %>';
            //表单初始数据(字符串,复杂格式采用json转化)
            formData = '<%= ViewData("formdata") %>';
            //表单处理地址
            formDealUrl = "/infBasicData/InfStationDetail";
            //选框初始化
            //水文测站类型:STTP
            var SttpData = [];
            $.each(Helper_Data_STTPEnum, function (dicindex, item) {
                SttpData.push({ id: dicindex, text: dicindex + '(' + item + ')' });
            });
    
            //拍报项目
//            var FRITMData = [];
//            $.each(Helper_Data_FRITMEnum, function (dicindex, item) {
//                FRITMData.push({ id: dicindex, text: dicindex + '(' + item + ')' });
            //            });
            //{ display: '拍报项目', name: 'FRITM', type: "select",editor:{data:FRITMData}, newline: true }
            
            //报讯等级
            var FRGRDData = [];
            $.each(Helper_Data_FRGRDEnum, function (dicindex, item) {
                FRGRDData.push({ id: dicindex, text: dicindex + '(' + item + ')' });
            });

            //表单设计
            formfields = [{ display: '测站编码', name: 'STCD', validate: { required: true, maxlength: 8 }, newline: true, type: "text", group: "必要信息" }, { display: '测站名称', name: 'STNM', validate: { required: true }, type: "text", newline: false },
                           { display: '管理机构', name: 'ADMAUTH', validate: { required: true }, newline: true, type: "text" }, { display: '所属单位', name: 'LOCALITY', validate: { required: true }, type: "text", newline: false },
                           { display: '经度', name: 'LGTD', validate: { required: true }, type: "number" }, { display: '纬度', name: 'LTTD', validate: { required: true }, type: "number", newline: false },
                           { display: '站址', name: 'STLC', validate: { required: true }, type: "text", newline: true }, { display: '站类', name: 'STTP', validate: { required: true }, width: 150, type: "select", editor: { data: SttpData }, newline: false },
                           { display: '河流名称', name: 'RVNM', newline: true, type: "text", group: "其它信息" },
                           { display: '水系名称', name: 'HNNM', type: "text", newline: true }, { display: '流域名称', name: 'BSNM', type: "text", newline: false },
                           { display: '行政区划码', name: 'ADDVCD', type: "text", newline: true }, { display: '拼音码', name: 'PHCD', type: "text", newline: false },
                           { display: '修正基值', name: 'MDBZ', type: "number", newline: true }, { display: '修正参数', name: 'MDPR', type: "number", newline: false },
                           { display: '基面名称', name: 'DTMNM', type: "text", newline: true }, { display: '拍报段次', name: 'DFRTMS', type: "number", newline: false },
                           { display: '基面高程', name: 'DTMEL', type: "number", newline: true }, { display: '修改时间', name: 'MODITIME', type: "date", options: { showTime: true, format: "yyyy-MM-dd hh:mm:ss" }, newline: false },
                           { display: '报汛等级', name: 'FRGRD', type: "select",editor:{data:FRGRDData}, newline: true },{ display: '集水面积', name: 'DRNA', type: "number", newline: false },
                           { display: '始报年月', name: 'BGFRYM', type: "date", options: { format: "yyyy-MM" }, newline: true }, { display: '建站年月', name: 'ESSTYM', type: "date", options: { format: "yyyy-MM" }, newline: false },
                           { display: '测站岸别', name: 'STBK', type: "select", editor: { data: [{ id: 0, text: "左岸" }, { id: 1, text: "右岸" }, { id: null , text: "无"}] }, newline: true }
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



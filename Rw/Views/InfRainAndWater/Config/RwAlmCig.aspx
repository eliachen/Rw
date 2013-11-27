<%@ Page Language="VB" MasterPageFile ="~/Views/Master/Grid.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        //标题栏和编辑都开启
        GridVisual.edit = true;
        GridVisual.searchForm = true;
        //表单大小
        FormOption.height = 540;

        //映射列
        //GridColumns.mapcolums = [{ display: '测站编码', name: 'STCD', width: 80 },
        //                                      { display: '测站名称', name: 'STNM', width: 80 }, { display: '河流名称', name: 'RVNM', width: 80 },
        //                                      { display: '水系名称', name: 'HNNM', width: 80 }, { display: '流域名称', name: 'BSNM', width: 80 },
        //                                      { display: '经度', name: 'LGTD', width: 80 }, { display: '纬度', name: 'LTTD', width: 80 },
        //                                      { display: '站址', name: 'STLC', width: 200 }, { display: '行政区划码', name: 'ADDVCD', width: 80 },
        //                                      { display: '修正基值', name: 'MDBZ', width: 80 }, { display: '修正参数', name: 'MDPR', width: 80 },
        //                                      { display: '基面名称', name: 'DTMNM', width: 80 }, { display: '拍报段次', name: 'DFRTMS', width: 80 },
        //                                      { display: '基面高程', name: 'DTMEL', width: 80 }, { display: '站类', name: 'STTP', width: 150, render: SttpRender },
        //                                      { display: '拍报项目', name: 'FRITM', width: 80 }, { display: '报汛等级', name: 'FRGRD', width: 80 },
        //                                      { display: '始报年月', name: 'BGFRYM', width: 80 }, { display: '建站年月', name: 'ESSTYM', width: 80 },
        //                                      { display: '管理机构', name: 'ADMAUTH', width: 80 }, { display: '测站岸别', name: 'STBK', width: 80 },
        //                                      { display: '集水面积', name: 'DRNA', width: 80 }, { display: '拼音码', name: 'PHCD', width: 80 }
        //];

        var CustomersData =
{ Rows: [{ "CustomerID": "ALFKI", "CompanyName": "Alfreds Futterkiste", "ContactName": "Maria Anders", "ContactTitle": "Sales Representative", "Address": "Obere Str. 57", "City": "Berlin", "Region": null, "PostalCode": "12209", "Country": "Germany", "Phone": "030-0074321", "Fax": "030-0076545" }, { "CustomerID": "ANATR", "CompanyName": "Ana Trujillo Emparedados y helados", "ContactName": "Ana Trujillo", "ContactTitle": "Owner", "Address": "Avda. de la Constitución 2222", "City": "México D.F.", "Region": null, "PostalCode": "05021", "Country": "Mexico", "Phone": "(5) 555-4729", "Fax": "(5) 555-3745" }, { "CustomerID": "ANTON", "CompanyName": "Antonio Moreno Taquería", "ContactName": "Antonio Moreno", "ContactTitle": "Owner", "Address": "Mataderos  2312", "City": "México D.F.", "Region": null, "PostalCode": "05023", "Country": "Mexico", "Phone": "(5) 555-3932", "Fax": null }, { "CustomerID": "AROUT", "CompanyName": "Around the Horn", "ContactName": "Thomas Hardy", "ContactTitle": "Sales Representative", "Address": "120 Hanover Sq.", "City": "London", "Region": null, "PostalCode": "WA1 1DP", "Country": "UK", "Phone": "(171) 555-7788", "Fax": "(171) 555-6750" }, { "CustomerID": "BERGS", "CompanyName": "Berglunds snabbköp", "ContactName": "Christina Berglund", "ContactTitle": "Order Administrator", "Address": "Berguvsvägen  8", "City": "Luleå", "Region": null, "PostalCode": "S-958 22", "Country": "Sweden", "Phone": "0921-12 34 65", "Fax": "0921-12 34 67" }, { "CustomerID": "BLAUS", "CompanyName": "Blauer See Delikatessen", "ContactName": "Hanna Moos", "ContactTitle": "Sales Representative", "Address": "Forsterstr. 57", "City": "Mannheim", "Region": null, "PostalCode": "68306", "Country": "Germany", "Phone": "0621-08460", "Fax": "0621-08924" }, { "CustomerID": "BLONP", "CompanyName": "Blondel père et fils", "ContactName": "Frédérique Citeaux", "ContactTitle": "Marketing Manager", "Address": "24, place Kléber", "City": "Strasbourg", "Region": null, "PostalCode": "67000", "Country": "France", "Phone": "88.60.15.31", "Fax": "88.60.15.32" }, { "CustomerID": "BOLID", "CompanyName": "Bólido Comidas preparadas", "ContactName": "Martín Sommer", "ContactTitle": "Owner", "Address": "C/ Araquil, 67", "City": "Madrid", "Region": null, "PostalCode": "28023", "Country": "Spain", "Phone": "(91) 555 22 82", "Fax": "(91) 555 91 99" }, { "CustomerID": "BONAP", "CompanyName": "Bon app'", "ContactName": "Laurence Lebihan", "ContactTitle": "Owner", "Address": "12, rue des Bouchers", "City": "Marseille", "Region": null, "PostalCode": "13008", "Country": "France", "Phone": "91.24.45.40", "Fax": "91.24.45.41" }, { "CustomerID": "BOTTM", "CompanyName": "Bottom-Dollar Markets", "ContactName": "Elizabeth Lincoln", "ContactTitle": "Accounting Manager", "Address": "23 Tsawassen Blvd.", "City": "Tsawwassen", "Region": "BC", "PostalCode": "T2F 8M4", "Country": "Canada", "Phone": "(604) 555-4729", "Fax": "(604) 555-3745" }, { "CustomerID": "BSBEV", "CompanyName": "B's Beverages", "ContactName": "Victoria Ashworth", "ContactTitle": "Sales Representative", "Address": "Fauntleroy Circus", "City": "London", "Region": null, "PostalCode": "EC2 5NT", "Country": "UK", "Phone": "(171) 555-1212", "Fax": null }, { "CustomerID": "CACTU", "CompanyName": "Cactus Comidas para llevar", "ContactName": "Patricio Simpson", "ContactTitle": "Sales Agent", "Address": "Cerrito 333", "City": "Buenos Aires", "Region": null, "PostalCode": "1010", "Country": "Argentina", "Phone": "(1) 135-5555", "Fax": "(1) 135-4892" }, { "CustomerID": "CENTC", "CompanyName": "Centro comercial Moctezuma", "ContactName": "Francisco Chang", "ContactTitle": "Marketing Manager", "Address": "Sierras de Granada 9993", "City": "México D.F.", "Region": null, "PostalCode": "05022", "Country": "Mexico", "Phone": "(5) 555-3392", "Fax": "(5) 555-7293" }, { "CustomerID": "CHOPS", "CompanyName": "Chop-suey Chinese", "ContactName": "Yang Wang", "ContactTitle": "Owner", "Address": "Hauptstr. 29", "City": "Bern", "Region": null, "PostalCode": "3012", "Country": "Switzerland", "Phone": "0452-076545", "Fax": null }, { "CustomerID": "COMMI", "CompanyName": "Comércio Mineiro", "ContactName": "Pedro Afonso", "ContactTitle": "Sales Associate", "Address": "Av. dos Lusíadas, 23", "City": "São Paulo", "Region": "SP", "PostalCode": "05432-043", "Country": "Brazil", "Phone": "(11) 555-7647", "Fax": null }, { "CustomerID": "CONSH", "CompanyName": "Consolidated Holdings", "ContactName": "Elizabeth Brown", "ContactTitle": "Sales Representative", "Address": "Berkeley Gardens\r\n12  Brewery ", "City": "London", "Region": null, "PostalCode": "WX1 6LT", "Country": "UK", "Phone": "(171) 555-2282", "Fax": "(171) 555-9199" }, { "CustomerID": "DRACD", "CompanyName": "Drachenblut Delikatessen", "ContactName": "Sven Ottlieb", "ContactTitle": "Order Administrator", "Address": "Walserweg 21", "City": "Aachen", "Region": null, "PostalCode": "52066", "Country": "Germany", "Phone": "0241-039123", "Fax": "0241-059428" }, { "CustomerID": "DUMON", "CompanyName": "Du monde entier", "ContactName": "Janine Labrune", "ContactTitle": "Owner", "Address": "67, rue des Cinquante Otages", "City": "Nantes", "Region": null, "PostalCode": "44000", "Country": "France", "Phone": "40.67.88.88", "Fax": "40.67.89.89" }, { "CustomerID": "EASTC", "CompanyName": "Eastern Connection", "ContactName": "Ann Devon", "ContactTitle": "Sales Agent", "Address": "35 King George", "City": "London", "Region": null, "PostalCode": "WX3 6FW", "Country": "UK", "Phone": "(171) 555-0297", "Fax": "(171) 555-3373" }, { "CustomerID": "ERNSH", "CompanyName": "Ernst Handel", "ContactName": "Roland Mendel", "ContactTitle": "Sales Manager", "Address": "Kirchgasse 6", "City": "Graz", "Region": null, "PostalCode": "8010", "Country": "Austria", "Phone": "7675-3425", "Fax": "7675-3426" }, { "CustomerID": "FAMIA", "CompanyName": "Familia Arquibaldo", "ContactName": "Aria Cruz", "ContactTitle": "Marketing Assistant", "Address": "Rua Orós, 92", "City": "São Paulo", "Region": "SP", "PostalCode": "05442-030", "Country": "Brazil", "Phone": "(11) 555-9857", "Fax": null }, { "CustomerID": "FISSA", "CompanyName": "FISSA Fabrica Inter. Salchichas S.A.", "ContactName": "Diego Roel", "ContactTitle": "Accounting Manager", "Address": "C/ Moralzarzal, 86", "City": "Madrid", "Region": null, "PostalCode": "28034", "Country": "Spain", "Phone": "(91) 555 94 44", "Fax": "(91) 555 55 93" }, { "CustomerID": "FOLIG", "CompanyName": "Folies gourmandes", "ContactName": "Martine Rancé", "ContactTitle": "Assistant Sales Agent", "Address": "184, chaussée de Tournai", "City": "Lille", "Region": null, "PostalCode": "59000", "Country": "France", "Phone": "20.16.10.16", "Fax": "20.16.10.17" }, { "CustomerID": "FOLKO", "CompanyName": "Folk och fä HB", "ContactName": "Maria Larsson", "ContactTitle": "Owner", "Address": "Åkergatan 24", "City": "Bräcke", "Region": null, "PostalCode": "S-844 67", "Country": "Sweden", "Phone": "0695-34 67 21", "Fax": null }, { "CustomerID": "FRANK", "CompanyName": "Frankenversand", "ContactName": "Peter Franken", "ContactTitle": "Marketing Manager", "Address": "Berliner Platz 43", "City": "München", "Region": null, "PostalCode": "80805", "Country": "Germany", "Phone": "089-0877310", "Fax": "089-0877451" }, { "CustomerID": "FRANR", "CompanyName": "France restauration", "ContactName": "Carine Schmitt", "ContactTitle": "Marketing Manager", "Address": "54, rue Royale", "City": "Nantes", "Region": null, "PostalCode": "44000", "Country": "France", "Phone": "40.32.21.21", "Fax": "40.32.21.20" }, { "CustomerID": "FRANS", "CompanyName": "Franchi S.p.A.", "ContactName": "Paolo Accorti", "ContactTitle": "Sales Representative", "Address": "Via Monte Bianco 34", "City": "Torino", "Region": null, "PostalCode": "10100", "Country": "Italy", "Phone": "011-4988260", "Fax": "011-4988261" }, { "CustomerID": "FURIB", "CompanyName": "Furia Bacalhau e Frutos do Mar", "ContactName": "Lino Rodriguez ", "ContactTitle": "Sales Manager", "Address": "Jardim das rosas n. 32", "City": "Lisboa", "Region": null, "PostalCode": "1675", "Country": "Portugal", "Phone": "(1) 354-2534", "Fax": "(1) 354-2535" }, { "CustomerID": "GALED", "CompanyName": "Galería del gastrónomo", "ContactName": "Eduardo Saavedra", "ContactTitle": "Marketing Manager", "Address": "Rambla de Cataluña, 23", "City": "Barcelona", "Region": null, "PostalCode": "08022", "Country": "Spain", "Phone": "(93) 203 4560", "Fax": "(93) 203 4561" }, { "CustomerID": "GODOS", "CompanyName": "Godos Cocina Típica", "ContactName": "José Pedro Freyre", "ContactTitle": "Sales Manager", "Address": "C/ Romero, 33", "City": "Sevilla", "Region": null, "PostalCode": "41101", "Country": "Spain", "Phone": "(95) 555 82 82", "Fax": null }], Total: 91 };

        GridColumns.mapcolums = [
            {
                display: '测站基本信息',fronze:true, columns:
                    [
                        { display: '测站编号', name: 'STCD', width: 220, fronze: true },
                        { display: '测站名称', name: 'STNM',  width: 220, fronze: true }
                    ]
            },
            { display: '水情报警设置', columns:
                [
                    { display: '警戒水位', name: 'WARNINGWATERLEVEL',  width: 220 },
                    { display: '保证水位', name: 'GUARWATERLEVEL', width: 240 },
                    { display: '超出水位', name: 'BEYONDWATERLEVEL', width: 240 }
                ]
            },
            { display: '雨情报警设置', columns: [
                       { display: '降雨级别', name: 'RAINLEVEL',  width: 220 },
                       { display: '自定义', name: 'RAINDIY', width: 240 }
                ]
            }

        ];

        //无设置服务器地址则是本地
        GridColumns.griddata = { Rows: [{STCD:1,STNM:"林泽琛",WARNINGWATERLEVEL:"101.23",GUARWATERLEVEL:"123.21",BEYONDWATERLEVEL:"113.2",RAINLEVEL:"1",RAINDIY:2}]};


       

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
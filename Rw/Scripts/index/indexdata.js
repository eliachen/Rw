/// <reference path="../../Views/InfRainAndWater/Config/RwAlmCig.aspx" />

var indexdata =
[
     { text: "信息监视图", isexpand: "true", children: [
		{ tabid: "home", url: "/InfRainAndWater/RainAndWater", text: "雨水情信息监视图" },
        { url: "/InfMeteorological?id=Meteorological", text: "气象信息监视图" },
        { url: "/InfPumpStation?id=PumpStationMap", text: "闸门与泵站信息监视图" },
        { url: "/InfRiverAndReservoir?id=RiverAndReservoirMap", text: "河道与水库信息监视图" }
	 ]
     },
    { text: "数据图表", isexpand: "true", children: [
		{ url: "/InfRainAndWater/Index?id=Rain/RainReportData", text: "雨情信息图表" },
		{ url: "/InfRainAndWater/Index?id=Water/WaterReportData", text: "水情信息图表" }
	]
    },
     {
          text: " 视频监控", isexpand: "true", children: [
          { url: "/InfPumpStation?id=PumpStationVideo", text: "视频监控中心" }
          //{ url: "/InfPumpStation?id=PumpStation", text: "泵站数据信息一览" }
         ]
     },
    {
        text: "基础数据管理", isexpand: "true", children: [
        { url: "/InfRainAndWater/Index?id=Config/RwAlmCig", text: "雨水情报警数据设置" },
        { url: "/InfRainAndWater/Index?id=Rain/RainOriginalTable", text: "雨情数据表" },
		{ url: "/InfRainAndWater/Index?id=Water/WaterOriginalTable", text: "水情数据表" },
		{ url: "/InfBasicData/Index/Station", text: "测站信息维护" }
       
	]
    }
];


var indexdata2 =
[
    { isexpand: "true", text: "表格", children: [
        { isexpand: "true", text: "可排序", children: [
		    { url: "dotnetdemos/grid/sortable/client.aspx", text: "客户端" },
            { url: "dotnetdemos/grid/sortable/server.aspx", text: "服务器" }
	    ]
        },
        { isexpand: "true", text: "可分页", children: [
		    { url: "dotnetdemos/grid/pager/client.aspx", text: "客户端" },
            { url: "dotnetdemos/grid/pager/server.aspx", text: "服务器" }
	    ]
        },
        { isexpand: "true", text: "树表格", children: [
		    { url: "dotnetdemos/grid/treegrid/tree.aspx", text: "树表格" } 
	    ]
        }
    ]
    }
];

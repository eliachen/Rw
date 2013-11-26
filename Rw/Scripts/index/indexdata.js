
var indexdata =
[
     { text: "信息图", isexpand: "true", children: [
		{ tabid: "home", url: "/InfRainAndWater/RainAndWater", text: "雨水情监测图" },
        { url: "/InfRainAndWater/RainAndWater", text: "土壤墒情图" },
        { url: "/InfRainAndWater/RainAndWater", text: "土壤墒情图" }
	 ]
     },
    { text: "数据图表", isexpand: "true", children: [
		{ url: "/InfRainAndWater/Index?id=Rain/RainReportData", text: "雨情信息图表" },
		{ url: "/InfRainAndWater/Index?id=Water/WaterReportData", text: "水情信息图表" }
	]
    },
     {
          text: "泵站监控", isexpand: "true", children: [
          { url: "/InfPumpStation?id=PumpStation", text: "泵站数据信息一览" },
          { url: "/InfPumpStation?id=PumpStationVideo", text: "泵站视频监控" }
         ]
     },
    { text: "基础数据管理", isexpand: "true", children: [
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

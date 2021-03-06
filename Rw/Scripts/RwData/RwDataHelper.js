﻿//测站类型
var Helper_Data_STTPEnum = {
    'MM': '气象站',
    'BB': '蒸发站',
    'DD': '堰闸水文站',
    'TT': '潮位站',
    'DP': '泵站',
    'SS': '墒情站',
    'PP': '雨量站',
    'ZZ': '河道水位水文站',
    'RR': '水库水文水站',
    'ZG': '地下水站',
    'ZB': '分洪水位站'
};
//拍报项目
var Helper_Data_FRITMEnum = {
    '1': '降水',
    '2': '蒸发',
    '3': '水位',
    '4': '流量',
    '5': '库内水位',
    '6': '蓄水量',
    '7': '入库流量',
    '8': '闸门启闭',
    '9': '出库流量',
    '10': '风浪',
    '11': '泥沙',
    '12': '冰情',
    '13': '抽水',
    '14': '引水',
    '15': '排水',
    '16': '墒情',
    '17': '地下水',
    '18': '旬月统计'
};
//报讯等级
var Helper_Data_FRGRDEnum = {
    '1': '中央报汛站',
    '2': '向省水文局（信息中心）或流域机构水文局（信息中心）报汛',
    '3': '不属于以上两级的其它报汛站'
};

//天气状况
var Helper_Data_WTHEnum = {
    '5': '雪',
    '6': '雨夹雪',
    '7': '雨',
    '8': '阴',
    '9': '晴'
};

//河水特征码
var Helper_Data_RWEnum = {
    '1': '干涸',
    '2': '断流',
    '3': '流向不定',
    '4': '逆流',
    '5': '起涨',
    '6': '洪峰',
    'P': '水电厂发电流量',
    ' ': '一般情况'
};

//水势特征码
var Helper_Data_RWPEnum = {
    '4': '落',
    '5': '涨',
    '6': '平'
};

//测流方法
var Helper_Data_MSQEnum = {
    '1': '水位流量关系曲线',
    '2': '浮标及溶液测流法',
    '3': '流速仪及量水建筑物',
    '4': '估算法',
    '5': 'ADCP',
    '6': '电功率反推法',
    '9': '其它方法'
};


var Helper_GetSTTP = function (s) {
    var rel = Helper_Data_STTPEnum[s];
    if (typeof (rel) == 'undefined') {
        return '未知测站';
    } else {
    return rel ;
    }
};
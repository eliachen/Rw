

(function ($) {
    window['LigerUIHelper'] = {};


    //右下角的提示框
    LigerUIHelper.tiptm = function (message,tm) {
        if (LigerUIHelper.wintip) {
            LigerUIHelper.wintip.set('content', message);
            LigerUIHelper.wintip.show();
        }
        else {
            LigerUIHelper.wintip = $.ligerDialog.tip({ content: message });
        }
        //4000ms后关闭
        setTimeout(function () {
            LigerUIHelper.wintip.hide()
        }, tm);
    };

    //右下角的提示框
    LigerUIHelper.tip = function (message) {
        if (LigerUIHelper.wintip) {
            LigerUIHelper.wintip.set('content', message);
            LigerUIHelper.wintip.show();
        }
        else {
            LigerUIHelper.wintip = $.ligerDialog.tip({ content: message });
        }
        //4000ms后关闭
        setTimeout(function () {
            LigerUIHelper.wintip.hide()
        }, 4000);
    };

    //预加载图片
    LigerUIHelper.prevLoadImage = function (rootpath, paths) {
        for (var i in paths) {
            $('<img />').attr('src', rootpath + paths[i]);
        }
    };
    //显示loading
    LigerUIHelper.showLoading = function (message) {
        $.ligerDialog.waitting('正在加载,请稍候...');

        //        message = message || "正在加载中...";
        //        $('body').append("<div class='jloading'>" + message + "</div>");
        //        $.ligerui.win.mask();

    };
    //隐藏loading
    LigerUIHelper.hideLoading = function (message) {
        $.ligerDialog.closeWaitting();
        //        $('body > div.jloading').remove();
        //        $.ligerui.win.unmask({ id: new Date().getTime() });
    }
    //显示成功提示窗口
    LigerUIHelper.showSuccess = function (message, callback) {
        if (typeof (message) == "function" || arguments.length == 0) {
            callback = message;
            message = "操作成功!";
        }
        $.ligerDialog.success(message, '提示信息', callback);
    };
    //显示失败提示窗口
    LigerUIHelper.showError = function (message, callback) {
        if (typeof (message) == "function" || arguments.length == 0) {
            callback = message;
            message = "操作失败!";
        }
        $.ligerDialog.error(message, '提示信息', callback);
    };


    //预加载dialog的图片
    LigerUIHelper.prevDialogImage = function (rootPath) {
        rootPath = rootPath || "";
        LigerUIHelper.prevLoadImage(rootPath + 'lib/ligerUI/skins/Aqua/images/win/', ['dialog-icons.gif']);
        LigerUIHelper.prevLoadImage(rootPath + 'lib/ligerUI/skins/Gray/images/win/', ['dialogicon.gif']);
    };

    //提交服务器请求
    //返回json格式
    //1,提交给类 options.type  方法 options.method 处理
    //2,并返回 AjaxResult(这也是一个类)类型的的序列化好的字符串
    //url:(string); data:(object) ;dataType();type();
    // 
    LigerUIHelper.ajax = function (options) {
        var p = options || {};
        var ashxUrl = options.ashxUrl || "../handler/ajax.ashx?";
        var url = p.url || ashxUrl + $.param({ type: p.type, method: p.method });

        //加载窗
        var tmpDlg = $.ligerDialog.open({ height: 20, content: p.loading || "正在加载,请稍候...",
            allowClose: false, show: false, isDrag: false
        });

        $.ajax({
            cache: false,
            async: true,
            url: url,
            async:p.async || true,
            data: p.data,
            dataType: p.dataType || 'json', type: p.type || 'get',
            beforeSend: function () {
                //                LigerUIHelper.loading = true;
                if (p.beforeSend)
                    p.beforeSend();
                else
                    tmpDlg.show();
            },
            complete: function () {
                //                LigerUIHelper.loading = false;
                if (p.complete)
                    p.complete();
                else
                    if (tmpDlg)
                    //LigerUIHelper.hideLoading();
                        tmpDlg.close();

            },
            success: function (result) {
                if (!result) return;
                if (!result.IsError) {
                    if (p.success)
                        p.success(result.Data, result.Message);
                }
                else {
                    if (p.error)
                        p.error(result.Message);
                }
            },
            error: function (result, b) {
                LigerUIHelper.tip('发现系统错误 <BR>错误码：' + result.status);
            }
        });
    };

    //表单验证
    LigerUIHelper.validate = function (form, options) {
        //        if (typeof (form) == "string")
        //            form = $(form);
        //        else if (typeof (form) == "object" && form.NodeType == 1)
        //            form = $(form);

        var tmpform = $(form);

        options = {
            //调试状态，不会提交数据的
            debug: true,
            errorPlacement: function (lable, element) {

                if (element.hasClass("l-textarea")) {
                    element.addClass("l-textarea-invalid");
                }
                else if (element.hasClass("l-text-field")) {
                    element.parent().addClass("l-text-invalid");
                }
                $(element).removeAttr("title").ligerHideTip();
                $(element).attr("title", lable.html()).ligerTip();
            },
            success: function (lable) {
                //                var element = $("#" + lable.attr("for"));
                var element = $("input[name='" + lable.attr("for") + "']");
                if (element.hasClass("l-textarea")) {
                    element.removeClass("l-textarea-invalid");
                }
                else if (element.hasClass("l-text-field")) {
                    element.parent().removeClass("l-text-invalid");
                }
                $(element).removeAttr("title").ligerHideTip();
            },
            submitHandler: function () {
                alert("Submitted!");
            }
        };

        LigerUIHelper.validator = tmpform.validate(options);
        return LigerUIHelper.validator;
    };

    LigerUIHelper.setFormSearchBtn = function (searchCallback) {
        //表单底部按钮
        var buttons = [];

        buttons.push({ text: '搜索', onclick: searchCallback });

        LigerUIHelper.addFormButtons(buttons);
    };


    //快速设置表单底部默认的按钮:保存、取消
    LigerUIHelper.setFormDefaultBtn = function (cancleCallback, savedCallback) {
        //表单底部按钮
        var buttons = [];
        if (cancleCallback) {
            buttons.push({ text: '取消', onclick: cancleCallback });
        }
        if (savedCallback) {
            buttons.push({ text: '保存', onclick: savedCallback });
        }
        LigerUIHelper.addFormButtons(buttons);
    };

    //增加表单底部按钮,比如：保存、取消
    LigerUIHelper.addFormButtons = function (buttons) {
        if (!buttons) return;
        var formbar = $("body > div.form-bar");
        if (formbar.length == 0)
            formbar = $('<div class="form-bar"><div class="form-bar-inner"></div></div>').appendTo('body');
        if (!(buttons instanceof Array)) {
            buttons = [buttons];
        }
        $(buttons).each(function (i, o) {
            var btn = $('<div class="l-dialog-btn"><div class="l-dialog-btn-l"></div><div class="l-dialog-btn-r"></div><div class="l-dialog-btn-inner"></div></div> ');
            $("div.l-dialog-btn-inner:first", btn).html(o.text || "BUTTON");
            if (o.onclick) {
                btn.bind('click', function () {
                    o.onclick(o);
                });
            }
            if (o.width) {
                btn.width(o.width);
            }
            $("> div:first", formbar).append(btn);
        });
    };

    //序列化时间
    LigerUIHelper.FormatTime = function (str, format) {
        if (!str) return '';

        var i = parseInt(str.match(/[-]*\d+/g)[0]);
        if (i < 0) return '';
        var d = new Date(i);
        if (d.toString() == 'Invalid Date') return '';

        //处理客户端时区不同导致的问题
        //480 是UTC+8
        var utc8Offset = 480;
        d.setMinutes(d.getMinutes() + (d.getTimezoneOffset() + 480));

        format = format || 'MM/dd hh:mm:ss tt';

        var hour = d.getHours();
        var month = FormatNum(d.getMonth() + 1)

        var re = format.replace('YYYY', d.getFullYear())
    .replace('YY', FormatNum(d.getFullYear() % 100))
    .replace('MM', FormatNum(month))
    .replace('dd', FormatNum(d.getDate()))
    .replace('hh', hour == 0 ? '12' : FormatNum(hour <= 12 ? hour : hour - 12))
    .replace('HH', FormatNum(hour))
    .replace('mm', FormatNum(d.getMinutes()))
    .replace('ss', FormatNum(d.getSeconds()))
    .replace('tt', (hour < 12 ? 'AM' : 'PM'));

        return re;
    };
    var FormatNum = function (num) {
        num = Number(num);
        return num < 10 ? ('0' + num) : num.toString();
    };

})(jQuery);


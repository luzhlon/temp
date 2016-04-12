<%@ page import="com.luzhlon.ImportServlet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-heading">
    <h3 class="panel-title">方剂导入</h3>
</div>
<div class="panel-body" id="content">
    <div id="input-area">
        <label>选择Excel文件(xls格式)： </label>
        <input name="excel-file" type="file" accept="application/vnd.ms-excel"/>
    </div>
    <div id="status-area">
        <p id="status-bar"></p>
    </div>
    <div><a href="javascript:void(0);" id="get-log">获取导入日志</a></div>
    <div><a href="javascript:void(0);" id="get-fail">获取上次导入失败的记录</a></div>
    <div id="output-area" class="panel-body">
        <ul id="output-list" style="max-height: 400px; overflow-y: auto"></ul>
    </div>
</div>
<script>
    _out = $('#output-list');
    var fileInput = $('[name="excel-file"]');
    function statusText(text) {
        return $('#status-bar').text(text);
    }
    function putLog(text) {
        _out.append($('<li></li>').text(text));
    }
    function putLast(text) {
        $('#output-list :last-child').text(text);
    }
    function clearLog() {
        _out.remove();
        $('#output-area')
                .append($(
                        '<ul id="output-list" style="max-height: 400px; overflow-y: auto"></ul>'));
        _out = $('#output-list');
    }
    // 获取导入日志
    function getLog(begin) {
        this.begin = begin || 1;
        var begin = this.begin;
        Request('/import?action=log', {
            begin: begin
        }, function(json) {
            if (!json.success) {
                putLog('获取日志信息失败：' + json.reason);
                return;
            }
            var logs = json.result;
            for (var i = 0; i < logs.length; i++)
                putLog(logs[i]);
            window.setTimeout(function() {
                var begin = this.begin + logs.length;
                getLog(begin);
            }, 1000);
        });
    }
    $('#get-log').click(function () {
        clearLog();
        getLog();
    });
    $('#get-fail').click(function() {
        window.open('/upload/failure.xls');
    });
    // 开始导入
    function BeginImport(file) {
        putLog("正在导入 " + fileInput.val());
        putLog('已上传: ' + '0%');
        Request('/import', {
            method: 'excel',
            name: fileInput.val(), // 原始文件名
            file: file
        }, function(json) {
            if(json.success) {
                putLog('导入任务创建成功！');
                getLog();
            } else {
                putLog('导入失败:'+json.reason);
            }
        });
    }
    setUpload(fileInput, {
        url: '/upload',
        field: { method: 'excel' },
        onprogress: function(evt) {
            if (evt.lengthComputable) {
                var per = Math.round((evt.loaded / evt.total)  * 100);
                putLast('已上传: ' + per + '%');
            }
        },
        onuploaded: function() {
            putLog('上传成功，正在导入...');
        },
        onerror: function() {
            putLog('上传出错.');
        },
        onresponse: function(xhr) {
            var json = JSON.parse(xhr.responseText);
            if(!json.success) return;
            BeginImport(json.result);
        }
    });

    <% if (ImportServlet.IsImporting()) { %>
    $('#input-area').hide();
    statusText('正在导入 ' + '<%=ImportServlet.rawFileName%>');
    getLog();
    <% } %>
</script>

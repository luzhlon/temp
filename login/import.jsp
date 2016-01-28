<%--
  Created by IntelliJ IDEA.
  User: john
  Date: 16-1-19
  Time: 上午12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>导入</title>
    <script src="../js/jquery.js"></script>
    <script src="../script/mine.js"></script>
</head>
<body>
<div id="content">
    <div id="input-area">
        <label>选择Excel文件： </label>
        <input name="excel-file" type="file" accept="application/vnd.ms-excel"/>
        <div id="output"></div>
    </div>
    <div id="output-area">
        <ul id="output-list">
        </ul>
    </div>
</div>

<style>
    div#input-area {
        width: 100%;
    }
    div#output-area {
        width: 100%;
    }
    ul#output-list {
        width: 100%;
    }
</style>

<script>
    _out = $('#output-list');
    _timer = null;
    var fileInput = $('[name="excel-file"]');
    function putLog(text) {
        _out.append($('<li></li>').text(text));
    }
    // 开始获取导入日志
    function BeginGetLog() {
        _timer = setInterval(function() {

        }, 2000);
    }
    // 结束获取日志
    function EndGetLog() {
        clearInterval(_timer);
    }
    // 开始导入
    function BeginImport(file) {
        _out.empty();
        putLog("正在导入 " + fileInput.attr('value'));
        Request('/import', {
            method: 'excel',
            file: file
        }, function(json) {
            EndGetLog();
            for(var i in json.log)
                putLog(json.log[i]);
            if(json.success) {
                putLog('导入成功！');
            } else {
                putLog('导入失败:'+json.reason);
            }
        });
        BeginGetLog();
    }
    setUpload(fileInput, {
        url: '/upload',
        field: { method: 'excel' },
        onprogress: function(evt) {
            if (evt.lengthComputable) {
                var per = Math.round((evt.loaded / evt.total)  * 100);
                putLog('已上传: ' + per + '%');
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
</script>

</body>
</html>

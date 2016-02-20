<%--
  Created by IntelliJ IDEA.
  User: john
  Date: 16-1-19
  Time: 上午12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-heading">
    <h3 class="panel-title">方剂导入</h3>
</div>
<div class="panel-body" id="content">
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
<script>
    _out = $('#output-list');
    var fileInput = $('[name="excel-file"]');
    function putLog(text) {
        _out.append($('<li></li>').text(text));
    }
    function webSocketId(id) {
        if(id) _wsid = id;
        else return _wsid;
    }
    // 开始导入
    function BeginImport(file) {
        var ws = new WebSocket("ws://localhost:8080/websocket");
        ws.onmessage = function(msg) {
            // 收到WebSocket id
            webSocketId(msg.data);
            // 准备接收导入日志
            ws.onmessage = function(msg) { putLog(msg.data); };
            // 请求导入
            _out.empty();
            putLog("正在导入 " + fileInput.attr('value'));
            Request('/import', {
                method: 'excel',
                wsid: webSocketId(),
                file: file
            }, function(json) {
                if(json.success) {
                    putLog('导入成功！');
                } else {
                    putLog('导入失败:'+json.reason);
                }
                ws.close();
            });
        };
        ws.onopen = function() { };
        ws.onclose = function() {
            webSocketId(null);
        };
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

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

<label>选择Excel文件： </label>
<input name="excel-file" type="file" accept="application/vnd.ms-excel"/>
<label id="upload-progress"></label>

<script>
    function setOutput(text) {
        _out = _out || $('#upload-progress');
        _out.text(text);
    }
    setUpload('#upload-progress', {
        url: '/upload',
        field: { method: 'excel' },
        onprogress: function(evt) {
            if (evt.lengthComputable) {
                var per = Math.round((evt.loaded / evt.total)  * 100) + '%';
                setOutput('Uploaded: ' + per);
            }
        },
        onuploaded: function() {
            setOutput('Upload success. Importing...');
        },
        onerror: function() {
            setOutput('Upload error.');
        },
        onresponse: function(xhr) {
            var json = JSON.parse(xhr.responseText);
            if(!json.success) return;
            setOutput("Importing " + json.result);
            Request('/import', {
                method: 'excel',
                file: json.result
            }, function() {

            });
        }
    });
</script>

</body>
</html>

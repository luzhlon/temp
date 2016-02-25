<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 2016/2/24
  Time: 13:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Administrator</title>
    <link href="../css/font-awesome.min.css" rel="stylesheet">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/bootstrap-table.min.css" rel="stylesheet">
    <link href="../css/templatemo-style.css" rel="stylesheet">
    <script src="../js/jquery-2.2.0.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-dialog.min.js"></script>
    <script src="../js/extensions/resizable/bootstrap-table-resizable.min.js"></script>
    <script src="../js/extensions/resizable/colResizable.js"></script>
    <script src="../js/extensions/editable/bootstrap-table-editable.min.js"></script>
    <script src="../js/extensions/editable/editable.js"></script>
    <script src="../js/luzhlon.js"></script>
</head>
<body>
<!-- Left column -->
<div class="templatemo-flex-row">
    <div class="templatemo-sidebar">
        <header class="templatemo-site-header">
            <div class="square"></div>
            <h3>Admin</h3>
        </header>
        <div class="profile-photo-container">
            <img src="../images/profile-photo.jpg" alt="Profile Photo" class="img-responsive">
            <div class="profile-photo-overlay"></div>
        </div>
        <div class="mobile-menu-icon">
            <i class="fa fa-bars"></i>
        </div>
        <nav class="templatemo-left-nav">
            <ul>
                <li><a id="welcome" href="main.jsp"><i class="fa fa-home fa-fw"></i>主页</a></li>
                <li><a id="prescript" href="main.jsp?page=prescript"><i class="fa fa-bar-chart fa-fw"></i>方剂</a></li>
                <li><a id="book" href="main.jsp?page=book"><i class="fa fa-bar-chart fa-fw"></i>书籍</a></li>
                <li><a id="import" href="main.jsp?page=import"><i class="fa fa-database fa-fw"></i>导入</a></li>
                <%--<li><a href="help.html"><i class="fa fa-map-marker fa-fw"></i>帮助</a></li>--%>
            </ul>
        </nav>
    </div>
    <!-- Main content -->
    <div class="templatemo-content col-1 light-gray-bg">
        <div class="templatemo-content-container">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <h1>Admin</h1>
                </div>
                <div class="panel-body">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="form-group">
                                <label>导入中药词典</label>
                                <input type="file" id="fileinput_med_dict">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <footer class="text-right">
                        <p>Copyright &copy; 2016 CodeSoul | Designed by luzhlon</p>
                    </footer>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    setUpload('#fileinput_med_dict', {
        url : '/upload',
        fields: { method : 'image' },
        onchange: function(fileObj) { return true; },
        onprogress: function(evt) { },
        onerror : function() {
            BootstrapDialog.alert("上传失败！");
        },
        onuploaded: function() { },
        onresponse : function(xhr) {
            var r = JSON.parse(xhr.responseText);
            if(!r.success) {
                BootstrapDialog.alert("上传失败！");
                return;
            }
            Request('/admin?object=medicine&method=import',
                    { file: r.result }, function(json) {
                if(json.success) {
                    BootstrapDialog.alert("导入成功！");
                } else {
                    BootstrapDialog.alert("导入失败！" + json.reason);
                }
            });
        }
    });
</script>
</body>
</html>

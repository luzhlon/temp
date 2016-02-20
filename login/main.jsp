<%@ page import="com.tool.User" %><%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-12
  Time: 下午9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>中医方剂管理系统</title>
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
      <h1>中医</h1>
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

        <%
          String p = request.getParameter("page");
          if(p == null) p = "welcome";
          String PageStr = p + ".jsp";
          String SelStr = "a#" + p;
        %>
        <jsp:include page="<%=PageStr%>"/>
        <script> $("<%=SelStr%>").attr('class', 'active'); </script>
        <div class="panel-footer">
          <footer class="text-right">
            <p>Copyright &copy; 2016 CodeSoul
              | Designed by <a href="http://luzhlon.github.io" target="_parent">luzhlon</a></p>
          </footer>
        </div>
      </div>
      </div>

    </div>
  </div>
<script>
  // 心跳包
  window.setInterval(function() {
    Request('/server', {
      method: 'heartbeat'
    }, function(json) {
      if(!json.success) {
        alert("Login Expired. Please reLogin.");
        location.replace("/index.jsp");
      }
    });
  }, 30000);
</script>
</body>
</html>


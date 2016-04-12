<%@ page import="com.tool.User" %><%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-12
  Time: 下午9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
  <title>中医方剂管理系统</title>
  <link href="../css/font-awesome.min.css" rel="stylesheet">
  <link href="../css/bootstrap.min.css" rel="stylesheet">
  <link href="../css/bootstrap-table.min.css" rel="stylesheet">
  <link href="../css/templatemo-style.css" rel="stylesheet">
  <script src="../js/jquery-2.2.0.min.js"></script>
  <script src="../js/bootstrap.min.js"></script>
  <script src="../js/bootstrap-table.min.js"></script>
  <script src="../js/bootstrap-dialog.min.js"></script>
  <script src="../js/luzhlon.js"></script>
</head>
<body>
<!-- Left column -->
<div class="templatemo-flex-row">
  <div class="templatemo-sidebar">
    <header class="templatemo-site-header">
      <%--<div class="square"></div>--%>
      <h1 align="center">中医方剂管理系统</h1>
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
        <li><a id="prescript" href="main.jsp?page=prescript"><i class="fa fa-bar-chart-o fa-fw"></i>方剂</a></li>
        <li><a id="book" href="main.jsp?page=book"><i class="fa fa-bar-chart fa-fw"></i>著作</a></li>
        <li><a id="import" href="main.jsp?page=import"><i class="fa fa-database fa-fw"></i>导入</a></li>
        <li><a id="welcome" href="main.jsp?page=welcome"><i class="fa fa-home fa-fw"></i>手册</a></li>
      </ul>
    </nav>
  </div>
  <!-- Main content -->
  <div class="templatemo-content col-1 light-gray-bg">
    <div class="templatemo-content-container">
      <div class="panel panel-default">
        <%
          String p = request.getParameter("page");
          if(p == null) p = "prescript";
          String PageStr = p + ".jsp";
          String SelStr = "a#" + p;
        %>
        <jsp:include page="<%=PageStr%>"/>
        <script> $("<%=SelStr%>").attr('class', 'active'); </script>
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


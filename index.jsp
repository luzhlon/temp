<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 检测是否已经登录 --%>
<%@ page import="com.tool.User"%>

<html>
  <head>
    <title>登录</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/index.css" />
    <script src="js/jquery-2.2.0.min.js"></script>
    <script type="text/javascript" src="http://www.francescomalagrino.com/BootstrapPageGenerator/3/js/jquery-ui"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="js/jQuery.md5.js"></script>
    <script src="js/mine.js"></script>
    <script src="js/index.js"></script>
  </head>

<body>
<div id="main">
    <form name="login_form" action="/user"
          method="post" onsubmit="return onSubmit()">
        <div class="form-group">
            <span class="glyphicon glyphicon-user"></span>
            <input type="text" class="form-control"
                   name="user_name" id="firstname" placeholder="用户名">
        </div>
        <div class="form-group">
            <span class="glyphicon glyphicon-lock"></span>
            <input type="password" class="form-control"
                   name="user_passwd" id="lastname" placeholder="密码">
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">登录</button>
            </div>
        </div>
    </form>
    <script>
        var name = document.getElementsByName("user_name")[0];
        var passwd = document.getElementsByName("user_passwd")[0];
        function ReplacePage(uri) {
            window.top.location.replace(uri);
        }
    <%
        String status = request.getParameter("status");
        if(status != null && !status.isEmpty())
            if(status.equals("success")) {
    %>
        window.setTimeout(function() {
            ReplacePage("/login/main.jsp");
        }, 1000);
        alert("登录成功！");
        ReplacePage("/login/main.jsp");
    <% } else if(status.equals("failure")) { %>
        alert("用户名或密码错误！");
        passwd.focus();
    <% } %>
    </script>
</div>
</body>
</html>

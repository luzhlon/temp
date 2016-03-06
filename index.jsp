<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 检测是否已经登录 --%>
<%@ page import="com.tool.User"%>
<!doctype html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <title>登录</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link href="css/templatemo-style.css" rel="stylesheet">
    <script src="js/jquery-2.2.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jQuery.md5.js"></script>
    <script>
        function onSubmit() {
            var $user_name = $('[name="user_name"]');
            var $user_passwd = $('[name="user_passwd"]');
            if($user_name.val() == '') {
                alert("用户名不可以为空！");
                $user_name.focus();
                return false;
            }
            if($user_passwd.val() == '') {
                alert("请输入密码!");
                $user_passwd.focus();
                return false;
            }
            $user_passwd.val($.md5($user_passwd.val()));
            return true;
        }
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
        $('[name="user_passwd"]').focus();
        <% } %>
    </script>
  </head>

<body>
<body class="light-gray-bg">
<div class="templatemo-content-widget templatemo-login-widget white-bg">
    <header class="text-center">
        <div class="square"></div>
        <h1>中医方剂管理系统</h1>
    </header>
    <form name="login_form" action="/server?method=login"
          method="post" onsubmit="return onSubmit()" class="templatemo-login-form">
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon"><i class="fa fa-user fa-fw"></i></div>
                <input type="text" class="form-control"
                       name="user_name" id="firstname" placeholder="用户名">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon"><i class="fa fa-key fa-fw"></i></div>
                <input type="password" class="form-control"
                       name="user_passwd" id="lastname" placeholder="密码">
            </div>
        </div>
        <div class="form-group">
            <button type="submit" class="templatemo-blue-button width-100">登录</button>
        </div>
    </form>
</div>
</body>
</div>
</body>
</html>

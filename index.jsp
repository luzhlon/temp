<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 检测是否已经登录 --%>
<%@ page import="com.luzhlon.User"%>

<html>
  <head>
    <title>登录</title>
    <script src="js/jquery.min.js"></script>
    <script src="js/jQuery.md5.js"></script>
    <script src="script/mine.js"></script>
    <script src="script/index.js"></script>
  </head>

<body>
    <link rel="stylesheet" href="css/index.css" />
    <table border="0">
    <form name="login_form" action="/logining"
          method="post" onsubmit="return onSubmit()">
      <tr> <td align="right">用户名：</td> <td><input class="edit" type="text" name="user_name"/></td> </tr>
      <tr> <td align="right">密码&nbsp;&nbsp;：</td> <td><input class="edit" type="password"name="user_passwd"/></td> </tr>
      <tr> <td/> <td><input class="submit" type="submit" value="登录" /></td> </tr>
    </form>
    </table>
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
</body>
</html>
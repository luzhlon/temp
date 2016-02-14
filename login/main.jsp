<%@ page import="com.tool.User" %><%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-12
  Time: 下午9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>中药信息管理系统</title>
  <link rel="stylesheet" href="../skins/Aqua/css/ligerui-all.css">
  <script src="../js/jquery.js"></script>
  <script src="../js/ligerui.min.js"></script>
  <script src="../script/mine.js"></script>
  <style>
    div#sys-navbar {
      width: 100%;
      height: 100%;
      background: #191818 none repeat scroll 0 0;
      /*overflow-y: auto;*/
    }
    div#sys-navbar-header {
      font-size: 110%;
      width: 100%;
      padding: 10px;
      color: #FFF;
      margin: 0;
    }
    div#sys-navbar ul {
      width: 100%;
      border-top: 1px solid #333;
    }
    div#sys-navbar li {
      /*float: left;*/
      color: #999;
      padding: 10px;
      /*padding: 0.6em 0 0.6em 0.6em;*/
    }
    div#sys-navbar li:hover {
      cursor: pointer;
      background: #333 none repeat scroll 0 0;
    }
    #main-frame {
      border: 0;
      height: 100%;
      width: 100%;
    }
  </style>
</head>

<%-- 主页面 --%>
<body>
<div id="main-layout" style="height: 100%;">
  <div position="left">
  <div id="sys-navbar">
    <div id="sys-navbar-header">中医方剂管理系统</div>
    <ul>
      <li href="component/edit.jsp">方剂</li>
      <li href="tables.jsp">著作</li>
      <li href="import.jsp">导入</li>
      <li href="help.jsp">帮助</li>
      <% if(User.GetCurrentUser(session).IsAdmin()) { %>
      <li href="user-manage.jsp">User Manager</li>
      <% } %>
    </ul>
  </div></div>
  <div position="center">
    <iframe id="main-frame" src="main.html"></iframe>
  </div>
</div>
  <script>
    // 布局
    $('#main-layout').ligerLayout({
      leftWidth: 130,
      height: "100%"
    });
    //
    $('#sys-navbar ul li').bind('click', function() {
      $('#main-frame').attr('src', $(this).attr('href'));
    });
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

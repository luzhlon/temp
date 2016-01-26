<%@ page import="com.luzhlon.User" %><%--
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
  <link rel="stylesheet" href="../css/main.css"/>
</head>

<%-- 主页面 --%>
<body>
  <div id="sys-navbar">
    <div id="sys-navbar-header">中医方剂管理系统</div>
    <div id="sys-navbar-padding"></div>
    <ul>
      <li onclick="document.getElementById('main-frame').src='/login/input.jsp'">
        <a href="javascript:void(0)">录入</a></li>
      <li onclick="document.getElementById('main-frame').src='/login/import.jsp'">
        <a href="javascript:void(0)">导入</a></li>
      <li onclick="document.getElementById('main-frame').src='/login/statistic.jsp'">
        <a href="javascript:void(0)">统计</a></li>
      <li onclick="document.getElementById('main-frame').src='/login/analyze.jsp'">
        <a href="javascript:void(0)">分析</a></li>
      <li onclick="document.getElementById('main-frame').src='/login/help.jsp'">
        <a href="javascript:void(0)">帮助</a></li>

      <% if(User.GetCurrentUser(session).IsAdmin()) { %>
      <li onclick="document.getElementById('main-frame').src='/login/user-manage.jsp'">
        <a href="javascript:void(0)">User Manager</a></li>
      <% } %>
    </ul>
  </div>
  <iframe id="main-frame" src="main.html"> </iframe>

</body>
</html>

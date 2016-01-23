<%--
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
  <style type="text/css">
    * {
      margin: 0;
      padding: 0;
    }
    div#sys-navbar {
      width: 100%;
      height: 100px;
      background: #191818 none repeat scroll 0 0;
      top: 0;
      bottom: 0;
      /*overflow-y: auto;*/
    }
    #sys-navbar-header {
      float: left;
      font-size: 110%;
      width: 200px;
      height: 80%;
      padding: 10px;
      color: #FFF;
      margin: 0;
    }
    #sys-navbar-padding {
      float: left;
      width: 50%;
      height: 80%;
    }
    div#sys-navbar ul {
      float: left;
      width: calc(48% - 200px);
      height: 80%;
      border-top: 1px solid #333;
    }
    div#sys-navbar li {
      float: left;
      padding: 10px;
    }
    div#sys-navbar li a {
      color: #999;
      border: medium none;
      padding: 0.6em 0 0.6em 0.6em;
      display: block;
    }
    div#sys-navbar li:hover {
      cursor: hand;
      background: #333 none repeat scroll 0 0;
    }
    #main-frame {
      border: 0;
      /*height: 85%;*/
      height: calc(100% - 100px);
      width: 100%;
    }
  </style>
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
    </ul>
  </div>
  <iframe id="main-frame" src="main.html"> </iframe>

</body>
</html>

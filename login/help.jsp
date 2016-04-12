<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-13
  Time: 下午3:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="manual">
<h1>用户手册</h1>
<h2>登录</h2>
<p>http://211.87.234.10:8080/index.jsp</a>  ，输入用户名和密码，点击‘登录’按钮。若用户名和密码正确则跳转到系统主页面。</p>
<h2>方剂（管理）页面</h2>
<p>
  <img src="../images/prescript.png" alt="prescript"/>
</p>
<h3>按钮功能说明</h3>
<ol>
  <li>
    <p>新建方剂</p>
  </li>
  <li>
    <p>查询（过滤）方剂</p>
  </li>
  <li>
    <p>统计方剂数据</p>
  </li>
  <li>
    <p>删除（选中的）方剂</p>
  </li>
  <li>
    <p>刷新表格数据</p>
  </li>
  <li>
    <p>切换表格的显示方式</p>
  </li>
  <li>
    <p>选择要显示的字段</p>
  </li>
  <li>
    <p>导出表格中的方剂数据</p>
  </li>
</ol>

<h3>方剂录入</h3>
<ul>
  <li>
    <p>
      <strong>新建方剂</strong>，点击‘新建’按钮（图中1处）。
      <br>
      <img src="../images/pres-input.png" alt="pres-input">
    </p>
  </li>
  <li>
    <p>
      <strong>编辑已录入的方剂</strong>， 在表格中双击相应的条目即可进入编辑模式。
      <br>
      <img src="../images/pres-edit.png" alt="pres-edit">
    </p>
    <p>方剂编辑完后，按‘提交’按钮将方剂数据提交给服务器。</p>
  </li>
</ul>

<h3>查询方剂</h3>

<p>点击查询按钮（图中2处），进入查询界面。
  <br>
  <img src="../images/pres-query.png" alt="pres-query">
</p>
<ul>
  <li>
    <p>编辑查询条件</p>
    <ol>
      <li>
        <p>选择多个条件之间的逻辑关系（可选择‘且’和‘或’）</p>
      </li>
      <li>
        <p>选择要查询的字段</p>
      </li>
      <li>
        <p>选择所查询字段和值的关系（可选择‘等于’、‘包含’、‘形似’、‘正则’）</p>
      </li>
      <li>
        <p>编辑要查询的值</p>
      </li>
      <li>
        <p>编辑完查询条件，点击‘添加’按钮将查询条件加入条件列表。</p>
      </li>
    </ol>
  </li>
  <li>
    <p>删除查询条件
      <br> 在条件列表中选中查询条件，点击‘删除’按钮即可。
    </p>
  </li>
</ul>

<p>最后，点击‘确定’按钮即可查询根据查询条件所过滤出来的方剂列表。</p>

<h2>书籍（著作）页面</h2>

<p>
  <img src="../images/book.png" alt="book">
</p>

<h3>新建著作</h3>

<p>点击‘新建’按钮，弹出如图所示对话框
  <br>
  <img src="../images/book-new.png" alt="book-new">
</p>

<h3>编辑（已有）著作</h3>

<p>选中一条著作，点击‘编辑’按钮；或者双击一条著作。
  <br>
  <img src="../images/book-edit.png" alt="book-edit">
</p>
<h2>导入页面</h2>
<p>
  <img src="../images/import.png" alt="import">
  <br> 如图所示，选择文件（xls格式）即可向系统导入已经录入的excel方剂文档。
</p>
</div>
<style>
  #manual {
    height: 500px;
    overflow: auto;
  }
  #manual img {
    margin: 10px;
    margin-left: 10%;
    width: 80%;
  }
  #manual h1 {
    text-align: center;
  }
  #manual h1,h2,h3,h4,h5,h6 {
    margin: 10px 0;
  }
</style>

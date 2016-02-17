<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-26
  Time: 上午12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>EDIT</title>
  <link rel="stylesheet" href="../css/autocomplete.css"/>
  <link rel="stylesheet" href="../css/input.css"/>
  <script src="../js/jquery-2.2.0.min.js"></script>
  <script src="../js/autocomplete.js"></script>
  <script src="../js/mine.js"></script>
  <script src="../js/input.js"></script>
</head>
<body>
<div id="main">

  <form name="prescription" method="post" action="/input"
        enctype="application/x-www-form-urlencoded"
        target="empty_frame"
  <%--onsubmit="return onSubmit()"--%>
        onreset="return onReset()"
        onkeydown="if(event.keyCode==13)return false;">

    <div class="column">
      <div class="block">
        <label>方名：</label>
        <input name="pres_name" class="input-edit" type="text"/>
      </div>

      <div class="block">
        <label>出处：</label>
        <input name="source" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>著作：</label>
        <input name="book" class="input-edit" type="text"/>
      </div>
      <div class="small-block" >
        <label>版本：</label>
        <input name="version" class="input-edit" type="text"/>
      </div>
      <div class="small-padding"></div>
      <div class="small-block" >
        <label>页码：</label>
        <input name="page" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>原文图像：</label>
        <%-- 存放服务器端的图片文件名 --%>
        <input name="image" type="text" style="display: none;"/>
        <%-- 用来显示文件上传进度 --%>
        <input id="output" type="text" style="display: none;"/>
        <!--<input type="file" onchange="onFile(this)"-->
        <input id="file_input" type="file"
               accept="image/jpeg,image/png,image/bmp"/>
        <img id="image" src="" />
      </div>
    </div>

    <div class="column">
      <!--<div class="small-block" >-->
      <div class="block" >
        <label>剂型：</label>
        <input name="pres_type" class="input-edit" type="text" value="汤剂"/>
      </div>

      <div class="block">
        <label>剂型制法：</label>
        <textarea name="make_method" class="input-area" ></textarea>
      </div>
      <div class="block">
        <label>服法：</label>
        <textarea name="use_method" class="input-area" ></textarea>
      </div>
      <div class="block">
        <label>用量：</label>
        <textarea name="use_level" class="input-area" ></textarea>
      </div>
      <div class="block">
        <label>注意事项：</label>
        <textarea name="use_note" class="input-area" ></textarea>
      </div>
    </div>

    <div class="column">

      <div class="block">
        <label>现代病名：</label>
        <input name="modern_name" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>主治中医病名：</label>
        <input name="mcure_name" class="input-edit" type="text"/>
      </div>

      <div class="block">
        <label>主治症候：</label>
        <input name="mas_disease" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>主治症状：</label>
        <input name="mas_symptom" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>兼症：</label>
        <input name="aux_symptom" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>君药：</label>
        <input name="mas_medicine" class="input-edit" type="text"/>
      </div>
      <div class="block">
        <label>臣药：</label>
        <input name="aux_medicine" class="input-edit" type="text"/>
      </div>
    </div>

    <div class="column">
      <div class="small-block" >
        <label>性别：</label>
        <input name="sex" class="input-edit" type="text"/>
      </div>
      <div class="small-padding"></div>
      <div class="small-block" >
        <label>年龄：</label>
        <input name="age" class="input-edit" type="text" />
      </div>
      <div class="block" >
        <label>脉象：</label>
        <input name="pulse_cond" class="input-edit" type="text"/>
      </div>
      <div class="small-block" >
        <label>舌苔：</label>
        <input name="tongue_coat" class="input-edit" type="text"/>
      </div>
      <div class="small-padding"></div>
      <div class="small-block" >
        <label>舌质：</label>
        <input name="tongue_nature" class="input-edit" type="text"/>
      </div>
      <div class="small-block" >
        <label>舌体：</label>
        <input name="tongue_body" class="input-edit" type="text"/>
      </div>
      <div class="small-padding"></div>
      <div class="small-block" >
        <label>初诊复诊：</label>
        <input name="first_second" class="input-edit" type="text"/>
      </div>
      <div class="small-block" >
        <label>地域：</label>
        <input name="region" class="input-edit" type="text" />
      </div>
      <div class="small-padding"></div>
      <div class="small-block" >
        <label>季节：</label>
        <input name="season" class="input-edit" type="text" />
      </div>

      <div class="small-block" >
        <input type="reset" value="重置" class="input-button"/>
      </div>
      <div class="small-padding"></div>
      <div class="small-block" >
        <%--<input type="submit" value="提交" class="input-button"/>--%>
        <input type="button" value="提交"
               class="input-button"
               style="background: coral;"
               onclick="onSubmit()"/>
      </div>
      <div id="status-bar" class="block"> </div>
    </div>

    <div class="column">
      <div class="block">
        <label>治法：</label>
        <textarea name="cure_method" class="input-area"></textarea>
      </div>
      <div class="block">
        <label>病因：</label>
        <textarea name="disease_reason" class="input-area"></textarea>
      </div>
      <div class="block">
        <label>病机：</label>
        <textarea name="disease_mechsm" class="input-area"></textarea>
      </div>

      <div class="block">
        <label>方剂组成：</label>
        <textarea name="constituent" class="input-area" type="text"></textarea>
      </div>

      <div class="block">
        <label>加减法：</label>
        <textarea name="else_medicine" class="input-area" ></textarea>
      </div>
    </div>
  </form>
</div>
<script>
  SelectizeAll();
  var ps = GetPrescript();
  LimitNumberInput(ps.page);
  FilterInput(ps.book, /[《》]/);
  FilterInput(ps.source, /[《》]/);
  FilterInput(ps.sex, /[\s]/);
  FilterInput(ps.firSec, /[\s]/);
  initImageUpload();
</script>
</body>
</html>

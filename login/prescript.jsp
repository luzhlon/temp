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
  <link rel="stylesheet" href="../skins/Aqua/css/ligerui-all.css"/>
  <link rel="stylesheet" href="../css/prescript.css"/>
  <script src="../js/jquery-2.2.0.min.js"></script>
  <script src="../js/ligerui.min.js"></script>
  <script src="../js/autocomplete.js"></script>
  <script src="../js/mine.js"></script>
</head>
<body>
<div id="prescript-book"></div>
<script>
  var presGrid = $('#table-book').ligerGrid({
    title: '方剂管理',
    height: '100%',
    width: '100%',
    enabledEdit: true, clickToEdit: false,
    showTableToggleBtn: true,
    method: 'get',
    onSelectRow: onSelectBook,
    onDblClickRow: onModifyBook,
    onAfterEdit: onAfterEditBook,
    url: '/output?method=prescript',
    'toolbar': { items: [
      { text: '增加', click: onAddBook, icon: 'add'},
      { text: '修改', click: onModifyBook, icon: 'modify'}
    ]},
    columns: [
      { display: 'ID', name: 'id', align: 'left', width: 80 },
      { display: '方名', name: 'pres_name', width: 110 },
      { display: '剂型', name: 'pres_type', width: 50 },
      { display: '著作', name: 'book', width: 100 },
      { display: '版本', name: 'version', width: 100 },
      { display: '页码', name: 'page', width: 100 },
      { display: '出处', name: 'source', width: 100 },
      { display: '剂型制法', name: 'make_method', width: 100 },
      { display: '服法', name: 'use_method', width: 100 },
      { display: '用量', name: 'use_level', width: 100 },
      { display: '注意事项', name: 'use_note', width: 100 },
      { display: '现代病名', name: 'modern_name', width: 100 },
      { display: '主治中医病名', name: 'mcure_name', width: 100 },
      { display: '主治症候', name: 'mas_disease', width: 100 },
      { display: '主治症状', name: 'mas_symptom', width: 100 },
      { display: '兼症', name: 'aux_symptom', width: 100 },
      { display: '君药', name: 'mas_medicine', width: 100 },
      { display: '臣药', name: 'aux_medicine', width: 100 },
      { display: '性别', name: 'sex', width: 20 },
      { display: '年龄', name: 'age', width: 50 },
      { display: '脉象', name: 'pulse_cond', width: 80 },
      { display: '舌苔', name: 'tongue_coat', width: 50 },
      { display: '舌质', name: 'tongue_nature', width: 50 },
      { display: '舌体', name: 'tongue_body', width: 50 },
      { display: '初复诊', name: 'first_second', width: 30 },
      { display: '地域', name: 'region', width: 30 },
      { display: '季节', name: 'season', width: 30 },
      { display: '治法', name: 'cure_method', width: 100 },
      { display: '病因', name: 'disease_reason', width: 100 },
      { display: '病机', name: 'disease_mechsm', width: 100 },
      { display: '方剂组成', name: 'constituent', width: 100 },
      { display: '加减法', name: 'else_medicine', width: 100 } ]
  });
  function onAddBook() {
    bookGrid.endEdit();
    bookGrid.addEditRow();
  }
  function onSelectBook() {
    bookGrid.endEdit();
  }
  function onModifyBook() {
    bookGrid.endEdit();
    var sel = bookGrid.getSelectedRow();
    bookGrid.beginEdit(sel);
  }
  function onAfterEditBook(row) {
    if(row.record.name.length <= 0) {
      bookGrid.deleteRow(row);
      return;
    }
    Request('/input', {
      method: 'update_book',
      name: row.record.name,
      author: row.record.author,
      dynasty: row.record.dynasty
    }, function(json) {
      if(json.success)
        bookGrid.reload();
    });
  }
</script>
</body>
</html>

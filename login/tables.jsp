<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-29
  Time: 下午9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>子表</title>
    <link rel="stylesheet" href="../skins/Aqua/css/ligerui-all.css">
    <link rel="stylesheet" href="../skins/ligerui-icons.css">
    <link rel="stylesheet" href="../skins/Gray/css/all.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/ligerui.min.js"></script>
    <script src="../script/mine.js"></script>
</head>
<body style="width: 100%; height: 100%;">

<div id="table-book"></div>

</body>
<script>
  var bookGrid = $('#table-book').ligerGrid({
      title: '著作管理',
      //width: 400,
      height: '100%',
      enabledEdit: true, clickToEdit: false,
      showTableToggleBtn: true,
      method: 'get',
      onSelectRow: onSelectBook,
      onDblClickRow: onModifyBook,
      onAfterEdit: onAfterEditBook,
      url: '/output?method=book',
      'toolbar': { items: [
          { text: '增加', click: onAddBook, icon: 'add'},
          { text: '修改', click: onModifyBook, icon: 'modify'}
      ]},
      columns: [
          { display: 'ID', name: 'id', align: 'left', width: 80 },
          { display: '著作', name: 'name', width: 110, editor: { type: 'text' } },
          { display: '作者', name: 'author', width: 110, editor: { type: 'text' } },
          { display: '朝代', name: 'dynasty', width: 100, editor: { type: 'text' } } ]
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
</html>

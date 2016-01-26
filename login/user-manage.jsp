<%@ page import="com.luzhlon.DB" %>
<%@ page import="com.sun.xml.internal.ws.util.ReadAllStream" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.luzhlon.User" %><%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-25
  Time: 下午2:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(!User.GetCurrentUser(session).IsAdmin())
        response.sendRedirect("main.html");
%>
<html>
<head>
    <title>User Manage</title>
    <link rel="stylesheet" href="../themes/default/easyui.css">
    <link rel="stylesheet" href="../themes/icon.css">
    <link rel="stylesheet" href="../css/autocomplete.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/jquery.easyui.min.js"></script>
    <script src="../js/jQuery.md5.js"></script>
    <script src="../script/mine.js"></script>
    <script src="../script/autocomplete.js"></script>
</head>
<body>
<table style="border: none;width: 200px;">
    <tr>
        <td><label>UserName:</label></td>
        <td><input id="input-name" type="text"></td>
    </tr>
    <tr>
        <td><label>Password:</label></td>
        <td><input id="input-passwd" type="password"></td>
    </tr>
    <tr>
        <td><label>Type:</label></td>
        <td><input id="input-type" type="text" value="user" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><input id="button-add" type="button" onclick="onAdd()" value="Add"/></td>
        <td><input id="button-delete" type="button" onclick="onDelete()" value="Delete" disabled="true"/></td>
    </tr>
</table>
<table id="user-table" class="easyui-datagrid" title="User manage"
       data-options="singleSelect:true,collapsible:true">
    <thead>
    <tr>
        <th data-options="field:'name',width:100">User name</th>
        <th data-options="field:'type',width:100">User type</th>
    </tr>
    </thead>
    <%
        ResultSet rs = DB.executeQuery("SELECT name,type FROM user");
        while(rs.next()) {
            String name = rs.getString(1);
            String type = rs.getString(2);
    %>
    <tr><td><%=name%></td> <td><%=type%></td> </tr>
    <%
        }
    %>
</table>
<p>

</p>
<script>
    _cur_sel_row = null;
    _cur_sel_index = -1;
    var type_input = new AutoCompleter('#input-type');
    type_input.addOption('user');
    type_input.addOption('admin');
    var dg = $('#user-table').datagrid({
        onClickRow: function(index, data) {
            $('#button-delete').attr('disabled', false);
            _cur_sel_row = data;
            _cur_sel_index = index;
        }
    });
    function onDelete() {
        if(typeof _cur_sel_row == 'object') {
            Request('/user', {
                method: 'delete',
                user: _cur_sel_row.name
            }, function(json) {
                if(json.success) {
                    $(dg).datagrid('deleteRow', _cur_sel_index);
                } else {
                    alert('Delete user failure');
                }
            });
        }
    }
    function onAdd() {
        var ui = document.getElementById('input-name');
        var pi = document.getElementById('input-passwd');
        var ti = document.getElementById('input-type');
        var name = ui.value;
        var passwd = pi.value;
        var type = ti.value;
        if(name.length <= 0) {
            alert('User name can not be empty');
            return;
        }
        if(passwd.length <= 0) {
            alert('Password can not be empty');
            return;
        }
        Request('/user', {
            method: 'add',
            name: name,
            passwd: $.md5(passwd),
            type: type
        }, function(json) {
            if(json.success) {
                $(dg).datagrid('appendRow',{
                    name:name,
                    type:type
                });
                name.value = '';
                passwd.value = '';
            } else {
                alert('Add user failure.');
            }
        });
    }
</script>
</body>
</html>

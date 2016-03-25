<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-26
  Time: 上午12:54
  To change this template use File | Settings | File Templates.
--%>
<link href="../css/autocomplete.css" rel="stylesheet">
<script src="../js/extensions/export/bootstrap-table-export.min.js"></script>
<script src="../js/extensions/export/tableExport.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-heading">
    <h3 class="panel-title">方剂管理</h3>
</div>
<div class="panel-body" style="padding-top: 0;" id="content">
<%--查询界面--%>
<div class="modal fade" id="cond-modal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
                             <button type="button" class="close"
                             data-dismiss="modal" aria-hidden="true">
                             &times;
                             </button>
                             <h4 class="modal-title">
                             编辑查询条件
                             </h4>
                             </div>
        <div class="modal-body">
                           <div id="condition-toolbar" class="row">
                           <div style="width: 10%; margin-left: 3%;">
                           <select class="form-control"
                           id="cond-relate">
                           <option value="AND">且</option>
                           <option value="OR">或</option>
                           </select>
                           </div>
                           <div style="width: 23%;">
                           <select class="form-control" id="cond-field">
                           </select>
                           </div>
                           <div style="width: 15%;">
                           <select class="form-control"
                           id="cond-method">
                           </select>
                           </div>
                           <div style="width: 20%;">
                           <input type="text"
                           class="form-control" placeholder="值"
                           id="cond-value"/>
                           </div>
                           <div style="width: 10%;">
                           <button class="btn btn-info" type="button"
                           id="button-cond-add">添加</button>
                           </div>
                           <div style="width: 10%;">
                           <button class="btn btn-danger" type="button"
                           id="button-cond-delete">删除</button>
                           </div>
                           <style>
                           #condition-toolbar>div {
                           display: inline-block;
                           }
                           </style>
                           </div>
                           <table id="table-condition"
                           data-toggle="table"
                           data-unique-id="id"
                           data-show-header="false"
                           data-click-to-select="true" >
                           <thead> <tr>
                           <th data-field="id" data-visible="false">ID</th>
                           <th data-field="cond_relate" data-visible="false">Relate</th>
                           <th data-field="show_relate" data-align="center">逻辑关系</th>
                           <th data-field="cond_field" data-visible="false">Field</th>
                           <th data-field="show_field" data-align="center">字段</th>
                           <th data-field="cond_method" data-visible="false">Method</th>
                           <th data-field="show_method" data-align="center">相等性</th>
                           <th data-field="cond_value" data-align="center">值</th>
                           <th data-field="state" data-checkbox="true"></th>
                           </tr></thead>
                           </table>
                           </div>
        <div class="modal-footer">
                             <button type="button" id="modal-button-cancel"
                             class="btn btn-default"
                             data-dismiss="modal">取消</button>
                             <button type="submit" id="modal-button-ok"
                             class="btn btn-primary">确定</button>
                             </div>
    </div><%-- /.modal-content --%>
</div><%-- /.modal dialog--%>
</div><%--modal--%>

<%--选择统计范围--%>
<div class="modal fade" id="statistics-modal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">
                    选择统计类型
                </h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal --%>
</div><%--statistics dialog--%>

<%--方剂列表--%>
<div id="prescript-toolbar">
    <div class="btn-group">
        <button type="button" class="btn btn-info" id="button-new">新建</button>
        <button type="button" class="btn btn-success" id="button-query">查询</button>
        <button type="button" class="btn btn-warning" id="button-statistics">统计</button>
        <button type="button" class="btn btn-danger" id="button-delete">删除</button>
    </div>
</div>
<table id="table-prescript"
 data-toggle="table"
 data-height="600"
 data-pagination="true"
 data-side-pagination="server"
 data-toolbar="#prescript-toolbar"
 data-unique-id="id"
 data-query-params="onPresTableQuery"
 data-click-to-select="true"
 data-show-columns="true"
 data-show-refresh="true"
 data-show-toggle="true"
 data-show-export="true"
 data-page-list="[10,20,50,100,200,500,1000,2000,5000]"
 data-export-types="['json','excel']"
 data-url="/data?method=query&object=prescription"
 data-resizable="true"
 >
<thead> <tr>
    <th data-field="state" data-checkbox="true"></th>
    <th data-field="id" data-visible="false" data-align="center">ID</th>
    <th data-field="pres_name" data-align="center">方名</th>
    <th data-width="50" data-field="pres_type" data-align="center">剂型</th>
    <th data-width="80" data-field="book" data-align="center">著作</th>
    <th data-width="60" data-visible="false" data-field="version" data-align="center">版本</th>
    <th data-width="50" data-visible="false" data-field="page" data-align="center">页码</th>
    <th data-width="80" data-align="center" data-field="source">出处</th>
    <th data-width="300"data-field="make_method">剂型制法</th>
    <th data-width="300" data-field="use_method">服法</th>
    <th data-field="use_level">用量</th>
    <th data-field="use_note">注意事项</th>
    <th data-field="image" data-visible="false">原文图像</th>
    <th data-field="modern_name">现代病名</th>
    <th data-field="mcure_name">主治中医病名</th>
    <th data-field="mas_disease">主治证候</th>
    <th data-field="mas_symptom">主治症状</th>
    <th data-field="aux_symptom">兼症</th>
    <th data-field="mas_medicine">君药</th>
    <th data-field="aux_medicine">臣药</th>
    <th data-width="30" data-field="sex" data-align="center">性别</th>
    <th data-width="50" data-field="age" data-align="center">年龄</th>
    <th data-field="pulse_cond" data-align="center">脉象</th>
    <th data-field="tongue_coat" data-align="center">舌苔</th>
    <th data-field="tongue_nature" data-align="center">舌质</th>
    <th data-field="tongue_body" data-align="center">舌体</th>
    <th data-width="40" data-field="first_second" data-align="center">初复诊</th>
    <th data-width="30" data-field="region" data-align="center">地域</th>
    <th data-width="50" data-field="season" data-align="center">季节</th>
    <th data-field="cure_method">治法</th>
    <th data-field="disease_reason">病因</th>
    <th data-field="disease_mechsm">病机</th>
    <th data-field="constituent">方剂组成</th>
    <th data-width="400" data-field="else_medicine">加减法</th>
</tr> </thead>
</table>

</div><%--panel-body--%>

<script src="../js/extensions/resizable/bootstrap-table-resizable.js"></script>
<script src="../js/extensions/resizable/colResizable.js"></script>
<script src="../js/autocomplete.js"></script>
<script src="../js/luzhlon.js"></script>
<script src="../js/prescript/prescript.js"></script>
<script src="../js/prescript/table.js"></script>
<script src="../js/prescript/condition.js"></script>

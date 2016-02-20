<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-26
  Time: 上午12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-body" id="content">
  <ul class="nav nav-tabs">
    <li>
      <a href="#prescript-table" data-toggle="tab">方剂管理</a>
    </li>
    <li class="active">
      <a href="#prescript-input" data-toggle="tab">方剂录入</a>
    </li>
  </ul>
  <div class="tab-content">
    <!--Prescript table-->
    <div id="prescript-table" class="tab-pane">
        <div class="panel-body">
        <div id="prescript-toolbar">
            <div class="btn-group">
                <button type="button" class="btn btn-info" onclick="onNewPrescript()">新建</button>
                <button type="button" class="btn btn-warning" onclick="onEditPrescript()">编辑</button>
                <!--button type="button" class="btn btn-danger" onclick="onDeletePrescript()">删除</button-->
                <button type="button" class="btn btn-success" onclick="onQueryPrescript()">查询</button>
            </div>
        </div>
      <table id="table-book"
             data-toggle="table"
             data-height="500"
             data-pagination="true"
             data-side-pagination="server"
             data-toolbar="#prescript-toolbar"
             data-detail-view="true"
             data-detail-formatter="detailFormatter"
             data-show-columns="true"
             data-show-refresh="true"
             data-show-toggle="true"
             data-url="/data?method=query&object=prescription"
             data-resizable="true">
        <thead> <tr>
            <th data-field="id" data-align="center">ID</th>
            <th data-field="pres_name" data-width="50%">方名</th>
            <th data-field="pres_type" data-width="40px">剂型</th>
            <th data-field="book" data-width="80px">著作</th>
            <th data-field="version" data-width="30px">版本</th>
            <th data-field="page" data-align="center" data-width="30px">页码</th>
            <th data-field="source" data-width="80px">出处</th>
            <th data-field="make_method" data-width="100px">剂型制法</th>
            <th data-field="use_method" data-width="100px">服法</th>
            <th data-field="use_level" data-width="100px">用量</th>
            <th data-field="use_note" data-width="100px">注意事项</th>
            <th data-field="modern_name" data-width="80px">现代病名</th>
            <th data-field="mcure_name" data-width="80px">主治中医病名</th>
            <th data-field="mas_disease" data-width="">主治证候</th>
            <th data-field="mas_symptom" data-width="">主治症状</th>
            <th data-field="aux_symptom" data-width="">兼症</th>
            <th data-field="mas_medicine" data-width="">君药</th>
            <th data-field="aux_medicine" data-width="">臣药</th>
            <th data-field="sex" data-width="">性别</th>
            <th data-field="age" data-width="">年龄</th>
            <th data-field="pulse_cond" data-width="">脉象</th>
            <th data-field="tongue_coat" data-width="">舌苔</th>
            <th data-field="tongue_nature" data-width="">舌质</th>
            <th data-field="tongue_body" data-width="">舌体</th>
            <th data-field="first_second" data-width="">初复诊</th>
            <th data-field="region" data-width="">地域</th>
            <th data-field="season" data-width="">季节</th>
            <th data-field="cure_method" data-width="">治法</th>
            <th data-field="disease_reason" data-width="">病因</th>
            <th data-field="disease_mechsm" data-width="">病机</th>
            <th data-field="constituent" data-width="">方剂组成</th>
            <th data-field="else_medicine" data-width="">加减法</th>
        </tr> </thead>
      </table>
        </div>
    </div>
    <!--Prescript input-->
    <div id="prescript-input" class="tab-pane in active">
    <div class="container">
    <div class="row">
      <form name="prescription" method="post" action="/input"
            enctype="application/x-www-form-urlencoded"
            target="empty_frame"
            onreset="return onReset()"
            onkeydown="if(event.keyCode==13)return false;">

        <div class="col-md-2">
            <label>方名：</label>
            <input name="pres_name" class="form-control" type="text"/>
            <label>著作：</label>
            <input name="book" class="form-control" type="text"/>
            <label>版本：</label>
            <input name="version" class="form-control" type="text"/>
            <label>页码：</label>
            <input name="page" class="form-control" type="text"/>
            <label>出处：</label>
            <input name="source" class="form-control" type="text"/>
            <label>主治中医病名：</label>
            <input name="mcure_name" class="form-control" type="text"/>
        </div>
        <div class="col-md-2">
            <label>剂型：</label>
            <input name="pres_type" class="form-control" type="text"/>
            <label>制法：</label>
            <textarea name="make_method" class="form-control" ></textarea>
            <label>服法：</label>
            <textarea name="use_method" class="form-control" ></textarea>
            <label>用量：</label>
            <textarea name="use_level" class="form-control" ></textarea>
            <label>注意事项：</label>
            <textarea name="use_note" class="form-control" ></textarea>
        </div>
        <div class="col-md-2">
            <label>现代病名：</label>
            <input name="modern_name" class="form-control" type="text"/>
            <label>主治症候：</label>
            <input name="mas_disease" class="form-control" type="text"/>
            <label>主治症状：</label>
            <input name="mas_symptom" class="form-control" type="text"/>
            <label>兼症：</label>
            <input name="aux_symptom" class="form-control" type="text"/>
            <label>君药：</label>
            <input name="mas_medicine" class="form-control" type="text"/>
            <label>臣药：</label>
            <input name="aux_medicine" class="form-control" type="text"/>
        </div>

        <div class="col-md-1">
            <label>性别：</label>
            <input name="sex" class="form-control" type="text"/>
            <label>年龄：</label>
            <input name="age" class="form-control" type="text" />
            <label>初复诊：</label>
            <input name="first_second" class="form-control" type="text"/>
            <label>地域：</label>
            <input name="region" class="form-control" type="text" />
            <label>季节：</label>
            <input name="season" class="form-control" type="text" />
        </div>
        <div class="col-md-2">
            <label>脉象：</label>
            <input name="pulse_cond" class="form-control" type="text"/>
            <label>舌苔：</label>
            <input name="tongue_coat" class="form-control" type="text"/>
            <label>舌质：</label>
            <input name="tongue_nature" class="form-control" type="text"/>
            <label>舌体：</label>
            <input name="tongue_body" class="form-control" type="text"/>
            <label>原文图像：</label>
            <!-- 存放服务器端的图片文件名 -->
            <input name="image" type="text" style="display: none;"/>
            <input id="file_input" type="file"
                   accept="image/jpeg,image/png,image/bmp"/>
            <img id="image-frame" src="" />
            <div id="image-progress" style="display: none;">
                <!-- 用来显示文件上传进度 -->
                <label>已上传：</label>
                <div class="progress progress-striped">
                    <div id="image-progress-bar"
                         class="progress-bar progress-bar-success" role="progressbar"
                         aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
            </div>
          </div>
        <div class="col-md-2">
            <label>治法：</label>
            <textarea name="cure_method" class="form-control"></textarea>
            <label>病因：</label>
            <textarea name="disease_reason" class="form-control"></textarea>
            <label>病机：</label>
            <textarea name="disease_mechsm" class="form-control"></textarea>
            <label>方剂组成：</label>
            <textarea name="constituent" class="form-control" type="text"></textarea>
            <label>加减法：</label>
            <textarea name="else_medicine" class="form-control" ></textarea>
        </div>
      </form>
    </div> <!--row-->
    <div class="row" style="margin-top: 20px;"> <div class="form-group text-center">
        <input id="button-submit" type="button" value="提交"
               class="btn btn-success btn-large"
               style="width: 100px;margin-right: 80px;" onclick="onSubmit()"/>
        <input type="reset" value="重置"
               style="width: 100px; margin-right: 80px;"
               class="btn btn-danger btn-large"/>
    </div></div>
    </div> <!--container-->
</div> <!--tab-pane-->
</div> <!--tab-content-->
</div><!--panel-body-->
<style>
    img#image-frame {
        width: 100%;
        height: 20%;
    }
    .container form label {
        margin-left: -5px;
    }
</style>
<link href="../css/autocomplete.css" rel="stylesheet">
<script src="../js/autocomplete.js"></script>
<script src="../js/input.js"></script>
<script>
    /*
    var pres_table = $('#prescript-table');
    pres_table.on('click-row.bs.table', function(e, row, $element) {
        if($element.hasClass('success'))
            $element.removeClass('success');
        else
            $element.addClass('success');
    });  // */
    function onNewPrescript() {
        console.log(pres_table.bootstrapTable('getSelections'));
    }
</script>

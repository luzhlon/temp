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
<div class="panel-body" id="content">
  <ul class="nav nav-tabs" id="pres-tab-ul">
    <li class="active">
      <a href="#prescript-table" data-toggle="tab">方剂管理</a>
    </li>
    <li>
      <a href="#prescript-input" data-toggle="tab">方剂编辑器</a>
    </li>
  </ul>
  <div class="tab-content">
    <!--Prescript table-->
    <div id="prescript-table" class="tab-pane in active">
        <div class="panel-body">
        <div id="prescript-toolbar">
            <div class="btn-group">
                <button type="button" class="btn btn-info" id="button-new">新建</button>
                <button type="button" class="btn btn-warning" id="button-edit">编辑</button>
                <button type="button" class="btn btn-success" id="button-query">查询</button>
                <button type="button" class="btn btn-danger" id="button-delete">删除</button>
            </div>
        </div>
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
                                <option value="且">且</option>
                                <option value="或">或</option>
                            </select>
                        </div>
                        <div style="width: 23%;">
                            <select class="form-control" id="cond-field">
                            </select>
                        </div>
                        <div style="width: 15%;">
                            <select class="form-control"
                                    value="包含"
                                    id="cond-method">
                                <option value="等于">等于</option>
                                <option value="包含">包含</option>
                                <option value="形似">形似</option>
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
                                <th data-field="cond_relate" data-align="center">逻辑关系</th>
                                <th data-field="cond_field" data-align="center">字段</th>
                                <th data-field="cond_method" data-align="center">相等关系</th>
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
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <table id="table-prescript"
             data-toggle="table"
             data-height="700"
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
             data-url="/data?method=query&object=prescription"
             data-resizable="true">
        <thead> <tr>
            <th data-field="state" data-checkbox="true"></th>
            <th data-field="id" data-visible="false" data-align="center">ID</th>
            <th data-field="pres_name" data-align="center">方名</th>
            <th data-field="pres_type" data-align="center">剂型</th>
            <th data-field="book" data-align="center">著作</th>
            <th data-field="version" data-align="center">版本</th>
            <th data-field="page" data-align="center">页码</th>
            <th data-field="source">出处</th>
            <th data-field="make_method">剂型制法</th>
            <th data-field="use_method">服法</th>
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
            <th data-field="sex" data-align="center">性别</th>
            <th data-field="age" data-align="center">年龄</th>
            <th data-field="pulse_cond" data-align="center">脉象</th>
            <th data-field="tongue_coat" data-align="center">舌苔</th>
            <th data-field="tongue_nature" data-align="center">舌质</th>
            <th data-field="tongue_body" data-align="center">舌体</th>
            <th data-field="first_second" data-align="center">初复诊</th>
            <th data-field="region" data-align="center">地域</th>
            <th data-field="season" data-align="center">季节</th>
            <th data-field="cure_method">治法</th>
            <th data-field="disease_reason">病因</th>
            <th data-field="disease_mechsm">病机</th>
            <th data-field="constituent">方剂组成</th>
            <th data-field="else_medicine">加减法</th>
            <!--
            -->
        </tr> </thead>
        </table>
        </div>
    </div>

      <div class="modal fade" id="replace-modal" tabindex="-1" role="dialog"
           aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
              <div class="modal-content">
                  <div class="modal-header">
                      <button type="button" class="close"
                              data-dismiss="modal" aria-hidden="true">
                          &times;
                      </button>
                      <h4 class="modal-title">
                          检测到不规范药名
                      </h4>
                  </div>
                  <div class="modal-body">
                      <table id="table-replace"
                             data-toggle="table"
                             data-unique-id="id"
                             data-click-to-select="true">
                          <thead>
                          <tr>
                              <th data-field="id" data-visible="false">ID</th>
                              <th data-field="field" data-align="center">字段</th>
                              <th data-field="old" data-align="center">旧</th>
                              <th data-field="new" data-align="center">新</th>
                              <th data-field="state" data-checkbox="true"></th>
                          </tr>
                          </thead>
                      </table>
                  </div>
                  <div class="modal-footer">
                      <button type="button" id="modal-button-rep-cancel"
                              class="btn btn-default"
                              data-dismiss="modal">取消</button>
                      <button type="button" id="modal-button-replace"
                              class="btn btn-info">替换</button>
                      <button type="submit" id="modal-button-repsubmit"
                              class="btn btn-primary">替换并提交</button>
                  </div>
              </div><!-- /.modal-content -->
          </div><!-- /.modal -->
      </div>
      <!--Prescript input-->
    <div id="prescript-input" class="tab-pane">
    <div class="container">
    <div class="row">
      <form name="prescription" method="post" action="/input"
            enctype="application/x-www-form-urlencoded"
            target="empty_frame"
            onreset="return onPresFrameReset()"
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
            <label>主治证候：</label>
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
          <style>
              img#image-frame {
                  width: 100%;
                  height: 20%;
              }
              .container form label {
                  margin-left: -5px;
              }
          </style>
      </form>
    </div> <!--row-->
    <div class="row" style="margin-top: 20px;"> <div class="form-group">
        <label id="label-status" style="color: red;" class="col-md-4"></label>
        <span id="span-show-replace"
              class="col-md-4">
            <a href="javascript:void(0)" id="link-replace">检查规范药名</a>
        </span>
        <input id="button-submit" type="button" value="提交"
               class="btn btn-success btn-large col-md-1"/>
        <input id="button-reset" type="reset" value="重置"
               class="btn btn-danger btn-large col-md-1 col-md-offset-1"/>
    </div></div>
    </div> <!--container-->
</div> <!--tab-pane-->
</div> <!--tab-content-->
</div><!--panel-body-->

<script src="../js/autocomplete.js"></script>
<script src="../js/luzhlon.js"></script>
<script src="../js/pres/prescript.js"></script>
<script src="../js/pres/table.js"></script>
<script src="../js/pres/image.js"></script>
<script src="../js/pres/input.js"></script>
<script src="../js/pres/condition.js"></script>
<script src="../js/pres/replace.js"></script>


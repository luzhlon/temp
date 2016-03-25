<%@ page import="com.luzhlon.Global" %>
<%@ page import="com.mysql.jdbc.StringUtils" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.tool.DB" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="com.tool.Book" %>
<%@ page import="com.tool.Prescription" %>
<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 2016/3/23
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String id = request.getParameter(Global.ID);
        if (StringUtils.isNullOrEmpty(id)) {
    %>
    <title>新的方剂</title>
    <%
        } else {
    %>
    <title>编辑方剂<%=id%></title>
    <%
        }
    %>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/bootstrap-table.min.css" rel="stylesheet">
    <link href="../css/autocomplete.css" rel="stylesheet">
    <script src="../js/jquery-2.2.0.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-table.min.js"></script>
    <script src="../js/bootstrap-dialog.min.js"></script>
</head>
<body>

<%--录入界面--%>
<form name="prescription" method="post" action="/input"
      enctype="application/x-www-form-urlencoded"
      target="empty_frame"
      onkeydown="if(event.keyCode==13)return false;">
    <div class="modal-body">
        <div class="row" style="margin-left: 10px;">
            <div class="col-md-2">
                <label>方名：</label>
                <input name="pres_name" class="form-control" type="text"/>
                <label>剂型：</label>
                <input name="pres_type" class="form-control" type="text"/>
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
                <label>现代病名：</label>
                <input name="modern_name" class="form-control" type="text"/>
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
                <label>主治证候：</label>
                <input name="mas_disease" class="form-control" type="text"/>
                <label>主治症状：</label>
                <textarea name="mas_symptom" class="form-control"></textarea>
                <label>兼症：</label>
                <textarea name="aux_symptom" class="form-control"></textarea>
                <label>君药：</label>
                <input name="mas_medicine" class="form-control" type="text"/>
                <label>臣药：</label>
                <input name="aux_medicine" class="form-control" type="text"/>
            </div>

            <div class="col-md-1">
                <label>性别：</label>
                <%--<input name="sex" class="form-control" type="text"/>--%>
                <select name="sex" class="form-control">
                    <option value="">&nbsp;</option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
                <label>年龄：</label>
                <input name="age" class="form-control" type="text" />
                <label>初复诊：</label>
                <%--<input name="first_second" class="form-control" type="text"/>--%>
                <select name="first_second" class="form-control">
                    <option value="">&nbsp;</option>
                    <option value="初诊">初诊</option>
                    <option value="复诊">复诊</option>
                </select>
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
            <span id="span-show-replace">
                <a href="javascript:void(0)" id="link-replace">检查规范药名</a>
            </span>
                <textarea name="constituent" class="form-control" type="text"></textarea>
                <label>加减法：</label>
                <textarea name="else_medicine" class="form-control" ></textarea>
            </div>
            <style>
                img#image-frame {
                    width: 100%;
                    height: 20%;
                }
                #prescript-dialog form label {
                    margin-left: -5px;
                }
            </style>
        </div> <!--row-->
        <div class="row" style="margin-top: 20px;"> <div class="form-group">
            <label id="label-status" style="color: red;" class="col-md-4"></label>
        </div></div>
    </div>
    <div class="modal-footer">
        <input id="button-submit" value="提交" type="button"
               class="btn btn-success btn-large col-md-1"/>
        <input id="button-reset" value="重置" type="button"
               class="btn btn-danger btn-large col-md-1"/>
        <style>
            #button-submit, #button-reset {
                margin-left: 30px;
                margin-right: 30px;
            }
            #button-submit {
                margin-left: 40%;
            }
        </style>
    </div>
</form>

<%--药物替换界面--%>
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
                       data-height="300"
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
        </div><%-- /.modal-content --%>
    </div><%-- /.modal --%>
</div><%--Replace dialog--%>

<script src="../js/autocomplete.js"></script>
<script src="../js/luzhlon.js"></script>
<script src="../js/prescript/prescript.js"></script>
<script src="../js/input/image.js"></script>
<script src="../js/input/input.js"></script>
<script src="../js/input/replace.js"></script>

<script>
    <%
        if(StringUtils.isNullOrEmpty(id)) {
    %>
    pres_frame.New();
    <%
        } else {
            int iid = Integer.parseInt(id);
            PreparedStatement ps =
                        DB.preStatement("SELECT * FROM prescription WHERE id=?");
            ps.setInt(1, iid);
            ResultSet rs = ps.executeQuery();
            // 列名
            ArrayList<String> cols = new ArrayList<>();
            int col_num = rs.getMetaData().getColumnCount();
            for(int i = 1; i <= col_num; i++)
                cols.add(rs.getMetaData().getColumnName(i));
            //
            JSONObject jo = new JSONObject();
            if (rs.next())
                for(int i = 1; i <= cols.size(); i++)
                    jo.put(cols.get(i-1), rs.getString(i));
            String bid = jo.getString(Global.BOOK_ID);
            jo = Prescription.ItemFilter(jo);
            /* jo.put(Global.BOOK,
                Book.GetBookName(jo.optInt(Global.BOOK_ID)));
            if(jo.optString(Global.PAGE).equals("-1"))
                jo.put(Global.PAGE, ""); // */
    %>
    pres_frame.Edit(<%=jo.toString()%>);
    <%
        }
    %>
</script>

</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: tom
  Date: 16-1-29
  Time: 下午9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="panel-heading">
    <h3 class="panel-title">书籍管理</h3>
</div>
<div class="panel-body" id="content">
    <!-- 工具条 -->
    <div id="book-toolbar">
        <div class="btn-group">
            <button type="button" class="btn btn-info" id="button-new">新建</button>
            <button type="button" class="btn btn-warning" id="button-edit">编辑</button>
            <!--button type="button" class="btn btn-danger" onclick="onDelete()">删除</button-->
            <button type="button" class="btn btn-success" id="button-query">查询</button>
        </div>
    </div>
    <table id="table-book"
           data-height="500"
           data-toggle="table"
           data-toolbar="#book-toolbar"
           data-pagination="true"
           data-side-pagination="server"
           data-click-to-select="true"
           data-show-refresh="true"
           data-show-toggle="true"
           data-show-columns="true"
           data-url="/data?method=query&object=book"
           data-resizable="true">
        <thead>
        <tr>
            <th data-field="id" data-align="center">ID</th>
            <th data-field="name" data-align="center" data-editable="true">著作</th>
            <th data-field="author" data-align="center" data-editable="true">作者</th>
            <th data-field="dynasty" data-align="center" data-editable="true">朝代</th>
        </tr>
        </thead>
    </table>
</div>
<div class="modal fade" id="book-modal" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close"
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="book-modal-title">
               Modal Title
            </h4>
         </div>
         <div class="modal-body">
             <div class="form-group">
                 <label>著作：</label>
                 <input type="text" id="book-name"/>
             </div>
             <div class="form-group">
                 <label>作者：</label>
                 <input type="text" id="book-author"/>
             </div>
             <div class="form-group">
                 <label>朝代：</label>
                 <input type="text" id="book-dynasty"/>
             </div>
         </div>
         <div class="modal-footer">
            <button type="button" id="modal-button-cancel"
                    class="btn btn-default"
                    data-dismiss="modal">取消</button>
            <button type="button" id="modal-button-ok"
                    class="btn btn-primary">确定</button>
         </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
    var table_book = $('#table-book');
    table_book.on('editable-save.bs.table', function(event, field, row, old, jqobj) {
        var cur_val = row[field];
        var id = row.id;
        //var row_data = table_book.bootstrapTable('getRowByUniqueId',row.id);
        Request('/data?method=update&object=book', {
            'id': id,
            [field]: row[field]
        }, function (json) {
            if (json.success) {
                ShowToolTip(jqobj, "数据更新成功");
            } else {
                BootstrapDialog.show({
                    title: "错误",
                    message: '数据更新失败.'
                });
            }
        });
    });
    //*
    table_book.on('click-row.bs.table', function(e, row, $element) {
        $('.success').removeClass('success');
        $($element).addClass('success');
    });  // */
    var book = {
        $modal : $('#book-modal'),
        operate : 'new',
        GetValues : function() {
            return {
                name : $('#book-name').val(),
                author : $('#book-author').val(),
                dynasty : $('#book-dynasty').val()
            };
        },
        SetValues : function(vals) {
            $('#book-name').val(vals.name);
            $('#book-author').val(vals.author);
            $('#book-dynasty').val(vals.dynasty);
        },
        InitModal : function() {
            var self = this;
            var modal = this.$modal;
            $('#modal-button-cancel').click(function() {
                modal.modal('hide');
            });
            $('#modal-button-ok').click(function() {
                var method, suc_tip, fail_tip;
                var values = self.GetValues();
                if(self.operate == 'new') {
                    method = 'insert';
                    suc_tip = '著作创建成功！';
                    fail_tip = '著作创建失败:';
                } else {
                    method = 'update';
                    suc_tip = '著作更新成功！';
                    fail_tip = '著作更新失败:';
                }
                Request(
                        '/data?object=book&method=' + method,
                        values, function(json) {
                            if (json.success)
                                ShowToolTip($('#button-new'), suc_tip);
                            else
                                ShowToolTip($('#button-new'), fail_tip + json.reason);
                        }
                );
                modal.modal('hide');
            });
        },
        ModalTitle : function(text) {
            return $('#book-modal-title').text(text);
        },
        New : function() {
            this.ModalTitle("新的著作");
            this.operate = 'new';
            this.SetValues({name:'',author:'',dynasty:''});
            this.$modal.modal('show');
        },
        Edit : function(row) {
            if(!row) return;
            this.ModalTitle("编辑著作 ID:" + row.id);
            this.operate = 'edit';
            this.SetValues(row);
            this.$modal.modal('show');
        }
    };
    book.InitModal();
    $('#button-new').click(function() {
        book.New();
    });
    $('#button-edit').click(function() {
        var row = TableSelectedRow(table_book);
        book.Edit(row);
    });
    $('#button-query').click(function() {
    });
</script>

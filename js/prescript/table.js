// 表格的jquery对象
pres_table = $('#table-prescript');
// 双击表格条目时进入编辑模式
pres_table.on('dbl-click-row.bs.table', function(e, row, $element) {
    //pres_frame.Edit(row);
    window.open('input.jsp?id='+row.id);
});
// 表格刷新时调用
function onPresTableQuery(params) {
    var cond = cond_dialog.GetCondJSON();
    if(cond)
        params.condition = cond;
    return params;
}
// ’新建‘按钮点击事件
$('#button-new').click(function() {
    //pres_frame.New();
    window.open('input.jsp');
});
// ’删除‘按钮点击事件
$('#button-delete').click(function() {
    var ids = getIdSelections(pres_table);

    Request('/data?object=prescription&method=delete',
        { id: ids.join(',') }, function(json) {
            if(json.success) {
                ShowToolTip($('#button-delete'), '删除方剂成功！');
                pres_table.bootstrapTable('remove', {field: 'id', values:ids});
            }
            else
                ShowToolTip($('#button-delete'), '删除方剂失败：' + json.reason);
        });
});
// ’查询‘按钮点击事件
$('#button-query').click(function() {
    cond_dialog.Show();
});
// 选择统计范围
$('#button-statistics').click(function() {
    $('#statistics-modal').modal('show');
});
// 处理表格不能调节列宽度的问题
window.setTimeout(function() {
    $('#table-prescript')
        .wrap('<div style="width: 4000px; overflow: hidden"></div>');
}, 200);

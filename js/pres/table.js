// 表格的jquery对象
pres_table = $('#table-prescript');
// 双击表格条目时进入编辑模式
pres_table.on('dbl-click-row.bs.table', function(e, row, $element) {
    pres_frame.Edit(row);
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
    pres_frame.New();
});
// ’编辑‘按钮点击事件
$('#button-edit').click(function() {
    ShowToolTip($('#button-edit'), '双击方剂条目编辑');
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

// 处理表格不能调节的现象
function UpTableWidth($table) {
    window.setTimeout(function() {
        $($table).wrap('<div style="width: 4000px; overflow: hidden"></div>');
    }, 100);
}
UpTableWidth('#table-prescript');

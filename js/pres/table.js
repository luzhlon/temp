
pres_table = $('#table-prescript');
// DoubleClick table item
pres_table.on('dbl-click-row.bs.table', function(e, row, $element) {
    pres_frame.Edit(row);
});
// On refresh or query
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


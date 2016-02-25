
pres_table = $('#table-prescript');
// DoubleClick table item
pres_table.on('dbl-click-row.bs.table', function(e, row, $element) {
    pres_frame.Edit(row);
});
// On refresh or query
function onPresTableQuery(params) {
    //alert(JSON.stringify(params));
    return params;
}

$('#button-new').click(function() {
    pres_frame.New();
});

$('#button-edit').click(function() {
    ShowToolTip($('#button-edit'), '双击方剂条目编辑');
});

$('#button-delete').click(function() {
    var ids = getIdSelections(pres_table);

    Request('/data?object=prescription&method=delete',
        { id: ids.join(',') }, function(json) {
            if(json.success) {
                ShowToolTip($('#button-delete'), '删除方剂成功！');
                pres_frame.Delete(ids);
            }
            else
                ShowToolTip($('#button-delete'), '删除方剂失败：' + json.reason);
        });
});

$('#button-query').click(function() {
    cond_dialog.Show();
});


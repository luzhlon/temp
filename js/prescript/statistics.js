statistics_result = {
    $modal: $('#statistics-result-modal'),
    $table: $('#statistics-result-table'),
    Init : function() {
        $('#button-statistics').click(function() {
            statistics_result.Show();
            Request('/statistics', {
                type: 'medicine-rate',
                condition: cond_dialog.GetCondJSON()
            }, function(json) {
                if (!json.success) {
                    alert('统计出错！');
                    return;
                }
                var data = json.result;

                $('#search-result').text('从' + data.total + '条记录里检索到了' +
                        data.search + '条记录，占' + data.rate + '%\n');

                var tbody = $("<tbody></tbody>");
                for (var i = 0, r = data.result; i < r.length;) {
                    statistics_result.$table.bootstrapTable('append', {
                        id: r[i++],
                        count: r[i++],
                        rate: r[i++]
                    });
                }
            });
        });
    },
    Show : function() {
        var conds = "";
        var data = cond_dialog.$table.bootstrapTable('getData');
        for(var i = 0; i < data.length; i++)
            conds += data[i].show_relate + ' ' +
                data[i].show_field + ' ' +
                data[i].show_method + ' ' +
                data[i].cond_value + '\n';
        $('#search-condition').text(conds);
        $('#search-result').text('请稍等......');
        this.$table.bootstrapTable('removeAll');
        this.$modal.modal('show');
    }
};
statistics_result.Init();

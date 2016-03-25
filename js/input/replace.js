// 中药药名规范对话框
rep_dialog = {
    $modal : $('#replace-modal'),
    $table : $('#table-replace'),
    result: {},   // Result from server
    // 初始化
    Init: function() {
        var self = this;
        $('#modal-button-rep-cancel').click(function() {
            self.$modal.modal('hide');
        });
        $('#modal-button-replace').click(function() {
            self.Replace();
            self.$modal.modal('hide');
        });
        $('#modal-button-repsubmit').click(function() {
            self.Replace();
            pres_frame.Submit();
            self.$modal.modal('hide');
        });
        $('#link-replace').click(function() {
            self.CheckReplace();
        });
    },
    // 替换所选的不规范的药名
    Replace: function() {
        var data = this.$table.bootstrapTable('getSelections');
        for(var i = 0; i < data.length; i++) {
            var item = data[i];
            var field = g_field_map[item.field];
            try {
                g_prescript[field].val(item.new);
            } catch (e) {
                console.log(e);
            }
        }
    },
    // 获取旧的输入（不规范的药名）
    GetOldValues: function() {
        return {
            constituent: g_prescript.constituent.val(),
            use_level: g_prescript.use_level.val(),
            mas_medicine: g_prescript.mas_medicine.val(),
            aux_medicine: g_prescript.aux_medicine.val()
        };
    },
    // 刷新列表
    RefreshTable: function() {
        this.$table.bootstrapTable('removeAll');
        var rows = this.result.rows;
        if(!rows) return;
        for(var i = 0; i < rows.length; i++) {
            var r = rows[i];
            var row = {};
            for(var key in r)
                row[key] = r[key];
            row.field = g_field_map[r.field];
            this.$table.bootstrapTable('append', row);
        }
    },
    // 显示对话框
    Show: function() {
        this.RefreshTable();
        this.$modal.modal('show');
        this.$table.bootstrapTable('checkAll');
    },
    // 检查是否需要规范中药名
    CheckReplace: function() {
        var self = this;
        Request('/replace', this.GetOldValues(), function(json) {
            if(!json.success) {
                ShowToolTip($('#link-replace'), '没有要替换的中药名');
                return;
            }
            self.result = json.result;
            self.Show();
        });
    }
};

rep_dialog.Init();
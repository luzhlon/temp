
rep_dialog = {
    $modal : $('#replace-modal'),
    $table : $('#table-replace'),
    result: {},   // Result from server
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
    GetOldValues: function() {
        return {
            constituent: g_prescript.constituent.val(),
            use_level: g_prescript.use_level.val(),
            mas_medicine: g_prescript.mas_medicine.val(),
            aux_medicine: g_prescript.aux_medicine.val()
        };
    },
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
    Show: function() {
        this.RefreshTable();
        this.$modal.modal('show');
        this.$table.bootstrapTable('checkAll');
    },
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

cond_dialog = {
    $modal: $('#cond-modal'),
    $table: $('#table-condition'),
    condition: [],
    $relate: $('#cond-relate'),
    $field: $('#cond-field'),
    $method: $('#cond-method'),
    $value: $('#cond-value'),
    _id: 0,
    GetCondition: function() {
        return {
            cond_relate: this.$relate.val(),
            cond_field: this.$field.val(),
            cond_method: this.$method.val(),
            cond_value: this.$value.val()
        };
    },
    GetCondJSON: function() {
        var ret = [];
        for(var i = 0; i < this.condition.length; i++) {
            var cond = this.condition[i];
            var obj = {};
            obj.relate = cond.cond_relate == '且' ? 'and' : 'or';
            obj.field = g_field_map[cond.cond_field];
            switch(cond.cond_method) {
                case '等于': obj.method = 'equal'; break;
                case '包含': obj.method = 'contain'; break;
                case '形似': obj.method = 'like'; break;
            }
            obj.value = cond.cond_value;
            if(obj.field)
                ret.push(obj);
            else {
                BootstrapDialog.alert('Error field');
                return null;
            }
        }
        return ret.length ? JSON.stringify(ret) : null;
    },
    GetID : function() {
        return this._id++;
    },
    Init: function() {
        var cond_field = $('#cond-field');
        for(var i = 0; i < g_fields.length; i++) {
            var key = g_fields[i];
            cond_field.append( $('<option></option>')
                                .val(g_field_map[key])
                                .text(g_field_map[key]));
        }

        var self = this;
        $('#button-cond-add').click(function() {
            var cond = self.GetCondition();
            cond.id = self.GetID();
            self.$table.bootstrapTable('append', cond);
        });
        $('#button-cond-delete').click(function() {
            self.$table.bootstrapTable('remove', {
                field: 'id',
                values: getIdSelections(self.$table)
            });
        });
        $('#modal-button-ok').click(function() {
            self.condition = [];
            var data = self.$table.bootstrapTable('getData');
            for(var i = 0; i < data.length; i++)
                self.condition[i] = data[i];
            self.$modal.modal('hide');
            pres_table.bootstrapTable('refresh');
            pres_table.bootstrapTable('selectPage', 1);
        });
        $('#modal-button-cancel').click(function() {
            self.$modal.modal('hide');
        });
    },
    Refresh: function() {
        this.$table.bootstrapTable('removeAll');
        for(var i = 0; i < this.condition.length; i++)
            this.$table.bootstrapTable('append', this.condition[i]);
    },
    Show: function() {
        this.$modal.modal('show');
        this.Refresh();
    }
};

cond_dialog.Init();

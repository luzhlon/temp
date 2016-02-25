
cond_dialog = {
    $modal: $('#cond-modal'),
    $table: $('#table-condition'),
    condition: [],
    ac_field: new AutoCompleter($('#cond-field')),
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
    GetID : function() {
        return this._id++;
    },
    Init: function() {
        for(var key in g_fieldNames) {
            var val = g_fieldNames[key];
            g_fieldNames[val] = key;
            this.ac_field.addOption(val);
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

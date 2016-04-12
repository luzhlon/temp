// 查询对话框（和查询条件有关的数据，操作）
cond_dialog = {
    $modal: $('#cond-modal'),
    $table: $('#table-condition'),
    $relate: $('#cond-relate'),
    $field: $('#cond-field'),
    $method: $('#cond-method'),
    $value: $('#cond-value'),
    condition: [],
    _id: 0,
    // 获取输入的条件
    GetCondition: function() {
        return {
            cond_relate: this.$relate.val(),
            cond_field: this.$field.val(),
            cond_method: this.$method.val(),
            cond_value: this.$value.val()
        };
    },
    // 获取条件列表的JSON格式
    GetCondJSON: function() {
        var ret = [];
        for(var i = 0; i < this.condition.length; i++) {
            var cond = this.condition[i];
            var obj = {};
            obj.relate = cond.cond_relate;
            obj.field = cond.cond_field;
            obj.method = cond.cond_method;
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
    // 获得一个新的条件ID
    GetID : function() {
        return this._id++;
    },
    // 初始化
    Init: function() {
        // 字段选项
        for(var i = 0; i < g_fields.length; i++) {
            var key = g_fields[i];
            this.$field.append( $('<option></option>')
                                .val(key)
                                .text(g_field_map[key]));
        }
        this.$field.append($('<option></option>').val('author').text("作者"));
        this.$field.append($('<option></option>').val('dynasty').text("朝代"));
        // 相等性选项
        var es = { equal: '等于', contain: '包含', like: '形似', regexp: '正则' };
        for(var key in es)
            this.$method.append($('<option></option>').val(key).text(es[key]));

        var self = this;
        $('#button-cond-add').click(function() {
            var cond = self.GetCondition();
            cond.id = self.GetID();
            if(cond.cond_value == '') {
                ShowToolTip(this.$value, "不能为空！");
                return;
            }
            cond.show_relate =
                $('#cond-relate option[value="' + cond.cond_relate + '"]').text();
            cond.show_field =
                $('#cond-field option[value="' + cond.cond_field + '"]').text();
            cond.show_method =
                $('#cond-method option[value="' + cond.cond_method + '"]').text();
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
            // 刷新方剂表
            pres_table.bootstrapTable('refresh');
            pres_table.bootstrapTable('selectPage', 1);
        });
        $('#modal-button-cancel').click(function() {
            self.$modal.modal('hide');
        });
    },
    // 刷新条件列表
    Refresh: function() {
        this.$table.bootstrapTable('removeAll');
        for(var i = 0; i < this.condition.length; i++)
            this.$table.bootstrapTable('append', this.condition[i]);
    },
    // 显示对话框
    Show: function() {
        this.$modal.modal('show');
        this.Refresh();
    }
};

cond_dialog.Init();

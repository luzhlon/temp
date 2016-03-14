/*
 function detailFormatter(index, row) {
 var html = [];
 $.each(row, function (key, value) {
 html.push('<p><b>' + key + ':</b> ' + value + '</p>');
 });
 return html.join('');
 } // */

function RequestData(method, callback) {
    Request('/output', { method: method }, callback);
}

function SelectizeAll(selct) {
    function defHandler(ac) {
        return function(rst) {
            if(!rst.success) return;
            if(rst.result.length <= 0) return;
            ac.addOptions(rst.result);
            ac.refreshOptions(false);
        };
    }

    var ps = g_prescript;

    var season = new AutoCompleter(ps.season);
    var region = new AutoCompleter(ps.region);

    var mdisease = new AutoCompleter(ps.mas_disease);
    var msymptom = new AutoCompleter(ps.mas_symptom);
    var asymptom = new AutoCompleter(ps.aux_symptom);
    var mmedicine = new AutoCompleter(ps.mas_medicine);
    var amedicine = new AutoCompleter(ps.aux_medicine);

    var source = new AutoCompleter(ps.source);
    var book = new AutoCompleter(ps.book);
    var tcoat = new AutoCompleter(ps.tongue_coat);
    var tnature = new AutoCompleter(ps.tongue_nature);
    var tbody = new AutoCompleter(ps.tongue_body);

    var type = new AutoCompleter(ps.pres_type);
    var mname = new AutoCompleter(ps.mcure_name);
    var pcond = new AutoCompleter(ps.pulse_cond);

    RequestData("type", defHandler(type));
    RequestData("source", defHandler(source));
    RequestData("book", defHandler(book));
    RequestData("disease", defHandler(mdisease));
    RequestData("disease_name", defHandler(mname));
    RequestData("pulse_cond", defHandler(pcond));
    RequestData("season", defHandler(season));
    RequestData("region", defHandler(region));
    RequestData("tongue", defHandler(tcoat));
    tnature.setOptionTable(tcoat.getOptionTable());
    tbody.setOptionTable(tcoat.getOptionTable());
    RequestData("symptom", defHandler(msymptom));
    asymptom.setOptionTable(msymptom.getOptionTable());
    RequestData("medicine", defHandler(mmedicine));
    amedicine.setOptionTable(mmedicine.getOptionTable());
}

pres_frame = {
    $table: $('#prescript-table'),
    $form: $('[name="prescription"]'),
    $status: $('#label-status'),
    edit_pres: null,
    Status : function(s) { return this.$status.text(s); },
    GetValues : function() {
        var psv = {};
        var ps = g_prescript;
        for(var i in ps)
            psv[i] = ps[i].val();
        return psv;
    },
    SetValues : function(vals) {
        var ps = g_prescript;
        for(var i in ps)
            ps[i].val(vals[i]);
    },
    // 检查必填字段
    CheckFields : function() {
        var ps = g_prescript;
        var tip_text = {
            pres_name: "方名忘写咯~~",
            pres_type: "剂型没填哦~~",

            constituent: "方剂组成没写哦~~"
        };
        for(var key in tip_text) {
            if(ps[key].val().length <= 0) {
                BootstrapDialog.show({
                    title: "提示",
                    message: tip_text[key]
                });
                return false;
            }
        }
        return true;
    },
    // 重置所有输入
    Reset : function () {
        this.SetValues({});
        g_image_frame.setImage('');
    },
    // 提交录入的数据
    Submit: function() {
        if(!this.CheckFields()) return false;
        var psv = this.GetValues();
        var method, suc_tip, fail_tip;
        if(this.edit_pres) {
            method = 'update';
            psv.id = this.edit_pres.id;
            suc_tip = psv.pres_name + '更新成功！';
            fail_tip = psv.pres_name + '更新失败:';
        } else {
            method = 'insert';
            suc_tip = psv.pres_name + '添加成功！';
            fail_tip = psv.pres_name + '添加失败:';
        }
        var self = this;
        Request('/data?object=prescription&method=' + method, psv, function(json) {
            if(json.success) {
                // 数据录入成功
                ShowToolTip($('#button-submit'), suc_tip);
                g_prescript.pres_name.focus();
                self.$table.bootstrapTable(
                    'updateByUniqueId', {id:psv.id, row:psv});
                //g_form.reset();
            } else {
                BootstrapDialog.show({
                    title: fail_tip,
                    message: json.reason
                });
            }
        });
        return false;
    },
    // 初始化
    Init : function() {
        var self = this;
        g_image_frame.Init();
        $('#button-submit').click(function() { self.Submit(); });
        $('#button-reset').click(function() { self.Reset(); });
        this.Status("新的方剂");
        SelectizeAll();
        var ps = g_prescript;
        LimitNumberInput(ps.page);
        FilterInput(ps.book, /[《》]/);
        FilterInput(ps.source, /[《》]/);
        FilterInput(ps.sex, /[\s]/);
        FilterInput(ps.first_second, /[\s]/);
    },
    // 显示录入标签页
    ShowInput : function () {
        $('#pres-tab-ul a[href="#prescript-input"]').tab('show');
    },
    // 新建方剂
    New : function() {
        this.Status("新的方剂");
        this.Reset();
        this.edit_pres = null;
        g_image_frame.setImage('');
        this.ShowInput();
    },
    // 编辑方剂
    Edit : function(row) {
        if(!row) return;
        this.Status("正在编辑方剂 ID:" + row.id);
        this.SetValues(row);
        this.edit_pres = row;
        g_image_frame.setImage(row.image);
        this.ShowInput();
    }
};

pres_frame.Init();

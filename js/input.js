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

var g_image = {
    $frame : $('#image-frame'),
    $input : $('[name="image"]'),
    $prog_frame : $('#image-progress'),
    $prog_label : $('#image-progress label'),
    $prog_bar : $('#image-progress-bar'),
    Init : function() {
        var self = this;
        setUpload('#file_input', {
            url : '/upload',
            fields: { method : 'image' },
            onchange: function(fileObj) {
                self.showProgress();
                return true;
            },
            onprogress: function(evt) {
                if (evt.lengthComputable) {
                    self.setProgressInfo(Math.round((evt.loaded / evt.total)  * 100));
                }
            },
            onerror : function() {
                ShowToolTip(self.$input, '上传失败。');
            },
            onuploaded: function() {
                ShowToolTip(self.$input, '上传完成。');
            },
            onresponse : function(xhr) {
                var r = JSON.parse(xhr.responseText);
                if(r.success) {
                    // 设置图片
                    self.setImage(r.result);
                    self.showImage();
                }
                console.log(xhr.responseText);
            }
        });
    },
    // 设置图片
    setImage : function setImage(name) {
        this.$input.val(name);
        this.$frame.attr('src', '/upload/'+name);
    },
    // 设置进度信息
    setProgressInfo : function (per) {
        this.$prog_label.text('已上传：' + per + '%');
        this.$prog_bar.attr('aria-valuenow', per);
    },
    // 显示进度条
    showProgress : function () {
        this.$frame.css('display', 'none');
        this.$prog_frame.css('display', '');
    },
    // 显示图片
    showImage : function () {
        this.$frame.css('display', '');
        this.$prog_frame.css('display', 'none');
    },
};
var g_fields = [ 'pres_name', 'book', 'source', 'version', 'page', 'image', 'pres_type', 'make_method', 'use_method', 'use_level', 'use_note', 'modern_name', 'mcure_name', 'mas_disease', 'mas_symptom', 'aux_symptom', 'mas_medicine', 'aux_medicine', 'sex', 'age', 'pulse_cond', 'tongue_coat', 'tongue_nature', 'tongue_body', 'first_second', 'region', 'season', 'cure_method', 'disease_reason', 'disease_mechsm', 'constituent', 'else_medicine' ];
var g_fieldNames = { pres_name : "方名", book : "著作", source : "出处", version : "版本", page : "页码", image : "原文图像", pres_type : "剂型", make_method : "剂型制法", use_method : "服法", use_level : "用量", use_note : "注意事项", modern_name : "现代病名", mcure_name : "主治中医病名", mas_disease : "主治证候", mas_symptom : "主治症状", aux_symptom : "兼症", mas_medicine : "君药", aux_medicine : "辅药", sex : "性别", age : "年龄", pulse_cond : "脉象", tongue_coat : "舌苔", tongue_nature : "舌质", tongue_body : "舌体", first_second : "初诊复诊", region : "地区", season : "季节", cure_method : "治法", disease_reason : "病因", disease_mechsm : "病机", constituent : "方剂组成", else_medicine : "加减法" };
var g_prescript = {}; for(var i in g_fields) { var key = g_fields[i]; var val = $('[name="' + key + '"]'); if(!val) alert(key); g_prescript[key] = val; }

function SelectizeAll(selct) {
    function defHandler(ac) {
        return function(rst) {
            if(!rst.success) return;
            if(rst.result.length <= 0) return;
            for(var i in rst.result) {
                ac.addOption(rst.result[i]);
            }
            ac.refreshOptions(false);
        };
    }

    var ps = g_prescript;

    var firSec = new AutoCompleter(ps.first_second); firSec.addOption('初诊'); firSec.addOption('复诊');
    var sex = new AutoCompleter(ps.sex); sex.addOption('男'); sex.addOption('女');
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
    RequestData("tongue_coat", defHandler(tcoat));
    RequestData("tongue_nature", defHandler(tnature));
    RequestData("tongue_body", defHandler(tbody));
    // */
    RequestData("medicine", function(rst) {
        if(rst.result.length <= 0) {
            return;
        }
        for(var i in rst.result) {
            var option = rst.result[i];
            mmedicine.addOption(option);
            amedicine.addOption(option);
        }
        mmedicine.refreshOptions(false);
        amedicine.refreshOptions(false);
    });

    RequestData("symptom", function(rst) {
        if(rst.result.length <= 0) {
            return;
        }
        for(var i in rst.result) {
            var option = rst.result[i];
            msymptom.addOption(option);
            asymptom.addOption(option);
        }
        msymptom.refreshOptions(false);
        asymptom.refreshOptions(false);
    });
}

// 检查字段
function CheckFields() {
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
}

function onReset() {
    g_image.setImage('');
    return true;
}

var pres_table = $('#prescript-table');
var pres_frame = {
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
    Init : function() {
        var self = this;
        g_image.Init();
        $('#button-submit').click(function() {
            if(!CheckFields()) return false;
            var psv = self.GetValues();
            var method, suc_tip, fail_tip;
            if(self.edit_pres) {
                method = 'update';
                psv.id = self.edit_pres.id;
                suc_tip = psv.pres_name + '更新成功！';
                fail_tip = psv.pres_name + '更新失败:';
            } else {
                method = 'insert';
                suc_tip = psv.pres_name + '添加成功！';
                fail_tip = psv.pres_name + '添加失败:';
            }
            $.post('/data?object=prescription&method=' + method, psv, function(reText) {
                var json = JSON.parse(reText);
                if(json.success) {
                    // 数据录入成功
                    ShowToolTip($('#button-submit'), suc_tip);
                    g_prescript.pres_name.focus();
                    pres_table.bootstrapTable('updateByUniqueId', psv.id, psv);
                    //g_form.reset();
                } else {
                    BootstrapDialog.show({
                        title: fail_tip,
                        message: json.reason
                    });
                }
            });
            return false;
        });
        this.Status("新的方剂");
    },
    New : function() {
        this.Status("新的方剂");
        this.SetValues({});
        this.edit_pres = null;
        g_image.setImage('');
        $('#pres-tab-ul a[href="#prescript-input"]').tab('show');
    },
    Edit : function(row) {
        if(!row) return;
        this.Status("正在编辑方剂 ID:" + row.id);
        this.SetValues(row);
        this.edit_pres = row;
        g_image.setImage(row.image);
        $('#pres-tab-ul a[href="#prescript-input"]').tab('show');
    }
};
pres_table.on('dbl-click-row.bs.table', function(e, row, $element) {
    pres_frame.Edit(row);
});
$('#button-new').click(function() {
    pres_frame.New();
});
$('#button-edit').click(function() {
    ShowToolTip($('#button-edit'), '双击方剂条目编辑');
});
$('#button-delete').click(function() {
});


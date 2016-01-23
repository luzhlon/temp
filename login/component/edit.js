
// 需要外部页面设置
_id = null;
_onsuccess = null;

function Request(uri, data, callback) {
    $.post(uri, data, function(reText) {
        try {
            var r = JSON.parse(reText);
            if(callback) callback(r);
        } catch (e) {
            console.log(e);
        }
    });
}

function RequestData(method, callback) {
    Request('/output', { method: method }, callback);
}
function GetForm() {
    if(typeof _form == 'undefined') {
        _form = document.getElementsByName('prescription')[0];
    }
    return _form;
}
// 获取各字段的jQuery对象
function GetPrescript() {
    if(typeof _prescript != 'undefined') {
        return _prescript;
    }

    _prescript = {};
    var ps = _prescript;

    ps.name = $('[name="pres_name"]');
    ps.book = $('[name="book"]');
    ps.source = $('[name="source"]');
    ps.version = $('[name="version"]');
    ps.page = $('[name="page"]');
    ps.image = $('[name="image"]');

    ps.type = $('[name="pres_type"]');
    ps.mmethod = $('[name="make_method"]');
    ps.umethod = $('[name="use_method"]');
    ps.ulevel = $('[name="use_level"]');
    ps.unote = $('[name="use_note"]');

    ps.mname = $('[name="modern_name"]');
    ps.mcname = $('[name="mcure_name"]');
    ps.mdisease = $('[name="mas_disease"]');
    ps.msymptom = $('[name="mas_symptom"]');
    ps.asymptom = $('[name="aux_symptom"]');
    ps.mmedicine = $('[name="mas_medicine"]');
    ps.amedicine = $('[name="aux_medicine"]');

    ps.sex = $('[name="sex"]');
    ps.age = $('[name="age"]');
    ps.pcond = $('[name="pulse_cond"]');
    ps.toncoat = $('[name="tongue_coat"]');
    ps.tonnature = $('[name="tongue_nature"]');
    ps.tonbody = $('[name="tongue_body"]');
    ps.firsec = $('[name="first_second"]');
    ps.region = $('[name="region"]');
    ps.season = $('[name="season"]');

    ps.cmethod = $('[name="cure_method"]');
    ps.dreason = $('[name="disease_reason"]');
    ps.dmechsm = $('[name="disease_mechsm"]');
    ps.consti = $('[name="constituent"]');
    ps.emedicine = $('[name="else_medicine"]');

    return ps;
}

// 获取录入数据
function GetPresValue() {
    var psv = {};
    for(var i in ps) {
        psv[i] = ps[i].attr('value');
    }
    return psv;
}
// 设置录入数据
function SetPresValue(psv) {
    var ps = GetPrescript();
    for(var i in ps) {
        ps[i].attr('value', psv[i]);
    }
}

function SelectizeAll(selct) {
    var defOpts = {
        plugins: ['restore_on_backspace'],
        create: true,
        maxItems: 1
    };
    var defHandler = function(ac) {
        return function(rst) {
            if(!rst.success) return;
            if(rst.result.length <= 0) return;
            for(var i in rst.result) {
                ac.addOption(rst.result[i]);
            }
            ac.refreshOptions(false);
        };
    };
    var ps = GetPrescript();

    var firSec = new AutoCompleter(ps.firsec);
    firSec.addOption('初诊');
    firSec.addOption('复诊');
    var sex = new AutoCompleter(ps.sex);
    sex.addOption('男');
    sex.addOption('女');
    var season = new AutoCompleter(ps.season);
    var region = new AutoCompleter(ps.region);

    var mdisease = new AutoCompleter(ps.mdisease);
    var msymptom = new AutoCompleter(ps.msymptom);
    var asymptom = new AutoCompleter(ps.asymptom);
    var mmedicine = new AutoCompleter(ps.mmedicine);
    var amedicine = new AutoCompleter(ps.amedicine);

    var source = new AutoCompleter(ps.source);
    var book = new AutoCompleter(ps.book);
    var tcoat = new AutoCompleter(ps.toncoat);
    var tnature = new AutoCompleter(ps.tonnature);
    var tbody = new AutoCompleter(ps.tonbody);

    var type = new AutoCompleter(ps.type);
    var mname = new AutoCompleter(ps.mcname);
    var pcond = new AutoCompleter(ps.pcond);

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

// 检查空字段
function CheckFields() {
    var ps = GetPrescript();
    if(ps.name.attr('value').length <= 0) {
        alert("方名忘写咯~");
        con.focus();
        return false;
    }
    if(ps.type.attr('value').length <= 0) {
        alert("方剂类型没写~");
        con.focus();
        return false;
    }
    return true;
}

function onSubmit() {
    if(!CheckFields()) {
        return false;
    }

    var ps = GetPrescript();
    var form = {};
    for(var i in ps) {
        form[ps[i].attr('name')] = ps[i].attr('value');
    }
    if(_id) {   // 更新数据，而不是录入
        form.method = 'update_prescript';
    } else {
        form.method = 'insert_prescript';
    }

    var name = ps.name.attr('value');
    $.post('/input', form,
        function(reText) {
            var json = JSON.parse(reText);
            if(json.success) {
                // 数据录入成功
                SetStatusBar(name + ' 录入成功');
                GetForm().reset();
                console.log('Input success.');
            } else {
                console.log('Input failure.');
            }
        });

    return false;
}

function onFile(imgFile) {
    var img_name = document.getElementsByName('image')[0];
    img_name.value = ""; //

    var img = document.getElementById('image');
    img.src = "";
    var out = document.getElementById('output');
    var fo = imgFile.files[0]; // File Object
    // 隐藏图片框并显示进度框
    img.style = 'display: none;';
    out.style = 'display:';

    var fd = new FormData(); // FormData Object
    fd.append('method', 'upload');
    fd.append('file', fo);

    var xhr = getXHR();
    xhr.onreadystatechange = function() {
        if(xhr.readyState === 4 && xhr.status == 200) {
            var r = JSON.parse(xhr.responseText);
            if(r.success) {
                img_name.value = r.result;
                // 设置图片框内容
                img.src = '/upload/' + r.result;
                //
                img.style = 'display:';
                out.style = 'display:none;';
            }
            console.log(xhr.responseText);
        }
    };
    xhr.upload.addEventListener( 'progress',
        function uploadProgress(evt) {
            // evt 有三个属性：
            // lengthComputable – 可计算的已上传字节数
            // total – 总的字节数
            // loaded – 到目前为止上传的字节数
            if (evt.lengthComputable) {
                out.value = Math.round((evt.loaded / evt.total)  * 100) + '%';
            }
        }, false); // false表示在事件冒泡阶段处理

    xhr.upload.onload = function() {
        out.value = '上传完成。';
    };

    xhr.upload.onerror = function(e) {
        out.value = fileNames + ' 上传失败。';
    };

    xhr.open('post', '/upload');            // 发送表单对象。
    xhr.send(fd);
}

function SetStatusBar(str, delay) {
    var stb = $('#status-bar').text(str);
    window.setTimeout(function() {
        stb.text('');
    }, delay || 2000);
}

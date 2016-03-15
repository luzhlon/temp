// 获得一个XMLHttpRequest 对象
function getXHR() {
    /*
    if(typeof _xmlhttp != 'undefined') {
        return _xmlhttp;
    } // */
    var _xmlhttp;
    if (window.XMLHttpRequest) {
        // code for all new browsers
        _xmlhttp=new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        // code for IE5 and IE6
        _xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    if (_xmlhttp==null) {
        alert("Your browser does not support XMLHTTP.");
    }
    return _xmlhttp;
}
// 限制输入框所能输入的字符；filter为和要过滤的字符匹配的正则表达式
function FilterInput(input, filter) {
    var ctl = $(input);
    ctl.bind('input', function() {
        var text = ctl.attr('value');
        ctl.attr('value', text.replace(filter, ''));
    });
}
// 限制输入框只能输入数字
function LimitNumberInput(input) {
    FilterInput(input, /\D/);
}

function setUpload(fileSelc, options) {
    /* options:
     *   onchange(firstFileObj); return true upload, false not upload.
     *   onprogress(event)
     *   onresponse()
     *   onuploaded()
     *   onerror()
     *   fields : {}
     *   url :
     */
    $(fileSelc).bind('change', function() {
        var fileObject = this.files[0];
        options.onchange = options.onchange || function(){return true};
        if(options.onchange(fileObject)) {
            var xhr = getXHR();
            xhr.onreadystatechange = function() {
                if(xhr.readyState === 4 && xhr.status == 200) {
                    options.onresponse(xhr);
                }
            };
            xhr.upload.addEventListener( 'progress',
                options.onprogress, false); // false表示在事件冒泡阶段处理 */
            /* function uploadProgress(evt) {
             // evt 有三个属性：
             // lengthComputable – 可计算的已上传字节数
             // total – 总的字节数
             // loaded – 到目前为止上传的字节数 */
            xhr.upload.onload = options.onuploaded;
            xhr.upload.onerror = options.onerror;

            var formData = new FormData();
            for(var i in (options.fields || {}))
                formData.append(i, options.fields[i]);
            formData.append('_file', fileObject);
            xhr.open('post', options.url);    // 发送表单对象。
            xhr.send(formData);
        }
    });
}

function Request(uri, data, callback) {
    $.post(uri, data, function(reText) {
        try {
            var r = JSON.parse(reText);
            if(!r.success && r.reason=="PERMISSION_DENIED")
                alert("Permission denied.");
            else if(callback)
                callback(r);
        } catch (e) {
            console.log(e);
        }
    });
}

// Dependences: bootstrap
function ShowToolTip(sel, text, time, side) {
    var tip = $(sel).tooltip({
        placement: side || 'right',
        title: text,
        //content: text,
        trigger: 'manual'
    }).tooltip('show');
    setTimeout(function() {
        //tip.tooltip('hide');
        tip.tooltip('destroy')
    }, time || 1500);
}

function TableSelectedRow($table) {
    var index = $table.find('tr.success').data('index');
    return $table.bootstrapTable('getData')[index];
}
// 获取bootstrap表格中选择的id
function getIdSelections($table) {
    return $.map($table.bootstrapTable('getSelections'), function (row) {
        return row.id;
    });
}

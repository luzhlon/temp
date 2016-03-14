
g_image_frame = {
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
    }
};

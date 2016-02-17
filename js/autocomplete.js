/**
 * Created by john on 16-1-19.
 */

function AutoCompleter(input, cfg) {
    var target = $(input)
        .wrap('<div class="ac-frame"></div>')
        .after('<div class="ac-dropdown"></div>');

    var dropdown = $(target).next();
    var frame = $(target).parent();
    var self = this;

    frame.width(target.outerWidth());
    dropdown.width(target.outerWidth());

    target.bind('focus', function() {
        self.refreshOptions(true);
    }).bind('blur', function() {
        self.onblur();
    }).bind('keydown', function(event) {
        if(event.keyCode==13) {         // enter
            if(self.isShown()) {
                self.select();
            }
        } else if(event.keyCode==38) {  // up
            if(self.isShown()) {
                self.upActiveOption();
            }
        } else if(event.keyCode==40) {  // down
            if(self.isShown()) {
                self.downActiveOption();
            }
        } else {
            return true;
        }
        return false;
    }).bind('input', function(event) {
    //}).bind('keyup', function() {
        self.onchange(this);
    });

    var config = {
        maxShowItems: 50,   // Option最大显示数目
        onSelect : function(ctl, text) {
            ctl.target.val(text);
            ctl.showDropdown(false);
        }
    };
    $.extend(config, cfg);

    this.target = target;     // 目标控件
    this.dropdown = dropdown; // 下拉框
    this.frame = frame;       // 包裹控件的边框
    this.config = config;     // 配置
    this.option_table = {};   // 下拉框关联数组
    this.option_count = 0;    // option个数
    this.cur_option = null;   // 当前选中的选项

    this.showDropdown(false);
}
// 添加 Option
AutoCompleter.prototype.addOption = function(option) {
    if(this.option_table[option]) { return; }
    this.option_count++;
    this.option_table[option] = this.option_count;
    this.option_table[this.option_count] = option;
};
// 删除Option
AutoCompleter.prototype.delOption = function(option) {
    var key = this.option_table[option];
    if(key) {
        this.option_table[key] = null;
        this.option_table[option] = null;
    }
};
// 显示Dropdown
AutoCompleter.prototype.showDropdown = function(show) {
    if(typeof show == 'undefined') {
        this.dropdown.css('display', '');
        this.downActiveOption();
    } else if(show) {
        this.dropdown.css('display', '');
        this.downActiveOption();
    } else {
        this.cur_option = null;
        this.dropdown.css('display', 'none');
    }
};
// 刷新Dropdown
AutoCompleter.prototype.refreshOptions = function(show) {
    var self = this;
    this.dropdown.empty();
    var to_show = this.option_table;
    if(typeof show == 'object') {
        to_show = show;
    }
    for(var i = 1, n = 1; i <= this.option_count; i++) {
        var option = to_show[i];
        if(!option) { continue; }

        // 超过了最大显示数目
        if(n++ > this.config.maxShowItems) { break; }

        this.dropdown.append(
            $('<div class="ac-option-item"></div>')
                .text(to_show[i])
                .bind({
                    mouseenter: function() {
                        self.cur_option =
                            $(this).attr('class', 'ac-option-item-active');
                    },
                    mouseout: function() {
                        $(this).attr('class', 'ac-option-item');
                    },
                    mousedown: function() {
                        self.select();
                    }
                }));
    }
    if(show) {
        this.showDropdown();
    }
    // 选中第一个
    this.cur_option = this.dropdown
                          .children()
                          .first()
                          .attr('class', 'ac-option-item-active');
};
// 向上激活
AutoCompleter.prototype.upActiveOption = function() {
    var to_selct = null;
    if(this.cur_option == null) {    // 如果当前没有选中的，选最后一个子元素
        to_selct = this.dropdown.children().last();
    } else {
        var up = this.cur_option.prev();
        if(up.length != 0) {
            this.cur_option.attr('class', 'ac-option-item');
            to_selct = up;
        }
    }
    if(to_selct) {
        this.cur_option = to_selct;
        to_selct.attr('class', 'ac-option-item-active');
    }
};
// 向下激活
AutoCompleter.prototype.downActiveOption = function() {
    var to_selct = null;
    if(!this.cur_option) {    // 如果当前没有选中的，选最前一个子元素
        to_selct = this.dropdown.children().first();
    } else {
        var down = this.cur_option.next();
        if(down.length != 0) {
            this.cur_option.attr('class', 'ac-option-item');
            to_selct = down;
        }
    }
    if(to_selct) {
        this.cur_option = to_selct;
        to_selct.attr('class', 'ac-option-item-active');
    }
};
// Dropdown是否正在显示
AutoCompleter.prototype.isShown = function() {
    var show = this.dropdown.css('display');
    if(show == 'none') {
        return false;
    } else {
        return true;
    }
};
// 选择Option的动作
AutoCompleter.prototype.select = function() {
    //var callback = this.config.onSelect;
    var text = this.cur_option.text();
    var index = this.option_table[text];

    if(text && index) {
        var re = new RegExp('(.*[,\\s，、。或]+).*$');
        var ma = re.exec(this.target.val());

        if(ma) {
            this.target.val(ma[1] + text);
        } else {
            this.target.val(text);
        }
        //callback(this,text);
        // 与第一个交换位置
        var first = this.option_table[1];
        var selet = this.option_table[index];
        this.option_table[index] = first;
        this.option_table[first] = index;
        this.option_table[1] = selet;
        this.option_table[selet] = 1;
    }
};
// 分割
AutoCompleter.prototype.getSplit = function() {
    return this.target.val().split(/[,\s，、。或]+/);
};
// 失去焦点时
AutoCompleter.prototype.onblur = function() {
    this.showDropdown(false);

    var ss = this.getSplit();
    this.addOption(ss[ss.length-1]);
};
// 文本框内容改变时
AutoCompleter.prototype.onchange = function(input) {
    var to_show = {};
    var ss = this.getSplit();
    var key = input.value;

    if(ss.length > 0) {
        key = ss[ss.length - 1];
        if(ss.length > 1) // 添加倒数第二个到选项中
            this.addOption(ss[ss.length - 2]);
    }
    if(key == '') { to_show = this.option_table; }
    else {
        for(var i = 1; i <= this.option_count; i++) {
            // 如果有匹配，加入加入到to_show列表里
            if(this.option_table[i].indexOf(key) >= 0) {
                to_show[i] = this.option_table[i];
            }
        }
    }
    this.refreshOptions(to_show);
};

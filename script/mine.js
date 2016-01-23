/**
 * Created by tom on 16-1-15.
 */

/*
 * Dependence: jquery
 */

function getXHR()
{
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


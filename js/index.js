/**
 * Created by tom on 16-1-13.
 */

function onSubmit() {
    var name = document.getElementsByName("user_name")[0];
    var passwd = document.getElementsByName("user_passwd")[0];

    if("" == name.value) {
        alert("用户名不可以为空！");
        name.focus();
        return false;
    }
    if("" == passwd.value) {
        alert("请输入密码!");
        passwd.focus();
        return false;
    }

    passwd.value = $.md5(passwd.value);

    return true;
}

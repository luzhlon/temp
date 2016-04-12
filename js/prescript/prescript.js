// 所有的字段
g_fields = [ 'pres_name', 'book', 'source', 'version', 'page', 'image', 'pres_type', 'make_method', 'use_method', 'use_level', 'use_note', 'modern_name', 'mcure_name', 'mas_disease', 'mas_symptom', 'aux_symptom', 'mas_medicine', 'aux_medicine', 'sex', 'age', 'pulse_cond', 'tongue_coat', 'tongue_nature', 'tongue_body', 'first_second', 'region', 'season', 'cure_method', 'disease_reason', 'disease_mechsm', 'constituent', 'else_medicine' ];
// 字段显示名到字段名的映射
g_field_map = { pres_name : "方名", book : "著作", source : "出处", version : "版本", page : "页码", image : "原文图像", pres_type : "剂型", make_method : "剂型制法", use_method : "服法", use_level : "用量", use_note : "注意事项", modern_name : "现代病名", mcure_name : "主治中医病名", mas_disease : "主治证候", mas_symptom : "主治症状", aux_symptom : "兼症", mas_medicine : "君药", aux_medicine : "辅药", sex : "性别", age : "年龄", pulse_cond : "脉象", tongue_coat : "舌苔", tongue_nature : "舌质", tongue_body : "舌体", first_second : "初诊复诊", region : "地区", season : "季节", cure_method : "治法", disease_reason : "病因", disease_mechsm : "病机", constituent : "方剂组成", else_medicine : "加减法" };
// 所有的方剂录入控件
g_prescript = {}; for(var i in g_fields) { var key = g_fields[i]; var val = $('[name="' + key + '"]'); if(!val) alert(key); g_prescript[key] = val; }
// 设置字段名到字段显示名的映射
for(var key in g_field_map) { var val = g_field_map[key]; g_field_map[val] = key; }


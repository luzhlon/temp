<%@ page import="com.luzhlon.Global" %>
<%@ page import="com.mysql.jdbc.StringUtils" %>
<%@ page import="com.tool.Prescription" %>
<%@ page import="com.tool.DBObject" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.tool.DB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>统计结果</title>
</head>
<body>

<%
    String type = request.getParameter(Global.TYPE);
    if (StringUtils.isNullOrEmpty(type))
        return;
    Prescription pres =
            (Prescription) DBObject.GetSessionInst(request, Global.PRESCRIPTION);
    ResultSet rs =
        DB.executeQuery(
                "SELECT constituent FROM prescription" +
                        pres.GetConditionSql(request));
    switch (type) {
        case "medicine-rate":
            break;
        case "all-medicine-rate":
            break;
        case "like-degree":
            break;
    }
%>

</body>
</html>

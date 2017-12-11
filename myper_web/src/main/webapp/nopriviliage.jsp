<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basepath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
function goback(){
	history.back();
}
</script>
</head>
<body>
<h3>对不起，您没有权限进行当前操作，请联系管理员或者选择其他操作</h3>
<p>您还可以选择<a href="javascript:goback();">后退</a>回到上一个页面</p>
</body>
</html>
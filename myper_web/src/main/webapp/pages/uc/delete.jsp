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
<script type="text/javascript" src="js/jquery-1.8.3.js" ></script>
<script type="text/javascript">
$(function(){
	console.log($("#flag").val());
	if($("#flag").val()=="true"){
		
		$("#showmsg").html("删除成功");
	}
	if($("#flag").val()=="false"){
		$("#showmsg").html("删除失败");
	}
});

</script>
</head>
<body>
<input type="hidden" id="flag" name="flag" value="${flag}"/>
<h3 id="showmsg"></h3>
<span><a href="uc/findusersplit">返回</a>主页面。。。</span>
</body>
</html>
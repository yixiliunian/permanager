<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String path = request.getContextPath();
	String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basepath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>变更用户角色</title>
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="js/lhgdialog/lhgdialog.js"></script>
<script type="text/javascript">
var DG = frameElement.lhgDG;
DG.addBtn("makesure","确定",makesure);
function makesure(){
	//alert("确定");
	
	//ajax提交请求到后台，完成角色变更的工作
	//后台处理完毕后，在ajax的回调函数中，关闭子窗口：
	//DG.curWin.location.reload();//关闭子窗口并刷新父页面
	DG.cancel();//直接退出子窗口
}

</script>
</head>
<body >
<form>
	<input type="hidden" value="${userinfo.userid }" name="userid" id="userid" />
	用户名：<input type="text" readonly="readonly" name="realname" value="${userinfo.realname }"/><br/>
	密码：<input type="password" readonly="readonly" name="loginpwd" value="${userinfo.loginpwd}"/><br/>
	邮箱：<input  type="text" readonly="readonly" name="email" value="${userinfo.email }"/><br/>
	用户状态：<input  type="text" readonly="readonly" name="userStatus" value="${userinfo.userStatus=='0'?'在职':(userinfo.userStatus=='1'?'休假':'离职') }"><br/>
	部门：<input  type="text" readonly="readonly" value="${userinfo.dept.dname }"/><br/>
	岗位：<input  type="text" readonly="readonly" value="${userinfo.role.roleCn}"/><br/>
	用户照片：<img alt="" src="upload/${userinfo.picpath}" width="100" height="100" border="1"><br/>
	简介：<textarea readonly="readonly">${userinfo.userDesc }</textarea>
</form>

</body>
</html>
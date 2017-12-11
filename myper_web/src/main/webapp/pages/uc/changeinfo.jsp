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
$(function(){
	//加载部门信息
	$.post("dc/findalldept",{},function(data){
		$.each(data,function(i,n){
			$("#deptno").append("<option value='"+n.deptno+"'>"+n.dname+"</option>");
		});
	},"json");
	//这里，还需要通过ajax来查询所有角色信息
	$.post("rc/findallrole",{},function(data){
		$.each(data,function(i,n){
			$("#roleid").append("<option value='"+n.roleid+"'>"+n.roleCn+"</option>");
		});
	},"json");
	
	//判断是否修改成功
	if($("#flag").val()=="true"){
		alert("修改成功");
		DG.curWin.location.reload();
	}
	if($("#flag").val()=="false"){
		alert("修改失败");
		DG.curWin.location.reload();
	}
});

function makesure(){
	//alert("确定");
	//ajax提交请求到后台，完成角色变更的工作
	//后台处理完毕后，在ajax的回调函数中，关闭子窗口：
	//DG.curWin.location.reload();//关闭子窗口并刷新父页面
	//DG.cancel();//直接退出子窗口
	$("#changeform").submit();
}

</script>
</head>
<body >
<form action="uc/changeinfo" id="changeform" method="post">
	<input type="hidden" value="${userinfo.userid }" name="userid" id="userid" />
	<input type="hidden" id="flag" value="${flag }"/>
	密码：<input type="password" name="loginpwd" value="${userinfo.loginpwd}"/><br/>
	用户名：<input type="text" name="realname" value="${userinfo.realname }"/><br/>
	邮箱：<input type="text" name="email" value="${userinfo.email }"/><br/>
	用户状态：
	<select name="userStatus" >
		<option value="0" ${userinfo.userStatus=='0'? 'selected':''}>在职</option>
		<option value="1" ${userinfo.userStatus=='1'? 'selected':''}>休假</option>
		<option value="2" ${userinfo.userStatus=='2'? 'selected':''}>离职</option>
    </select><br/>
	部门：<select id="deptno" name="dept.deptno" ></select><br/>
	岗位：<select id="roleid" name="role.roleid" ></select><br/>
	用户照片：<img alt="" src="upload/${userinfo.picpath}" width="100" height="100" border="1"><br/>
	简介：<textarea id="userDesc" name="userDesc">${userinfo.userDesc }</textarea>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basepath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>用户添加页面</title>
<link rel="stylesheet" rev="stylesheet" href="css/style.css" type="text/css" media="all" />
<script language="JavaScript" type="text/javascript">
function tishi()
{
  var a=confirm('数据库中保存有该人员基本信息，您可以修改或保留该信息。');
  if(a!=true)return false;
  window.open("冲突页.htm","","depended=0,alwaysRaised=1,width=800,height=400,location=0,menubar=0,resizable=0,scrollbars=0,status=0,toolbar=0");
}

function check()
{
document.getElementById("aa").style.display="";
}

</script>
<style type="text/css">
<!--
.atten {font-size:12px;font-weight:normal;color:#F00;}
-->
.check_off{
		color:red;
		font-weight:bold;
	}
</style>

<script type="text/javascript" src="js/jquery-1.8.3.js" ></script>
<script type="text/javascript" src="js/uploadPreView.js" ></script>
<script type="text/javascript">
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
	//图片上传预览
	new uploadPreview({ UpBtn: "pic", DivShow: "imgdiv", ImgShow: "imgShow" });
	//验证用户名
	$("#loginname").blur(checkname);
	//验证密码
	$("#loginpwd").blur(checkpwd);
	//确认密码
	$("#repwd").blur(checkrepwd);
	//验证邮箱
	$("#email").blur(checkemail);
	//判断保存成功与否
	if($("#flag").val()=="true"){
		alert("保存成功");
	}
	if($("#flag").val()=="false"){
		alert("保存失败");
	}
	
});
function checkname(){
	var reg=/^[a-zA-Z_]\w{5,15}$/;
	if(!reg.test($("#loginname").val())){
		$("#loginnameinfo").html("格式不正确");
		$("#loginnameinfo").addClass("check_off");
		return false;
	}
	$("#loginnameinfo").html("格式正确");
	$("#loginnameinfo").removeClass("check_off");
	return true;
}

function checkpwd(){
	if($("#loginpwd").val()==""||$("#loginpwd").val()==null){
		$("#pwdinfo").html("密码不能为空");
		$("#pwdinfo").addClass("check_off");
		return false;
	}
	$("#pwdinfo").html("密码可行");
	$("#pwdinfo").removeClass("check_off");
	return true;
}
function checkrepwd(){
	if($("#repwd").val()!=$("#loginpwd").val()){
		$("#repwdinfo").html("两次密码输入不一样");
		$("#repwdinfo").addClass("check_off");
		return false;
	}
	$("#repwdinfo").html("密码一致");
	$("#repwdinfo").removeClass("check_off");
	return true;
}
function checkemail(){
	var reg1 = /^[1-9]\d{5,15}[@][qQ][qQ][.][cC][oO][mM]$/;
	var reg2 = /^[a-zA-Z]\w{5,17}[@][1][6][3][.][cC][oO][mM]$/;
	if(!reg1.test($("#email").val())&&!reg2.test($("#email").val())){
		$("#emailinfo").html("格式不正确");
		$("#emailinfo").addClass("check_off");
		return false;
	}
	$("#emailinfo").html("格式正确");
	$("#emailinfo").removeClass("check_off");
	return true;
}
//保存
function link(){
	if(checkname()&&checkpwd()&&checkrepwd()&&checkemail()){
		 document.getElementById("fom").action="uc/add";
		 document.getElementById("fom").submit();
	}
}
//返回
function backpage(){
	document.getElementById("fom").action="uc/findusersplit";
	document.getElementById("fom").submit();
}
</script>




</head>

<body class="ContentBody">
<form action="" method="post" enctype="multipart/form-data" name="fom" id="fom">
<div class="MainDiv">
<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  <tr>
      <th class="tablestyle_title" >用户添加页面</th>
  </tr>
  <tr>
    <td class="CPanel">
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">
			<tr>
				<td align="left"> 
					<input type="button" name="saveuser" value="保存" class="button" onclick="link();"/>　
					<input type="button" name="goback" value="返回" class="button" onclick="backpage();"/>
					<input type="hidden" id="flag" name="flag" value="${flag}"/>
				</td>
			</tr>
			<tr>
				<td width="100%">
					<fieldset style="height:100%;">
						<legend>添加用户</legend>
					  	<table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					  		<tr>
					    		<td nowrap align="right" width="13%">账户名称:</td>
					    		<td width="41%">
					    			<input id="loginname" name="loginname" class="text" style="width:154px" type="text" size="40" />
				        			<span id="loginnameinfo">用户名必须是字母，数字，_的组合,长度必须在6-16位之间</span>
				        			<span class="red"> *</span>
				        		</td>
					    		<td align="right" width="19%">真实姓名:</td>
					    		<td width="27%">
					    			<input name="realname" id="realname" class="text" style="width:154px" />
					    		</td>
					    	</tr>
					  		<tr>
					    		<td nowrap align="right">密码:</td>
					    		<td>
					    			<input name="loginpwd" type="password" id="loginpwd" class="text" style="width:154px" />
					    			<span id="pwdinfo"></span>
					    		</td>
					    		<td align="right">邮箱:</td>
					    		<td>
					    			<input name="email" id="email" class="text" style="width:154px" />
					    			<span id="emailinfo">邮箱格式为QQ邮箱或者163邮箱</span>
					    		</td>
					  		</tr>
					   		<tr>
					    		<td nowrap align="right">确认密码:</td>
					    		<td>
					    			<input name="repwd" type="password" id="repwd" class="text" style="width:154px" />
                        			<span id="repwdinfo"></span>
                        		</td>
					    		<td align="right">用户状态:</td>
					    		<td>
					    		<select name="userStatus" >
			                          <!-- <option  selected="selected">==请选择==</option> -->
			                          <option value="0" selected="selected">在职</option>
			                          <option value="1">休假</option>
			                          <option value="2">离职</option>
                        		</select>
                        		</td>
					  		</tr>
					  		<tr>
					    		<td nowrap align="right">部门:</td>
					    		<td>
					    			<select id="deptno" name="dept.deptno" >
			                          <option  selected="selected">==请选择==</option>
                        			</select>
                        		</td>
					    		<td align="right">用户岗位:</td>
					    		<td>
					    			<select id="roleid" name="role.roleid" >
			                          <option  selected="selected">==请选择==</option>
                        			</select>
                        		</td>
					  		</tr>
					  		<tr>
					    		<td nowrap align="right">用户照片:</td>
					    		<td>
					    			<input name="pic" type="file" id="pic" class="text" style="width:154px" />
					    		</td>
					    		<td colspan="2">
					    			<div id="imgdiv"><img id="imgShow" width="60" height="60"/></div>
					    		</td>
					  		</tr>
					  		<tr>
					    		<td nowrap align="right" height="120px">简介:</td>
					    		<td colspan="3">
					    			<textarea id="userDesc" name="userDesc" rows="5" cols="80"></textarea>
					    		</td>
					    	</tr>
					  	</table>
			 			<br />
					</fieldset>			
				</td>
			</tr>
		</table>
	 </td>
  </tr>
  <tr>
	<td colspan="2" align="center" height="50px">
		<input type="button" name="Submit" value="保存" class="button" onclick="link();"/>　
		<input type="button" name="Submit2" value="返回" class="button" onclick="backpage();"/>
	</td>
  </tr>
</table>
</div>
</form>
</body>
</html>

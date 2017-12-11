<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String path = request.getContextPath();
	String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basepath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>用户列表页面</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.tabfont01 {	
	font-family: "宋体";
	font-size: 9px;
	color: #555555;
	text-decoration: none;
	text-align: center;
}
.font051 {font-family: "宋体";
	font-size: 12px;
	color: #333333;
	text-decoration: none;
	line-height: 20px;
}
.font201 {font-family: "宋体";
	font-size: 12px;
	color: #FF0000;
	text-decoration: none;
}
.button {
	font-family: "宋体";
	font-size: 14px;
	height: 37px;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 
-->
</style>

<link href="css/css.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">

</script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.8.3.js" ></script>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css"/>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<script language="javascript">

function selectAll(){
	var obj = document.fom.elements;
	for (var i=0;i<obj.length;i++){
		if (obj[i].name == "delid"){
			obj[i].checked = true;
		}
	}
}

function unselectAll(){
	var obj = document.fom.elements;
	for (var i=0;i<obj.length;i++){
		if (obj[i].name == "delid"){
			if (obj[i].checked==true) obj[i].checked = false;
			else obj[i].checked = true;
		}
	}
}

function link(){
    document.getElementById("fom").action="uc/adduser";
   	document.getElementById("fom").submit();
}

function changeinfo(msg){
	/* $("#dlg").dialog({
		width:"400",
		height:"200",
		title : "修改角色窗口",
		buttons:[{
			text:'保存',
			handler:function(){alert("save");}
		},{
			text:'关闭',
			handler:function(){alert("close");}
		}]
	});  */
	parent.parent.changeinfo(msg);
}
function showinfo(msg) {
	parent.parent.showinfo(msg);
}
</script>

</head>
<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30">      
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
        		<!-- 搜索部分开始 -->
          		<td height="62" background="images/nav04.gif">
		   			<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    			<tr>
			  				<td width="21"><img src="images/ico07.gif" width="20" height="18" /></td>
			  				<td width="538">查看内容：按时间：
								<input name="textfield" type="text" size="12" readonly="readonly"/>
								<span class="newfont06">至</span>
								<input name="textfield" type="text" size="12" readonly="readonly"/>
								<input name="Submit4" type="button" class="right-button02" value="查 询" />
							</td>
			   				<td width="144" align="left">
			   					<a href="#" onclick="sousuo()"> <input name="Submit3" type="button" class="right-button07" value="高级搜索" /></a>
			   				</td>	
		    			</tr>
          			</table>
          		</td>
          		<!-- 搜索部分结束 -->
        	</tr>
    	</table>
    </td>
   </tr>
  <tr>
    <td>
    	<table id="subtree1" style="DISPLAY: " width="100%" border="0" cellspacing="0" cellpadding="0">
        	<tr>
          		<td>
          			<form name="fom" id="fom" method="post">
          			<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          	 			<tr>
               				<td height="20">
               					<span class="newfont07">选择：
               						<a href="javascript:void(0);" class="right-font08" onclick="selectAll();">全选</a>
               						-<a href="javascript:void(0);" class="right-font08" onclick="unselectAll();">反选</a>
               					</span>
	              				<input name="deleteuser" type="button" class="right-button08" value="删除所选用户" />
	              				<input name="adduser" type="button" class="right-button08" value="添加用户" onclick="link();"/>
	              			</td>
          	 			</tr>
          	 			<!-- 表格部分开始 -->
              			<tr>
                			<td height="40" class="font42">
								<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#464646" class="newfont03">
				 					<tr class="CTitle" >
                    					<td height="22" colspan="7" align="center" style="font-size:16px">用户详细列表</td>
                  					</tr>
                  					<tr bgcolor="#EEEEEE">
				    					<td width="4%" align="center" height="30">选择</td>
                    					<td width="10%">账户</td>
										<td width="10%">真实姓名</td>
                    					<td width="10%">部门</td>
										<td width="10%">简介</td>
										<td width="5%">状态</td>
										<td width="12%">操作</td>
                  					</tr>
	                  				<c:forEach items="${userlist }" var="ul">
					                  <tr bgcolor="#FFFFFF">
									    <td height="20"><input type="checkbox" id="delid" value="${ul.userid }" name="delid"/></td>
					                    <td ><a href="listmokuaimingxi.htm" onclick=""></a>${ul.loginname }</td>
										<td>${ul.realname }</td>
					                    <td>${ul.dept.dname }</td>
					                    <td>
					                    ${fn:substring(ul.userDesc,0,12) }
					                    ${fn:length(ul.userDesc)>12?"...":"" }
					                    </td>
					                    <td>${ul.userStatus=="0"?"在职":(ul.userStatus=="1"?"休假":"离职") }</td>
					                    <td>
					                    	<a href="javascript:changeinfo('${ul.loginname}');">编辑|</a>
					                   	 	<a href="javascript:showinfo('${ul.loginname}');">查看|</a>
											<a href="uc/deleteuser?userid=${ul.userid }" onclick="return window.confirm('你确定要删除该用户');">删除</a>
										</td>
					                  </tr>
					                 </c:forEach>
            					</table>
            				</td>
        				</tr>
        				<!-- 表格部分结束 -->
      				</table>
      				</form>
      				<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        				<tr>
          					<td height="6"><img src="images/spacer.gif" width="1" height="1" /></td>
        				</tr>
        				<tr>
          					<td height="33">
          						<!-- 分页部分开始 -->
          						<jsp:include page="/pages/frame/split.jsp" >
          							<jsp:param value="uc/findusersplit" name="myurl"/>
          						</jsp:include>
          						<!-- 分页部分结束 -->
          					</td>
        				</tr>
      				</table>
      			</td>
  			</tr>
		</table>
	</td>
</tr>
</table>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<html>
<head>
<base href="<%=basepath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>左边菜单页面</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(images/left.gif);
}
-->
</style>
<link href="css/css.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	$(function(){
		//单击父菜单显示隐藏子菜单，并且改变父菜单前黑三角的样式
		$(".firstmenu").click(function(){
			var allchildtb = $(".left-table02");
			var pid = $(this).attr("id");
			var childtb = $("#subtree_"+pid.split("_")[1]);
			var img = $("#img_"+pid.split("_")[1]);
			if(childtb.css("display")=="none"){
				for(var i=0;i<allchildtb.length;i++){
					$(allchildtb[i]).css("display","none");
					var cid = $(allchildtb[i]).attr("id");
					$("#img_"+cid.split("_")[1]).attr("src","images/ico04.gif");
				}
				childtb.css("display","");
				img.attr("src","images/ico03.gif");
			}else{
				childtb.css("display","none");
				img.attr("src","images/ico04.gif");
			}
		});
		//单击子菜单，需要修改子菜单前面的图片样式
		$(".childmenu").click(function(){
			var allchild = $(".childmenu");
			for(var i=0;i<allchild.length;i++){
				if($(this).html()==$(allchild[i]).html()){
					$(this).parent().prev().children("img").attr("src","images/ico05.gif");
				}else{
					$(allchild[i]).parent().prev().children("img").attr("src","images/ico06.gif");
				}
			}
		});
		
	});
</script>
<body>
<table width="198" border="0" cellpadding="0" cellspacing="0" class="left-table01">
  <tr>
    <TD>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<td width="207" height="55" background="images/nav01.gif">
				<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
				  <tr>
					<td width="25%" rowspan="2"><img src="images/ico02.gif" width="35" height="35" /></td>
					<td width="75%" height="22" class="left-font01">您好，<span class="left-font02">${sessionScope.user.realname }</span></td>
				  </tr>
				  <tr>
					<td height="22" class="left-font01">
						[&nbsp;<a href="uc/logout" target="_top" class="left-font01">退出</a>&nbsp;]</td>
				  </tr>
				</table>
			</td>
		  </tr>
		</table>
		
		<!--  任务系统开始    -->
		<c:forEach items="${sessionScope.user.role.prilist }" var="first" varStatus="p" >
		<c:if test="${first.parentid==0 }">
		<TABLE width="100%" border="0" cellpadding="0" cellspacing="0" class="left-table03">
          <tr>
            <td height="29">
				<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="8%"><img name="img_${p.count}" id="img_${p.count}" src="images/ico04.gif" width="8" height="11" /></td>
						<td width="92%">
								<a href="javascript:void(0);" target="mainFrame" class="left-font03 firstmenu" id="first_${p.count }"  >${first.priName }</a></td>
					</tr>
				</table>
			</td>
          </tr>		  
        </TABLE>
		
		<table id="subtree_${p.count}" style="display:none;" width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="left-table02">
			<c:forEach items="${sessionScope.user.role.prilist }" var="child">
			<c:if test="${child.parentid==first.priid }">
			<tr>
				<td width="9%" height="20" ><img  src="images/ico06.gif" width="8" height="12" /></td>
				<td width="91%"><a href="${child.priUrl }" target="mainFrame" class="left-font03 childmenu"  >${child.priName }</a></td>
			</tr>
			</c:if>
			</c:forEach>
      </table>
      
      </c:if>
      </c:forEach>
		<!--  任务系统结束    -->


		
    </TD>
  </tr>
</table>
</body>
</html>


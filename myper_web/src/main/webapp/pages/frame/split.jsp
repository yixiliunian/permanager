<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
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
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.3.js" ></script>
<script>
$(function(){
	//单击首页
	$("#firstpage").click(function(){
		splitform.cp.value = 1;
		splitform.submit();
	});
	
	//上一页
	$("#prepage").click(function(){
		var cp = parseInt(splitform.cp.value);
		if(cp>1){
			splitform.cp.value = cp-1;
			splitform.submit();
		}else{
			alert("已经是第一页了");
		}
	});
	
	//下一页
	$("#nextpage").click(function(){
		var allpage = parseInt(splitform.allpage.value);
		var cp = parseInt(splitform.cp.value);
		if(cp<allpage){
			splitform.cp.value = cp+1;
			splitform.submit();
		}else{
			alert("已经是最后一页了");
		}
	});
	
	//尾页
	$("#lastpage").click(function(){
		var allpage = parseInt(splitform.allpage.value);
		splitform.cp.value = allpage;
		splitform.submit();
	});
	
	//go提交
	$("#sbt").click(function(){
		var allpage = parseInt(splitform.allpage.value);
		var mypage = splitform.mypage.value;
		
		var reg = /^\d+$/;
		if(reg.test(mypage)&&parseInt(mypage)>0&&parseInt(mypage)<=allpage){
			splitform.cp.value = mypage;
			splitform.submit();
		}else{
			$("#mypage").val("");
			alert("页码输入不合法");
			$("#mypage").focus();
		}
	});
});
</script>
</head>
<body>
<form name="splitform" id="splitform" action="${myurl }" method="post" >
    <input type="hidden" value="${cp }" name="cp" id="cp" />
	<input type="hidden" value="${ps }" name="ps" id="ps" />
	<input type="hidden" value="${count }" name="count" id="count" />
	<input type="hidden" value="${allpage }" name="allpage" id="allpage" />
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="right-font08">
		<tr>
			<td width="50%">
				共 <span class="right-text09">${allpage }</span> 页 | 
				第 <span class="right-text09">${cp }</span> 页
			</td>
			<td width="49%" align="right">
				[<a href="javascript:void(0);" id="firstpage" class="right-font08">首页</a> | 
				<a href="javascript:void(0);" id="prepage" class="right-font08">上一页</a> | 
				<a href="javascript:void(0);" id="nextpage" class="right-font08">下一页</a> | 
				<a href="javascript:void(0);" id="lastpage" class="right-font08">末页</a>] 转至：
			</td>
			<td width="1%">
				<table width="20" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="1%">
							<input name="mypage" id="mypage" type="text" class="right-textfield03" size="1" />
						</td>
						<td width="87%">
							<input name="Submit23222" id="sbt" type="button" class="right-button06" value=" " />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.vo.VIP"%>
<%@page import="com.shxt.dao.VIPDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javaScript">
	function submitBt() {

		var btn = document.getElementById("btn");
		var name = document.getElementById("name");
		var home = document.getElementById("home");

		if (name.value == "") {
			alert("姓名为空");
			username.focus();
			return;
		}
		if (home.value == "") {
			alert("地址为空");
			home.focus();
			return;
		}
		btn.type = "submit";
	}
</script>

<%
	String idString = request.getParameter("id");
	int id = Integer.parseInt(idString);
	VIP vip = VIPDao.getInstance().getVipById(id);
	vip.id = id;
%>
</head>

<body>


	<div class="formbody">

		<div class="formtitle">
			<span>会员信息信息</span>
		</div>
		<br /> <br /> <br />

		<form id="form" action="jspdo/updateVipDo.jsp" method="post">
			<input type="hidden" name="id" value="<%=vip.id%>" />
			<ul class="forminfo">
				<li><label>姓名</label><input id="name" name="name" type="text"
					class="dfinput" value="<%=vip.name%>" /><i>不能超过10个字符</i></li>
				<li><input type="hidden" name="id" value="<%=vip.id%>" /></li>
				<li><label>地址</label><input id="home" name="home" type="text"
					class="dfinput" value="<%=vip.home%>" /><i>不能超过50个字符</i></li>
				<li><label>&nbsp;</label><input id="btn" type="button"
					onclick="submitBt();" class="btn" value="确认保存" /></li>
			</ul>
		</form>
	</div>
</body>

</html>

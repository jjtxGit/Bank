<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javaScript">
	function submitBt() {

		var btn = document.getElementById("btn");
		var name = document.getElementById("name");
		var home = document.getElementById("home");

		if (name.value == "") {
			alert("会员名为空");
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
</head>

<body>


	<div class="formbody">

		<div class="formtitle">
			<span>基本信息</span>
		</div>
		<br /> <br /> <br />

		<form id="form" action="jspdo/addVipDo.jsp" method="post">

			<ul class="forminfo">
				<li><label>员工姓名<b>*</b></label><input id="name" name="name"
					type="text" class="dfinput" /><i>不超过30个字符</i></li>
				<li><label>地址</label><input id="home" name="home" type="text"
					class="dfinput" /><i>不超过200个字符</i></li>
				<li><label>&nbsp;</label><input id="btn" type="button"
					onclick="submitBt();" class="btn" value="添加" /></li>
			</ul>
		</form>

	</div>


</body>

</html>

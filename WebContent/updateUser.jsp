<%@page import="com.shxt.vo.User"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<%
	String idString = request.getParameter("id");
	int id = Integer.parseInt(idString);
	UserDao userDao = UserDao.getInstance();
	User user = userDao.getUserById(id);
	user.id = id;
%>
<script type="text/javaScript">
	function submitBt() {
		var pw = document.getElementById("password");
		var rpw = document.getElementById("repassword");
		var btn = document.getElementById("btn");

		var username = document.getElementById("username");
		var home = document.getElementById("home");
		var salary = document.getElementById("salary");

		if (username.value == "") {
			alert("用户名为空");
			username.focus();
			return;
		}

		if (home.value == "") {
			alert("籍贯为空");
			home.focus();
			return;
		}

		if (isNaN(salary.value)) {
			alert("薪资错误");
			salary.value = "";
			salary.focus();
			return;
		}

		var password = pw.value;
		var repassword = rpw.value;

		if (password != repassword) {
			pw.value = "";
			rpw.value = "";
			alert("两次的密码不相同，请重新输入");
			pw.focus();
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

		<form id="form" action="jspdo/updateUserdo.jsp" method="post">

			<ul class="forminfo">
				<li><input name="id" type="hidden" value="<%=user.id%>" /></li>

				<li><label>用户名</label><input id="username" name="username"
					type="text" class="dfinput" value="<%=user.userName%>" /><i>用户名不能是汉字，不能超过30个字符</i></li>

				<li><label>密码</label><input id="password" name="password"
					type="password" class="dfinput" /><i>不能是汉字</i></li>
				<li><label>确认密码</label><input id="repassword" name="repassword"
					type="password" class="dfinput" /><i>不能是汉字</i></li>
				<li><label>籍贯</label><input id="home" name="home" type="text"
					value="<%=user.home%>" class="dfinput" /></li>

				<li><label>薪资</label><input id="salary" name="salary"
					value="<%=user.salary%>" type="text" class="dfinput" /></li>

				<li><label>权限&nbsp;</label><input value="2" name="power"
					type="radio" checked="checked" />管理员&nbsp;&nbsp;&nbsp;<input
					value="1" name="power" type="radio" />收银员</li>

				<li><label>&nbsp;</label><input id="btn" type="button"
					onclick="submitBt();" class="btn" value="确认保存" /></li>
			</ul>
		</form>

	</div>


</body>

</html>

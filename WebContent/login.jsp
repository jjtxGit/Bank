<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.dao.BankDao"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	BankDao bankDao = BankDao.getInstance();
	bankDao.deleteAll();
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>超市管理系统</title>
<link href="<%=basePath%>css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=basePath%>js/jquery.js"></script>
<script src="<%=basePath%>js/cloud.js" type="text/javascript"></script>

<script language="javascript">
	$(function() {
		$('.loginbox').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		})
	});
</script>

</head>

<body
	style="background-color: #1c77ac; background-image: url(<%=basePath%>images/light.png); background-repeat: no-repeat; background-position: center top; overflow: hidden;">

	<div id="mainBody">
		<div id="cloud1" class="cloud"></div>
		<div id="cloud2" class="cloud"></div>
	</div>


	<div class="logintop">
		<span>欢迎登录超市管理系统</span>

	</div>

	<div class="loginbody">
		<br /> <br /> <br /> <br /> <br />

		<div class="loginbox">
			<%
				String msg = request.getParameter("msg");
				msg = msg == null ? "" : "登陆名或者密码错误";
			%>
			<form action="jspdo/logindo.jsp" method="post">
				<ul>
					<li><input id="username" name="username" type="text"
						class="loginuser" /></li>
					<li><input id="password" name="password" type="password"
						class="loginpwd" /></li>

					<font color="red"><%=msg%></font>

					<li></li>
					<li><input type="submit" value="登陆" class="loginbtn" />
				</ul>


			</form>


		</div>

	</div>



	<div class="loginbm">
		版权所有 2016 <a href="http://www.mycodes.net">四海兴唐</a>
	</div>

</body>

</html>

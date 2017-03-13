<%@page import="com.shxt.vo.LoginRec"%>
<%@page import="com.shxt.dao.LoginRecDao"%>
<%@page import="org.eclipse.jdt.internal.compiler.batch.Main"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@page import="com.shxt.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	UserDao userDao = UserDao.getInstance();
	boolean result = userDao.verUser(userName, password);
	if (result) {
		
		LoginRecDao loginRecDao = LoginRecDao.getInstance();
		LoginRec loginRec = new LoginRec();
		
		session.setAttribute("username", userName);
		int power = userDao.getPower(userName);
		
		switch (power) {
		case 1:

			loginRec.setLoginName(userName);
			loginRec.setPower(1);
			loginRecDao.addRec(loginRec);

			response.sendRedirect("../bank.html");

			break;
		//boss权限
		case 2:

			loginRecDao = LoginRecDao.getInstance();
			loginRec = new LoginRec();
			loginRec.setLoginName(userName);
			loginRec.setPower(2);
			loginRecDao.addRec(loginRec);

			response.sendRedirect("../main.html");

			break;

		}

	} else {
		response.sendRedirect("../login.jsp?msg=aa");
	}
%>
</head>
<body>

</body>
</html>
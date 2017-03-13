<%@page import="com.shxt.dao.WorkerRecDao"%>
<%@page import="com.shxt.vo.WorkerRec"%>
<%@page import="com.shxt.vo.User"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("../Error.html");
		return;
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	UserDao userDao = UserDao.getInstance();
	User user = new User();
	String userName = request.getParameter("username");
	String password = request.getParameter("password");
	String home = request.getParameter("home");

	String salaryString = request.getParameter("salary");
	String powerString = request.getParameter("power");

	int salary = Integer.parseInt(salaryString);
	int power = Integer.parseInt(powerString);

	user.userName = userName;
	user.password = password;
	user.home = home;
	user.salary = salary;
	user.power = power;
	user.chageCode();

	userDao.createUser(user);

	WorkerRec workerRec = new WorkerRec();
	workerRec.setType(1);//1表示添加

	String username = (String) session.getAttribute("username");
	workerRec.setUser(username);
	String des = username + "添加了员工" + userName;
	workerRec.setDes(des);
	WorkerRecDao.getInstance().addRec(workerRec);

	response.sendRedirect("../showuser.jsp");
%>


</head>
<body>

</body>
</html>
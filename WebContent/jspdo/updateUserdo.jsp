<%@page import="com.shxt.dao.WorkerRecDao"%>
<%@page import="com.shxt.vo.WorkerRec"%>
<%@page import="com.shxt.vo.User"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@page import="org.omg.PortableServer.ID_ASSIGNMENT_POLICY_ID"%>
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
	String idString = request.getParameter("id");
	int id = Integer.parseInt(idString);
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

	userDao.updateUserInfoById(id, user);

	
	WorkerRec workerRec = new WorkerRec();
	workerRec.setType(2);//2表示修改

	String username = (String) session.getAttribute("username");
	workerRec.setUser(username);
	String des = username + "修改了员工" + userName+"的信息";
	workerRec.setDes(des);
	WorkerRecDao.getInstance().addRec(workerRec);

	response.sendRedirect("../showuser.jsp");
%>
</head>
<body>

</body>
</html>
<%@page import="com.shxt.dao.WorkerRecDao"%>
<%@page import="com.shxt.vo.WorkerRec"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("../Error.html");
		return;
	}
%>
<%
	String idString = request.getParameter("id");
	int id = Integer.parseInt(idString);
	UserDao userDao = UserDao.getInstance();
	String username = userDao.getUserNameById(id);
	userDao.dorpUser(username);

	WorkerRec workerRec = new WorkerRec();
	workerRec.setType(3);//3表示删除

	String username2 = (String) session.getAttribute("username");
	workerRec.setUser(username2);
	String des = username2 + "删除了员工" + username + "的信息";
	workerRec.setDes(des);
	WorkerRecDao.getInstance().addRec(workerRec);

	response.sendRedirect("../showuser.jsp");
%>
</head>
<body>

</body>
</html>
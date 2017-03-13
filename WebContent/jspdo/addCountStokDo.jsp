<%@page import="com.shxt.dao.GoodOfStorDao"%>
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
	String addCountString = request.getParameter("count");

	int id = Integer.parseInt(idString);
	int addCount = Integer.parseInt(addCountString);

	GoodOfStorDao goodOfStorDao = GoodOfStorDao.getInstance();
	int count = goodOfStorDao.getCountById(id);
	count += addCount;
	goodOfStorDao.updateCountByid(id, count);
	response.sendRedirect("../showStok.jsp?flage=page&page=1");
%>
</head>
<body>

</body>
</html>
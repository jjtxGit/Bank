<%@page import="com.shxt.dao.VIPDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("../Error.html");
		return;
	}
%>
</head>
<body>
	<%
		String vipIdString = request.getParameter("vipid");
		System.out.println(vipIdString);
		int vipId = Integer.parseInt(vipIdString);
		response.sendRedirect("../BankButtom.jsp?flage=false&id=" + vipId );
	%>

</body>
</html>
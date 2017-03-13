<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.duo.Code"%>
<%@page import="com.shxt.dao.VipRecDao"%>
<%@page import="com.shxt.vo.VipRec"%>
<%@page import="com.shxt.vo.VIP"%>
<%@page import="com.shxt.dao.VIPDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("../Error.html");
		return;
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%
	VIPDao vipDao = VIPDao.getInstance();
	VIP vip = new VIP();
	String name = request.getParameter("name");
	String home = request.getParameter("home");
	vip.setHome(home);
	vip.setName(name);
	vipDao.addVip(vip);

	VipRec vipRec = new VipRec();
	vipRec.setType(1);//1表示添加

	String username = (String) session.getAttribute("username");
	vipRec.setUser(username);
	String des2 = username + "添加了会员" + Code.getNewCode(name);
	vipRec.setDes(des2);
	VipRecDao.getInstance().addRec(vipRec);

	response.sendRedirect("../showVip.jsp?flage=page&page=1");
%>
</head>
<body>

</body>
</html>
<%@page import="com.shxt.duo.Code"%>
<%@page import="com.shxt.dao.VipRecDao"%>
<%@page import="com.shxt.vo.VipRec"%>
<%@page import="com.shxt.dao.VIPDao"%>
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

	VipRec vipRec = new VipRec();
	vipRec.setType(3);//1表示删除
	String username = (String) session.getAttribute("username");
	vipRec.setUser(username);
	String des2 = username + "删除了会员" + VIPDao.getInstance().getVipById(id).name;
	vipRec.setDes(des2);
	VipRecDao.getInstance().addRec(vipRec);

	VIPDao.getInstance().deleteVipById(id);

	response.sendRedirect("../showVip.jsp?flage=page&page=1");
%>

</head>
<body>

</body>
</html>
<%@page import="com.shxt.duo.Code"%>
<%@page import="com.shxt.dao.VipRecDao"%>
<%@page import="com.shxt.vo.VipRec"%>
<%@page import="com.shxt.vo.VIP"%>
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
	VIP vip = new VIP();
	String name = request.getParameter("name");
	String home = request.getParameter("home");

	vip.setHome(home);
	vip.setName(name);

	String idString = request.getParameter("id");
	int id = Integer.parseInt(idString);

	VIPDao vipDao = VIPDao.getInstance();
	vipDao.updateVipByid(vip, id);

	
	
	
	VipRec vipRec = new VipRec();
	vipRec.setType(2);//2表示 修改

	String username = (String) session.getAttribute("username");
	vipRec.setUser(username);
	String des2 = username + "修改了会员" + Code.getNewCode(name);
	vipRec.setDes(des2);
	System.out.print("niaff");
	VipRecDao.getInstance().addRec(vipRec);

	
	
	
	response.sendRedirect("../showVip.jsp?flage=page&page=1");
%>
</head>
<body>

</body>
</html>
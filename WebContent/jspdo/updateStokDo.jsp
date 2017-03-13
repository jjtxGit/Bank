<%@page import="com.shxt.dao.GoodRecDao"%>
<%@page import="com.shxt.vo.GoodRec"%>
<%@page import="com.shxt.vo.Good"%>
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
	Good good = new Good();
	String name = request.getParameter("name");
	String idString = request.getParameter("id");
	String pointString = request.getParameter("point");
	String priceString = request.getParameter("price");
	String des = request.getParameter("des");
	int point = Integer.parseInt(pointString);
	double price = Double.parseDouble(pointString);
	int id = Integer.parseInt(idString);

	good.name = name;
	good.point = point;
	good.price = price;
	good.des = des;
	good.chageCode();
	GoodOfStorDao goodOfStorDao = GoodOfStorDao.getInstance();
	goodOfStorDao.updateGoodById(id, good);
	
	
	
	
	
	
	GoodRec goodRec = new GoodRec();
	goodRec.setType(2);//1表示修改

	String username = (String) session.getAttribute("username");
	goodRec.setUser(username);
	String des2 = username + "修改了商品" + good.name;
	goodRec.setDes(des2);
	GoodRecDao.getInstance().addRec(goodRec);
	
	
	
	
	response.sendRedirect("../showStok.jsp?flage=page&page=1");
%>
</head>
<body>

</body>
</html>
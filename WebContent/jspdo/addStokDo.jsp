<%@page import="com.shxt.dao.GoodRecDao"%>
<%@page import="com.shxt.vo.GoodRec"%>
<%@page import="com.shxt.dao.GoodOfStorDao"%>
<%@page import="com.shxt.vo.Good"%>
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
<title>Insert title here</title>
<%
	Good good = new Good();

	String name = request.getParameter("name");
	String prodate = request.getParameter("prodate");

	String pointString = request.getParameter("point");
	String priceString = request.getParameter("price");
	String countString = request.getParameter("count");
	String des =request.getParameter("des");
	
	int point = Integer.parseInt(pointString);
	int count = Integer.parseInt(countString);
	double price = Double.parseDouble(pointString);

	good.name = name;
	good.proDate = prodate;
	good.point = point;
	good.count = count;
	good.price = price;
	good.des =des;
	good.chageCode();
	
	
	GoodRec goodRec = new GoodRec();
	goodRec.setType(1);//1表示添加

	String username = (String) session.getAttribute("username");
	goodRec.setUser(username);
	String des2 = username + "添加了商品" + good.name;
	goodRec.setDes(des2);
	GoodRecDao.getInstance().addRec(goodRec);
	
	
	
	
	
	
	
	
	GoodOfStorDao goodOfStorDao = GoodOfStorDao.getInstance();
	if (goodOfStorDao.addNewGoods(good)) {
		response.sendRedirect("../showStok.jsp?flage=page&page=1");
	} else {
		response.sendRedirect("../addStok.jsp?msg=flase");
	}
%>

</head>
<body>

</body>
</html>
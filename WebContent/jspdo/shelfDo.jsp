<%@page import="com.shxt.dao.GoodRecDao"%>
<%@page import="com.shxt.vo.GoodRec"%>
<%@page import="com.shxt.dao.GoodOfStorDao"%>
<%@page import="com.shxt.vo.Good"%>
<%@page import="com.shxt.dao.GoodOfShelfDao"%>
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
	String countString = request.getParameter("count");

	int id = Integer.parseInt(idString);
	int addCount = Integer.parseInt(countString);

	GoodOfStorDao goodOfStorDao = GoodOfStorDao.getInstance();
	GoodOfShelfDao goodOfShelfDao = GoodOfShelfDao.getInstance();

	if (goodOfShelfDao.isExist(id)) {//如果商品已经在货架上 只需改变数量
		int count = goodOfShelfDao.getCount(id);
		int newCount = count + addCount;
		goodOfShelfDao.changeCountById(id, newCount);

	} else {//否则就添加商品
		Good good = GoodOfStorDao.getInstance().getGoodById(id);
		good.count = addCount;
		goodOfShelfDao.addGood(good);
	}

	int count2 = goodOfStorDao.getCountById(id);
	int newCount2 = count2 - addCount;

	goodOfStorDao.updateCountByid(id, newCount2);

	GoodRec goodRec = new GoodRec();
	goodRec.setType(2);//1表示修改

	String username = (String) session.getAttribute("username");
	goodRec.setUser(username);
	String des2 = username + "上架了商品::" + GoodOfStorDao.getInstance().getGoodById(id).name;
	goodRec.setDes(des2);
	GoodRecDao.getInstance().addRec(goodRec);

	response.sendRedirect("../showStok.jsp?flage=page&page=1");
%>

</head>
<body>

</body>
</html>
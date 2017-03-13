<%@page import="com.shxt.vo.Good"%>
<%@page import="com.shxt.dao.GoodOfStorDao"%>
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

	GoodOfStorDao goodofStorDao = GoodOfStorDao.getInstance();
	GoodOfShelfDao goodOfShelfDao = GoodOfShelfDao.getInstance();

	if (goodofStorDao.isExist(id)) {//如果商品已经在仓库上 只需改变数量

		int count = goodofStorDao.getCount(id);
		int newCount = count + addCount;
		goodofStorDao.changeCountById(id, newCount);

	} else {//否则就添加商品
		Good good = GoodOfShelfDao.getInstance().getGoodById(id);
		good.count = addCount;
		goodofStorDao.addGood(good);
	}

	int count2 = goodOfShelfDao.getCountById(id);
	int newCount2 = count2 - addCount;

	goodOfShelfDao.updateCountByid(id, newCount2);

	response.sendRedirect("../showShelf.jsp?flage=page&page=1");
%>


</head>
<body>

</body>
</html>
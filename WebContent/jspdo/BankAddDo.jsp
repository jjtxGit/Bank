<%@page import="com.shxt.dao.BankDao"%>
<%@page import="com.shxt.dao.GoodOfShelfDao"%>
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
</head>
<body>
	<%
		GoodOfShelfDao goodOfShelfDao = GoodOfShelfDao.getInstance();
		BankDao bankDao = BankDao.getInstance();

		String idString = request.getParameter("id");
		int id = Integer.parseInt(idString);

		if (goodOfShelfDao.isExist(id) && goodOfShelfDao.getCount(id) > 0) {
			//如果顾客购买的商品在货架上存在，并且数量大于0
			Good good = goodOfShelfDao.getGoodById(id);
			bankDao.addGood(good);

			int count = goodOfShelfDao.getCount(id);
			count--;
			goodOfShelfDao.updateCountByid(id, count);
			session.setAttribute("msg", "ture");

		} else {

			session.setAttribute("msg", "flase");
		}

		response.sendRedirect("../bank.html");
	%>




</body>
</html>
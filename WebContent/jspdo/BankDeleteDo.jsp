<%@page import="com.shxt.dao.BankRecDao"%>
<%@page import="com.shxt.vo.BankRec"%>
<%@page import="com.shxt.dao.GoodOfShelfDao"%>
<%@page import="com.shxt.vo.VIP"%>
<%@page import="com.shxt.dao.VIPDao"%>
<%@page import="com.shxt.dao.BankDao"%>
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
	BankDao bankDao = BankDao.getInstance();
	VIPDao vipDao = VIPDao.getInstance();

	String flage = request.getParameter("flage");

	flage = flage == null ? "" : flage;
	System.out.print(flage);
	if (flage.equals("false")) {//无会员

		BankRec bankRec = new BankRec();

		String userName = (String) session.getAttribute("username");
		bankRec.setUser(userName);
		double sumMoney = bankDao.getPrices();
		bankRec.setMoney(sumMoney);
		String des = userName + "完成了一笔交易    会员：无";
		bankRec.setDes(des);
		BankRecDao.getInstance().addRec(bankRec);

	} else {//有会员

		String idString = request.getParameter("id");
		int id = Integer.parseInt(idString);
		VIP vip = vipDao.getVipById(id);
		int point = bankDao.getPoint();
		vip.addPoint(point);
		vipDao.updateVipByid(vip, vip.id);

		BankRec bankRec = new BankRec();
		String userName = (String) session.getAttribute("username");
		bankRec.setUser(userName);
		double sumMoney = bankDao.getPrices();
		bankRec.setMoney(sumMoney);
		String des = userName + "完成了一笔交易     会员姓名：" + vip.name;
		bankRec.setDes(des);
		BankRecDao.getInstance().addRec(bankRec);
		System.out.print("添加一条无会员的信息");

	}
	bankDao.deleteAll();
	response.sendRedirect("../bank.html");
%>
</head>
<body>

</body>
</html>
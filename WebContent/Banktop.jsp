<%@page import="com.shxt.vo.Good"%>
<%@page import="com.shxt.dao.BankDao"%>
<%@page import="java.awt.print.Book"%>
<%@page import="com.shxt.vo.User"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<head>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<%
	BankDao bankDao = BankDao.getInstance();
	ArrayList<Good> aList = bankDao.getGoods();
%>
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$(".click").click(function() {
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

		$(".sure").click(function() {
			$(".tip").fadeOut(100);
		});

		$(".cancel").click(function() {
			$(".tip").fadeOut(100);
		});

	});
</script>

</head>

<body>



	<div class="rightinfo"></div>




	<table class="tablelist">
		<thead>
			<tr>
				<th>商品名</th>
				<th>生产日期</th>
				<th>描述</th>
				<th>积分</th>
				<th>价格</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (Good good : aList) {
			%>
			<tr>
				<td><%=good.name%></td>
				<td><%=good.proDate%></td>
				<td><%=good.des%></td>
				<td><%=good.point%></td>
				<td><%=good.price%></td>
			</tr>
			<%
				}
			%>

		</tbody>
	</table>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>

</html>

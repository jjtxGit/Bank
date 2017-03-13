<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.dao.SeekDao"%>
<%@page import="com.shxt.vo.Seek"%>
<%@page import="com.shxt.vo.Comment"%>
<%@page import="com.shxt.dao.CommentDao"%>
<%@page import="com.shxt.vo.WorkerRec"%>
<%@page import="com.shxt.dao.WorkerRecDao"%>
<%@page import="com.shxt.vo.LoginRec"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
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

<%
	SeekDao	 seekDao = SeekDao.getInstance();

	ArrayList<Seek> aList = seekDao.getSeeks();
%>

</head>


<body>



	<div class="rightinfo">

		<div class="tools"></div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>昵称</th>
					<th>联系方式</th>
					<th>内容</th>
					<th>操作时间</th>
				</tr>
			</thead>

			<tbody>
				<%
					for (Seek seek : aList) {
				%>
				<tr>
					<td><%=seek.name%></td>
					<td><%=seek.contact%></td>
					<td><%=seek.des%></td>
					<td><%=seek.time%></td>

				</tr>

				<%
					}
				%>

			</tbody>
		</table>
	</div>
	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>

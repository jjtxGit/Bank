<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<meta http-equiv="refresh" content="3; url=showComment.jsp">


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
	CommentDao commentDao = CommentDao.getInstance();

	ArrayList<Comment> aList = commentDao.getComments();
%>

</head>


<body>



	<div class="rightinfo">

		<div class="tools"></div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>昵称</th>
					<th>内容</th>
					<th>操作时间</th>
				</tr>
			</thead>

			<tbody>
				<%
					for (Comment comment : aList) {
				%>
				<tr>
					<td><%=comment.getName()%></td>
					<td><%=comment.getDes()%></td>
					<td><%=comment.getTime()%></td>

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

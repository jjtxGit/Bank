<%@page import="java.awt.print.Book"%>
<%@page import="com.shxt.vo.User"%>
<%@page import="com.shxt.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<%
	UserDao userDao = UserDao.getInstance();
	ArrayList<User> aList = userDao.getUsers();
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
<script type="text/javascript">
	function deletBit(obj,id) 
 	{
		if (confirm("确认解聘员工?"))
		{
			obj.href="jspdo/deleteuserdo.jsp?id="+id;
		}
	}
</script>
</head>

<body>



	<div class="rightinfo"></div>




	<table class="tablelist">
		<thead>
			<tr>
				<th>工号<i class="sort"><img src="images/px.gif" /></i></th>
				<th>用户名</th>
				<th>入职时间</th>
				<th>籍贯</th>
				<th>薪资</th>
				<th>权限</th>
				<th>操作</th>

			</tr>
		</thead>
		<tbody>
			<%
				for (User user : aList) {
			%>
			<tr>
				<td><%=user.id%></td>
				<td><%=user.userName%></td>
				<td><%=user.entryTime%></td>
				<td><%=user.home%></td>
				<td><%=user.salary%></td>
				<td>
					<%
						if (user.power == 1) {
								out.print("收银员");
							} else {
								out.print("管理员");
							}
					%>
				</td>
				<td><a href="updateUser.jsp?id=<%=user.id%>" class="tablelink">修改</a>
					<a href="#" class="tablelink"
					onclick="deletBit(this,<%=user.id%>);"> 解聘</a></td>
			</tr>

			<%
				}
			%>


		</tbody>
	</table>


	<div class="pagin">
		<div class="message">
			共<i class="blue"><%=userDao.getUserCount()%></i>条记录
		</div>
	</div>
	<script type="text/javascript">
			$('.tablelist tbody tr:odd').addClass('odd');
		</script>
</body>

</html>

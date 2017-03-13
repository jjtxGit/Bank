<%@page import="com.shxt.dao.GoodOfStorDao"%>
<%@page import="com.shxt.vo.Good"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<link href="css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	function bt() {
		var form = document.getElementById("form");
		var name = document.getElementById("name");
		var point = document.getElementById("point");
		var price = document.getElementById("price");

		if (name.value == "") {
			alert("商品名称不能为空");
			name.focus();
			return;
		}

		

		if (point.value == "" || isNaN(point.value)) {
			alert("商品积分错误");
			point.value = "";
			point.focus();
			return;
		}

		if (price.value == "" || isNaN(price.value)) {
			alert("商品价格错误");
			price.focus();
			price.value = "";
			return;
		}
	

		form.action = "jspdo/updateStokDo.jsp";

	}
</script>
<%

	String idString = request.getParameter("id");

	int id = Integer.parseInt(idString);
	GoodOfStorDao goodOfStorDao = GoodOfStorDao.getInstance();
	Good good = goodOfStorDao.getGoodById(id);
%>
</head>
<body>
	<div class="formbody">
		<div class="formtitle">
			<span>基本信息</span>
		</div>

		<form id="form" method="post">

			<ul class="forminfo">
				<li><label>商品名称</label><input id="name" name="name" type="text" value="<%=good.name %>"
					class="dfinput" /><i>不能超过15汉字</i></li>
					
				<li><input type="hidden" name="id" value="<%=id%>" /></li>

				<li><label>商品积分</label><input id="point" name="point"
					type="text" class="dfinput" value="<%=good.point %>" /></li>

				<li><label>商品价格</label><input id="price" name="price"
					type="text" class="dfinput" value="<%=good.price %>"/><i>精确到两位小数</i></li>
					

				<li><label>备注信息</label> <textarea name="des" class="textinput"></textarea></li>
				<li><label>&nbsp;</label><input onclick="bt();" type="submit"
					class="btn" value="确定" /></li>

			</ul>
		</form>


	</div>

</body>

</html>

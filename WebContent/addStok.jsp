<%@page import="com.shxt.vo.Good"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<script type="text/javascript">
	function bt() {
		var form = document.getElementById("form");
		var name = document.getElementById("name");
		var prodate = document.getElementById("prodate");
		var point = document.getElementById("point");
		var price = document.getElementById("price");
		var count = document.getElementById("count");

		if (name.value == "") {
			alert("商品名称不能为空");
			name.focus();
			return;
		}

		if (prodate.value == "") {
			alert("商品生产日期为空");
			prodate.focus();
			prodate.value == "xxxx-xx-xx";
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
		if (count.value == "" || isNaN(count.value)) {
			alert("进货数量错误");
			count.value = "";
			count.focus();
			return;
		}

		form.action = "jspdo/addStokDo.jsp";

	}
</script>
<%
	String msg = request.getParameter("msg");

	msg = msg == null ? "" : "添加失败，格式有误，请重新填写";
%>
</head>
<body>
	<div class="formbody">
		<div class="formtitle">
			<span>基本信息</span>
		</div>

		<form id="form">

			<ul class="forminfo">
				<li><font color="red"><%=msg%></font></li>
				<li><label>商品名称<b>*</b></label><input id="name" name="name" type="text"
					class="dfinput" /><i>不能超过15汉字</i></li>

				<li><label>生产日期<b>*</b></label><input id="prodate" name="prodate"
					type="text" class="dfinput" /><i>格式如：2016-2-28</i></li>

				<li><label>商品积分</label><input id="point" name="point"
					type="text" class="dfinput" /></li>

				<li><label>商品价格<b>*</b></label><input id="price" name="price"
					type="text" class="dfinput" /><i>精确到两位小数</i></li>

				<li><label>进货数量<b>*</b></label><input id="count" name="count"
					type="text" class="dfinput" /></li>

				<li><label>备注信息</label> <textarea name="des" class="textinput"></textarea></li>
				<li><label>&nbsp;</label><input onclick="bt();" type="submit"
					class="btn" value="入库" /></li>

			</ul>
		</form>


	</div>

</body>

</html>

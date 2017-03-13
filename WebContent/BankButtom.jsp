<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.dao.VIPDao"%>
<%@page import="com.shxt.vo.VIP"%>
<%@page import="com.shxt.dao.BankDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<head>

<link href="css/style.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	BankDao bankDao = BankDao.getInstance();
	double prices = bankDao.getPrices();
	String flage2 = (String) session.getAttribute("msg");
	if (flage2 == null || flage2.equals("ture")) {
		flage2 = "";
	} else {
		flage2 = "添加商品失败";
	}

	String flage = request.getParameter("flage");
	if (flage == null)
		flage = "true";
	String vipidString = "";
	VIP vip = new VIP();

	if (flage.equals("false")) {
		vipidString = request.getParameter("id");

		int vipid = Integer.parseInt(vipidString);
		VIPDao vipDao = VIPDao.getInstance();
		vip = vipDao.getVipById(vipid);

		switch (vip.level) {
			case 1 :
				break;
			case 2 :
				prices = prices * 0.95;
				break;
			case 3 :
				prices = prices * 0.9;
				break;
			case 4 :
				prices = prices * 0.85;
				break;
		}
	}
%>
<script type="text/javascript">
	function add() {

		var id = document.getElementById("id").value;
		if (id == "") {
			alert("商品编号为空");
			return;
		}

		top.location.href = "jspdo/BankAddDo.jsp?id=" + id;

	}
	function findVip() {
		var vipid = document.getElementById("vipid");
		location.href = "jspdo/findVipDo.jsp?vipid=" + vipid.value;
	}

	function Onsubmit() {
		var vipid = document.getElementById("vipid");
		var sumMoney =<%=prices%>;
		var money = document.getElementById("money").value;
	
		if (sumMoney > money) {
			alert("请重新收钱");
			money.focus();
			return 
		}
		
		alert("找零："+ (money- sumMoney)+"元" ) ;
		
		if(vipid.value=="")
		{
			
			top.location.href="jspdo/BankDeleteDo.jsp?flage=false";
		
		}
		else
		{
			top.location.href="jspdo/BankDeleteDo.jsp?flage=true&id="+vipid.value;
				
		}

	}
</script>
</head>
<body>
	<ul class="forminfo">

		<li><font color="red" style="font-size: 50px">总金额:<%=prices%></font><font>
				<%
					switch (vip.level) {
					case 1:
						out.print("不打折");
						break;
					case 2:
						out.print("已打9.5折");
						break;
					case 3:
						out.print("已打9折");
						break;
					case 4:
						out.print("已打8.5折");
						break;
					}
				%>
		</font></li>
		<li><label>商品编号:</label><input name="id" id="id" type="text"
			class="dfinput" /> &nbsp;&nbsp;&nbsp;&nbsp; <input name=""
			type="button" class="btn" onclick="add();" value="添加" />

			&nbsp;&nbsp;会员编号: <input value="<%=vipidString%>" name="vipid"
			id="vipid" type="text" class="dfinput" onchange="findVip();" />
			&nbsp;&nbsp;&nbsp;&nbsp; <font color="green"> <%
 	out.print(vip.name + "&nbsp;&nbsp;");

 	switch (vip.level) {
 	case 1:
 		out.print("青铜");
 		break;
 	case 2:
 		out.print("白银");
 		break;
 	case 3:
 		out.print("黄金");
 		break;
 	case 4:
 		out.print("骨灰");
 		break;
 	}
 %>
		</font></li>
		<li><font color="red"><%=flage2%></font></li>

		<li><label>收 &nbsp;&nbsp; 钱：</label><input name="" id="money"
			type="text" class="dfinput" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
			name="" type="button" class="btn" onclick="Onsubmit();" value="找零" /></li>
	</ul>
</body>
</html>
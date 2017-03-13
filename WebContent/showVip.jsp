<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.shxt.vo.VIP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shxt.dao.VIPDao"%>
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

<script type="text/javascript">

function  delBt(obj,id) {
	
	if(confirm("确认删除？"))
	{
		obj.href="jspdo/deleteVipdo.jsp?id="+id;	
	}
}

</script>
<%
	VIPDao vipDao = VIPDao.getInstance();
	ArrayList<VIP> arrayList = null;
	int count = 1;
	int pages = count / 6 + 1;
	int localPage = 1;

	String flage = request.getParameter("flage");
	if (flage != null && flage.equals("find")) {

		String type = request.getParameter("type");
		if (type.equals("name")) {
			String name = request.getParameter("name");
			arrayList = vipDao.getVipByName(name);
			if (arrayList.isEmpty())
				count = 0;

		} else {
			String idString = request.getParameter("id");
			int id = Integer.parseInt(idString);
			VIP vip = vipDao.getVipById(id);
			arrayList = new ArrayList<VIP>();
			arrayList.add(vip);
			if (arrayList.isEmpty()) {
				count = 0;
			}
		}
	} else {
		String pagString = request.getParameter("page");

		int pageInt = Integer.parseInt(pagString);
		int begin = --pageInt * 6;
		localPage = begin / 6 + 1;
		count = vipDao.getCount();
		pages = count / 6 + 1;
		arrayList = vipDao.getVips(begin);
	}
%>
<script type="text/javascript">
function  vipname() {
	var vipid=document.getElementById("vipid");
	vipid.value="";
}
function vipid() {
	var vipname=document.getElementById("vipname");
	vipname.value="";
}

function findvip() {
	var vipname=document.getElementById("vipname");
	var vipid=document.getElementById("vipid");
	if(vipname.value!="")
	{
		location.href ="showVip.jsp?flage=find&type=name&name="+vipname.value;	
		return ;
	}
	if(vipid.value!="")
	{
		if(isNaN(vipid.value))
			{
				alert("会员编号必须是数字");
				vipid.value="";
				vipid.focus();
				return ;
			}
		
		location.href ="showVip.jsp?flage=find&type=id&id="+vipid.value;	
		return ;	
	}

}

</script>

</head>


<body>
	<br />
	<ul class="seachform">

		<li><label>会员姓名</label><input id="vipname" name="vipname"
			type="text" class="scinput" onclick="vipname();" /></li>

		<li><label>会员编号</label><input id="vipid" name="vipid" type="text"
			class="scinput" onclick="vipid();" /></li>


		<li><label>&nbsp;</label><input id="findvip" name="findvip"
			onclick="findvip();" type="button" class="scbtn" value="查询" /></li>

	</ul>

	<div class="rightinfo"></div>


	<table class="tablelist">
		<thead>

			<tr>
				<th>会员号<i class="sort"><img src="images/px.gif" /></i></th>
				<th>会员姓名</th>
				<th>登记时间</th>
				<th>地址</th>
				<th>积分</th>
				<th>等级</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>

			<%
				for (VIP vip : arrayList) {
			%>
			<tr>

				<td><%=vip.id%></td>
				<td><%=vip.name%></td>
				<td><%=vip.time%></td>
				<td><%=vip.home%></td>
				<td><%=vip.point%></td>
				<td>
					<%
						switch (vip.level) {
								case 1 :
									out.print("青铜");
									break;
								case 2 :
									out.print("白银");
									break;

								case 3 :
									out.print("黄金");
									break;

								case 4 :
									out.print("铂金");
									break;
								case 5 :
									out.print("骨灰");
									break;

							}
					%>
				</td>
				<td><a href="updateVip.jsp?id=<%=vip.id%>" class="tablelink">更新</a>
					<a href="#" onclick="delBt(this,<%=vip.id%>);" class="tablelink">删除</a></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>


	<div class="pagin">
		<div class="message">
			共<i class="blue"><%=count%></i>条记录，当前显示第&nbsp;<i class="blue"><%=localPage%>&nbsp;</i>页
		</div>
		<ul class="paginList">

			<%
				for (int i = 1; i <= pages; i++) {
			%>
			<li class="paginItem current"><a
				href="showVip.jsp?flage=page&page=<%=i%>"><%=i%></a></li>
			<%
				}
			%>

		</ul>
	</div>

	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>

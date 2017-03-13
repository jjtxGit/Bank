<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.vo.Good"%>
<%@page import="com.shxt.dao.GoodOfStorDao"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
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

function  addBt(obj,id) {
	
	var count=prompt("进货数量","请输入进货数量");
	count = count==null?"0":count;
	if(count=="")
	{
		count="0";	
	}
	if(isNaN(count))
	{
		alert("请输入数字") ;
		return ;
	}
	obj.href="jspdo/addCountStokDo.jsp?id="+id+"&count="+count;
}


function  shelfBt(obj,id,count) {
	
	var addcount=prompt("上架数量","1");
	addcount = addcount==null?"0":addcount;
	if(addcount=="")
	{
		addcount="0";	
	}
	
	
	if(isNaN(addcount))
	{
		alert("请输入数字") ;
		return ;
	}
	
	if(addcount>count)
	{
		alert("库存不足");
		return ;
	}
	
	alert("上架成功");
	obj.href="jspdo/shelfDo.jsp?id="+id+"&count="+addcount;
	
}

function delBt(obj , id)
{
	if(confirm("确定移除?"))
	{
		obj.href="jspdo/remStokDo.jsp?id="+id;	
	}
	return ;
	
}

</script>
<%
	GoodOfStorDao goodOfStorDao = GoodOfStorDao.getInstance();
	ArrayList<Good> arrayList = null;

	int count = 1;
	int pages = 1;
	int localPage = 1;

	String flage = request.getParameter("flage");
	if (flage != null && flage.equals("find")) {
		String type = request.getParameter("type");
		int typeFlage = 0;
		if (type.equals("name")) {
			typeFlage = 1;
		} else if (type.equals("id")) {
			typeFlage = 2;
		} else if (type.equals("count")) {
			typeFlage = 3;
		} else if (type.equals("point")) {
			typeFlage = 4;
		}

		switch (typeFlage) {

			case 1 :
				String name2 = request.getParameter("name");
				System.out.print(name2);
				arrayList = goodOfStorDao.getGoodsByName(name2);

				break;
			case 2 :
				String idString = request.getParameter("id");
				int id2 = Integer.parseInt(idString);

				Good good2 = goodOfStorDao.getGoodById(id2);

				arrayList = new ArrayList<Good>();
				
				if (good2 != null)
					arrayList.add(good2);
					
				break;
				
			case 3 :
				String countString = request.getParameter("count");
				int count2 = Integer.parseInt(countString);
				arrayList = goodOfStorDao.getGoodsByCount(count2);

				break;
			case 4 :
				String pointString = request.getParameter("point");
				int point2 = Integer.parseInt(pointString);
				arrayList = goodOfStorDao.getGoodsByPoint(point2);

				break;

		}
		count = arrayList.size();
		pages = 1;

	} else {
		String pagString = request.getParameter("page");

		int pageInt = Integer.parseInt(pagString);
		int begin = --pageInt * 6;
		localPage = begin / 6 + 1;
		arrayList = goodOfStorDao.getGoods(begin);
		count = goodOfStorDao.getGoodCount();
		pages = count / 7 + 1;

	}
%>
<script type="text/javascript">

function name() {
	
	var goodid=document.getElementById("goodid");
	var goodcount =document.getElementById("goodcount");
	var goodpoint =document.getElementById("goodpoint");
	
	goodname.value="";
	goodid.value="";
	goodcount.value="";
	goodpoint.value="";
	
}
function goodid() {
	
	var goodname =document.getElementById("goodname");
	var goodcount =document.getElementById("goodcount");
	var goodpoint =document.getElementById("goodpoint");
	
	goodname.value="";
	goodid.value="";
	goodcount.value="";
	goodpoint.value="";
	
}function goodcount() {
	
	var goodname =document.getElementById("goodname");
	var goodid=document.getElementById("goodid");
	var goodpoint =document.getElementById("goodpoint");
	
	goodname.value="";
	goodid.value="";
	goodcount.value="";
	goodpoint.value="";
	
}function goodpoint() {
	
	var goodname =document.getElementById("goodname");
	var goodid=document.getElementById("goodid");
	var goodcount =document.getElementById("goodcount");
	var goodpoint =document.getElementById("goodpoint");
	
	goodname.value="";
	goodid.value="";
	goodcount.value="";
	
}

function find() {
	
	var goodname =document.getElementById("goodname");
	var goodid=document.getElementById("goodid");
	var goodcount =document.getElementById("goodcount");
	var goodpoint =document.getElementById("goodpoint");
	
	
	if(goodname.value!="")
	{
		location.href ="showStok.jsp?flage=find&type=name&name="+goodname.value;
		return ;
	}
	
	if(goodid.value!="")
	{
		if(isNaN(goodid.value))
		{
			alert("编号必须是数字");
			goodid.value="";
			goodid.focus();
			return ;
		}
		location.href ="showStok.jsp?flage=find&type=id&id="+goodid.value;
		return ;
	}
	
	if(goodcount.value!="")
	{
		if(isNaN(goodcount.value))
		{
			alert("数量必须是数字");
			goodcount.value="";
			goodcount.focus();
			return ;
		}
		
		location.href ="showStok.jsp?flage=find&type=count&count="+goodcount.value;
		return ;
	}
	
	if(goodpoint.value!="")
	{
		if(isNaN(goodpoint.value))
		{
			alert("积分必须是数字");
			goodpoint.value="";
			goodpoint.focus();
			return ;
		}
		
		location.href ="showStok.jsp?flage=find&type=point&point="+goodpoint.value;
		return ;
	}
}

</script>

</head>


<body>
	<br />
	<ul class="seachform">
		<li><label>商品编号</label><input id="goodid" name="goodid"
			type="text" class="scinput" onclick="goodid();" /></li>

		<li><label>商品名称</label><input id="goodname" name="goodname"
			type="text" class="scinput" onclick="goodname();" /></li>

		<li><label>积分阈值</label><input id="goodpoint" name="goodpoint"
			type="text" class="scinput" onclick="goodpoint();" /></li>

		<li><label>库存阈值</label><input id="goodcount" name="goodcount"
			type="text" class="scinput" onclick="goodcount();" /></li>

		<li><label>&nbsp;</label><input id="findgood" name="findgood"
			onclick="find();" type="button" class="scbtn" value="查询" /></li>

	</ul>

	<div class="rightinfo"></div>


	<table class="tablelist">
		<thead>

			<tr>
				<th>商品编号<i class="sort"><img src="images/px.gif" /></i></th>
				<th>商品名称</th>
				<th>生产日期</th>
				<th>商品备注</th>
				<th>商品积分</th>
				<th>商品价格</th>
				<th>库存数量</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>

			<%
				for (Good good : arrayList) {
			%>
			<tr>

				<td><%=good.id%></td>
				<td><%=good.name%></td>
				<td><%=good.proDate%></td>
				<td><%=good.des%></td>
				<td><%=good.point%></td>
				<td><%=good.price%></td>
				<td>
					<%
						out.print(good.count);
							if (good.count <= 10)
								out.print("&nbsp&nbsp<font color='red'>库存紧张</font>");
					%>
				</td>
				<td><a href="updateStok.jsp?id=<%=good.id%>" class="tablelink">修改</a>
					<a href="#" onclick="addBt(this,<%=good.id%>);" class="tablelink">进货</a>
					<a href="#" onclick="shelfBt(this,<%=good.id%>,<%=good.count%>);"
					class="tablelink">上架</a> <a href="#"
					onclick="delBt(this,<%=good.id%>);" class="tablelink"> <%
 	if (good.count == 0) {
 			out.print("<font color='red'>移除</font>");
 		}
 %>
				</a></td>


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
				href="showStok.jsp?flage=page&page=<%=i%>"><%=i%></a></li>
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

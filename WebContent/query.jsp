<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.*"%>
    <%@page import="wlzx.bbs.vo.*"%>
    <%@page import="wlzx.bbs.factory.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/query.css" media="all">
<title>网络中心BBS</title>
</head>
<body>
	<div class="wrap1">
<div class="wrap2">
<div id="head" class=" search_bright clearfix" style="">
	<div class="search_main_wrap"></div>
<div id="main_wrapper" class="main_wrapper">
<div id="main_back_img">
<div id="main_back_bottom">
	<div id="main_header_logo" class="main_header">
		<ul class="nav_bar">
			<img src="image/head5.jpg">
		</ul>
	</div>
<%
	//乱码处理
	request.setCharacterEncoding("utf-8") ;
	//分页
	Paging paging = new Paging();
	String u_pageNow = request.getParameter("pageNow");
	if(u_pageNow != null) {
		paging.setPageNow(Integer.parseInt(u_pageNow));
	}
	//获取权限
	int u_authority = (Integer)session.getAttribute("uauthority");
	String keyword = request.getParameter("keyword");
	if(u_authority == 1) {
		//如果有内容，则修改变量i，如果没有，则根据i的值显示无内容提示
		int i = 0;
		List all = null ;
		//获取总记录条数
		int rowCount = 0;
		rowCount = DAOFactory.getPersonDAOInstance().number(keyword);
		paging.setRowCount(rowCount);
		int p = paging.getPageSize()*(paging.getPageNow() - 1);
		all = DAOFactory.getPersonDAOInstance().queryByLike(keyword,paging.getPageSize(),p);
%>
<div id="container" class="ibody clearfix">
<div class="w750 fleft"><div id="content">
<div id="feed" class="feed">
	<h3><a href="user_control.jsp">返回</a></h3>
	<div class="feed_head"><!----><h3 class="favth_title">用户管理</h3>
	<div class="favth_thead">
		<div class="favth_col1">用户名</div>
		<div class="favth_col2">账号</div>
		<div class="favth_col4">管理</div>
	</div>
	</div>
	<ul>
<%
	Iterator iter = all.iterator() ;
		while(iter.hasNext()) {
			Person person = (Person)iter.next() ;
			i++;
			//进行循环打印
			//从数据库取内容
			int Nid = person.getNid();
			String name = person.getName();
			String account = person.getAccount();
			String password = person.getPassword();
			int authority = person.getAuthority();
			String flag = "u_control";
			if(keyword!=null) {
				//数据反红
				name = name.replaceAll(keyword,"<font color=\"red\">"+keyword+"</font>");
				account = account.replaceAll(keyword,"<font color=\"red\">"+keyword+"</font>");
			}
%>
		<li style="z-index: 119;" class="feed_item clearfix feed_favts j_feed_favts">
			<div class="favth_col1"><span class="favth_item_title"><%=name%></span></div>
			<div class="favth_col2"><span class="favth_item_author"><%=account%></span></div>
<%
			if(authority == 1) {
%>
			<div class="favth_col4"><span class="favth_item_time">超级管理员</span></div>
<%
			} else {
%>
			<div class="favth_col4"><span class="favth_item_time"><input type="submit" value="删除"></span></div>
<%
			}
		}
		if(i==0) {
		//进行提示
%>
		<div class="favth_col4"><span class="favth_item_time">没有找到</span></div>
<%
		}
%>
		</li>
	</ul>
	<table align="right">
	<hr>
			<tr>
				<td>第<%=paging.getPageNow() %>页</td>
				<td>
						<a href="query.jsp?pageNow=1&keyword=<%=keyword%>">首页</a>					
				</td>
				<td>
	<% 
					if(paging.getPageNow()!=1){
	%>
						<a href="query.jsp?pageNow=<%=paging.getPageNow()-1 %>&keyword=<%=keyword%>">上一页</a>
	<%
						}						
	%>
				</td>
				<td>
	<% 
					for(int l=1; l<=paging.getPageCount(); l++){
						if(paging.getPageCount() <= 5) {
							for(; l<=paging.getPageCount(); l++) {
	%>
								<a href="query.jsp?pageNow=<%=l %>&keyword=<%=keyword%>">[<%=l %>]</a>
	<%									
							}
						} else {
							if(paging.getPageNow() > 3 && paging.getPageNow() < paging.getPageCount()-2) {
								for(l =paging.getPageNow()-2 ; l <=paging.getPageNow()+2; l++) {
	%>
									<a href="query.jsp?pageNow=<%=l %>&keyword=<%=keyword%>">[<%=l %>]</a>
	<%								
							}
						} else if(paging.getPageNow() >= paging.getPageCount()-2) {
							for(l = paging.getPageCount()-4; l <=paging.getPageCount(); l++) { 
	%>
								<a href="query.jsp?pageNow=<%=l %>&keyword=<%=keyword%>">[<%=l %>]</a> 
	<%									
									}
								}
							}
						}
	%>
				</td>
				<td>
	<%
					if(paging.getPageNow() != paging.getPageCount()) {
	%>
						<a href="query.jsp?pageNow=<%=paging.getPageNow() + 1 %>&keyword=<%=keyword%>">下一页</a>
	<%
					}
	%>
				</td>
				<td>
					<a href="query.jsp?pageNow=<%=paging.getPageCount() %>&keyword=<%=keyword%>">末页</a>
				</td>
			</tr>
		</table> 
	<%
		}
	%>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>
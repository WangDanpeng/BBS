<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网络中心BBS</title>
<link rel="stylesheet" type="text/css" href="css/see.css" media="all">
</head>
<body>
<div class="wrap1">
<div class="wrap2">
<div id="head" class=" search_bright clearfix" style="">
	<div class="search_main_wrap"></div>
</div>


<div id="main_wrapper" class="main_wrapper">
<div id="main_back_img">
<div id="main_back_bottom">
	<div id="main_header_logo" class="main_header">
		<img src="image/head5.jpg">
	</div>
<div id="container" class="ibody clearfix">
	<div class="w750 fleft">
	<div id="content">
    <div id="tiezi_sub_tab" class="sub_nav clearfix">
			<h3>回复我的</h3>
    </div>
    <div class="simple_block_container">
    <ul>
    <%
		int u_id = (Integer)session.getAttribute("uid");
		List all = null ;
		Paging paging = new Paging();
		all = DAOFactory.getReplyDAOInstance().queryUnread(u_id);
		Iterator iter = all.iterator() ;
		while(iter.hasNext()) {
			Reply reply = (Reply)iter.next() ;
			//进行循环打印回复
			//从数据库取内容
			String author_r = reply.getAuthor();
			String content_r = reply.getContent();
			int id_i = reply.getInvitation_id();
			int id_r = reply.getNid();
			int floor = reply.getFloor();
			int p_id = reply.getPerson_id();
			int pageN = (floor - 2) / paging.getPageSize() + 1;
			Invitation invi = DAOFactory.getInvitationDAOInstance().queryById(id_i);
			String title_i = invi.getTitle();
	%>
		<div class="block t_forward clearfix ">
			<div class="b_left_up">
				<span><img src="image/reply.gif"></span>
			</div>
			<div class="b_right_up">		
				<h4>
					<cite>8-31</cite>
					<a href="person.jsp?id=<%=p_id%>" target="_top"><%=author_r%></a>&nbsp;回复
				</h4>
				<span class="for_reply">										
						<img src="image/yh_0.png"> 
						<a class="for_reply_context" style="text-decoration: none;" href="show.jsp?invi_id=<%=id_i%>&pageNow=<%=pageN%>#<%=id_r%>"><%=content_r%></a>
						<img src="image/yh_1.png"> 						
				</span>		
				<div class="common_source_main">
					<%=title_i %>&nbsp;-&nbsp;来自<a href="list_invitation.jsp">网络中心BBS</a>
				</div>
			</div>
		</div> 
		<%
		}
		List all2 = null ;
		all2 = DAOFactory.getCommentDAOInstance().queryUnreadI(u_id);
		Iterator iter2 = all2.iterator() ;
		while(iter2.hasNext()) {
			Comment comment = (Comment)iter2.next() ;
			//进行循环打印回复
			//从数据库取内容
			String author_c = comment.getAuthor();
			String content_c = comment.getContent();
			int id_i_c = comment.getInvitation_id();
			int id_c = comment.getNid();
			int id_r_c = comment.getReply_id();
			Invitation invi2 = DAOFactory.getInvitationDAOInstance().queryById(id_i_c);
			String title = invi2.getTitle();
			int floor2 = DAOFactory.getReplyDAOInstance().queryFloor(id_r_c);
			int pageN2 = (floor2 - 2) / paging.getPageSize() + 1;
	%>
	<div class="block t_forward clearfix ">
			<div class="b_left_up">
				<span><img src="image/reply.gif"></span>
			</div>
			<div class="b_right_up">		
				<h4>
					<cite>8-31</cite>
					<a href="http://tieba.baidu.com/i/378640509" target="_top"><%=author_c%></a>&nbsp;回复
				</h4>
				<span class="for_reply">										
						<img src="image/yh_0.png"> 
						<a class="for_reply_context" style="text-decoration: none;" href="show.jsp?invi_id=<%=id_i_c%>&pageNow=<%=pageN2%>#c<%=id_c%>"><%=content_c%></a>
						<img src="image/yh_1.png"> 						
				</span>		
				<div class="common_source_main">
					<a href="http://tieba.baidu.com/p/2566859254" class="thread_title" target="_top"><%=title %></a>&nbsp;-&nbsp;来自<a href="list_invitation.jsp">网络中心BBS</a>
				</div>
			</div>
		</div> 
		<%
		}
		List all3 = null ;
		all3 = DAOFactory.getCommentDAOInstance().queryUnreadR(u_id);
		Iterator iter3 = all3.iterator() ;
		while(iter3.hasNext()) {
			Comment comment = (Comment)iter3.next() ;
			//进行循环打印回复
			//从数据库取内容
			String author_c = comment.getAuthor();
			String content_c = comment.getContent();
			int id_i_c = comment.getInvitation_id();
			int id_c = comment.getNid();
			int id_r_c = comment.getReply_id();
			Invitation invi2 = DAOFactory.getInvitationDAOInstance().queryById(id_i_c);
			String title = invi2.getTitle();
			int floor2 = DAOFactory.getReplyDAOInstance().queryFloor(id_r_c);
			int pageN2 = (floor2 - 2) / paging.getPageSize() + 1;
	%>
	<div class="block t_forward clearfix ">
			<div class="b_left_up">
				<span><img src="image/reply.gif"></span>
			</div>
			<div class="b_right_up">		
				<h4>
					<cite>8-31</cite>
					<a href="http://tieba.baidu.com/i/378640509" target="_top"><%=author_c%></a>&nbsp;回复
				</h4>
				<span class="for_reply">										
						<img src="image/yh_0.png"> 
						<a class="for_reply_context" style="text-decoration: none;" href="show.jsp?invi_id=<%=id_i_c%>&pageNow=<%=pageN2%>#c<%=id_c%>"><%=content_c%></a>
						<img src="image/yh_1.png"> 						
				</span>		
				<div class="common_source_main">
					<a href="http://tieba.baidu.com/p/2566859254" class="thread_title" target="_top"><%=title %></a>&nbsp;-&nbsp;来自<a href="list_invitation.jsp">网络中心BBS</a>
				</div>
			</div>
		</div> 
	<%
		}
	%>
    </ul>
    </div>
	</div>
	</div>
	<div id="main_aside" class="content_aside">
		<div id="aside_person_info" class="aside_person_info">
			<div class="aside_p_info_head">
				<span class="a_p_title">个人信息 </span>
			</div>
			<div class="aside_person_info_wraper">
				<div class="aside_userface_wraper">
					<p class="aside_userface_border">
					<% 
						if(DAOFactory.getPersonDAOInstance().queryHead(u_id) == 0) {
					%>
						<img src="upload/0.jpg" id="img_aside_head" style="max-width: 64px; max-height: 64px; width: 64px; height: 64px; visibility: visible; margin-top: 0px;">
					<%
						} else {
					%>
						<img src="upload/<%=u_id%>.jpg" id="img_aside_head" style="max-width: 64px; max-height: 64px; width: 64px; height: 64px; visibility: visible; margin-top: 0px;">
					<%
						}
					%>
					</p>
				</div>
				<div class="aside_user_profile">
					<p class="aside_user_name"><%=session.getAttribute("uname")%></p>						
				</div>
			</div>
		</div>
	<div id="aside_menu" class="aside_menu">
		<ul>
			<li class="aside_home_li">
				<a id="aside_home" href="list_invitation.jsp">首页</a>
			</li>	
		</ul>	
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
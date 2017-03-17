<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
<script type="text/javascript">
function see(){
	$.ajax({
		  type: "POST",
		  url: "see_do.jsp"
		})
		  .done(function( msg ) {
		  	$("#see").empty().append(msg);
		  });
	
}
$(function(){
	setInterval("see()",30000);//30000为30秒钟
});
/* 判断添加为空 */
function aa(){
		if($("input[name='title']:first").val()==""){
			alert(	"标题不能为空");
		} else if($("textarea[name='content']:first").val()==""){
			alert(	"内容不能为空");
		} else {
			$("form").submit();
		}
}
</script>
<head>
	<title>网络中心BBS</title>
	<link rel="stylesheet" type="text/css" href="css/list_invitation.css" media="all">
</head>
<body>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
		//分页
		Paging paging = new Paging();
		String u_pageNow = request.getParameter("pageNow");
		if(u_pageNow != null) {
			paging.setPageNow(Integer.parseInt(u_pageNow));
		}
		//定义两个变量接收用户id和权限
		int u_id = 0;
		int u_authority = 0;
	%>
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
<div id="container" class="ibody clearfix" align="center">
	<%
		if(session.getAttribute("uname")==null) {
			//用户未登陆
	%>
	<div  style="margin:8px;"align="left">
		<h4><a href="login.jsp">登陆</a>&nbsp|&nbsp<a href="register.jsp">注册</a></h4>
	</div>
	<%
		} else {
			//用户已登陆
			u_id = (Integer)session.getAttribute("uid");
			u_authority = (Integer)session.getAttribute("uauthority");
	%>
	<div  style="margin:8px;"align="left"> <h4><a href="person.jsp?id=<%=u_id%>"><%=session.getAttribute("uname")%></a> | <a href="logout.jsp">注销</a>
	<%
		if(u_authority == 1) {
	%>
			| <a href="user_control.jsp">用户管理</a>
	<%
			}
	%>
	</h4></div>
	<div style="margin:8px; float: left" id="see">
	<%
		int a = DAOFactory.getReplyDAOInstance().numberUnread(u_id);
		int b = DAOFactory.getCommentDAOInstance().numberUnreadI(u_id);
		int c = DAOFactory.getCommentDAOInstance().numberUnreadR(u_id);
		int m = a + b + c;
		if(m != 0) {
	%>
<h4><a href="see.jsp?m=<%=m%>">您有<%=m%>条新回复</a></h4>
	<%
		}
	%>
	</div><br><br>
	<%
		}
	%>
<div id="feed" class="feed">
	<table style="margin-left:-100px" >
	<%
			//如果有内容，则修改变量i，如果没有，则根据i的值显示无内容提示
			int i = 0;
			List all = null ;
			//获取总记录条数
			int rowCount = 0;
			rowCount = DAOFactory.getInvitationDAOInstance().number();
			paging.setRowCount(rowCount);
			int p = paging.getPageSize()*(paging.getPageNow() - 1);
			all = DAOFactory.getInvitationDAOInstance().queryAll(paging.getPageSize(),p);
	%>
		<tr>
			<td width="8%">回帖数</td>
			<td>标题</td>
			<td width="10%">楼主</td>
			<td width="18%">时间</td>
			<td width="5%"></td>
		</tr> 
		<tr>
			<td colspan="5" height="3px"><img src="image/hui.jpg"></td>
		</tr>
		<%
		Iterator iter = all.iterator() ;
			while(iter.hasNext()) {
				Invitation invi = (Invitation)iter.next() ;
				i++;
				//进行循环打印
				//从数据库取内容
				int Nid = invi.getNid();
				String author = invi.getAuthor();
				String title = invi.getTitle();
				String time = invi.getTime();
				int person_id = invi.getPerson_id();
				int number_r = DAOFactory.getInvitationDAOInstance().numberReply(Nid);
				int number_c = DAOFactory.getInvitationDAOInstance().numberComment(Nid);
				int number = number_r + number_c;
				String flag = "invi";
	%>
		<tr>
			<td><%=number%></td>
			<td><a href="show.jsp?invi_id=<%=Nid%>"><%=title%></a></td>
			<td><a href="person.jsp?id=<%=person_id%>"><%=author%></a></td>
			<td><%=time%></td>
	<%
			if(u_authority == 1) {
	%>
			<td><a href="delete_do.jsp?Nid=<%=Nid%>&flag=<%=flag%>">删除</a></td>
	<%
			}
	%>
		</tr>
		<tr>
			<td colspan="5" height="3px"><img src="image/hui.jpg"></td>
		</tr>
	<%
				}
				//判断i值是否改变，如果改变则表示有内容，反之无内容
				if(i==0) {
					//进行提示
	%>
		<tr>
			<h2>暂无内容</h2>
		</tr>
	<%
				}
	%>
	</table>
	
	<div class="page" align="right">
        <%
		if(rowCount != 0) {
	%>
	<table>
			<tr>
				<td>第<%=paging.getPageNow() %>页</td>
				<td>
						<a href="list_invitation.jsp?pageNow=1">首页</a>					
				</td>
				<td>
	<% 
					if(paging.getPageNow()!=1){
	%>
						<a href=list_invitation.jsp?pageNow=<%=paging.getPageNow()-1 %>>上一页</a>
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
								<a href="list_invitation.jsp?pageNow=<%=l %>">[<%=l %>]</a>
	<%									
							}
						} else {
							if(paging.getPageNow() <= 3) {
								for(l = 1; l <= 5; l++) {
	%>
									<a href="list_invitation.jsp?pageNow=<%=l %>">[<%=l %>]</a>
	<%									
								}
							} else if(paging.getPageNow() > 3 && paging.getPageNow() < paging.getPageCount()-2) {
								for(l =paging.getPageNow()-2 ; l <=paging.getPageNow()+2; l++) {
	%>
									<a href="list_invitation.jsp?pageNow=<%=l %>">[<%=l %>]</a>
	<%								
							}
						} else if(paging.getPageNow() >= paging.getPageCount()-2) {
							for(l = paging.getPageCount()-4; l <=paging.getPageCount(); l++) { 
	%>
								<a href="list_invitation.jsp?pageNow=<%=l %>">[<%=l %>]</a> 
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
						<a href=list_invitation.jsp?pageNow=<%=paging.getPageNow() + 1 %>>下一页</a>
	<%
					}
	%>
				</td>
				<td>
					<a href="list_invitation.jsp?pageNow=<%=paging.getPageCount() %>">末页</a>
				</td>
			</tr>
		</table> 
	<%
				}
	%>
	</div>
	<div id="main_aside" class="content_aside" style="margin-left:-120px; margin-top:20px;">
	   <form action="insert_do.jsp" method="POST">
	   <table>
			<tr>
				<td>发表新帖（登录后发表）</td>
				<td></td>
			</tr>
			<tr>
				<td>标题：</td>
				<td><input type="text"  name="title" style="width:650px; height:30px"></td>
			</tr>
			<tr>
				<td>内容：</td>
				<td><textarea name="content" rows="4" cols="60"  style="width:650px; resize: none;"></textarea></td>
			</tr>
			<tr>
			<td>
				<input type="button" value="发表" onclick="aa()">
			</td>
		</tr>
	   </table>
	   </form>
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
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>网络中心BBS</title>
	<link rel="stylesheet" type="text/css" href="css/use-control.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	/* 判断添加为空 */
	function aa(){
			if($("input[name='keyword']:first").val()==""){
				alert(	"查询不能为空");
			} else {
				$("form").submit();
			}
	}
	</script>
</head>
<body>

<div class="wrap1">
<div class="wrap2">
<div id="head" class=" search_bright clearfix" style="">
		
	<div class="search_main_wrap">
		
   </div>


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
		if(session.getAttribute("uname")!=null) {
		//分页
		Paging paging = new Paging();
		String u_pageNow = request.getParameter("pageNow");
		if(u_pageNow != null) {
			paging.setPageNow(Integer.parseInt(u_pageNow));
		}
		//获取权限
		int u_authority = (Integer)session.getAttribute("uauthority");
		if(u_authority == 1) {
		//如果有内容，则修改变量i，如果没有，则根据i的值显示无内容提示
		int i = 0;
		List all = null ;
		//获取总记录条数
		int rowCount = 0;
		rowCount = DAOFactory.getPersonDAOInstance().number();
		paging.setRowCount(rowCount);
		int p = paging.getPageSize()*(paging.getPageNow() - 1);
		all = DAOFactory.getPersonDAOInstance().queryAll(paging.getPageSize(),p);
	%>
<div id="container" class="ibody clearfix" align="center">
			<h3><p align="left">
				<a href="list_invitation.jsp">进入BBS</a>
			</p></h3>
		<form action="query.jsp" method="POST">
			<p  align="right">
				请输入要查询的用户名/账号：<input type="text" name="keyword">
				<input type="button" value="查询" onclick="aa()">
            </p>
        </form>
		<div class="w750">
              	<div id="content">                	
			<div id="feed" class="feed">
			<div class="feed_head"><!----><h3 class="favth_title">用户管理</h3></div>

 				 <hr />

    
		<table style="border:0px #000000 solid;">    	
        <tr>
            <td width="500px" height="50px"><b>用户名</b></td>
            <td width="500px" height="50px"><b>账号</b></td>
            <td width="100px" height="50px"><b>操作</b></td>
        </tr>
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
		%>
        <tr>
            <td><a href="person.jsp?id=<%=Nid%>"><%=name%></a></td>
			<td><%=account%></td>
		<%
				if(authority == 1) {
		%>
						<td>超级管理员</td>
		<%
				} else {
		%>
           <td><a href="delete_do.jsp?Nid=<%=Nid%>&flag=<%=flag%>">删除</a></td>
		<%
				}
		%>
        </tr>
        <%
				}
				//判断i值是否改变，如果改变则表示有内容，反之无内容
				if(i==0) {
					//进行提示
		%>
					<tr>
						<td colspan="5">没有内容</td>
					</tr>
		<%
				}
		%>
  <table align="right">
<hr>
			<tr>
				<td>第<%=paging.getPageNow() %>页</td>
				<td>
						<a href="user_control.jsp?pageNow=1">首页</a>					
				</td>
				<td>
	<% 
					if(paging.getPageNow()!=1){
	%>
						<a href=user_control.jsp?pageNow=<%=paging.getPageNow()-1 %>>上一页</a>
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
								<a href="user_control.jsp?pageNow=<%=l %>">[<%=l %>]</a>
	<%									
							}
						} else {
							if(paging.getPageNow() <= 3) {
								for(l = 1; l <= 5; l++) {
	%>
									<a href="user_control.jsp?pageNow=<%=l %>">[<%=l %>]</a>
	<%									
								}
						} else if(paging.getPageNow() > 3 && paging.getPageNow() < paging.getPageCount()-2) {
								for(l =paging.getPageNow()-2 ; l <=paging.getPageNow()+2; l++) {
	%>
									<a href="user_control.jsp?pageNow=<%=l %>">[<%=l %>]</a>
	<%								
							}
						} else if(paging.getPageNow() >= paging.getPageCount()-2) {
							for(l = paging.getPageCount()-4; l <=paging.getPageCount(); l++) { 
	%>
								<a href="user_control.jsp?pageNow=<%=l %>">[<%=l %>]</a> 
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
						<a href=user_control.jsp?pageNow=<%=paging.getPageNow() + 1 %>>下一页</a>
	<%
					}
	%>
				</td>
				<td>
					<a href="user_control.jsp?pageNow=<%=paging.getPageCount() %>">末页</a>
				</td>
			</tr>
		</table> 
	
	<%
			}
	%>
</table>
		</div>
<div id="pager" class="itb_pager">
			</div>
</div></div>

			</div>
			<div id="footer" class="footer">                                                                                                    </div>
	</div>
</div>


 </div></div></div></div>
 <%
 			} else {
 				//用户未登陆
 				response.setHeader("refresh","0;URL=login.jsp?a=null");
 			}
 %>
</body>
</html>
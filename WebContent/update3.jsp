<%@page contentType="text/html;charset=utf-8"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>上传头像</title>
	<link rel="stylesheet" type="text/css" href="css/update3.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		function aa(){
			if($("input[name='pic']:first").val()==""){
				alert("头像不能为空");
			} else {
				$("form").submit();
			}
		}
	</script>
</head>
<body>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
	
		/* if(session.getAttribute("uname")!=null) {
			//用户已登陆
			int u_id = (Integer)session.getAttribute("uid");
			Person person = DAOFactory.getPersonDAOInstance().queryById(u_id);
			String name = person.getName();
			String password = person.getPassword(); */
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
	<div id="container" class="ibody clearfix">
	<div class="w750 fleft">
	<div id="content">
	<div id="feed" class="feed">
		<div class="feed_head"><!----><h3 class="favth_title">个人设置</h3>
			<div class="favth_thead"></div>
			<ul>
			<li><label>个人头像</label>
			<%-- <% 
				if(DAOFactory.getPersonDAOInstance().queryHead(u_id) == 0) {
			%> --%>
				<img src="upload/0.jpg" width="120px" height="120px"/>
			<%-- <%
				} else {
			%>
				<img src="upload/<%=u_id%>.jpg" width="120px" height="120px"/>
			<%
				}
			%> --%>
			</li>
			<form action="upload.jsp" method="post" enctype="multipart/form-data">
			<li><label for="user_logo">上传新头像</label> <input class="validate-file-jpg-gif-png-bmp-jpeg" id="user_logo" name="pic" size="30" type="file"><input type="hidden" name="name" value="1"><input value="提交" type="button" style="margin-left:100px" onclick="aa()"></li>
			</form>
			</ul>
		<br/> <%-- <a href="person.jsp?id=<%=u_id%>">返回</a> --%>
		</div>
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
				<p class="aside_userface_border"  style=" box-shadow:#666; border-radius:5px;">
				<%-- <% 
					if(DAOFactory.getPersonDAOInstance().queryHead(u_id) == 0) {
				%> --%>
					<img  src="upload/0.jpg"  style="max-width: 64px; max-height: 64px; width: 64px; height: 64px; visibility: visible; margin-top: 0px;">
				<%-- <%
					} else {
				%>
					<img  src="upload/<%=u_id%>.jpg"  style="max-width: 64px; max-height: 64px; width: 64px; height: 64px; visibility: visible; margin-top: 0px;">
				<%
					}
				%> --%>
				</p>
			</div>
			<div class="aside_user_profile">
				<%-- <p class="aside_user_name"><%=session.getAttribute("uname")%></p>	 --%>					
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
</div>
	<%
		/* } else {
			//用户未登陆
			response.setHeader("refresh","0;URL=login.jsp?a=null");
		} */
	%>
</body>
</html>
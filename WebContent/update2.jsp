<%@page contentType="text/html;charset=utf-8"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>修改密码</title>
	<link rel="stylesheet" type="text/css" href="css/update2.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		/* 两个密码的比较 */
		$(document).ready(function(){  
			$("#a").blur(function(){
				if($('#a').val().length < 6 && $('#a').val().length >0 || $('#a').val().length > 14){
					alert("密码长度应为6-14位");
				}
			});
			$("#b").blur(function(){
				var pass1 = $("#a").val();  
				var pass2 = $("#b").val();
				if(pass1 != pass2){
					alert("密码不一致");
				}
			});
				
		});
		function aa(){
			if($("input[name='password']:first").val()==""){
				alert("密码不能为空");
			} else if($("#b").val()=="") {
				alert("密码不能为空");
			} else if($("#a").val()=="") {
				alert("密码不能为空");
			} else {
				var pass1 = $("#a").val();  
				var pass2 = $("#b").val();
				if(pass1 != pass2){
					alert("密码不一致");
				} else if($('#a').val().length < 6 && $('#a').val().length >0 || $('#a').val().length > 14) {
					alert("密码长度应为6-14位");
				} else {
					$("form").submit();
				}
			}
		}
	</script>
</head>
<body>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
	
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
			int u_id = (Integer)session.getAttribute("uid");
			Person person = DAOFactory.getPersonDAOInstance().queryById(u_id);
			String name = person.getName();
			String password = person.getPassword();
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
		<div id="pc2client" class="pc2client" style=""></div>
		<div id="feed" class="feed">
			<div class="feed_head"><!----><h3 class="favth_title">个人设置</h3>
				<div class="favth_thead"></div>
			   <form action="update_do.jsp" id="setting_form" method="post">
				请输入当前密码：<input style=" width: 240px; height:25px" type="password" name="password"><br/><br/>
				请输入新密码：<input id="a" style=" width: 240px; height:25px; margin-left:10px;" name="password_new" type="password">
				<input type="hidden" name="flag" value="u_password"><br/><br/>
				确认密码：<input id="b" style=" width: 240px; height:25px; margin-left:32px;" name="password_new" type="password"><br/><br/>
					 <input value="修改" type="button" style="margin-left:120px" onclick="aa()">
			   </form>
			   <a href="person.jsp?id=<%=u_id%>">返回</a>
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
				<% 
					if(DAOFactory.getPersonDAOInstance().queryHead(u_id) == 0) {
				%>
					<img  src="upload/0.jpg"  style="max-width: 64px; max-height: 64px; width: 64px; height: 64px; visibility: visible; margin-top: 0px;">
				<%
					} else {
				%>
					<img  src="upload/<%=u_id%>.jpg"  style="max-width: 64px; max-height: 64px; width: 64px; height: 64px; visibility: visible; margin-top: 0px;">
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
	</div>
	</div>
</div>
</div>
</div>
</div>
</div>
</div>
	<%
		} else {
			//用户未登陆
			response.setHeader("refresh","0;URL=login.jsp?a=null");
		}
	%>
</body>
</html>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>修改用户名</title>
	<link rel="stylesheet" type="text/css" href="css/update1.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	/* 判断添加为空 */
	function aa(){
			if($("input[name='name']:first").val()==""){
				alert("用户名不能为空");
			} else if($("input[name='password']:first").val()=="") {
				alert("密码不能为空");
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
	
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
			int u_id = (Integer)session.getAttribute("uid");
			Person person = DAOFactory.getPersonDAOInstance().queryById(u_id);
			String name = person.getName();
			String password = person.getPassword();
	%>
	<div style="z-index: 10005;" id="com_userbar" class="userbar "></div>
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
			  请输入修改后的用户名：<input id="query" class="text" style=" width: 240px; height:25px" name="name" value="<%=name%>">
			  <input type="hidden" name="flag" value="u_name"><br/><br/>
			  请输入密码：<input style=" width: 240px; height:25px; margin-left:60px;" name="password" type="password"><br/><br/>
			  <input class="submit" id="submit_button" name="commit" value="修改" type="button" style="margin-left:130px" onclick="aa()">
		   </form>
		   <a href="person.jsp?id=<%=u_id%>">返回</a>
		</div>
	</div>
	<div id="pager" class="itb_pager"></div>
	</div>
	</div>
	<div id="main_aside" class="content_aside">
	<div id="aside_person_info" class="aside_person_info">
		<div class="aside_p_info_head">
			<span class="right_set"><a href="http://tieba.baidu.com/i/378640509/profile" target="_top"></a></span>
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
		<div class="my_tb_pmclink">	</div>
	</div>
	<div id="aside_menu" class="aside_menu"></div>
	</div>
</div>
	<div id="footer" class="footer"></div>
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
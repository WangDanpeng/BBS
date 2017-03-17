<%@page contentType="text/html;charset=utf-8"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>个人档</title>
	<link rel="stylesheet" rev="stylesheet" href="css/35.css" type="text/css" media="screen">
	<link rel="stylesheet" rev="stylesheet" href="css/app_userinfo.css" type="text/css" media="screen">
</head>
<body>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
		if(request.getParameter("id") != null) {
			String id = request.getParameter("id");
			int p_id = 0;
			try {
				p_id = Integer.parseInt(id);
			} catch(Exception a) {}
			int u_id = 0;
			if(session.getAttribute("uname")!=null) {
				u_id = (Integer)session.getAttribute("uid");
			}
			Person person = DAOFactory.getPersonDAOInstance().queryById(p_id);
			if(person == null) {
				response.setHeader("refresh","0;URL=404.jsp");
			} else {
			String u_name = person.getName();
			String u_password = person.getPassword();
		%>
	<div class="bg_mode">
	<div class="box_ml bor">
		<div class="mode_gb">
			<div class="mode_gb_title style_mode_gb_title">
				<div class="bg_mode_gb_title"></div>
			</div>
			<div class="mode_gb_cont">
			<div style="width:980px; margin:auto; border:ridge; height:600px; border:#CCCCCC solid 1px;">
				<div style="width:500px" class="userinfo_mode" id="app_mod">
					<div class="info_side bg3 bor3">
						<div class="portrait_container">
							<p id="icon_container">
							<% 
								if(DAOFactory.getPersonDAOInstance().queryHead(p_id) == 0) {
							%>
								<img src="upload/0.jpg">
							<%
								} else {
							%>
								<img src="upload/<%=p_id%>.jpg">
							<%
								}
							%>
							</p>
							<div class="counter bbor2" id="profile-cnt">
							<ul class="clearfix"><li><font size="5"><%=u_name%></font></li><br>
			<%
				if(p_id == u_id) {
			%>
							<li class="rbor3"><a href="update1.jsp"><font size="2">修改用户名</font></a></li><li class="rbor3"><a href="update3.jsp"><font size="2">上传头像</font></a></li><li><a href="update2.jsp"><font size="2">修改密码</font></a></li>
							<%
			if(request.getParameter("a") != null) {
				String a = request.getParameter("a");
				if(a.equals("err")) {
		%>
					<br><h3><font color='red'>密码错误</font></h3>
		<%
				}
			}
			}
			
		%>
		</ul>
							</div>
							<div>
								<ul>
									<li><center><a href="list_invitation.jsp">返回首页</a></center></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="info_frame">
						<div id="owner_info_cont" class="owner_info"></div>
						
						<div id="info_preview" class="info_preview">
							<div class="preview_title bbor2">
								<h4>基本资料</h4>
							</div>
							<div class="preview_list">
								<ul>
									<li id="sex_li">
										<label>性别：</label>
										<div id="sex" class="preview_option">未填写</div>
									</li>
									<li id="age_li">
										<label>年龄：</label>
										<div id="age" class="preview_option">未填写</div>
									</li>
									<li id="birthday_li">
										<label>生日：</label>
										<div id="birthday" class="preview_option">未填写</div>
									</li>
									<li id="astro_li">
										<label>星座：</label>
										<div id="astro" class="preview_option">未填写</div>
									</li>
									<li id="live_address_li">
										<label>现居地：</label>
										<div id="live_address" class="preview_option"><span class="spacing">未填写</span>  <span class="spacing"></span>  <span class="spacing"></span></div>
									</li>
									<li id="marriage_li">
										<label>婚姻状况：</label>
										<div id="marriage" class="preview_option">未填写</div>
									</li>
									<li id="blood_li">
										<label>血型：</label>
										<div id="blood" class="preview_option">未填写</div>
									</li>
									<li id="hometown_address_li">
										<label>故乡：</label>
										<div id="hometown_address" class="preview_option">未填写</div>
									</li>
									<li id="career_li">
										<label>职业：</label>
										<div id="career" class="preview_option">未填写</div>
									</li>
									<li id="company_li">
										<label>公司名称：</label>
										<div id="company" class="preview_option">未填写</div>
									</li>
									<li id="company_caddress_li">
										<label>公司所在地：</label>
										<div id="company_caddress" class="preview_option">未填写</div>
									</li>
									<li id="caddress_li">
										<label>详细地址：</label>
										<div id="caddress" class="preview_option">未填写</div>
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
</div>
<%
			}
		} else {
			//用户未登陆
			response.setHeader("refresh","0;URL=login.jsp?a=null");
		}
	%>
</body>
</html>
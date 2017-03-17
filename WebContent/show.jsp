<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>网络中心BBS</title>
	<link rel="stylesheet" type="text/css" href="css/index.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	 <!-- 配置文件 -->
    <script type="text/javascript" src="ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="lang/zh-cn/zh-cn.js"></script>
    <!-- 实例化编辑器 -->
    <script type="text/javascript">
        var ue = UE.getEditor('content');
    </script>
	<script type="text/javascript">
	/* 判断添加为空 */
	function aa(){
		var uname = $("#uname").val();
		if(uname == "") {
			window.location.href="login.jsp?a=null";
		} else {
			var invi_Nid = $("#invi_Nid").val();
			var content = UE.getEditor('content').getContent();
			if(UE.getEditor('content').getContent()==""){
				alert(	"内容不能为空");
			} else {
				UE.getEditor('content').setContent("");
				$.ajax({
					  type: "POST",
					  url: "reply_do.jsp",
					  data: { id: invi_Nid, content: content}
				})
				.done(function(msg) {
				  	$("#content2").append(msg);
				  });
			}
		}
	}
	function cc(Nid_r) {
		var uname = $("#uname").val();
		if(uname == "") {
			window.location.href="login.jsp?a=null";
		} else {
			var invi_id = $("#invi_Nid").val();
			var invi_ac = $("#invi_ac").val();
			var reply_ac = $("#reply_ac").val();
			var content = $("#content3").val();
			if($("textarea[name='content3']:first").val()==""){
				alert(	"内容不能为空");
			} else {
				$("#content3").val('');
				$.ajax({
					  type: "POST",
					  url: "comment_do.jsp",
					  data: { invi_id: invi_id, invi_ac: invi_ac, reply_ac: reply_ac, r_id: Nid_r, content: content}
				})
				.done(function(msg) {
					$("#"+Nid_r).append(msg);
				  });
			}
		}
	}
	function see(){
		$.ajax({
			  type: "POST",
			  url: "see_do.jsp",
			})
			  .done(function( msg ) {
			  	$("#see").empty().append(msg);
			  });
		
	}
	$(function(){
		setInterval("see()",30000);//30000为30秒钟
	});
	</script>
</head>
<body class="skin_normal" spellcheck="false">
	<div class="search_main_wrap">
		<div class="search_main clearfix">
			<center><img src="image/head5.jpg"></center>
		</div>
	</div>
	      
   <div id="container" class="l_container  ">

   <div class="nav_wrap nav_wrap_add_border" id="tb_nav">
   <div class="core_title core_title_theme_bright">
   <%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
		//接收URL传值
		String invi_id = request.getParameter("invi_id");
		int invi_Nid =0;
		try {
			invi_Nid = Integer.parseInt(invi_id);
		} catch(Exception a) {}
			//按id查询帖子信息并显示
		Invitation invi = DAOFactory.getInvitationDAOInstance().queryById(invi_Nid);
			if(invi == null) {
				response.setHeader("refresh","0;URL=404.jsp");
			} else {
		String author = invi.getAuthor();
		String title = invi.getTitle();
		String content = invi.getContent();
		String time = invi.getTime();
		int person_id = invi.getPerson_id();
		//分页
		Paging paging = new Paging();
		String u_pageNow = request.getParameter("pageNow");
		if(u_pageNow != null) {
			paging.setPageNow(Integer.parseInt(u_pageNow));
		}
		//定义两个变量接收用户id和权限
		int u_id = 0;
		int u_authority = 0;
		String uname = "";
		if(session.getAttribute("uname")==null) {
			//用户未登陆
	%>
	<h1 class="core_title_txt "  style="width: 470px;"> <a href="login.jsp">登陆</a> | <a href="register.jsp">注册</a> | <a href="list_invitation.jsp">返回首页</a></h1>
	<%
		} else {
			//用户已登陆
			u_id = (Integer)session.getAttribute("uid");
			u_authority = (Integer)session.getAttribute("uauthority");
			uname = (String)session.getAttribute("uname");
	%>
   <h1 class="core_title_txt "  style="width: 470px;"> <a href="person.jsp?id=<%=u_id%>"><%=session.getAttribute("uname")%></a> | <a href="logout.jsp">注销</a>
   <%
		if(u_authority == 1) {
	%>
   | <a href="user_control.jsp">用户管理</a>
   <%
		}
	%>
   | <a href="list_invitation.jsp">返回首页</a></h1>
    <%
		}
	%>
	<input type="hidden" id="uname" value="<%=uname%>">
   </div></div>
   <div class="pb_content clearfix" id="pb_content">
   <div class="left_section">
   <div style="width: 980px; display: block;" class="core_title_wrap core_title_wrap_bright" id="j_core_title_wrap">
   <div class="core_title core_title_theme_bright">    
   <h1 class="core_title_txt " style="width: 470px;"><%=title%></h1>
   </div>
   </div>
   <div class="p_postlist" id="j_p_postlist">
   <div is_showed="true" id="content2" class="l_post noborder l_post_bright" data-field="#">
   
   <div class="d_author">				
  		<ul class="p_author">
				<li class="icon">
		  			<div class="icon_relative j_user_card">
				  		<a style="" target="_top" class="p_author_face " href="person.jsp?id=<%=person_id%>">
				  			<% 
								if(DAOFactory.getPersonDAOInstance().queryHead(person_id) == 0) {
							%>
								<img src="upload/0.jpg">
							<%
								} else {
							%>
								<img src="upload/<%=person_id%>.jpg">
							<%
								}
							%>
				  		</a>
			  		</div>	
			 	</li>
			 	<li class="d_name" data-field="{&quot;user_id&quot;:407068486}">
				 	<a class="p_author_name j_user_card" href="person.jsp?id=<%=person_id%>" target="_top"><%=author%></a>
			 	</li>
			</ul>
			</div>
			<div class="d_post_content_main d_post_content_firstfloor">
			<div class="p_content p_content_nameplate">			
			<cc>
			<div id="post_content_50565537239" class="d_post_content j_d_post_content "><pre><%=content%></pre></div>
			</cc><br><br>
			</div><div class="share_btn_wrapper">	
			<div class="j_lzl_r p_reply" data-field="{&quot;pid&quot;:50566195978,&quot;total_num&quot;:null}">
			<a href="#bottom" class="lzl_link_unfold" style="display:;">回复</a>
			</div>
			<ul class="p_tail">
			<li><span>1楼</span></li>
			<li><span><%=time%></span></li>
			</ul>
			<ul class="p_mtail">
			<!-- <li><span class="p_tail_txt">来自</span>
			<span class="tip_bubble_con"></span><a class="p_tail_wap" href="#" target="_top">iPhone客户端</a>
			</li> -->
			</ul>
			</div>
			</div>
	<%
		int i = 0;
		List all = null ;
		//获取总记录条数
		int rowCount = 0;
		rowCount = DAOFactory.getReplyDAOInstance().number(invi_Nid);
		paging.setRowCount(rowCount);
		int p = paging.getPageSize()*(paging.getPageNow() - 1);
		all = DAOFactory.getReplyDAOInstance().queryAll(invi_Nid,paging.getPageSize(),p);
		Iterator iter = all.iterator() ;
		while(iter.hasNext()) {
			Reply reply = (Reply)iter.next() ;
			//进行循环打印回复
			//从数据库取内容
			int Nid_r = reply.getNid();
			String author_r = reply.getAuthor();
			String content_r = reply.getContent();
			String time_r = reply.getTime();
			int id_r = reply.getInvitation_id();
			int p_id = reply.getPerson_id();
			int floor = reply.getFloor();
			if(u_id == person_id) {
				reply.setSee(1);
				DAOFactory.getReplyDAOInstance().update(reply);
			}
				i++;
				String flag = "reply";
	%>
			<div >
			
			<div class="d_author">			
			<ul class="p_author">
			<li class="icon">
			<div class="icon_relative j_user_card" data-field="{&quot;un&quot;:&quot;\u6211\u662f\u9893\u5e9f\u82f1\u96c4&quot;}">
				<a style="" target="_top" class="p_author_face " href="person.jsp?id=<%=p_id%>">
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
				</a>
			</div>	
			</li>
			<li class="d_nameplate">
				<a class="pb_np_get" href="person.jsp?id=<%=p_id%>" target="_top" ><%=author_r%></a>
			</li>
			</ul>
			</div>
			<div class="d_post_content_main"><hr width="980px" color="#CCCCCC" style="margin-left:-150px;"/>
			<div class="p_content p_content_nameplate">
			
			<div id="post_content_50566195978" class="d_post_content j_d_post_content "><pre><%=content_r%></pre><a name="<%=Nid_r%>"></a></div></cc><br><br>
			</div>
			<div class="core_reply j_lzl_wrapper"><a class="l_post_anchor" name="50566195978l"></a>
			<div class="core_reply_tail ">
			<div class="j_lzl_r p_reply" data-field="{&quot;pid&quot;:50566195978,&quot;total_num&quot;:null}">
			<input type="hidden" value="<%=Nid_r%>" name="Nid_r"><input type="submit" value="回复" onclick="ss(<%=Nid_r%>,<%=p_id%>,<%=i+1%>)">
	<%
			if(u_id == person_id ||  u_authority == 1) {
	%>
			<a href="delete_do.jsp?Nid_r=<%=Nid_r%>&invi_id=<%=id_r%>&flag=<%=flag%>">删除</a>
	<%
			}
	%>
			</div> 
			<ul class="p_tail">
			<li><span><%=floor%>楼</span></li>
			<li><span><%=time_r%></span></li>
			</ul>
			<ul class="p_mtail">
		<%-- <%
			int x = (int)(Math.random() * 8);
			if(x == 0) {
				x=1;
			}	
			String client = DAOFactory.getInvitationDAOInstance().queryClient(x);
		%>
			<li><span class="p_tail_txt">来自</span>
			<span class="tip_bubble_con"></span><a class="p_tail_wap" href="" target="_top"><%=client %>客户端</a>
			</li> --%>
			</ul>
			
			</div>
			<div style="width: 800px">
			<table style="width: 100%" id="<%=Nid_r%>">
	<%
			List all_c = null ;
			all_c = DAOFactory.getCommentDAOInstance().queryAll();
			Iterator iter_r = all_c.iterator() ;
			while(iter_r.hasNext()) {
				Comment comment = (Comment)iter_r.next() ;
				//进行循环打印
				//从数据库取内容
				int Nid_c = comment.getNid();
				String author_c = comment.getAuthor();
				String content_c = comment.getContent();
				String time_c = comment.getTime();
				int id_invi = comment.getInvitation_id();
				int rid_c = comment.getReply_id();
				int person_c = comment.getPerson_id();
				int invi_user_id = comment.getInvi_user_id();
				int reply_user_id = comment.getReply_user_id();
				int see = comment.getSee();
				if(rid_c == Nid_r) {
					flag = "comment";
					if(see == 0 && u_id == invi_user_id) {
						comment.setSee(1);
						DAOFactory.getCommentDAOInstance().update(comment);
					} else if (see == 0 && u_id == reply_user_id) {
						comment.setSee(2);
						DAOFactory.getCommentDAOInstance().update(comment);
					} else if(see == 1 && u_id == reply_user_id) {
						comment.setSee(3);
						DAOFactory.getCommentDAOInstance().update(comment);
					} else if(see == 2 && u_id == invi_user_id) {
						comment.setSee(3);
						DAOFactory.getCommentDAOInstance().update(comment);
					}
	%>
			<tr>
			<td style="width: 7%">
			<input type="hidden" id="invi_ac" value="<%=person_id%>">
			<input type="hidden" id="reply_ac" value="<%=p_id%>">
			<% 
								if(DAOFactory.getPersonDAOInstance().queryHead(person_c) == 0) {
							%>
								<img src="upload/0.jpg" width="30px" height="30px">
							<%
								} else {
							%>
								<img src="upload/<%=person_c%>.jpg" width="30px" height="30px"/>
							<%
								}
							%>
			</td>
			<td style="width: 7%">
			<a href="person.jsp?id=<%=person_c%>" name="c<%=Nid_c%>"><%=author_c%>：</a>
			</td>
			<td><%=content_c%></td>
			<td style="width: 15%"><%=time_c%></td>
	<%
					if(u_id == person_id ||  u_authority == 1) {
	%>
			<td style="width: 4%"><a href="delete_do.jsp?Nid_c=<%=Nid_c%>&invi_id=<%=id_invi%>&flag=<%=flag%>">删除</a></td>
	<%
					}
				}
	%>
		</tr>
		
		<%
			}
	%>
			</table>
			</div>
			<div id="hf<%=i+1%>"></div>
			<script type="text/javascript">
		function ss(ss,cc,aa){
			var v = document.getElementById('hf'+aa).innerHTML;
			if(v==null || v==''){
				$('#hf'+aa).empty().append("<textarea type='text' id='content3' name='content3' style='width:650px; resize: none;'></textarea><input type='submit' value='确定' onclick='cc("+ss+")'>");
			} else {
				$('#hf'+aa).empty();
			}
		}
	</script>
			</div>
			</div>    
			           
			</div>
	<%
		}
	%>
			</div>
			</div>
			</div>
			</div>
			<div id="page">
	<%
		if(rowCount != 0) {
	%>
	<table align="right">
			<tr>
				<td>第<%=paging.getPageNow() %>页</td>
				<td>
						<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=1">首页</a>					
				</td>
				<td>
	<% 
					if(paging.getPageNow()!=1){
	%>
						<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=paging.getPageNow()-1 %>">上一页</a>
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
								<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=l %>">[<%=l %>]</a>
	<%									
							}
						} else {
							if(paging.getPageNow() <= 3) {
								for(l = 1; l <= 5; l++) {
	%>
										<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=l %>">[<%=l %>]</a>
	<%									
								}
							} else if(paging.getPageNow() > 3 && paging.getPageNow() < paging.getPageCount()-2) {
								for(l =paging.getPageNow()-2 ; l <=paging.getPageNow()+2; l++) {
	%>
									<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=l %>">[<%=l %>]</a>
	<%								
							}
						} else if(paging.getPageNow() >= paging.getPageCount()-2) {
							for(l = paging.getPageCount()-4; l <=paging.getPageCount(); l++) { 
	%>
								<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=l %>">[<%=l %>]</a> 
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
						<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=paging.getPageNow() + 1 %>">下一页</a>
	<%
					}
	%>
				</td>
				<td>
					<a href="show.jsp?invi_id=<%=invi_Nid%>&pageNow=<%=paging.getPageCount() %>">末页</a>
				</td>
			</tr>
		</table> 
	<%
		}
	%>
			</div>
			

		<div id="text">
			<hr>
				<table>
					<tr>
						<td colspan="2"><a name="bottom">发表回复（登陆后发表）</a></td>
					</tr>
					<tr>
						<td><textarea id="content" name="content" cols="30" rows="6" style="width: 980px; resize: none;"></textarea></td>
					</tr>
					<tr>
						<td>
							<input type="hidden" id="invi_Nid" value="<%=invi_Nid%>">
							<input type="button" value="确定" onclick="aa()">
						</td>
					</tr>
				</table>
		</div>
		<div id="see">
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
   		}
	%>
		</div>
</div>			
</body>
</html>
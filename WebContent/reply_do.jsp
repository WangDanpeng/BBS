<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
</head>
<body>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
	%>
	<%
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
			//接收URL传值
			String id = request.getParameter("id");
			int Nid = Integer.parseInt(id);
			String content = request.getParameter("content");
	%>
	<jsp:useBean id="reply" scope="request" class="wlzx.bbs.vo.Reply"/>
	<jsp:setProperty name="reply" property="*"/>
	<%
			//从session获取登陆人name和id并添加到回复中
			reply.setAuthor((String)session.getAttribute("uname"));
			reply.setContent(content);
			reply.setPerson_id((Integer)session.getAttribute("uid"));
			reply.setInvitation_id(Nid);
			List al = DAOFactory.getReplyDAOInstance().queryAll(Nid);
			if(al.size() == 0) {
				reply.setFloor(2);
			} else {
				Reply rep = (Reply)al.get(al.size()-1);
				//int floor = DAOFactory.getReplyDAOInstance().number(Nid) + 2;
				reply.setFloor(rep.getFloor()+1);
			}
			Invitation invi2 = DAOFactory.getInvitationDAOInstance().queryById(Nid);
			reply.setInvi_user_id(invi2.getPerson_id());
			//System.out.println(reply.getContent());
			if((Integer)session.getAttribute("uid") == reply.getInvi_user_id()) {
				reply.setSee(1);
			}
			int person_id = 0;
			/* response.setHeader("refresh","0;URL=show.jsp?invi_id="+Nid); */
			boolean b = true;
			try{
				DAOFactory.getReplyDAOInstance().insert(reply);
				List all = DAOFactory.getReplyDAOInstance().queryAll();
				//获取刚添加的回复
				Reply reply2 = (Reply)all.get(0);
				Invitation invi = DAOFactory.getInvitationDAOInstance().queryById(Nid);
				person_id = invi.getPerson_id();
				invi.setShowtime(reply2.getTime());
				DAOFactory.getInvitationDAOInstance().update(invi);
				} 
			catch(Exception e) {
				b = false;
			}
			if(b) {
			
			} else {
				/* response.setHeader("refresh","0;URL=errors.jsp"); */
			}
	%>
	<% 
		int u_authority = (Integer)session.getAttribute("uauthority");
		List aall = DAOFactory.getReplyDAOInstance().queryAll(Nid);
		int i = DAOFactory.getReplyDAOInstance().number(Nid);
		Reply replyy = (Reply)aall.get(aall.size()-1);
		int Nid_r = replyy.getNid();
		String author_r = replyy.getAuthor();
		String content_r = replyy.getContent();
		String time_r = replyy.getTime();
		int id_r = replyy.getInvitation_id();
		int p_id = replyy.getPerson_id();
		int floor2 = replyy.getFloor();
		String flag = "reply";
	%>
	<div >
			
			<div class="d_author">			
			<ul class="p_author">
			<li class="icon">
			<div class="icon_relative j_user_card" data-field="{&quot;un&quot;:&quot;\u6211\u662f\u9893\u5e9f\u82f1\u96c4&quot;}">
				<a style="" target="_top" class="p_author_face " href="person.jsp?id=<%=(Integer)session.getAttribute("uid")%>">
				<% 
								if(DAOFactory.getPersonDAOInstance().queryHead((Integer)session.getAttribute("uid")) == 0) {
							%>
								<img src="upload/0.jpg">
							<%
								} else {
							%>
								<img src="upload/<%=(Integer)session.getAttribute("uid")%>.jpg">
							<%
								}
							%>
				</a>
			</div>	
			</li>
			<li class="d_nameplate">
				<a class="pb_np_get" href="person.jsp?id=<%=(Integer)session.getAttribute("uid")%>" target="_top" ><%=author_r%></a>
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
			<from action="show.jsp" method="post"><input type="hidden" value="<%=Nid_r%>" name="Nid_r"><input type="submit" value="回复" onclick="ss(<%=Nid_r%>,<%=p_id%>,<%=i+1%>)"></from>
	<%
			if((Integer)session.getAttribute("uid") == person_id ||  u_authority == 1) {
	%>
			<a href="delete_do.jsp?Nid_r=<%=Nid_r%>&invi_id=<%=id_r%>&flag=<%=flag%>">删除</a>
	<%
			}
	%>
			</div> 
			<ul class="p_tail">
			<li><span><%=floor2%>楼</span></li>
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
			<div id="hf<%=i+1%>"></div>
			<script type="text/javascript">
		function ss(ss,cc,aa){
			var v = document.getElementById('hf'+aa).innerHTML;
			if(v==null || v==''){
				$('#hf'+aa).empty().append("<form action='comment_do.jsp?invi_id="+<%=Nid%>+"&invi_ac="+<%=person_id%>+"&reply_ac="+cc+"&r_id="+ss+"' method='POST'><textarea type='text' name='content' style='width:650px; resize: none;'></textarea><input type='submit' value='确定'></form>");
			} else {
				$('#hf'+aa).empty();
			}
		}
	</script>
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
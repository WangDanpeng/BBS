<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
	%>
	<%
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
	%>
	<jsp:useBean id="comment" scope="request" class="wlzx.bbs.vo.Comment"/>
	<jsp:setProperty name="comment" property="*"/>
	<%
			//从session获取登陆人name和id并添加到评论中
			comment.setAuthor((String)session.getAttribute("uname"));
			comment.setPerson_id((Integer)session.getAttribute("uid"));
			//接收URL传值
			String id_invi = request.getParameter("invi_id");
			int invi_id = Integer.parseInt(id_invi);
			String id_r = request.getParameter("r_id");
			int r_id = Integer.parseInt(id_r);
			String invi_ac = request.getParameter("invi_ac");
			int invi_user_id = Integer.parseInt(invi_ac);
			String reply_ac = request.getParameter("reply_ac");
			int reply_user_id = Integer.parseInt(reply_ac);
			String content = request.getParameter("content");
			
			comment.setInvitation_id(invi_id);
			comment.setReply_id(r_id);
			comment.setInvi_user_id(invi_user_id);
			comment.setReply_user_id(reply_user_id);
			comment.setContent(content);
			if((Integer)session.getAttribute("uid") == comment.getInvi_user_id() && (Integer)session.getAttribute("uid") == comment.getReply_user_id()) {
				comment.setSee(3);
			} else if((Integer)session.getAttribute("uid") == comment.getInvi_user_id()) {
				comment.setSee(1);
			} else if((Integer)session.getAttribute("uid") == comment.getReply_user_id()) {
				comment.setSee(2);
			} 
			//response.setHeader("refresh","0;URL=show.jsp?invi_id="+invi_id);
			boolean b = true;
			try{
				//执行评论添加方法
				DAOFactory.getCommentDAOInstance().insert(comment);
			} catch(Exception e) {
				b = false;
			}
			if(b) {} else {
				/* response.setHeader("refresh","0;URL=errors.jsp"); */
			}
	%>
	<%
		int u_authority = (Integer)session.getAttribute("uauthority");
		List all_c = null ;
		all_c = DAOFactory.getCommentDAOInstance().queryAll(r_id);
		Comment com = (Comment)all_c.get(all_c.size() - 1);
		int person_c = com.getPerson_id();
		int Nid_c = com.getNid();
		String author_c = com.getAuthor();
		String content_c = com.getContent();
		String time_c = com.getTime();
		String flag = "comment";
	%>
	<tr>
			<td style="width: 7%">
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
					if((Integer)session.getAttribute("uid") == person_c ||  u_authority == 1) {
	%>
			<td style="width: 4%"><a href="delete_do.jsp?Nid_c=<%=Nid_c%>&invi_id=<%=id_invi%>&flag=<%=flag%>">删除</a></td>
	<%
					}
	%>
		</tr>
	<%
		} else {
			//用户未登陆
			response.setHeader("refresh","0;URL=login.jsp?a=null");
		}
	%>

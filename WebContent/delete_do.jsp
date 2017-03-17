<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<html>
<head>
	<title>网络中心BBS</title>
</head>
<body>
	<%
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
			//获取标记
			String flag = request.getParameter("flag");
			boolean b = false;
			if(flag.equals("comment")) {
				//删除评论
				String id = request.getParameter("Nid_c");
				int Nid_c = Integer.parseInt(id);
				String id_invi = request.getParameter("invi_id");
				int invi_id = Integer.parseInt(id_invi);
				try{
				DAOFactory.getCommentDAOInstance().delete(Nid_c);
				response.setHeader("refresh","0;URL=show.jsp?invi_id="+invi_id);
				b = true;
				} catch(Exception e) {}
			} else if(flag.equals("reply")) {
				//删除回复
				String id = request.getParameter("Nid_r");
				int Nid_r = Integer.parseInt(id);
				String id_invi = request.getParameter("invi_id");
				int invi_id = Integer.parseInt(id_invi);
				try{
					DAOFactory.getReplyDAOInstance().delete_c(Nid_r);
					DAOFactory.getReplyDAOInstance().delete(Nid_r);
					response.setHeader("refresh","0;URL=show.jsp?invi_id="+invi_id);
				b = true;
				} catch(Exception e) {}
			} else if(flag.equals("invi")) {
				//删除帖子
				String id = request.getParameter("Nid");
				int Nid = Integer.parseInt(id);
				try{
					DAOFactory.getInvitationDAOInstance().delete_c(Nid);
					DAOFactory.getInvitationDAOInstance().deleteReply(Nid);
					DAOFactory.getInvitationDAOInstance().delete(Nid);
					response.setHeader("refresh","0;URL=list_invitation.jsp");
				b = true;
				} catch(Exception e) {}
			} else if(flag.equals("u_control")) {
				//删除用户
				String id = request.getParameter("Nid");
				int Nid = Integer.parseInt(id);
				try{
					DAOFactory.getPersonDAOInstance().delete_c(Nid);
					DAOFactory.getPersonDAOInstance().delete_reply(Nid);
					DAOFactory.getPersonDAOInstance().delete_invi(Nid);
					DAOFactory.getPersonDAOInstance().delete_u(Nid);
					response.setHeader("refresh","0;URL=user_control.jsp");
					b = true;
				} catch(Exception e) {}
			}
			if(b) {} else {
				/* response.setHeader("refresh","0;URL=errors.jsp"); */
			}
		} else {
			//用户未登陆
			response.setHeader("refresh","0;URL=login.jsp?a=null");
		}
	%>
</body>
</html>
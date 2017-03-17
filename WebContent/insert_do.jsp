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
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
	
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
	%>
	<jsp:useBean id="invitation" scope="request" class="wlzx.bbs.vo.Invitation"/>
	<jsp:setProperty name="invitation" property="*"/>
	<%
			//从session获取登陆人name和id并添加到帖子中
			invitation.setAuthor((String)session.getAttribute("uname"));
			invitation.setPerson_id((Integer)session.getAttribute("uid"));
			boolean b = true;
			try{
				//执行帖子添加方法
				DAOFactory.getInvitationDAOInstance().insert(invitation);
				List all = null;
				all = DAOFactory.getInvitationDAOInstance().queryAll();
				//获取刚添加帖子的id
				Invitation invi = (Invitation)all.get(0);
				int invi_id = invi.getNid();
				response.setHeader("refresh","0;URL=show.jsp?invi_id="+invi_id);
			} catch(Exception e) {
				b = false;
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
<%@ page language="java" import="java.util.*,wlzx.bbs.factory.*,wlzx.bbs.vo.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网络中心BBS</title>
</head>
<body>
<%
	if(session.getAttribute("uname")!=null) {
		int u_id = (Integer)session.getAttribute("uid");
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
</body>
</html>
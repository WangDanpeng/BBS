<%@page contentType="text/html;charset=utf-8"%>
<html>
<head>
	<title>网络中心BBS</title>
</head>
<body>
	<%
		if(session.getAttribute("uname")!=null) {
			//用户已登陆
			boolean b = true;
			try{
				response.setHeader("refresh","0;URL=list_invitation.jsp");
				//注销用户
				session.invalidate();
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
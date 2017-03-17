<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="wlzx.bbs.vo.*"%>
<%@page import="wlzx.bbs.factory.*"%>
<%@page import="java.security.MessageDigest"%>
<html>
<head>
	<title>网络中心BBS</title>
</head>
<body>
	<%
		//乱码处理
		request.setCharacterEncoding("utf-8") ;
	%>
	<jsp:useBean id="person" scope="request" class="wlzx.bbs.vo.Person"/>
	<jsp:setProperty name="person" property="*"/>
	<%
			response.setHeader("refresh","0;URL=login.jsp?a=reg");
			boolean b = true;
			try{
				String password = request.getParameter("password");
				MessageDigest md = MessageDigest.getInstance("MD5"); 
				md.update(password.getBytes()); 
				byte c[] = md.digest(); 

				int i; 

				StringBuffer buf = new StringBuffer(""); 
				for (int offset = 0; offset < c.length; offset++) { 
				i = c[offset]; 
				if(i<0) i+= 256; 
				if(i<16) 
				buf.append("0"); 
				buf.append(Integer.toHexString(i)); 
				}
				person.setPassword(buf.toString());
				//执行注册方法
				DAOFactory.getPersonDAOInstance().register(person);
			} catch(Exception e) {
				b = false;
			}
			if(b) {
			} else {
				response.setHeader("refresh","0;URL=login.jsp?a=ree");
			}
	%>
</body>
</html>
<%@page contentType="text/html;charset=utf-8"%>
<%@page import="wlzx.bbs.factory.*"%>
<%@page import="java.security.MessageDigest"%>
<html>
<head>
</head>
<body>
	<jsp:useBean id="person" scope="request" class="wlzx.bbs.vo.Person"/>
	<jsp:setProperty name="person" property="*"/>
	<%
		try {
			String password = request.getParameter("password");
			MessageDigest md = MessageDigest.getInstance("MD5"); 
			md.update(password.getBytes()); 
			byte b[] = md.digest(); 

			int i; 

			StringBuffer buf = new StringBuffer(""); 
			for (int offset = 0; offset < b.length; offset++) { 
			i = b[offset]; 
			if(i<0) i+= 256; 
			if(i<16) 
			buf.append("0"); 
			buf.append(Integer.toHexString(i)); 
			}
			person.setPassword(buf.toString());
			//跳转
			if(DAOFactory.getPersonDAOInstance().login(person)) {
				//用户合法
				//设置用户姓名到session范围中
				session.setAttribute("uname",person.getName()) ;
				//设置用户Nid到session范围中
				session.setAttribute("uid",person.getNid()) ;
				//设置用户权限到session范围中
				session.setAttribute("uauthority",person.getAuthority()) ;
				response.setHeader("refresh","0;URL=list_invitation.jsp");
			} else {
				//用户非法
				response.setHeader("refresh","0;URL=login.jsp?a=err");
			}
		} catch(Exception e) {}
	%>
</body>
</html>
<%@page contentType="text/html;charset=utf-8"%>
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

		if(session.getAttribute("uname")!=null) {
			//用户已登陆
			//接收URL传值
			int u_id = (Integer)session.getAttribute("uid");
			String flag = request.getParameter("flag");
			boolean b = false;
			if(flag.equals("u_name")) {
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
				//修改用户名
				String name = request.getParameter("name");
				try{
					Person person = DAOFactory.getPersonDAOInstance().queryById(u_id);
					if(buf.toString().equals(person.getPassword())) {
						person.setName(name);
						DAOFactory.getPersonDAOInstance().updateName(person);
						session.setAttribute("uname",person.getName());
						b = true;
						response.setHeader("refresh","0;URL=person.jsp?id="+u_id);
					}
				} catch(Exception e) {}
			} else if(flag.equals("u_password")) {
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
				
				String password2 = request.getParameter("password_new");
				MessageDigest md2 = MessageDigest.getInstance("MD5"); 
				md2.update(password2.getBytes()); 
				byte c2[] = md2.digest(); 

				int i2; 

				StringBuffer buf2 = new StringBuffer(""); 
				for (int offset = 0; offset < c2.length; offset++) { 
				i2 = c2[offset]; 
				if(i2<0) i2+= 256; 
				if(i2<16) 
				buf2.append("0"); 
				buf2.append(Integer.toHexString(i2)); 
				}
				//修改用户密码
				try{
					Person person = DAOFactory.getPersonDAOInstance().queryById(u_id);
					if(buf.toString().equals(person.getPassword())) {
						person.setPassword(buf2.toString());
						DAOFactory.getPersonDAOInstance().updatePassword(person);
						b = true;
						response.setHeader("refresh","0;URL=login.jsp?a=suc");
						session.invalidate();
					}
				} catch(Exception e) {}
			}
			if(b) {} else {
				response.setHeader("refresh","0;URL=person.jsp?id="+u_id+"&a=err");
			}
	
		} else {
			//用户未登陆
			response.setHeader("refresh","0;URL=login.jsp?a=null");
		}
	%>
</body>
</html>
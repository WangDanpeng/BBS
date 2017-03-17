<%@page import="wlzx.bbs.factory.DAOFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网络中心BBS</title>
</head>
<body>
<jsp:useBean id="smart" scope="page" class="com.jspsmart.upload.SmartUpload"/>
<%
	// 上传初始化
	smart.initialize(pageContext) ;
	// 准备上传
	smart.upload() ;
	// 接收URL传值
	String name = smart.getRequest().getParameter("name");
	int userid = Integer.parseInt(name);
	//固定图片名
	String photoName = name+".jpg";
	//上传的地址
	String fileAddress=this.getServletContext().getRealPath("/")+"upload\\"+photoName;
	//DAOFactory.getPersonDAOInstance().head(userid, fileAddress);
	//上传图片
	smart.getFiles().getFile(0).saveAs(fileAddress);
	//int u_id = (Integer)session.getAttribute("uid");
	//response.setHeader("refresh","0;URL=person.jsp?id="+u_id);
	System.out.println("上传成功！");
%>
</body>
</html>
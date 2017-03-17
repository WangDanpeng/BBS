<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="wlzx.bbs.factory.*"%>

<%
		request.setCharacterEncoding("utf-8");
		String acco = request.getParameter("account");
		int ac = DAOFactory.getPersonDAOInstance().repeat(acco);
		out.println(ac);
%>

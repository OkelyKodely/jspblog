<%@page language="java"%>
<%
session.invalidate();
response.sendRedirect("login.jsp");
%>
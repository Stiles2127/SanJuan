<%-- 
    Document   : logout
    Created on : 19 may. 2025, 10:12:50
    Author     : LAB-USR-SJL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>


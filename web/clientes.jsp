<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clientes - Gestión CRUD</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/estilo_indexAdmin.css">
</head>
<body data-context="${pageContext.request.contextPath}">
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <h1 class="title">Gestión de Clientes</h1>
    <div id="form-clientes"></div>
    <div id="tabla-clientes"></div>
</div>
<script src="${pageContext.request.contextPath}/JS/clientes.js"></script>
</body>
</html>


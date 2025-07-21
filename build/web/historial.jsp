<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historial de Reservas y Pagos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/estilo_indexAdmin.css">
</head>
<body data-context="${pageContext.request.contextPath}">
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <h1 class="title">Historial de Cliente</h1>
    <div class="search-bar">
        <form id="formBusquedaHistorial" onsubmit="buscarHistorial(event)">
            <input type="text" name="busqueda" id="busqueda" placeholder="Buscar por usuario, DNI, correo o nombre..." list="sugerenciasClientes" autocomplete="off">
            <datalist id="sugerenciasClientes">
                <%
                Connection conS = Conexion.getConnection();
                Statement stS = conS.createStatement();
                ResultSet rsS = stS.executeQuery("SELECT Usuario, Nombre, Apellido, DNI, Correo FROM usuarios");
                while(rsS.next()) {
                    String sug = rsS.getString("Usuario") + " - " + rsS.getString("Nombre") + " " + rsS.getString("Apellido")
                        + " (" + rsS.getString("DNI") + ", " + rsS.getString("Correo") + ")";
                %>
                    <option value="<%=sug%>"></option>
                <% }
                rsS.close(); stS.close(); conS.close();
                %>
            </datalist>
            <button type="submit" class="login">Buscar</button>
        </form>
    </div>
    <div id="resultados-historial" class="resultados">
        <div class="msg-info">Busca y selecciona un cliente para ver su historial.</div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/JS/historial.js"></script>
</body>
</html>



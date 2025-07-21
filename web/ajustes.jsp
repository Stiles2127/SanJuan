<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajustes de Sistema</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/estilo_indexAdmin.css">
</head>
<body data-context="${pageContext.request.contextPath}">
<%@ include file="sidebar.jsp" %>
<div class="main-content">

    <!-- GESTIÓN DE TARIFAS -->
    <h1 class="title">Tarifas por Sede</h1>
    <form id="formNuevaTarifa">
        <select name="estacionamiento" id="estacionamiento-tarifa" required>
            <%
                Connection con1 = Conexion.getConnection();
                Statement st1 = con1.createStatement();
                ResultSet rs1 = st1.executeQuery("SELECT * FROM estacionamientos");
                while(rs1.next()){
            %>
                <option value="<%=rs1.getInt("EstacionamientoID")%>"><%=rs1.getString("Nombre")%></option>
            <% } rs1.close(); st1.close(); con1.close(); %>
        </select>
        <input type="text" name="tipoVehiculo" id="vehiculo-tarifa" placeholder="Tipo de Vehículo" required>
        <input type="number" name="precio" id="precio-tarifa" placeholder="Precio" step="0.1" required>
        <button type="button" class="registro" onclick="guardarTarifa()">Agregar / Modificar Tarifa</button>
    </form>

    <div id="tabla-tarifas"></div>

    <!-- GESTIÓN DE SEDES -->
    <h2 class="subtitulo">Agregar Nueva Sede</h2>
    <form id="formNuevaSede">
        <input type="text" name="nombreSede" placeholder="Nombre de la sede" required>
        <input type="text" name="direccionSede" placeholder="Dirección de la sede" required>
        <button type="button" class="registro" onclick="agregarSede()">Crear Sede</button>
    </form>

    <!-- GESTIÓN DE ESPACIOS -->
    <h3>Agregar varios espacios a una sede</h3>
    <form id="formAgregarEspacios">
        <select name="estacionamientoEspacio" id="estacionamiento-espacio" required>
            <%
                Connection con2 = Conexion.getConnection();
                Statement st2 = con2.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT * FROM estacionamientos");
                while(rs2.next()){
            %>
                <option value="<%=rs2.getInt("EstacionamientoID")%>"><%=rs2.getString("Nombre")%></option>
            <% } rs2.close(); st2.close(); con2.close(); %>
        </select>
        <select name="tipoZona" id="tipo-zona" required>
            <option value="M">M (Módulo)</option>
            <option value="A">A (Área)</option>
        </select>
        <input type="number" name="inicio" id="inicio" placeholder="Desde (ej. 1)" required>
        <input type="number" name="fin" id="fin" placeholder="Hasta (ej. 15)" required>
        <button type="button" class="login" onclick="agregarEspacios()">Agregar Espacios</button>
    </form>

    <div id="mensajes-ajustes"></div>
</div>
<script src="${pageContext.request.contextPath}/JS/funciones_ajustes.js"></script>
</body>
</html>

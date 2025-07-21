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
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <h1 class="title">Ajustes — Gestión de Tarifas/Roles</h1>
    <form method="post" action="AjustesServlet">
        <select name="estacionamiento">
            <% 
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alquilercocheras", "root", "root");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM estacionamientos");
                while(rs.next()){
            %>
                <option value="<%=rs.getInt("EstacionamientoID")%>"><%=rs.getString("Nombre")%></option>
            <% } rs.close(); st.close(); con.close(); %>
        </select>
        <input type="text" name="tipoVehiculo" placeholder="Tipo de Vehiculo" required>
        <input type="number" name="precio" placeholder="Precio" required>
        <button type="submit" class="registro">Actualizar Tarifa</button>
    </form>
    <!-- Aquí también puedes listar y editar perfiles o parámetros generales -->
</div>
</body>
</html>

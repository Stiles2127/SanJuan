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
<body>
<%@ include file="sidebar.jsp" %>
<div class="main-content">
    <h1 class="title">Gestión de Clientes</h1>
    <form method="post" action="ClienteServlet">
        <input type="hidden" name="accion" value="agregar"/>
        <input type="text" name="Usuario" placeholder="Usuario" required>
        <input type="text" name="Nombre" placeholder="Nombre" required>
        <input type="text" name="Apellido" placeholder="Apellido" required>
        <input type="text" name="DNI" placeholder="DNI" required>
        <input type="email" name="Correo" placeholder="Correo" required>
        <input type="password" name="Contraseña" placeholder="Contraseña" required>
        <button type="submit" class="registro">Agregar Cliente</button>
    </form>
    <table>
        <tr>
            <th>UsuarioID</th>
            <th>Usuario</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>DNI</th>
            <th>Correo</th>
            <th>Acciones</th>
        </tr>
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/alquilercocheras", "root", "root");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM usuarios");
            while(rs.next()){
        %>
        <tr>
            <td><%=rs.getInt("UsuarioID")%></td>
            <td><%=rs.getString("Usuario")%></td>
            <td><%=rs.getString("Nombre")%></td>
            <td><%=rs.getString("Apellido")%></td>
            <td><%=rs.getString("DNI")%></td>
            <td><%=rs.getString("Correo")%></td>
            <td>
                <form method="post" action="ClienteServlet" style="display:inline">
                    <input type="hidden" name="accion" value="borrar"/>
                    <input type="hidden" name="UsuarioID" value="<%=rs.getInt("UsuarioID")%>"/>
                    <button type="submit" class="login">Eliminar</button>
                </form>
                <form action="clientes.jsp" method="get" style="display:inline">
                    <input type="hidden" name="editUsuarioID" value="<%=rs.getInt("UsuarioID")%>"/>
                    <button type="submit" class="registro">Editar</button>
                </form>
            </td>
        </tr>
        <% } rs.close(); st.close(); con.close(); %>
    </table>
</div>
</body>
</html>

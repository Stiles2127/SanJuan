<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro</title>
    <link rel="stylesheet" href="CSS/registro_style.css">
</head>
<body>
    <div class="container">
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Error al registrar usuario. Intente nuevamente.</div>
        <% } %>

        <h2>Registro de usuario</h2>
            <form action="registro" method="post">
                <input type="text" name="usuario" placeholder="Usuario" required>
                <select name="perfil" id="perfil" required>
                    <option value="">Seleccione tipo de perfil</option>
                    <option value="1">Básico</option>
                    <option value="2">Premium</option>
                </select>
                <input type="text" name="nombre" placeholder="Nombres" required>
                <input type="text" name="apellido" placeholder="Apellidos" required>
                <input type="text" name="dni" placeholder="DNI" required>
                <input type="email" name="correo" placeholder="Correo" required>
                <input type="password" name="contrasena" placeholder="Contraseña" required>
                <!-- Campo para número de placas (solo premium) -->
                <input type="number" id="numPlacas" min="1" max="5" placeholder="¿Cuántas placas desea registrar?" >
                <div id="vehiculos">
                  <!-- Aquí se agregan dinámicamente los campos de placas y tipo de vehículo -->
                <div class="vehiculo">
                    <input type="text" name="placa[]" placeholder="Placa del Vehículo" required>
                    <input type="text" name="tipo[]" placeholder="Tipo (Carro/Moto)" readonly style="background:#dcdcf7;">
                    <input type="text" name="color[]" placeholder="Color" required>
                </div>

                </div>
                <input type="submit" value="Registrarse">
            </form>
        <a href="login.jsp">Volver al login</a>
    </div>
    <script src="JS/registro.js"></script>
</body>
</html>

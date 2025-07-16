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
    <title>Login</title>
    <link rel="stylesheet" href="CSS/login_style.css">
</head>
<body>
    <div class="container">
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Usuario o contraseña incorrectos.</div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
            <div class="success">¡Registro exitoso! Inicia sesión.</div>
        <% } %>

        <h2>Iniciar Sesión</h2>
        <form action="login" method="post">
            <input type="text" name="usuario" placeholder="Usuario" required>
            <input type="password" name="contrasena" placeholder="Contraseña" required>
            <input type="submit" value="Ingresar">
        </form>

        <div class="links">
            <a href="olvido.jsp">¿Olvidaste tu contraseña?</a><br>
            <a href="registro.jsp"><button>Registrarse</button></a>
        </div>
    </div>
</body>
</html>


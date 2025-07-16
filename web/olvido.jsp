<%-- 
    Document   : olvido
    Created on : 15 may. 2025, 19:58:23
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Recuperar contraseña</title>
    <link rel="stylesheet" type="text/css" href="CSS/olvido_style.css">
</head>
<body>
    <div class="container">
        <h2>Recuperar contraseña</h2>
        <form action="olvido.jsp" method="post">
            <input type="email" name="correo" placeholder="Correo electrónico" required>
            <input type="submit" value="Enviar instrucciones">
        </form>
        <a href="login.jsp">Volver al login</a>
    </div>
</body>
</html>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>The Parking San Juan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/estilo_indexAdmin.css">
</head>
<body>
    <div class="sidebar">
        <div class="menu-btn">&#9776;</div>
        <div class="nav-buttons">
            <form action="admin.jsp"><button type="submit">INICIO</button></form>
            <form action="historial.jsp"><button type="submit">HISTORIAL</button></form>
            <form action="clientes.jsp"><button type="submit">CLIENTES</button></form>
            <form action="ajustes.jsp"><button type="submit">AJUSTES</button></form>
        </div>
        <div class="avatar-container">
            <img src="${pageContext.request.contextPath}/IMAGE/1.png" alt="Avatar">
        </div>
        <div class="social-icons">
            <a href="#"><img src="https://img.icons8.com/ios-filled/25/linkedin.png"/></a>
            <a href="#"><img src="https://img.icons8.com/ios-filled/25/youtube-play.png"/></a>
            <a href="#"><img src="https://img.icons8.com/ios-filled/25/instagram-new.png"/></a>
            <a href="#"><img src="https://img.icons8.com/ios-filled/25/delete-sign.png"/></a>
        </div>
    </div>

    <div class="main-content">
        <h1 class="title">THE PARKING SAN JUAN</h1>
        <h2 class="subtitulo">Opciones de Gestión</h2>
        <!-- Botones de Zonas -->
        <div class="zonas" id="zonas">
            <button type="button" class="zona" onclick="mostrarDatosSede(1)">La Victoria</button>
            <button type="button" class="zona" onclick="mostrarDatosSede(2)">Los Olivos</button>
            <button type="button" class="zona" onclick="mostrarDatosSede(3)">Surco</button>
            <button type="button" class="zona" onclick="mostrarDatosSede(4)">Chaclacayo</button>
        </div>
        <!-- Aquí se muestra el resultado -->
        <div class="resultados" id="resultadosZona">
            <div class='msg-info'>Seleccione una sede para ver sus tarifas y espacios disponibles.</div>
        </div>
        <div class="auth-buttons">
            <button class="registro">REGISTRO</button>
            <button class="login">LOGIN</button>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/JS/funciones_admi.js"></script>
</body>
</html>


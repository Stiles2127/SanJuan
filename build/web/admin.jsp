
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

        <!-- Opciones de Gestión como zonas -->
        <div class="zonas">
        <div class="zona" onclick="abrirModal('modalTarifa')">Tarifas por Vehículo</div>
        <div class="zona" onclick="abrirModal('modalEspacio')">Gestión de Espacios</div>
        </div>

        <!-- Barra de búsqueda -->
        <div class="search-bar">
            <input type="text" placeholder="Buscar estacionamiento">
        </div>

        <!-- Zonas disponibles -->
        <div class="zonas">
            <div class="zona">La Victoria</div>
            <div class="zona">Los Olivos</div>
            <div class="zona">Surco</div>
            <div class="zona">Chaclacayo</div>
        </div>

        <!-- Botones de autenticación -->
        <div class="auth-buttons">
            <button class="registro">REGISTRO</button>
            <button class="login">LOGIN</button>
        </div>
    </div>    
    <!-- Modal: Tarifas por Vehículo -->
        <div class="modal" id="modalTarifa">
            <div class="modal-content">
                <button class="close-modal" onclick="cerrarModal()">&times;</button>
                <h3>Tarifas por Vehículo - Seleccione Sede</h3>
                <select id="tarifa-sede">
                    <option value="">-- Elija una sede --</option>
                    <option value="1">La Victoria</option>
                    <option value="2">Los Olivos</option>
                    <option value="3">Surco</option>
                    <option value="4">Chaclacayo</option>
                </select>
                <button class="login" onclick="consultarTarifas()">Consultar</button>
                <div id="resultado-tarifa"></div>
            </div>
        </div>

        <!-- Modal: Gestión de Espacios -->
        <div class="modal" id="modalEspacio">
            <div class="modal-content">
                <button class="close-modal" onclick="cerrarModal()">&times;</button>
                <h3>Gestión de Espacios - Seleccione Sede</h3>
                <select id="espacio-sede">
                    <option value="">-- Elija una sede --</option>
                    <option value="1">La Victoria</option>
                    <option value="2">Los Olivos</option>
                    <option value="3">Surco</option>
                    <option value="4">Chaclacayo</option>
                </select>
                <button class="registro" onclick="consultarEspacios()">Gestionar</button>
                <div id="resultado-espacios"></div>
            </div>
        </div>
   <script src="${pageContext.request.contextPath}/JS/funciones_admi.js"></script>
</body>
</html>

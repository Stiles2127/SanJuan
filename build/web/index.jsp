<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String usuario = (String) session.getAttribute("usuario");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>The Parking San Juan</title>
    <link rel="stylesheet" href="CSS/estilo_index.css">
</head>
<body>
    <div class="sidebar">
        <div class="menu-btn">&#9776;</div>
        <div class="nav-buttons">
            <form action="index.jsp"><button type="submit">INICIO</button></form> 
            <form action="nosotros.jsp"><button type="submit">SOBRE NOSOTROS</button></form>
            <form action="ayuda.jsp"><button type="submit">AYUDA</button></form>
        </div>
        <div class="avatar-container">
            <img src="IMAGE/1.png" alt="Avatar">
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
        <div class="search-bar">
<input type="text" id="buscadorSede" placeholder="Buscar estacionamiento">
            </div>
        <div class="zonas">
            <div class="zona" data-sede="La Victoria">La Victoria</div>
            <div class="zona" data-sede="Los Olivos">Los Olivos</div>
            <div class="zona" data-sede="Surco">Surco</div>
            <div class="zona" data-sede="Chaclacayo">Chaclacayo</div>
        </div>
        <div class="auth-buttons">
            <%
                if (usuario == null) {
            %>
                    <form action="registro.jsp" method="post" style="display:inline;">
                        <button class="registro">REGISTRO</button>
                    </form>
                    <form action="login.jsp" method="post" style="display:inline;">
                        <button class="login">LOGIN</button>
                    </form>
            <%
                } else {
            %>
                    <span>Bienvenido, <strong><%= usuario %></strong></span>
                    <form action="logout" method="post" style="display:inline;">
                        <button class="logout">LOGOUT</button>
                    </form>
            <%
                }
            %>

<!-- Modal de plazas mejorado -->
<div id="plazasModal" class="modal">
  <div class="modal-content parking-modal">
    <span class="close-btn" id="closePlazasBtn">&times;</span>
    <h2>Selecciona tu plaza en <span id="nombreSede"></span></h2>
    <div class="zonas-parking">
      <div class="zona-parking">
        <h3>Zona Media</h3>
        <div id="zonaMedia" class="parking-grid"></div>
      </div>
      <div class="zona-parking">
        <h3>Zona Atrás</h3>
        <div id="zonaAtras" class="parking-grid"></div>
      </div>
    </div>
    <div id="leyendaPlazas">
      <span class="plaza leyenda libre"></span> Libre
      <span class="plaza leyenda ocupada"></span> Ocupada
      <span class="plaza leyenda seleccionada"></span> Seleccionada
    </div>
    <button id="confirmarPlazaBtn" style="display:none;">Confirmar selección</button>
  </div>
</div>

    <!-- Modal de reserva -->
    <div id="reservaModal" class="modal">
      <div class="modal-content">
        <span class="close-btn" id="closeReservaBtn">&times;</span>
        <h2>Reserva de Estacionamiento</h2>
        <form id="reservaForm">
          <label for="fechaLlegada">Fecha de llegada:</label>
          <input type="date" id="fechaLlegada" name="fechaLlegada" required min="">
          <label for="fechaSalida">Fecha de salida:</label>
          <input type="date" id="fechaSalida" name="fechaSalida" required>
          <label for="horaLlegada">Hora de llegada:</label>
          <input type="time" id="horaLlegada" name="horaLlegada" required>
          <label for="horaSalida">Hora de salida:</label>
          <input type="time" id="horaSalida" name="horaSalida" required>
          <label for="tipoVehiculo">Tipo de vehículo:</label>
          <select id="tipoVehiculo" name="tipoVehiculo" required>
            <option value="">Seleccione</option>
            <option value="auto">Auto</option>
            <option value="moto">Moto</option>
          </select>
          <label for="tipoPlaza">Tipo de plaza:</label>
          <select id="tipoPlaza" name="tipoPlaza" required>
            <<option value="">Seleccione</option>
            <option value="normal">Normal</option>
            <option value="premium">Premium</option>
          </select>
          <label for="serviciosAdicionales">Servicios adicionales:</label>
            <select id="serviciosAdicionales" name="serviciosAdicionales" multiple>
                <option value="lavado">Lavado</option>
                <option value="mecanico">Mecánico</option>
                <option value="seguro">Seguro</option>
                <option value="aire">Inflado de llantas</option>
                <option value="parabrisas">Limpieza de parabrisas</option>
                <!-- Agrega los que desees -->
            </select>

          <label for="costo">Costo:</label>
            <textarea id="costo" name="costo" readonly style="width:100%;height:90px;"></textarea>
          <label for="tipoPago">Tipo de pago:</label>
          <select id="tipoPago" name="tipoPago" required>
            <option value="">Seleccione</option>
            <option value="efectivo">Efectivo</option>
            <option value="tarjeta">Tarjeta</option>
            <option value="paypal">PayPal</option>
            <option value="yape">Yape</option>
          </select>
           <button type="submit" class="reserva-btn">Reservar</button>
        </form>
      </div>
    </div>
<script>
  // Esto asume que guardaste el perfil como "premium" o "basico" en sesión
  var perfilUsuario = "<%= session.getAttribute("perfil") %>";
</script>
<%
    Integer usuarioID = (Integer) session.getAttribute("usuarioID");
    if (usuarioID == null) usuarioID = 0;
%>
<script>
  const usuarioID = <%= usuarioID %>;
</script>

<script src="JS/index.js"></script>
</body>
</html>



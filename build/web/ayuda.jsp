<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ayuda - The Parking San Juan</title>
    <link rel="stylesheet" href="CSS/estilo_index.css"> <!-- Sidebar y estilos globales -->
    <link rel="stylesheet" href="CSS/ayuda_style.css"> <!-- Estilos específicos -->
</head>
<body>

    <!-- Sidebar (igual que en index.jsp) -->
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

    <!-- Contenido principal -->
    <div class="main-content">
        <div class="container">
            <h2>¿Necesitas ayuda?</h2>

            <h3>Preguntas Frecuentes</h3>
            <ul class="faq-list">
                <li><strong>¿Cómo hago una reserva?</strong> Haz clic en el botón RESERVA, completa el formulario y confirma tu espacio.</li>
                <li><strong>¿Cómo puedo cancelar una reserva?</strong> Ingresa a tu cuenta y selecciona la reserva que deseas cancelar.</li>
                <li><strong>¿Qué métodos de pago aceptan?</strong> Efectivo, tarjeta y PayPal.</li>
            </ul>

            <h3>Contacto</h3>
            <p>Si tienes dudas, escríbenos a <a href="mailto:soporte@sanjuanparking.com">soporte@sanjuanparking.com</a></p>
        </div>
    </div>

</body>
</html>


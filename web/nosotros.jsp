<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sobre Nosotros - The Parking San Juan</title>
    <link rel="stylesheet" href="CSS/estilo_index.css"> <!-- Para sidebar y estilos globales -->
    <link rel="stylesheet" href="CSS/nosotros_style.css"> <!-- Tus estilos específicos -->
</head>
<body>

    <!-- Sidebar igual que en index.jsp -->
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

    <!-- Contenido principal con margen para sidebar -->
    <div class="main-content">
        <div class="container">
            <h2>Sobre The Parking San Juan</h2>
            <p>
                Somos una empresa dedicada a ofrecer soluciones de estacionamiento seguras, cómodas y modernas en Lima. 
                Nuestra misión es facilitar la movilidad urbana y brindar tranquilidad a nuestros clientes.
            </p>
            <h3>Misión</h3>
            <p>Ofrecer el mejor servicio de estacionamiento, con tecnología y atención de calidad.</p>
            <h3>Visión</h3>
            <p>Ser líderes en soluciones de estacionamiento en el Perú.</p>
            <h3>Valores</h3>
            <ul>
                <li>Seguridad</li>
                <li>Innovación</li>
                <li>Compromiso</li>
                <li>Calidad</li>
            </ul>
            <h3>Nuestro Equipo</h3>
            <p class="equipo">Contamos con profesionales apasionados por la movilidad urbana, comprometidos con la excelencia y la innovación constante.</p>
        </div>
    </div>

</body>
</html>


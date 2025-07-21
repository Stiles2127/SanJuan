<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String total = request.getParameter("total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Pagar con Yape</title>
    <link rel="stylesheet" href="CSS/pago_yape.css">

</head>
<body>
    <div class="form-container">
        <h2>Pagar con Yape</h2>
        <div class="total-label">Total a pagar: S/ <%= total %></div>
        <p>Escanea el siguiente QR con tu app de Yape:</p>
        <img src="IMAGE/qr_yape.png" alt="QR Yape">

        <form action="procesarPagoYape" method="post">
            <input type="hidden" name="total" value="<%= total %>">

            <label for="codigo">Código de operación (opcional):</label>
            <input type="text" id="codigo" name="codigo" placeholder="Ingrese código si lo tiene">

            <button type="submit">Confirmar pago</button>
        </form>
    </div>
</body>
</html>


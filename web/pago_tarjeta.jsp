<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String total = request.getParameter("total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Pagar con Tarjeta</title>
    <link rel="stylesheet" href="CSS/pago_tarjeta.css">
</head>
<body>
    <div class="form-container">
        <h2>Pagar con Tarjeta</h2>
        <form action="procesarPagoTarjeta" method="post">
            <div class="total-label">Total a pagar: S/ <%= total %></div>
            <input type="hidden" name="total" value="<%= total %>">

            <label for="numero">Número de tarjeta:</label>
            <input type="text" id="numero" name="numero" required autocomplete="cc-number" inputmode="numeric" maxlength="19" placeholder="1234 5678 9012 3456">

            <label for="nombre">Nombre en la tarjeta:</label>
            <input type="text" id="nombre" name="nombre" required autocomplete="cc-name" placeholder="Nombre completo">

            <label for="vencimiento">Fecha de vencimiento:</label>
            <input type="month" id="vencimiento" name="vencimiento" required placeholder="MM/AAAA">

            <label for="cvv">CVV:</label>
            <input type="password" id="cvv" name="cvv" required autocomplete="cc-csc" maxlength="4" placeholder="123">

            <button type="submit">Pagar</button>
        </form>
    </div>
</body>
</html>

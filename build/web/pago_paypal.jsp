<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String total = request.getParameter("total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Pagar con PayPal</title>
    <link rel="stylesheet" href="CSS/pago_paypal.css">
</head>
<body>
    <div class="form-container">
        <h2>Pagar con PayPal</h2>
        <div class="total-label">Total a pagar: S/ <%= total %></div>
        <form action="procesarPagoPaypal" method="post">
            <input type="hidden" name="total" value="<%= total %>">

            <label for="correo">Correo de PayPal:</label>
            <input type="email" id="correo" name="correo" required placeholder="correo@ejemplo.com">

            <button type="submit">Pagar</button>
        </form>
    </div>
</body>
</html>

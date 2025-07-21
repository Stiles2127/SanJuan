<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String total = request.getParameter("total");
    // Puedes agregar más parámetros para otros datos de la reserva, por ejemplo:
    String nombre = request.getParameter("nombre");
    String fechaReserva = request.getParameter("fechaReserva");
    String detalleReserva = request.getParameter("detalleReserva");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Boleta de Pago</title>
        <link rel="stylesheet" href="CSS/boleta_pago.css">
</head>
<body>
    <div class="boleta-container">
        <h2>Boleta de Pago</h2>
        <table>
            <tr>
                <th>Nombre</th>
                <td><%= (nombre != null ? nombre : "No especificado") %></td>
            </tr>
            <tr>
                <th>Fecha de Reserva</th>
                <td><%= (fechaReserva != null ? fechaReserva : "No especificada") %></td>
            </tr>
            <tr>
                <th>Detalle de Reserva</th>
                <td><%= (detalleReserva != null ? detalleReserva : "No especificado") %></td>
            </tr>
            <tr class="total-row">
                <td>Total a pagar</td>
                <td>S/ <%= total %></td>
            </tr>
        </table>
        <p>Presente esta boleta en la sede para completar su pago y reserva.</p>
        <button onclick="window.print()">Imprimir Boleta</button>
    </div>
</body>
</html>

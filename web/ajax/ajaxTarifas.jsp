<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table>
<tr>
    <th>Sede</th>
    <th>Tipo Vehículo</th>
    <th>Precio S/</th>
    <th>Acción</th>
</tr>
<%
Connection con = Conexion.getConnection();
String sql = "SELECT t.TarifaID, e.Nombre, t.TipoVehiculo, t.Precio FROM tarifas t JOIN estacionamientos e ON t.EstacionamientoID = e.EstacionamientoID";
PreparedStatement pst = con.prepareStatement(sql);
ResultSet rst = pst.executeQuery();
while(rst.next()) {
%>
<tr>
    <td><%=rst.getString("Nombre")%></td>
    <td><input type="text" id="vehiculo-<%=rst.getInt("TarifaID")%>" value="<%=rst.getString("TipoVehiculo")%>"></td>
    <td><input type="number" id="precio-<%=rst.getInt("TarifaID")%>" value="<%=rst.getDouble("Precio")%>" step="0.01"></td>
    <td>
        <button class="login" onclick="editarTarifa(<%=rst.getInt("TarifaID")%>)">Actualizar</button>
        <button class="registro" onclick="eliminarTarifa(<%=rst.getInt("TarifaID")%>)">Eliminar</button>
    </td>
</tr>
<%
}
rst.close();
pst.close();
con.close();
%>
</table>

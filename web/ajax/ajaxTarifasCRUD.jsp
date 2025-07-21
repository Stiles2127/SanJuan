<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
out.println("Depuración: ");
out.println("estacionamiento=" + request.getParameter("estacionamiento"));
out.println(", tipoVehiculo=" + request.getParameter("tipoVehiculo"));
out.println(", precio=" + request.getParameter("precio") + "<br>");
%>

<%
String accion = request.getParameter("accion");
try {
    Connection con = Conexion.getConnection();
    if ("editar".equals(accion)) {
        String tarifaIDStr = request.getParameter("tarifaID");
        String tipo = request.getParameter("tipoVehiculo");
        String precioStr = request.getParameter("precio");
        if (tarifaIDStr == null || tipo == null || precioStr == null || tipo.trim().isEmpty() || precioStr.trim().isEmpty()) throw new Exception("Faltan datos para editar");
        int tarifaID = Integer.parseInt(tarifaIDStr);
        double precio = Double.parseDouble(precioStr);
        PreparedStatement pst = con.prepareStatement("UPDATE tarifas SET TipoVehiculo=?, Precio=? WHERE TarifaID=?");
        pst.setString(1, tipo);
        pst.setDouble(2, precio);
        pst.setInt(3, tarifaID);
        pst.executeUpdate();
        pst.close();
        out.print("<span style='color:green'>Tarifa actualizada</span>");
    } else if ("eliminar".equals(accion)) {
        String tarifaIDStr = request.getParameter("tarifaID");
        if (tarifaIDStr == null) throw new Exception("Falta ID de tarifa");
        int tarifaID = Integer.parseInt(tarifaIDStr);
        PreparedStatement pst = con.prepareStatement("DELETE FROM tarifas WHERE TarifaID=?");
        pst.setInt(1, tarifaID);
        pst.executeUpdate();
        pst.close();
        out.print("<span style='color:green'>Tarifa eliminada</span>");
    } else {
        String sedeStr = request.getParameter("estacionamiento");
        String tipo = request.getParameter("tipoVehiculo");
        String precioStr = request.getParameter("precio");
        if (sedeStr == null || tipo == null || precioStr == null || tipo.trim().isEmpty() || precioStr.trim().isEmpty()) throw new Exception("Faltan datos para crear tarifa");
        int sede = Integer.parseInt(sedeStr);
        double precio = Double.parseDouble(precioStr);
        PreparedStatement sel = con.prepareStatement("SELECT TarifaID FROM tarifas WHERE EstacionamientoID=? AND TipoVehiculo=?");
        sel.setInt(1, sede);
        sel.setString(2, tipo);
        ResultSet rs = sel.executeQuery();
        if (rs.next()) {
            PreparedStatement pst = con.prepareStatement("UPDATE tarifas SET Precio=? WHERE TarifaID=?");
            pst.setDouble(1, precio);
            pst.setInt(2, rs.getInt(1));
            pst.executeUpdate();
            pst.close();
            out.print("<span style='color:blue'>Tarifa actualizada</span>");
        } else {
            PreparedStatement pst = con.prepareStatement("INSERT INTO tarifas (EstacionamientoID, TipoVehiculo, Precio) VALUES (?, ?, ?)");
            pst.setInt(1, sede);
            pst.setString(2, tipo);
            pst.setDouble(3, precio);
            pst.executeUpdate();
            pst.close();
            out.print("<span style='color:blue'>Tarifa agregada</span>");
        }
        rs.close(); sel.close();
    }
    con.close();
} catch(Exception e) {
    out.print("<span class='error'>" + e.getMessage() + "</span>");
}
%>


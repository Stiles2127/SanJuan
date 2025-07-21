<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try{
    String nombre = request.getParameter("nombreSede");
    String direccion = request.getParameter("direccionSede");
    if(nombre == null || nombre.trim().isEmpty()) throw new Exception("Nombre requerido");
    if(direccion == null || direccion.trim().isEmpty()) throw new Exception("Dirección requerida");
    Connection con = Conexion.getConnection();
    PreparedStatement pst = con.prepareStatement("INSERT INTO estacionamientos (Nombre, Dirección) VALUES (?, ?)");
    pst.setString(1, nombre.trim());
    pst.setString(2, direccion.trim());
    pst.executeUpdate();
    pst.close();
    con.close();
    out.print("<span style='color:green;'>Sede agregada correctamente</span>");
} catch(Exception e){
    out.print("<span class='error'>" + e.getMessage() + "</span>");
}
%>

<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try{
    int sede = Integer.parseInt(request.getParameter("estacionamientoEspacio"));
    String tipoZona = request.getParameter("tipoZona").toUpperCase();
    int inicio = Integer.parseInt(request.getParameter("inicio"));
    int fin = Integer.parseInt(request.getParameter("fin"));
    if(inicio > fin) throw new Exception("El inicio no puede ser mayor al fin");

    Connection con = Conexion.getConnection();

    int creados = 0, existentes = 0;
    for(int i=inicio; i<=fin; i++){
        String cod = tipoZona + i;
        // ¿Ya existe ese espacio en esta sede?
        PreparedStatement sel = con.prepareStatement("SELECT EspacioID FROM espacios WHERE EstacionamientoID=? AND Código=?");
        sel.setInt(1, sede); sel.setString(2, cod);
        ResultSet rs = sel.executeQuery();
        if(rs.next()){
            existentes++;
        } else {
            PreparedStatement pst = con.prepareStatement("INSERT INTO espacios (EstacionamientoID, Código, Estado) VALUES (?, ?, 'Disponible')");
            pst.setInt(1, sede); pst.setString(2, cod);
            pst.executeUpdate();
            pst.close();
            creados++;
        }
        rs.close(); sel.close();
    }
    con.close();
    out.print("<span style='color:green;'>"+creados+" espacio(s) agregados. "+(existentes>0?existentes+" ya existían.":"")+"</span>");
} catch(Exception e){
    out.print("<span class='error'>" + e.getMessage() + "</span>");
}
%>

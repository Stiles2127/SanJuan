<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String sede = request.getParameter("sede");
if (sede != null) {
    Connection con = null;
    PreparedStatement ps = null, ps2 = null, psA = null, psM = null;
    ResultSet rs = null, rs2 = null, rsA = null, rsM = null;
    String nombreSede = "";
    try {
        con = Conexion.getConnection();

        // Nombre sede
        ps = con.prepareStatement("SELECT Nombre FROM estacionamientos WHERE EstacionamientoID=?");
        ps.setInt(1, Integer.parseInt(sede));
        rs = ps.executeQuery();
        if(rs.next()) nombreSede = rs.getString("Nombre");
        if (nombreSede.equals("")) nombreSede = "Sede no encontrada";

        // Tarifas
        out.println("<h3>Tarifas para <span style='color: #5a5aff;'>" + nombreSede + "</span></h3>");
        ps2 = con.prepareStatement("SELECT TipoVehiculo, Precio FROM tarifas WHERE EstacionamientoID=?");
        ps2.setInt(1, Integer.parseInt(sede));
        rs2 = ps2.executeQuery();
        boolean tieneTarifas = false;
        out.println("<table class='tabla-tarifas'><tr><th>Tipo Vehículo</th><th>Precio (S/.)</th></tr>");
        while(rs2.next()) {
            tieneTarifas = true;
            out.println("<tr><td>"+rs2.getString(1)+"</td><td>"+rs2.getString(2)+"</td></tr>");
        }
        out.println("</table>");
        if(!tieneTarifas) out.println("<div class='msg-vacio'>No hay tarifas cargadas para esta sede.</div>");

        // Espacios: Módulo/Marquesina (M)
        out.println("<h3>Espacios disponibles por zona</h3>");
        out.println("<div class='cuadro-tipozona'>");
        
        // Módulos (M)
        psM = con.prepareStatement("SELECT Código FROM espacios WHERE EstacionamientoID=? AND Estado='Disponible' AND Código LIKE 'M%' ORDER BY Código+0 ASC");
        psM.setInt(1, Integer.parseInt(sede));
        rsM = psM.executeQuery();
        out.println("<div class='zona-categoria'><div class='etiqueta-zona tipo-m'>Zona M (Módulo)</div>");
        boolean hayM = false;
        out.println("<div class='espacios-grid'>");
        while(rsM.next()) {
            hayM = true;
            out.println("<div class='espacio-celda disponible'>" + rsM.getString(1) + "</div>");
        }
        out.println("</div>");
        if(!hayM) out.println("<div class='msg-vacio'>No hay espacios tipo M disponibles.</div>");
        out.println("</div>");

        // Áreas (A)
        psA = con.prepareStatement("SELECT Código FROM espacios WHERE EstacionamientoID=? AND Estado='Disponible' AND Código LIKE 'A%' ORDER BY Código+0 ASC");
        psA.setInt(1, Integer.parseInt(sede));
        rsA = psA.executeQuery();
        out.println("<div class='zona-categoria'><div class='etiqueta-zona tipo-a'>Zona A (Área)</div>");
        boolean hayA = false;
        out.println("<div class='espacios-grid'>");
        while(rsA.next()) {
            hayA = true;
            out.println("<div class='espacio-celda disponible'>" + rsA.getString(1) + "</div>");
        }
        out.println("</div>");
        if(!hayA) out.println("<div class='msg-vacio'>No hay espacios tipo A disponibles.</div>");
        out.println("</div>");

        out.println("</div>"); // Cierre cuadro-tipozona

    } catch(Exception e) {
        out.println("<div class='msg-error'>"+e.getMessage()+"</div>");
    } finally {
        try{ if(rs!=null)rs.close(); }catch(Exception e){}
        try{ if(rs2!=null)rs2.close(); }catch(Exception e){}
        try{ if(rsA!=null)rsA.close(); }catch(Exception e){}
        try{ if(rsM!=null)rsM.close(); }catch(Exception e){}
        try{ if(ps!=null)ps.close(); }catch(Exception e){}
        try{ if(ps2!=null)ps2.close(); }catch(Exception e){}
        try{ if(psA!=null)psA.close(); }catch(Exception e){}
        try{ if(psM!=null)psM.close(); }catch(Exception e){}
        try{ if(con!=null)con.close(); }catch(Exception e){}
    }
} else {
    out.println("<div class='msg-info'>Seleccione una sede para ver sus tarifas y espacios disponibles.</div>");
}
%>

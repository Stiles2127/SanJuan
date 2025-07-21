<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
String busqueda = request.getParameter("busqueda");
if(busqueda == null || busqueda.trim().isEmpty()){
    out.print("<div class='msg-info'>Debes proporcionar un dato de búsqueda.</div>");
    return;
}

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    con = Conexion.getConnection();
    String sql = 
        "SELECT * FROM usuarios WHERE Usuario LIKE ? OR DNI LIKE ? OR Correo LIKE ? " +
        "OR Nombre LIKE ? OR Apellido LIKE ?";
    ps = con.prepareStatement(sql);
    for(int i=1; i<=5; i++) ps.setString(i, "%" + busqueda + "%");
    rs = ps.executeQuery();
    if(!rs.next()) {
        out.print("<div class='msg-vacio'>Ningún cliente coincide con esa búsqueda.</div>");
    } else {
        int usuarioID = rs.getInt("UsuarioID");
        String usuario = rs.getString("Usuario");
        String nombreC = rs.getString("Nombre") + " " + rs.getString("Apellido");
        String correo = rs.getString("Correo");
        String dni = rs.getString("DNI");
%>
        <h3>Cliente encontrado</h3>
        <p>
            <strong>Usuario:</strong> <%=usuario%><br>
            <strong>Nombre:</strong> <%=nombreC%><br>
            <strong>Correo:</strong> <%=correo%><br>
            <strong>DNI:</strong> <%=dni%>
        </p>
        <%
        Statement st = con.createStatement();
        ResultSet rsr = st.executeQuery(
            "SELECT r.ReservaID, r.FechaReserva, r.HoraEntrada, r.HoraSalida, r.Estado, e.Código, p.NombrePerfil " +
            "FROM reservas r " +
            "LEFT JOIN espacios e ON r.EspacioID = e.EspacioID " +
            "LEFT JOIN usuarios u ON r.UsuarioID = u.UsuarioID "+
            "LEFT JOIN perfiles p ON u.PerfilID = p.PerfilID "+
            "WHERE r.UsuarioID="+usuarioID+" ORDER BY r.FechaReserva DESC"
        );
        int contR = 0;
        out.print("<h4>Reservas</h4>");
        out.print("<table><tr><th>ReservaID</th><th>Fecha</th><th>Entrada</th><th>Salida</th><th>Estado</th><th>Espacio</th><th>Perfil</th></tr>");
        while(rsr.next()) {
            contR++;
            out.print("<tr>");
            out.print("<td>"+rsr.getInt("ReservaID")+"</td>");
            out.print("<td>"+rsr.getDate("FechaReserva")+"</td>");
            out.print("<td>"+rsr.getString("HoraEntrada")+"</td>");
            out.print("<td>"+rsr.getString("HoraSalida")+"</td>");
            out.print("<td>"+rsr.getString("Estado")+"</td>");
            out.print("<td>"+rsr.getString("Código")+"</td>");
            out.print("<td>"+rsr.getString("NombrePerfil")+"</td>");
            out.print("</tr>");
        }
        out.print("</table>");
        if(contR == 0) out.print("<div class='msg-vacio'>No ha registrado reservas.</div>");
        rsr.close(); st.close();

        Statement st2 = con.createStatement();
        ResultSet rsp = st2.executeQuery(
            "SELECT p.PagoID, p.Monto, p.FechaPago, p.ReservaID " +
            "FROM pagos p INNER JOIN reservas r ON p.ReservaID = r.ReservaID " +
            "WHERE r.UsuarioID="+usuarioID+" ORDER BY p.FechaPago DESC"
        );
        int contP = 0;
        out.print("<h4>Pagos Realizados</h4>");
        out.print("<table><tr><th>PagoID</th><th>ReservaID</th><th>Monto</th><th>Fecha de Pago</th></tr>");
        while(rsp.next()) {
            contP++;
            out.print("<tr>");
            out.print("<td>"+rsp.getInt("PagoID")+"</td>");
            out.print("<td>"+rsp.getInt("ReservaID")+"</td>");
            out.print("<td>S/ "+rsp.getBigDecimal("Monto")+"</td>");
            out.print("<td>"+rsp.getTimestamp("FechaPago")+"</td>");
            out.print("</tr>");
        }
        out.print("</table>");
        if(contP == 0) out.print("<div class='msg-vacio'>No se encontraron pagos para este cliente.</div>");
        rsp.close(); st2.close();
    }
} catch(Exception e){
    out.print("<div class='msg-error'>"+e.getMessage()+"</div>");
} finally {
    try{ if(rs!=null)rs.close(); } catch(Exception e){}
    try{ if(ps!=null)ps.close(); } catch(Exception e){}
    try{ if(con!=null)con.close(); } catch(Exception e){}
}
%>

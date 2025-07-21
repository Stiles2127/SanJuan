<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
String editUsuarioID = request.getParameter("editUsuarioID");
String usuario = "", nombre = "", apellido = "", dni = "", correo = "", clave = "";
if (editUsuarioID != null) {
    Connection con = Conexion.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM usuarios WHERE UsuarioID=?");
    ps.setInt(1, Integer.parseInt(editUsuarioID));
    ResultSet rset = ps.executeQuery();
    if(rset.next()){
        usuario = rset.getString("Usuario");
        nombre = rset.getString("Nombre");
        apellido = rset.getString("Apellido");
        dni = rset.getString("DNI");
        correo = rset.getString("Correo");
        // NO recuperes la contraseña aquí por seguridad
    }
    rset.close(); ps.close(); con.close();
}
%>
<form id="fcliente" onsubmit="agregarCliente(event)">
    <input type="hidden" name="accion" value="<%= (editUsuarioID!=null?"editar":"agregar") %>"/>
    <% if(editUsuarioID!=null){ %>
      <input type="hidden" name="UsuarioID" value="<%=editUsuarioID%>">
    <% } %>
    <input type="text" name="Usuario" placeholder="Usuario" value="<%=usuario%>" required>
    <input type="text" name="Nombre" placeholder="Nombre" value="<%=nombre%>" required>
    <input type="text" name="Apellido" placeholder="Apellido" value="<%=apellido%>" required>
    <input type="text" name="DNI" placeholder="DNI" value="<%=dni%>" required>
    <input type="email" name="Correo" placeholder="Correo" value="<%=correo%>" required>
    <input type="password" name="Contraseña" placeholder="Contraseña" <%=editUsuarioID==null?"required":""%>>
    <button class="registro"><%= (editUsuarioID!=null?"Guardar Cambios":"Agregar Cliente") %></button>
    <% if(editUsuarioID!=null){ %>
      <button type="button" class="login" onclick="cargarFormulario()">Cancelar</button>
    <% } %>
</form>

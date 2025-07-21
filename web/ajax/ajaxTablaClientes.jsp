<%@page import="conexion.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<table>
  <tr>
    <th>UsuarioID</th>
    <th>Usuario</th>
    <th>Nombre</th>
    <th>Apellido</th>
    <th>DNI</th>
    <th>Correo</th>
    <th>Acciones</th>
  </tr>
<%
Connection con = Conexion.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM usuarios");
while(rs.next()){
%>
<tr>
  <td><%=rs.getInt("UsuarioID")%></td>
  <td><%=rs.getString("Usuario")%></td>
  <td><%=rs.getString("Nombre")%></td>
  <td><%=rs.getString("Apellido")%></td>
  <td><%=rs.getString("DNI")%></td>
  <td><%=rs.getString("Correo")%></td>
  <td>
    <button class="login" onclick="eliminarCliente(<%=rs.getInt("UsuarioID")%>)">Eliminar</button>
    <button class="registro" onclick="editarCliente(<%=rs.getInt("UsuarioID")%>)">Editar</button>
  </td>
</tr>
<%
}
rs.close(); st.close(); con.close();
%>
</table>

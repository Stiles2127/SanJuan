package servlets;

import conexion.Conexion;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AdminClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        String mensaje = "";
        try (Connection con = Conexion.getConnection()) {
            if ("borrar".equals(accion)) {
                int usuarioID = Integer.parseInt(request.getParameter("UsuarioID"));
                String sql = "DELETE FROM usuarios WHERE UsuarioID=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, usuarioID);
                    ps.executeUpdate();
                    mensaje = "Cliente eliminado correctamente";
                }
            } else if ("editar".equals(accion)) {
                int usuarioID = Integer.parseInt(request.getParameter("UsuarioID"));
                String usuario = request.getParameter("Usuario");
                String nombre = request.getParameter("Nombre");
                String apellido = request.getParameter("Apellido");
                String dni = request.getParameter("DNI");
                String correo = request.getParameter("Correo");
                String contrasena = request.getParameter("Contraseña");
                StringBuilder sql = new StringBuilder("UPDATE usuarios SET Usuario=?, Nombre=?, Apellido=?, DNI=?, Correo=?");
                if(contrasena != null && !contrasena.trim().isEmpty()){
                    sql.append(", Contraseña=?");
                }
                sql.append(" WHERE UsuarioID=?");
                try (PreparedStatement ps = con.prepareStatement(sql.toString())) {
                    int idx=1;
                    ps.setString(idx++, usuario);
                    ps.setString(idx++, nombre);
                    ps.setString(idx++, apellido);
                    ps.setString(idx++, dni);
                    ps.setString(idx++, correo);
                    if(contrasena != null && !contrasena.trim().isEmpty()){
                        ps.setString(idx++, contrasena);
                    }
                    ps.setInt(idx, usuarioID);
                    ps.executeUpdate();
                    mensaje = "Cliente actualizado correctamente";
                }
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
        response.setContentType("text/plain");
        response.getWriter().print(mensaje);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

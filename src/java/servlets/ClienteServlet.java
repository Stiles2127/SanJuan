package servlets;

import conexion.Conexion;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        String mensaje = "";

        try (Connection con = Conexion.getConnection()) {
            if ("agregar".equals(accion)) {
                String usuario = request.getParameter("Usuario");
                String nombre = request.getParameter("Nombre");
                String apellido = request.getParameter("Apellido");
                String dni = request.getParameter("DNI");
                String correo = request.getParameter("Correo");
                String contrasena = request.getParameter("Contraseña");
                int perfilID = 1; // Puedes modificar este valor si manejas perfiles diferentes

                String sql = "INSERT INTO usuarios (Usuario, PerfilID, Nombre, Apellido, DNI, Correo, Contraseña) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, usuario);
                    ps.setInt(2, perfilID);
                    ps.setString(3, nombre);
                    ps.setString(4, apellido);
                    ps.setString(5, dni);
                    ps.setString(6, correo);
                    ps.setString(7, contrasena);
                    ps.executeUpdate();
                    mensaje = "Cliente agregado exitosamente";
                }

            } else if ("borrar".equals(accion)) {
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

                String sql = "UPDATE usuarios SET Usuario=?, Nombre=?, Apellido=?, DNI=?, Correo=?, Contraseña=? WHERE UsuarioID=?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, usuario);
                    ps.setString(2, nombre);
                    ps.setString(3, apellido);
                    ps.setString(4, dni);
                    ps.setString(5, correo);
                    ps.setString(6, contrasena);
                    ps.setInt(7, usuarioID);
                    ps.executeUpdate();
                    mensaje = "Cliente actualizado correctamente";
                }
            }
        } catch (Exception e) {
            mensaje = "UPS: " + e.getMessage();
        }
        // Puedes pasar el mensaje a la vista para mostrar notificaciones
        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }

    // Si deseas manejar GET también, puedes redirigirlo igual que POST
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

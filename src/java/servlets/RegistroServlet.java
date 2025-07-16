package servlets;

import conexion.conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        int perfil = Integer.parseInt(request.getParameter("perfil"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        try (Connection conn = conexion.getConnection()) {
            String sql = "INSERT INTO usuarios (Usuario, PerfilID, Nombre, Apellido, DNI, Correo, Contraseña) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setInt(2, perfil);
            ps.setString(3, nombre);
            ps.setString(4, apellido);
            ps.setString(5, dni);
            ps.setString(6, correo);
            ps.setString(7, contrasena); // ¡En producción, usa hash!
            ps.executeUpdate();
            response.sendRedirect("login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registro.jsp?error=1");
        }
    }
}


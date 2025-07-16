package servlets;

import conexion.conexion;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        try (Connection conn = conexion.getConnection()) {
            String sql = "SELECT Nombre, Usuario FROM usuarios WHERE Usuario = ? AND Contraseña = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, contrasena); // En producción, compara con hash

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Login exitoso: guarda el nombre de usuario en sesión
                HttpSession session = request.getSession();
                session.setAttribute("usuario", rs.getString("Usuario"));
                // Puedes guardar también el nombre real si lo deseas:
                // session.setAttribute("nombre", rs.getString("Nombre"));
                response.sendRedirect("index.jsp");
            } else {
                // Login fallido
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=1");
        }
    }
}

package servlets;

import conexion.Conexion;
import java.io.IOException;
import java.sql.*;
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
        String[] placas = request.getParameterValues("placa[]");
        String[] tipos = request.getParameterValues("tipo[]");
        String[] colores = request.getParameterValues("color[]");

        
        if (placas == null || tipos == null || colores == null 
            || placas.length != tipos.length || placas.length != colores.length) {
            response.sendRedirect("registro.jsp?error=vehiculos");
            return;
        }


        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psVehiculo = null;
        ResultSet rsKeys = null;

        try {
            conn = Conexion.getConnection();
            conn.setAutoCommit(false); // Para manejo atómico
            
            // Insertar usuario
            String sqlUser = "INSERT INTO usuarios (Usuario, PerfilID, Nombre, Apellido, DNI, Correo, Contraseña) VALUES (?, ?, ?, ?, ?, ?, ?)";
            psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, usuario);
            psUser.setInt(2, perfil);
            psUser.setString(3, nombre);
            psUser.setString(4, apellido);
            psUser.setString(5, dni);
            psUser.setString(6, correo);
            psUser.setString(7, contrasena); // Recuerda usar hashing en producción
            int affectedRows = psUser.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Error insertando usuario, no filas afectadas.");
            }

            rsKeys = psUser.getGeneratedKeys();
            int usuarioID = 0;
            if (rsKeys.next()) {
                usuarioID = rsKeys.getInt(1);
            } else {
                throw new SQLException("No se pudo obtener ID generado del usuario.");
            }

            // Insertar vehículos
            String sqlVehiculo = "INSERT INTO vehiculos (UsuarioID, Placa, Tipo, Color) VALUES (?, ?, ?, ?)";
            psVehiculo = conn.prepareStatement(sqlVehiculo);

            for (int i = 0; i < placas.length; i++) {
                String placa = placas[i].trim();
                String tipo = tipos[i].trim();
                String color = colores[i].trim();
                if (placa.isEmpty() || tipo.isEmpty() || color.isEmpty()) {
                    conn.rollback();
                    response.sendRedirect("registro.jsp?error=vehiculos");
                    return;
                }
                psVehiculo.setInt(1, usuarioID);
                psVehiculo.setString(2, placa);
                psVehiculo.setString(3, tipo);
                psVehiculo.setString(4, color);
                psVehiculo.addBatch();
            }

            psVehiculo.executeBatch();

            conn.commit(); // Confirmar transacción
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendRedirect("registro.jsp?error=1");
        } finally {
            try { if (rsKeys != null) rsKeys.close(); } catch (Exception ignored) {}
            try { if (psUser != null) psUser.close(); } catch (Exception ignored) {}
            try { if (psVehiculo != null) psVehiculo.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }     
    }
}

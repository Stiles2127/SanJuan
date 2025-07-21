
package servlets;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/api/reserva-crear")
public class ReservaCrearServlet extends HttpServlet {

    private static class ReservaData {
        String sede;
        String plaza;
        int usuarioID;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try (BufferedReader reader = request.getReader()) {
            ReservaData data = new Gson().fromJson(reader, ReservaData.class);

            if (data == null || data.sede == null || data.plaza == null || data.usuarioID <= 0) {
                out.print("{\"success\":false, \"message\":\"Datos incompletos.\"}");
                return;
            }

            // Guardar reserva en BD
            try (Connection conn = getConnection()) {
                conn.setAutoCommit(false);

                // 1. Obtener EstacionamientoID
                String sqlEst = "SELECT EstacionamientoID FROM estacionamientos WHERE Nombre = ?";
                int estacionamientoID;
                try (PreparedStatement psEst = conn.prepareStatement(sqlEst)) {
                    psEst.setString(1, data.sede);
                    try (ResultSet rs = psEst.executeQuery()) {
                        if (!rs.next()) {
                            out.print("{\"success\":false, \"message\":\"Sede no encontrada.\"}");
                            return;
                        }
                        estacionamientoID = rs.getInt("EstacionamientoID");
                    }
                }

                // 2. Obtener EspacioID y verificar disponibilidad
                String sqlEsp = "SELECT EspacioID, Estado FROM espacios WHERE EstacionamientoID = ? AND Código = ?";
                int espacioID;
                try (PreparedStatement psEsp = conn.prepareStatement(sqlEsp)) {
                    psEsp.setInt(1, estacionamientoID);
                    psEsp.setString(2, data.plaza);
                    try (ResultSet rs = psEsp.executeQuery()) {
                        if (!rs.next()) {
                            out.print("{\"success\":false, \"message\":\"Plaza no encontrada.\"}");
                            return;
                        }
                        espacioID = rs.getInt("EspacioID");
                        String estado = rs.getString("Estado");
                        if (!"Disponible".equalsIgnoreCase(estado)) {
                            out.print("{\"success\":false, \"message\":\"Plaza no disponible.\"}");
                            return;
                        }
                    }
                }

                // 3. Insertar reserva con estado Pendiente (fecha y horario vacíos por ahora)
                String sqlInsertRes = "INSERT INTO reservas (UsuarioID, EspacioID, VehiculoID, FechaReserva, HoraEntrada, HoraSalida, Estado) VALUES (?, ?, NULL, NULL, NULL, NULL, 'Pendiente')";
                int reservaID;
                try (PreparedStatement psRes = conn.prepareStatement(sqlInsertRes, Statement.RETURN_GENERATED_KEYS)) {
                    psRes.setInt(1, data.usuarioID);
                    psRes.setInt(2, espacioID);
                    psRes.executeUpdate();
                    try (ResultSet rsKeys = psRes.getGeneratedKeys()) {
                        if (!rsKeys.next()) {
                            out.print("{\"success\":false, \"message\":\"No se pudo crear reserva.\"}");
                            return;
                        }
                        reservaID = rsKeys.getInt(1);
                    }
                }

                // 4. Actualizar estado del espacio a 'Reservado'
                String sqlUpdateEsp = "UPDATE espacios SET Estado = 'Reservado' WHERE EspacioID = ?";
                try (PreparedStatement psUpdEsp = conn.prepareStatement(sqlUpdateEsp)) {
                    psUpdEsp.setInt(1, espacioID);
                    psUpdEsp.executeUpdate();
                }

                conn.commit();
                out.print("{\"success\":true, \"reservaID\":" + reservaID + "}");
            } catch (SQLException e) {
                e.printStackTrace();
                out.print("{\"success\":false, \"message\":\"Error de base de datos.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false, \"message\":\"Error procesando petición.\"}");
        }
    }

    private Connection getConnection() throws SQLException {
        // Cambia aquí según tu configuración de conexión
        String url = "jdbc:mysql://localhost:3306/alquilercocheras?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String pass = "root";
        return DriverManager.getConnection(url, user, pass);
    }
}

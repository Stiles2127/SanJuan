
package servlets;

import com.google.gson.Gson;
import static conexion.Conexion.getConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.List;

@WebServlet("/api/reserva-confirmar")
public class ReservaConfirmarServlet extends HttpServlet {

    private static class ConfirmData {
        int reservaID;
        String fechaLlegada;
        String fechaSalida;
        String horaLlegada;
        String horaSalida;
        String tipoVehiculo;
        String tipoPlaza;
        List<String> serviciosAdicionales;
        String tipoPago;
    }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("application/json");
    PrintWriter out = response.getWriter();

    try (BufferedReader reader = request.getReader()) {
        ConfirmData data = new Gson().fromJson(reader, ConfirmData.class);

        if (data == null || data.reservaID <= 0 || data.fechaLlegada == null || data.fechaSalida == null || data.horaLlegada == null || data.horaSalida == null) {
            out.print("{\"success\":false, \"message\":\"Datos incompletos.\"}");
            return;
        }

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);  // Iniciar transacción

            // Actualizar reserva con los datos ingresados y poner estado Confirmada
            String sqlUpdate = "UPDATE reservas SET FechaReserva = ?, HoraEntrada = ?, HoraSalida = ?, Estado = 'Confirmada' WHERE ReservaID = ?";
            int filas;
            try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
                ps.setDate(1, Date.valueOf(data.fechaLlegada));
                ps.setTime(2, Time.valueOf(data.horaLlegada + ":00"));
                ps.setTime(3, Time.valueOf(data.horaSalida + ":00"));
                ps.setInt(4, data.reservaID);

                filas = ps.executeUpdate();
            }

            if (filas == 1) {
                // Obtener EspacioID asociado a la reserva
                int espacioID = 0;
                // Luego de actualizar reserva, actualiza el espacio:
                String sqlGetEspacio = "SELECT EspacioID FROM reservas WHERE ReservaID = ?";
                try (PreparedStatement psEsp = conn.prepareStatement(sqlGetEspacio)) {
                  psEsp.setInt(1, data.reservaID);
                  try (ResultSet rs = psEsp.executeQuery()) {
                    if (rs.next()) {
                      espacioID = rs.getInt("EspacioID");
                    }
                  }
                }

                if (espacioID > 0) {
                  String sqlUpdEsp = "UPDATE espacios SET Estado = 'Ocupado' WHERE EspacioID = ?";
                  try (PreparedStatement psUpdEsp = conn.prepareStatement(sqlUpdEsp)) {
                    psUpdEsp.setInt(1, espacioID);
                    psUpdEsp.executeUpdate();
                  }
                }


                conn.commit();  // Confirmar transacción

                out.print("{\"success\":true}");
            } else {
                conn.rollback();
                out.print("{\"success\":false, \"message\":\"Reserva no encontrada.\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"success\":false, \"message\":\"Error de base de datos.\"}");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"success\":false, \"message\":\"Error procesando petición.\"}");
    }
}


}

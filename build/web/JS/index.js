 document.addEventListener('DOMContentLoaded', () => {
  // Variables globales (únicas declaraciones)
  const plazasModal = document.getElementById('plazasModal');
  const closePlazasBtn = document.getElementById('closePlazasBtn');
  const reservaModal = document.getElementById('reservaModal');
  const closeReservaBtn = document.getElementById('closeReservaBtn');
  const zonas = document.querySelectorAll('.zona');
  const nombreSede = document.getElementById('nombreSede');
  const confirmarPlazaBtn = document.getElementById('confirmarPlazaBtn');
  const zonaMedia = document.getElementById('zonaMedia');
  const zonaAtras = document.getElementById('zonaAtras');
  const buscador = document.getElementById('buscadorSede');
  const reservaForm = document.getElementById('reservaForm');
  const tipoPlazaSelect = document.getElementById('tipoPlaza');
  const costoTextarea = document.getElementById('costo');
  const serviciosAdicionales = document.getElementById('serviciosAdicionales');
  const tipoPagoSelect = document.getElementById('tipoPago');
  const fechaLlegadaInput = document.getElementById('fechaLlegada');
const horaLlegadaInput = document.getElementById('horaLlegada');

// Establece el mínimo en fechaLlegada y horaLlegada
function setMinFechaHoraLlegada() {
    const now = new Date();
    // Formato YYYY-MM-DD
    const fechaHoy = now.toISOString().slice(0,10);
    fechaLlegadaInput.min = fechaHoy;
    // Si fechaLlegada === hoy, limitar la hora
    fechaLlegadaInput.addEventListener('change', function() {
        if (fechaLlegadaInput.value === fechaHoy) {
            // Formato HH:MM para input time
            const pad = n => n < 10 ? '0'+n : n;
            const horaMin = pad(now.getHours()) + ":" + pad(now.getMinutes());
            horaLlegadaInput.min = horaMin;
            // Si el valor de horaLlegada es menor al mínimo, actualizarlo
            if(horaLlegadaInput.value && horaLlegadaInput.value < horaMin){
                horaLlegadaInput.value = horaMin;
            }
        } else {
            horaLlegadaInput.min = "00:00";
        }
    });
}

// Ejecuta cuando abres el modal de reserva
setMinFechaHoraLlegada();



  let plazaSeleccionada = null;
  let sedeSeleccionada = null;
  let tipoUsuario = perfilUsuario || "basico"; // Asegurate que perfilUsuario viene definido globalmente
  const descuentoPremium = 0.10; 

  // Cerrar modal plazas con la X
  closePlazasBtn.addEventListener('click', () => {
    plazasModal.style.display = 'none';
  });

  // Cerrar modal reserva con la X
  closeReservaBtn.addEventListener('click', () => {
      console.log('Cerrar modal reserva clickeado');
    reservaModal.style.display = 'none';
  });

  // Cerrar modales haciendo click fuera del contenido (una sola escucha para ambos modales)
  window.addEventListener('click', (event) => {
    if (event.target === plazasModal) {
      plazasModal.style.display = 'none';
    }
    if (event.target === reservaModal) {
      reservaModal.style.display = 'none';
    }
  });


  // --- FILTRO DE SEDES ---
  buscador.addEventListener('input', function() {
    const texto = buscador.value.toLowerCase();
    zonas.forEach(zona => {
      const sede = zona.textContent.toLowerCase();
      zona.style.display = (sede.includes(texto) || texto === "") ? '' : 'none';
    });
  });

      // --- MODAL PLAZAS PARKING ---
      const zonas = document.querySelectorAll('.zona');
      const plazasModal = document.getElementById('plazasModal');
      const nombreSede = document.getElementById('nombreSede');
      const confirmarPlazaBtn = document.getElementById('confirmarPlazaBtn');
      const zonaMedia = document.getElementById('zonaMedia');
      const zonaAtras = document.getElementById('zonaAtras');

      let plazaSeleccionada = null;
      let sedeSeleccionada = null;

      // Ejemplo de plazas para cada zona
      const plazasPorSede = {
        "La Victoria": {
          media: [
            { libre: true, nombre: "M1" }, { libre: true, nombre: "M2" }, { libre: true, nombre: "M3" }, { libre: true, nombre: "M4" }, { libre: true, nombre: "M5" }, { libre: false, nombre: "M6" }, { libre: true, nombre: "M7" }, { libre: false, nombre: "M8" }, { libre: true, nombre: "M9" }, { libre: true, nombre: "M10" }, { libre: true, nombre: "M11" }, { libre: true, nombre: "M12" },
            { libre: true, nombre: "M13" }, { libre: true, nombre: "M14" }, { libre: true, nombre: "M15" }, { libre: false, nombre: "M16" }, { libre: true, nombre: "M17" }, { libre: true, nombre: "M18" }, { libre: true, nombre: "M19" }, { libre: true, nombre: "M20" }, { libre: true, nombre: "M21" }, { libre: true, nombre: "M22" }, { libre: true, nombre: "M23" }, { libre: true, nombre: "M24" }
          ],
          atras: [
            { libre: true, nombre: "A1" }, { libre: true, nombre: "A2" }, { libre: true, nombre: "A3" }, { libre: false, nombre: "A4" }, { libre: true, nombre: "A5" }, { libre: true, nombre: "A6" }, { libre: true, nombre: "A7" }, { libre: true, nombre: "A8" }, { libre: true, nombre: "A9" }, { libre: true, nombre: "A10" }, { libre: true, nombre: "A11" }, { libre: true, nombre: "A12" },
            { libre: true, nombre: "A13" }, { libre: true, nombre: "A14" }, { libre: true, nombre: "A15" }, { libre: true, nombre: "A16" }, { libre: true, nombre: "A17" }, { libre: true, nombre: "A18" }, { libre: true, nombre: "A19" }, { libre: true, nombre: "A20" }
          ]
        },
        "Los Olivos": {
            media: [
            { libre: true, nombre: "M1" }, { libre: true, nombre: "M2" }, { libre: true, nombre: "M3" }, { libre: true, nombre: "M4" }, { libre: false, nombre: "M5" }, { libre: true, nombre: "M6" }, { libre: true, nombre: "M7" }, { libre: false, nombre: "M8" }, { libre: true, nombre: "M9" }, { libre: true, nombre: "M10" }, { libre: true, nombre: "M11" }, { libre: true, nombre: "M12" },
            { libre: true, nombre: "M13" }, { libre: true, nombre: "M14" }, { libre: true, nombre: "M15" }, { libre: false, nombre: "M16" }, { libre: true, nombre: "M17" }, { libre: true, nombre: "M18" }, { libre: true, nombre: "M19" }, { libre: true, nombre: "M20" }, { libre: true, nombre: "M21" }, { libre: true, nombre: "M22" }, { libre: true, nombre: "M23" }, { libre: true, nombre: "M24" }
            ],
            atras: [
              { libre: true, nombre: "A1" }, { libre: true, nombre: "A2" }, { libre: true, nombre: "A3" }, { libre: false, nombre: "A4" }, { libre: true, nombre: "A5" }, { libre: true, nombre: "A6" }, { libre: true, nombre: "A7" }, { libre: true, nombre: "A8" }, { libre: true, nombre: "A9" }, { libre: true, nombre: "A10" }, { libre: true, nombre: "A11" }, { libre: true, nombre: "A12" },
              { libre: true, nombre: "A13" }, { libre: true, nombre: "A14" }, { libre: true, nombre: "A15" }, { libre: true, nombre: "A16" }, { libre: true, nombre: "A17" }, { libre: true, nombre: "A18" }, { libre: true, nombre: "A19" }, { libre: true, nombre: "A20" }
            ]
          },
        "Surco": {
            media: [
            { libre: true, nombre: "M1" }, { libre: true, nombre: "M2" }, { libre: true, nombre: "M3" }, { libre: true, nombre: "M4" }, { libre: true, nombre: "M5" }, { libre: true, nombre: "M6" }, { libre: true, nombre: "M7" }, { libre: false, nombre: "M8" }, { libre: true, nombre: "M9" }, { libre: true, nombre: "M10" }, { libre: true, nombre: "M11" }, { libre: true, nombre: "M12" },
            { libre: true, nombre: "M13" }, { libre: true, nombre: "M14" }, { libre: true, nombre: "M15" }, { libre: true, nombre: "M16" }, { libre: true, nombre: "M17" }, { libre: true, nombre: "M18" }, { libre: true, nombre: "M19" }, { libre: true, nombre: "M20" }, { libre: true, nombre: "M21" }, { libre: true, nombre: "M22" }, { libre: true, nombre: "M23" }, { libre: true, nombre: "M24" }
            ],
            atras: [
              { libre: true, nombre: "A1" }, { libre: true, nombre: "A2" }, { libre: true, nombre: "A3" }, { libre: false, nombre: "A4" }, { libre: true, nombre: "A5" }, { libre: true, nombre: "A6" }, { libre: true, nombre: "A7" }, { libre: true, nombre: "A8" }, { libre: true, nombre: "A9" }, { libre: true, nombre: "A10" }, { libre: true, nombre: "A11" }, { libre: true, nombre: "A12" },
              { libre: true, nombre: "A13" }, { libre: true, nombre: "A14" }, { libre: true, nombre: "A15" }, { libre: true, nombre: "A16" }, { libre: true, nombre: "A17" }, { libre: true, nombre: "A18" }, { libre: true, nombre: "A19" }, { libre: true, nombre: "A20" }
            ]
          },
        "Chaclacayo": {
            media: [
            { libre: true, nombre: "M1" }, { libre: true, nombre: "M2" }, { libre: true, nombre: "M3" }, { libre: true, nombre: "M4" }, { libre: true, nombre: "M5" }, { libre: true, nombre: "M6" }, { libre: true, nombre: "M7" }, { libre: true, nombre: "M8" }, { libre: false, nombre: "M9" }, { libre: true, nombre: "M10" }, { libre: true, nombre: "M11" }, { libre: true, nombre: "M12" },
            { libre: true, nombre: "M13" }, { libre: true, nombre: "M14" }, { libre: true, nombre: "M15" }, { libre: true, nombre: "M16" }, { libre: true, nombre: "M17" }, { libre: false, nombre: "M18" }, { libre: true, nombre: "M19" }, { libre: true, nombre: "M20" }, { libre: true, nombre: "M21" }, { libre: true, nombre: "M22" }, { libre: true, nombre: "M23" }, { libre: true, nombre: "M24" }
            ],
            atras: [
              { libre: true, nombre: "A1" }, { libre: true, nombre: "A2" }, { libre: true, nombre: "A3" }, { libre: true, nombre: "A4" }, { libre: true, nombre: "A5" }, { libre: true, nombre: "A6" }, { libre: true, nombre: "A7" }, { libre: true, nombre: "A8" }, { libre: true, nombre: "A9" }, { libre: true, nombre: "A10" }, { libre: true, nombre: "A11" }, { libre: true, nombre: "A12" },
              { libre: true, nombre: "A13" }, { libre: true, nombre: "A14" }, { libre: true, nombre: "A15" }, { libre: true, nombre: "A16" }, { libre: false, nombre: "A17" }, { libre: true, nombre: "A18" }, { libre: false, nombre: "A19" }, { libre: true, nombre: "A20" }
            ]
          }
        };
        // Puedes agregar otras sedes con sus propias zonas y plazas
zonas.forEach(zona => {
    zona.addEventListener('click', () => {
      sedeSeleccionada = zona.getAttribute('data-sede');
      nombreSede.textContent = sedeSeleccionada;
      plazaSeleccionada = null;
      confirmarPlazaBtn.style.display = 'none';

      zonaMedia.innerHTML = '';
      zonaAtras.innerHTML = '';

      plazasPorSede[sedeSeleccionada].media.forEach(plazaObj => {
        const plaza = document.createElement('div');
        plaza.className = 'plaza' + (plazaObj.libre ? ' libre' : ' ocupada');
        plaza.textContent = plazaObj.nombre;
        if (plazaObj.libre) {
          plaza.addEventListener('click', () => {
            document.querySelectorAll('#zonaMedia .plaza.libre, #zonaAtras .plaza.libre')
              .forEach(p => p.classList.remove('seleccionada'));
            plaza.classList.add('seleccionada');
            plazaSeleccionada = plazaObj.nombre;
            confirmarPlazaBtn.style.display = 'inline-block';
          });
        }
        zonaMedia.appendChild(plaza);
      });

      plazasPorSede[sedeSeleccionada].atras.forEach(plazaObj => {
        const plaza = document.createElement('div');
        plaza.className = 'plaza' + (plazaObj.libre ? ' libre' : ' ocupada');
        plaza.textContent = plazaObj.nombre;
        if (plazaObj.libre) {
          plaza.addEventListener('click', () => {
            document.querySelectorAll('#zonaMedia .plaza.libre, #zonaAtras .plaza.libre')
              .forEach(p => p.classList.remove('seleccionada'));
            plaza.classList.add('seleccionada');
            plazaSeleccionada = plazaObj.nombre;
            confirmarPlazaBtn.style.display = 'inline-block';
          });
        }
        zonaAtras.appendChild(plaza);
      });

      plazasModal.style.display = 'block';
    });
  });

confirmarPlazaBtn.addEventListener('click', async () => {
  if (!usuarioID || usuarioID === 0) {
    alert("Debes iniciar sesión para reservar una plaza.");
    return;
  }
  if (plazaSeleccionada) {
    const data = {
      sede: sedeSeleccionada,
      plaza: plazaSeleccionada,
      usuarioID: usuarioID
    };

    try {
      const resp = await fetch('/api/reserva-crear', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });

      if (!resp.ok) {
        alert("Error al comunicarse con el servidor.");
        return;
      }
      const result = await resp.json();
      if (result.success) {
        alert("Plaza reservada temporalmente (en proceso). Completa la reserva.");
        plazasModal.style.display = 'none';
        reservaForm.dataset.reservaID = result.reservaID; // Guarda id para luego
        reservaModal.style.display = 'block';
      } else {
        alert("No se pudo reservar la plaza: " + result.message);
      }
    } catch (e) {
      console.error("Error en la petición:", e);
      alert("Error en la conexión.");
    }
  }
});





  // --- RESTRICCIÓN DE TIPO DE PLAZA SEGÚN PERFIL ---
  function actualizarTipoPlaza() {
    Array.from(tipoPlazaSelect.options).forEach(opt => {
      if (opt.value === "premium") {
        opt.disabled = (tipoUsuario !== "premium");
      }
    });
  }
  actualizarTipoPlaza();

  // --- CÁLCULO Y DETALLE DEL COSTO ---
  function calcularYMostrarCosto() {
    const fechaLlegada = document.getElementById('fechaLlegada').value;
    const fechaSalida = document.getElementById('fechaSalida').value;
    const horaLlegada = document.getElementById('horaLlegada').value;
    const horaSalida = document.getElementById('horaSalida').value;

    if (!fechaLlegada || !fechaSalida || !horaLlegada || !horaSalida) {
      costoTextarea.value = "Complete las fechas y horas para ver el costo.";
      return 0;
    }

    const entrada = new Date(`${fechaLlegada}T${horaLlegada}`);
    const salida = new Date(`${fechaSalida}T${horaSalida}`);

    if (salida <= entrada) {
      costoTextarea.value = "La salida debe ser posterior a la llegada.";
      return 0;
    }

    const ms = salida - entrada;
    const horas = ms / (1000 * 60 * 60);
    const tarifaPorHora = 10;
    let costoTiempo = Math.ceil(horas) * tarifaPorHora;

    let costoServicios = 0;
    let detalleServicios = "";
    Array.from(serviciosAdicionales.selectedOptions).forEach(opt => {
      let costo = 0;
      if (opt.value === "lavado") { costo = 5; detalleServicios += "Lavado: S/10\n"; }
      if (opt.value === "mecanico") { costo = 15; detalleServicios += "Mecánico: S/20\n"; }
      if (opt.value === "seguro") { costo = 8; detalleServicios += "Seguro: S/13\n"; }
      if (opt.value === "aire") { costo = 15; detalleServicios += "Inflado de llantas: S/10\n"; }
      if (opt.value === "parabrisas") { costo = 8; detalleServicios += "Limpieza de parabrisas: S/8\n"; }
      costoServicios += costo;
    });

    let total = costoTiempo + costoServicios;
    let detalle = `Tiempo: S/${costoTiempo}\n${detalleServicios}`;
    if (tipoUsuario === "premium") {
      let descuento = total * descuentoPremium;
      total -= descuento;
      detalle += `Descuento premium: -S/${descuento.toFixed(2)}\n`;
    }
    detalle += `TOTAL: S/${total.toFixed(2)}`;

    costoTextarea.value = detalle;
    return total;
  }

  ['fechaLlegada','fechaSalida','horaLlegada','horaSalida','serviciosAdicionales','tipoPlaza'].forEach(id => {
    const el = document.getElementById(id);
    if(el) el.addEventListener('change', calcularYMostrarCosto);
  });
  serviciosAdicionales.addEventListener('change', calcularYMostrarCosto);

  // --- RESTRICCIÓN AL ENVIAR FORMULARIO Y REDIRECCIÓN POR TIPO DE PAGO ---
  reservaForm.addEventListener('submit', async function(e) {
  e.preventDefault();

  const reservaID = reservaForm.dataset.reservaID;
  if (!reservaID) {
    alert("No se encontró reserva preliminar. Selecciona una plaza.");
    return;
  }

  const formData = {
    reservaID: reservaID,
    fechaLlegada: document.getElementById('fechaLlegada').value,
    fechaSalida: document.getElementById('fechaSalida').value,
    horaLlegada: document.getElementById('horaLlegada').value,
    horaSalida: document.getElementById('horaSalida').value,
    tipoVehiculo: document.getElementById('tipoVehiculo').value,
    tipoPlaza: document.getElementById('tipoPlaza').value,
    serviciosAdicionales: Array.from(document.getElementById('serviciosAdicionales').selectedOptions).map(opt => opt.value),
    tipoPago: document.getElementById('tipoPago').value,
    // etc.
  };

  try {
    const response = await fetch('/api/reserva-confirmar', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(formData),
    });
    const result = await response.json();

    if (result.success) {
      alert("Reserva confirmada con éxito. Procede al pago.");
      reservaModal.style.display = 'none';

      // Redirigir según tipoPago (o mostrar modal)
      switch(formData.tipoPago) {
        case 'tarjeta': window.location.href = 'pago_tarjeta.jsp?reservaID=' + reservaID; break;
        case 'paypal': window.location.href = 'pago_paypal.jsp?reservaID=' + reservaID; break;
        case 'yape': window.location.href = 'pago_yape.jsp?reservaID=' + reservaID; break;
        case 'efectivo': window.location.href = 'boleta_pago.jsp?reservaID=' + reservaID; break;
        default: alert("Método de pago inválido."); break;
      }
    } else {
      alert("No se pudo confirmar la reserva.");
    }

  } catch (error) {
    console.error("Error confirmando reserva:", error);
    alert("Error en la conexión al servidor.");
  }
});

});
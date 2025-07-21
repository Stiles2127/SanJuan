
// Abre/cierra modales básicos
function abrirModal(idModal) {
    document.getElementById(idModal).style.display = "flex";
    document.body.classList.add("modal-open"); // Previene scroll de fondo
}
function cerrarModal() {
    document.querySelectorAll('.modal').forEach(function(modal) {
        modal.style.display = "none";
    });
    document.body.classList.remove("modal-open");
}

// Demo dinámico para tarifas
function consultarTarifas() {
    var sede = document.getElementById("tarifa-sede").value;
    var resultados = document.getElementById("resultado-tarifa");
    // Aquí iría fetch/ajax si quieres datos reales
    // Demo hardcode:
    if (sede === "1") {
        resultados.innerHTML = `
            <table>
                <tr><th>Tipo Vehículo</th><th>Precio (S/.)</th></tr>
                <tr><td>Auto</td><td>4.50</td></tr>
                <tr><td>Moto</td><td>2.00</td></tr>
            </table>`;
    } else if (sede === "2") {
        resultados.innerHTML = `
            <table>
                <tr><th>Tipo Vehículo</th><th>Precio (S/.)</th></tr>
                <tr><td>Auto</td><td>3.50</td></tr>
                <tr><td>Moto</td><td>1.80</td></tr>
            </table>`;
    } else if (sede === "3") {
        resultados.innerHTML = `
            <table>
                <tr><th>Tipo Vehículo</th><th>Precio (S/.)</th></tr>
                <tr><td>Auto</td><td>5.10</td></tr>
                <tr><td>Moto</td><td>2.20</td></tr>
            </table>`;
    } else if (sede === "4") {
        resultados.innerHTML = `
            <table>
                <tr><th>Tipo Vehículo</th><th>Precio (S/.)</th></tr>
                <tr><td>Auto</td><td>4.10</td></tr>
                <tr><td>Moto</td><td>1.70</td></tr>
            </table>`;
    } else {
        resultados.innerHTML = "(Elije una sede)";
    }
}

// Demo dinámico para espacios
function consultarEspacios() {
    var sede = document.getElementById("espacio-sede").value;
    var resultados = document.getElementById("resultado-espacios");
    // Aquí iría fetch/ajax para datos reales
    // Demo hardcode:
    if (sede === "1") {
        resultados.innerHTML = `
            <ul>
                <li>Módulo 1: 12 Disponibles</li>
                <li>Módulo 2: 4 Ocupados</li>
            </ul>`;
    } else if (sede === "2") {
        resultados.innerHTML = `
            <ul>
                <li>Módulo 1: 8 Disponibles</li>
                <li>Módulo 2: 2 Ocupados</li>
            </ul>`;
    } else if (sede === "3") {
        resultados.innerHTML = `
            <ul>
                <li>Módulo 1: 15 Disponibles</li>
                <li>Módulo 2: 1 Ocupado</li>
            </ul>`;
    } else if (sede === "4") {
        resultados.innerHTML = `
            <ul>
                <li>Módulo 1: 11 Disponibles</li>
                <li>Módulo 2: 5 Ocupados</li>
            </ul>`;
    } else {
        resultados.innerHTML = "(Elije una sede)";
    }
}

// Permitir cerrar modal haciendo clic afuera
window.onclick = function (event) {
    document.querySelectorAll('.modal').forEach(function(modal) {
        if (event.target === modal) cerrarModal();
    });
};

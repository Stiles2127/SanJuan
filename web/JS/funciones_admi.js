
function mostrarDatosSede(sedeID) {
    // Limpia el área primero (opcional)
    document.getElementById('resultadosZona').innerHTML = "<div class='msg-info'>Cargando...</div>";
    // AJAX con fetch moderno
    fetch('ajaxDatosSede.jsp?sede=' + sedeID)
        .then(resp => resp.text())
        .then(html => {
            document.getElementById('resultadosZona').innerHTML = html;
        })
        .catch(e => {
            document.getElementById('resultadosZona').innerHTML = "<div class='msg-error'>No se pudo cargar la información.</div>";
        });
}

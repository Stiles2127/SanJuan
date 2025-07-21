// Mostrar tabla de tarifas al cargar
const context = document.body.getAttribute('data-context') || '';


function cargarTarifas() {
    fetch('ajax/ajaxTarifas.jsp')
        .then(r => r.text())
        .then(html => { document.getElementById('tabla-tarifas').innerHTML = html; });
}

function guardarTarifa() {
    let fd = new FormData(document.getElementById('formNuevaTarifa'));
    fetch('ajax/ajaxTarifasCRUD.jsp', { method: 'POST', body: fd })
        .then(r => r.text())
        .then(msj => {
            cargarTarifas();
            document.getElementById('mensajes-ajustes').innerHTML = msj;
        });
}

function editarTarifa(id) {
    let vehiculo = document.getElementById('vehiculo-'+id).value;
    let precio   = document.getElementById('precio-'+id).value;
    let fd = new FormData();
    fd.append('accion', 'editar');
    fd.append('tarifaID', id);
    fd.append('tipoVehiculo', vehiculo);
    fd.append('precio', precio);
    fetch('ajaxTarifasCRUD.jsp', { method: 'POST', body: fd })
        .then(r => r.text())
        .then(msj => {
            cargarTarifas();
            document.getElementById('mensajes-ajustes').innerHTML = msj;
        });
}

function eliminarTarifa(id) {
    if(!confirm("¿Eliminar esta tarifa?")) return;
    let fd = new FormData();
    fd.append('accion', 'eliminar');
    fd.append('tarifaID', id);
    fetch('ajax/ajaxTarifasCRUD.jsp', { method: 'POST', body: fd })
        .then(r => r.text())
        .then(msj => {
            cargarTarifas();
            document.getElementById('mensajes-ajustes').innerHTML = msj;
        });
}

function agregarSede() {
    let fd = new FormData(document.getElementById('formNuevaSede'));
    fetch('ajax/ajaxSedesCRUD.jsp', { method: 'POST', body: fd })
        .then(r => r.text())
        .then(msj => {
            document.getElementById('mensajes-ajustes').innerHTML = msj;
        });
}

function agregarEspacios() {
    let fd = new FormData(document.getElementById('formAgregarEspacios'));
    fetch('ajax/ajaxEspaciosCRUD.jsp', { method: 'POST', body: fd })
        .then(r => r.text())
        .then(msj => { document.getElementById('mensajes-ajustes').innerHTML = msj; });
}

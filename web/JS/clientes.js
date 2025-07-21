const CONTEXT = document.body.dataset.context || '';

document.addEventListener('DOMContentLoaded', function() {
    cargarFormulario();
    cargarClientes();
});

function cargarFormulario(editId) {
    let url = CONTEXT + "/ajax/ajaxFormCliente.jsp";
    if (editId) url += "?editUsuarioID=" + editId;
    fetch(url).then(r=>r.text()).then(html=>{
        document.getElementById('form-clientes').innerHTML = html;
    });
}

function cargarClientes() {
    fetch(CONTEXT+'/ajax/ajaxTablaClientes.jsp')
      .then(r=>r.text())
      .then(html=>{ document.getElementById('tabla-clientes').innerHTML=html; });
}


function editarCliente(usuarioId) {
    cargarFormulario(usuarioId);
}

function eliminarCliente(usuarioId) {
    if(confirm("¿Eliminar este cliente?")){
        let fd = new FormData();
        fd.append("accion", "borrar");
        fd.append("UsuarioID", usuarioId);
        fetch(CONTEXT+'/servlet/AdminClienteServlet', {method:'POST', body: fd})
            .then(r=>r.text())
            .then(res=>{
                cargarClientes();
                cargarFormulario();
            });
    }
}

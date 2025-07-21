const CONTEXT = document.body.getAttribute('data-context') || '';

function buscarHistorial(e) {
    e.preventDefault();
    let q = document.getElementById('busqueda').value.trim();
    if(q === '') {
        document.getElementById('resultados-historial').innerHTML =
            "<div class='msg-info'>Debes escribir algún dato del cliente.</div>";
        return;
    }
    document.getElementById('resultados-historial').innerHTML = "<div class='msg-info'>Buscando...</div>";
    fetch(CONTEXT + '/ajax/ajaxBuscarHistorial.jsp?busqueda=' + encodeURIComponent(q))
      .then(r=>r.text())
      .then(html=>{
        document.getElementById('resultados-historial').innerHTML = html;
      });
}

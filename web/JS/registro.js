document.addEventListener('DOMContentLoaded', function() {
    const perfil = document.getElementById('perfil');
    const numPlacas = document.getElementById('numPlacas');
    const vehiculosDiv = document.getElementById('vehiculos');

    function crearCampoVehiculo(index) {
        return `
        <div class="vehiculo">
            <input type="text" name="placa[]" placeholder="Placa del Vehículo" required class="placa-input" data-index="${index}">
            <input type="text" name="tipo[]" placeholder="Tipo (Carro/Moto)" readonly style="background:#dcdcf7;">
        </div>
        `;
    }

    perfil.addEventListener('change', function() {
        if (this.value === '2') { // Premium
            numPlacas.style.display = 'block';
            numPlacas.value = '';
            vehiculosDiv.innerHTML = '';
        } else {
            numPlacas.style.display = 'none';
            vehiculosDiv.innerHTML = crearCampoVehiculo(0);
            agregarListenersPlaca();
        }
    });

    numPlacas.addEventListener('input', function() {
        let cantidad = parseInt(this.value) || 1;
        cantidad = Math.max(1, Math.min(cantidad, 5)); // Limita entre 1 y 5
        vehiculosDiv.innerHTML = '';
        for(let i=0; i<cantidad; i++) {
            vehiculosDiv.innerHTML += crearCampoVehiculo(i);
        }
        agregarListenersPlaca();
    });

    function detectarTipoPlaca(placa) {
        placa = placa.trim().toUpperCase();
        // Moto: AB-1234 o 1234-AB
        if (/^[A-Z]{2}-\d{4}$/.test(placa) || /^\d{4}-[A-Z]{2}$/.test(placa)) {
            return 'Moto';
        }
        // Carro: TUV-456
        if (/^[A-Z]{3}-\d{3}$/.test(placa)) {
            return 'Carro';
        }
        return '';
    }

    function agregarListenersPlaca() {
        document.querySelectorAll('.placa-input').forEach(function(input) {
            input.addEventListener('input', function() {
                const tipoField = this.parentNode.querySelector('input[name="tipo[]"]');
                tipoField.value = detectarTipoPlaca(this.value);
            });
        });
    }

    // Inicialización para el caso básico
    agregarListenersPlaca();
});

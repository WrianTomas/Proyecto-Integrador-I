<%-- 
    Document   : registro
    Created on : 14 may. 2026, 9:04:54 a. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Incidentes Urbanos</title>
    <link href="CSS/estilos.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="CSS/registro.css">
</head>
<body>

<div class="contenedor-login ancho-medio">
    <div class="cabecera-login">
        <h3 style="color: #198754;">Crear Cuenta</h3>
        <p>Únete para reportar en Santa Clara</p>
    </div>
    
    <form id="formRegistro">
        <div class="fila-2-cols">
            <div class="grupo-formulario">
                <label>Nombres</label>
                <input type="text" class="input-estandar" name="nombres" required>
            </div>
            <div class="grupo-formulario">
                <label>Apellidos</label>
                <input type="text" class="input-estandar" name="apellidos" required>
            </div>
        </div>
        
        <div class="fila-2-cols">
            <div class="grupo-formulario">
                <label>DNI</label>
                <input type="text" class="input-estandar" name="dni" maxlength="8" pattern="\d{8}" title="Debe contener exactamente 8 números" required>
            </div>
            <div class="grupo-formulario">
                <label>Teléfono</label>
                <input type="tel" class="input-estandar" name="telefono" maxlength="15" pattern="[0-9]+" title="Solo ingrese números">
            </div>
        </div>
        
        <div class="grupo-formulario">
            <label>Correo Electrónico</label>
            <input type="email" class="input-estandar" name="correo" required>
        </div>
        <div class="grupo-formulario">
            <label>Contraseña</label>
            <input type="password" class="input-estandar" name="clave" required>
        </div>
        
        <button type="submit" class="btn-principal" style="background-color: #198754;">Registrarme</button>
    </form>
    
    <div id="mensajeAlerta" class="alerta-error"></div>
    
    <a href="login.jsp" class="enlace-registro">¿Ya tienes cuenta? Inicia sesión aquí</a>
</div>

<script>
    document.getElementById('formRegistro').addEventListener('submit', function(event) {
        event.preventDefault(); 
        
        const formData = new URLSearchParams(new FormData(this));
        const alerta = document.getElementById('mensajeAlerta');
        const btnSubmit = this.querySelector('button[type="submit"]'); // Capturamos el botón
        
        btnSubmit.disabled = true;
        btnSubmit.textContent = "Procesando...";
        btnSubmit.style.opacity = "0.7";
        
        fetch('/ProyectoIntegrador/api/registro', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        })
        .then(respuesta => respuesta.json())
        .then(datos => {
            alerta.classList.add('visible');
            if(datos.status === 'success'){
                alerta.style.backgroundColor = '#d1e7dd';
                alerta.style.color = '#0f5132';
                alerta.textContent = datos.message;
                setTimeout(() => { window.location.href = 'login.jsp'; }, 2000);
            } else {
                alerta.style.backgroundColor = '#f8d7da';
                alerta.style.color = '#dc3545';
                alerta.textContent = datos.message;
                restaurarBoton(btnSubmit);
            }
        })
        .catch(error => {
            alerta.classList.add('visible');
            alerta.style.backgroundColor = '#f8d7da';
            alerta.style.color = '#dc3545';
            alerta.textContent = "Error de conexión con el servidor.";
            restaurarBoton(btnSubmit);
        });
    });

    function restaurarBoton(btn) {
        btn.disabled = false;
        btn.textContent = "Registrarme";
        btn.style.opacity = "1";
    }
</script>

</body>
</html>
<%-- 
    Document   : dashboardAdmin
    Created on : 20 may. 2026, 10:15:44 p. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Centro de Control - Autoridades</title>
        <link rel="stylesheet" href="CSS/dashboardAd.css">
    </head>
    <body>

        <div class="cabecera">
            <div>
                <h1 style="margin:0; color:#dc3545;">Panel de Control Administrativo</h1>
                <p style="margin:5px 0 0 0; color:#adb5bd;">Municipalidad de Ate - Zona Santa Clara</p>
            </div>
            <div>
                <span id="nombreAdminUI" style="margin-right: 20px; color: #adb5bd; font-weight: bold;">Cargando...</span>
                <button onclick="cerrarSesionAdmin()" class="btn-salir">Cerrar Sesión</button>
            </div>
        </div>

        <div class="grid-menu">
            <a href="gestionZonas.jsp" class="tarjeta-modulo">
                <div class="icono">🗺️</div>
                <h3>Gestión de Zonas</h3>
                <p style="color:#adb5bd; font-size:14px;">Añadir o editar sectores y urbanizaciones operativas.</p>
            </a>

            <a href="bandejaIncidentes.jsp" class="tarjeta-modulo">
                <div class="icono">🚨</div>
                <h3>Bandeja de Incidentes</h3>
                <p style="color:#adb5bd; font-size:14px;">Revisar reportes de vecinos y cambiar estados.</p>
            </a>
        </div>

        <script>
            const adminActivo = JSON.parse(localStorage.getItem('adminLogueado'));
            if (!adminActivo) {
                window.location.href = 'loginAdmin.jsp';
            } else {
                document.getElementById('nombreAdminUI').innerText = "Bienvenido, " + adminActivo.usuario;
            }

            function cerrarSesionAdmin() {
                localStorage.removeItem('adminLogueado');
                window.location.href = 'loginAdmin.jsp';
            }
        </script>
    </body>
</html>
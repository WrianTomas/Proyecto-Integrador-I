<%-- 
    Document   : bandejaIncidentes
    Created on : 20 may. 2026, 11:18:38 p. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bandeja de Incidentes - Autoridades</title>
        <link rel="stylesheet" href="CSS/bandeja.css">
    </head>
    <body>

        <div class="cabecera">
            <div class="titulo">
                <h1>Bandeja de Incidentes Activos</h1>
                <p>Gestión y seguimiento de reportes ciudadanos.</p>
            </div>
            <a href="dashboardAdmin.jsp" class="btn-volver">← Volver al Panel</a>
        </div>

        <div class="panel-tabla">
            <table class="tabla-admin">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Categoría</th>
                        <th>Ubicación</th>
                        <th>Prioridad</th>
                        <th>Estado Actual</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody id="cuerpoTablaAdmin">
                    <tr><td colspan="6" style="text-align: center; color: #adb5bd;">Cargando reportes del servidor...</td></tr>
                </tbody>
            </table>
        </div>

        <script>
            // Validación de Seguridad
            const adminActivo = JSON.parse(localStorage.getItem('adminLogueado'));
            if (!adminActivo) {
                window.location.href = 'loginAdmin.jsp';
            }

            document.addEventListener("DOMContentLoaded", function () {
                cargarBandeja();
            });

            // 1. CARGAR DATOS DESDE LA BASE DE DATOS
            function cargarBandeja() {
                fetch('/ProyectoIntegrador/api/incidencias')
                        .then(res => res.json())
                        .then(datos => {
                            const tbody = document.getElementById('cuerpoTablaAdmin');
                            tbody.innerHTML = '';

                            if (datos.length === 0) {
                                tbody.innerHTML = '<tr><td colspan="6" style="text-align: center; color: #adb5bd;">No hay incidentes reportados.</td></tr>';
                                return;
                            }

                            datos.forEach(inc => {
                                let idVal = inc.idIncidencia || inc.id || inc.id_incidencia;
                                let catVal = inc.categoria || "Desconocida";
                                let ubiVal = inc.ubicacion || "Sin ubicación";
                                let prioVal = inc.prioridad || "Media";
                                let estVal = inc.estado || "Pendiente";

                                // Estilos de prioridad
                                let clasePrio = prioVal === 'Alta' ? 'p-alta' : (prioVal === 'Media' ? 'p-media' : 'p-baja');

                                // Selección dinámica del estado actual
                                let selPendiente = estVal === 'Pendiente' ? 'selected' : '';
                                let selProceso = estVal === 'En proceso' ? 'selected' : '';
                                let selAtendido = estVal === 'Atendido' ? 'selected' : '';

                                let fila = "<tr>" +
                                        "<td>#" + idVal + "</td>" +
                                        "<td style='font-weight:bold;'>" + catVal + "</td>" +
                                        "<td>" + ubiVal + "</td>" +
                                        "<td><span class='badge " + clasePrio + "'>" + prioVal + "</span></td>" +
                                        "<td>" +
                                        "<select class='select-estado' id='estado_" + idVal + "'>" +
                                        "<option value='Pendiente' " + selPendiente + ">Pendiente</option>" +
                                        "<option value='En proceso' " + selProceso + ">En proceso</option>" +
                                        "<option value='Atendido' " + selAtendido + ">Atendido</option>" +
                                        "</select>" +
                                        "</td>" +
                                        "<td><button class='btn-actualizar' onclick='actualizarEstado(" + idVal + ")'>Guardar</button></td>" +
                                        "</tr>";

                                tbody.innerHTML += fila;
                            });
                        })
                        .catch(err => {
                            document.getElementById('cuerpoTablaAdmin').innerHTML = '<tr><td colspan="6" style="color: #ff6b6b; text-align:center;">Error de conexión con el servidor.</td></tr>';
                        });
            }

            // 2. ENVIAR EL NUEVO ESTADO A JAVA
            function actualizarEstado(idIncidencia) {
                let nuevoEstado = document.getElementById('estado_' + idIncidencia).value;

                let payload = "accion=actualizarEstado&idIncidencia=" + idIncidencia + "&nuevoEstado=" + encodeURIComponent(nuevoEstado);

                fetch('/ProyectoIntegrador/api/incidencias', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: payload
                })
                        .then(res => res.json())
                        .then(data => {
                            if (data.status === 'success') {
                                alert('Estado actualizado correctamente a: ' + nuevoEstado);
                                cargarBandeja();
                            } else {
                                alert('Error BD: No se pudo actualizar el estado.');
                            }
                        })
                        .catch(err => alert('Error interno al intentar comunicarse con el servidor.'));
            }
        </script>
    </body>
</html>
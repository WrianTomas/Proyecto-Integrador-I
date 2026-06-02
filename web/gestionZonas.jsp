<%-- 
    Document   : gestionZonas
    Created on : 19 may. 2026, 11:15:30 a. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Zonas - Santa Clara</title>
        <link rel="stylesheet" href="CSS/gestion.css">
    </head>
    <body>

        <a href="dashboardAdmin.jsp" class="btn-volver">← Volver al Panel de Control</a>

        <div class="tarjeta tarjeta-azul">
            <h2 class="h2-azul">Añadir Nuevo Sector a Santa Clara</h2>
            <form id="formNuevaZona" class="formulario-zona">
                <input type="text" id="nombreZona" class="input-estandar" placeholder="Ej. Urbanización Los Pinos" required>
                <input type="text" id="tipoSector" class="input-estandar" placeholder="Ej. Residencial / Comercial" required>
                <button type="submit" class="btn-guardar">+ Guardar Zona</button>
            </form>
        </div>

        <div class="tarjeta tarjeta-gris">
            <h2 style="color: #495057;">Zonas Registradas en la Base de Datos</h2>
            <table class="tabla-estandar">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre de la Zona/Sector</th>
                        <th>Tipo de Área</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablaZonasCuerpo">
                    <tr><td colspan="4" style="text-align: center;">Cargando zonas...</td></tr>
                </tbody>
            </table>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const adminActivo = JSON.parse(localStorage.getItem('adminLogueado'));
                if (!adminActivo) {
                    window.location.href = 'loginAdmin.jsp';
                }

                cargarTablaZonas();
            });

            function cargarTablaZonas() {
                fetch('/ProyectoIntegrador/api/zonas')
                        .then(res => res.json())
                        .then(datos => {
                            const tbody = document.getElementById('tablaZonasCuerpo');
                            tbody.innerHTML = '';

                            if (datos.length === 0) {
                                tbody.innerHTML = '<tr><td colspan="4" style="text-align: center;">No hay zonas registradas.</td></tr>';
                                return;
                            }

                            datos.forEach(z => {
                                let idVal = z.idZona || z.id_zona || z.id || "N/A";
                                let nombreVal = z.nombreZona || z.nombre_zona || z.nombre || "Desconocido";
                                let tipoVal = z.tipoSector || z.tipo_sector || z.tipo || "Sin definir";

                                let fila = "<tr>" +
                                        "<td>#" + idVal + "</td>" +
                                        "<td>" + nombreVal + "</td>" +
                                        "<td><span class='badge'>" + tipoVal + "</span></td>" +
                                        "<td><button class='btn-editar' onclick='alert(\"Módulo de edición en desarrollo para la entrega final\")'>✏️ Editar</button></td>" +
                                        "</tr>";

                                tbody.innerHTML += fila;
                            });
                        })
                        .catch(err => {
                            console.error("Error:", err);
                            document.getElementById('tablaZonasCuerpo').innerHTML = '<tr><td colspan="4" style="text-align: center; color: red;">Error al cargar los datos desde el servidor.</td></tr>';
                        });
            }

            document.getElementById('formNuevaZona').addEventListener('submit', function (e) {
                e.preventDefault();

                const nombre = document.getElementById('nombreZona').value;
                const tipo = document.getElementById('tipoSector').value;

                let payload = "nombreZona=" + encodeURIComponent(nombre) + "&tipoSector=" + encodeURIComponent(tipo);

                fetch('/ProyectoIntegrador/api/zonas', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: payload
                })
                        .then(res => res.json())
                        .then(datos => {
                            if (datos.status === 'success') {
                                alert("¡Sector registrado correctamente en la base de datos!");
                                this.reset();
                                cargarTablaZonas();
                            } else {
                                alert("Error BD: " + datos.message);
                            }
                        })
                        .catch(err => alert("Error interno al intentar guardar."));
            });
        </script>
    </body>
</html>
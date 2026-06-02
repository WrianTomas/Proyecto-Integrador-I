<%-- 
    Document   : index
    Created on : 13 may. 2026, 11:00:01 p. m.
    Author     : david
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">

        <title>Santa Clara Conecta - Portal Ciudadano</title>

        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

        <link rel="stylesheet" href="CSS/index.css">
    </head>
    <body>

        <nav class="navbar">
            <div class="logo">📍 Santa Clara Conecta</div>
            <div class="user-controls">
                <span id="nombreUsuarioUI" style="color: #6c757d; font-weight: 500;">Cargando...</span>
                <button class="btn-reportar" onclick="abrirModal('modalNuevoReporte')">+ Nuevo Reporte</button>
                <button class="btn-salir" onclick="cerrarSesion()">Cerrar Sesión</button>
            </div>
        </nav>

        <div class="stats-banner">
            <div class="stat-card">
                <div class="stat-valor" id="statTotales">0</div>
                <div class="stat-label">Reportes Totales</div>
            </div>
            <div class="stat-card">
                <div class="stat-valor" id="statAtendidos">0</div>
                <div class="stat-label">Casos Solucionados</div>
            </div>
            <div class="stat-card">
                <div class="stat-valor" id="statProceso">0</div>
                <div class="stat-label">En Proceso</div>
            </div>
        </div>

        <div class="contenedor-main">
            <div class="panel-mapa">
                <div class="panel-header">
                    <h2>Mapa de Incidencias en Vivo</h2>
                    <p style="font-size: 12px; color: #6c757d; margin: 0;">💡 Consejo: Haz un clic directo en cualquier punto del mapa para reportar ahí de forma precisa.</p>
                    <button onclick="cargarIncidencias()" style="background:none;border:none;color:#0d6efd;cursor:pointer;font-weight:bold;">↻ Actualizar Mapa</button>
                </div>
                <div id="mapaSantaClara"></div>
            </div>

            <div class="panel-lista">
                <h3>Últimos Reportes</h3>
                <div id="listaIncidencias">
                    <div style="text-align: center; color: #888; padding: 20px;">Cargando historial...</div>
                </div>
            </div>
        </div>

        <div class="modal-overlay" id="modalNuevoReporte">
            <div class="modal-content">
                <button class="btn-cerrar-modal" onclick="cerrarModal('modalNuevoReporte')">&times;</button>
                <h3 style="color: #0d6efd; margin-top: 0; margin-bottom: 20px;">Registrar Incidente</h3>

                <form id="formIncidencia">
                    <input type="hidden" name="idUsuario" id="inputUsuarioId">
                    <input type="hidden" name="idEntidad" value="1">

                    <input type="hidden" id="geoLatitud" name="latitud">
                    <input type="hidden" id="geoLongitud" name="longitud">

                    <div class="grupo-formulario">
                        <label>Zona Afectada (Santa Clara)</label>
                        <select class="input-estandar" name="idZona" id="selectZonas" required>
                            <option value="" disabled selected>Cargando sectores...</option>
                        </select>
                    </div>
                    <div class="grupo-formulario">
                        <label>Categoría</label>
                        <select class="input-estandar" name="categoria" required>
                            <option value="Bache">Bache en la vía</option>
                            <option value="Basura">Acumulación de Basura</option>
                            <option value="Alumbrado">Poste sin luz</option>
                            <option value="Seguridad">Inseguridad ciudadana</option>
                            <option value="Fuga de agua">Fuga de agua</option>
                        </select>
                    </div>
                    <div class="grupo-formulario">
                        <label>Prioridad</label>
                        <select class="input-estandar" name="prioridad" required>
                            <option value="Alta">Alta</option>
                            <option value="Media" selected>Media</option>
                            <option value="Baja">Baja</option>
                        </select>
                    </div>
                    <div class="grupo-formulario">
                        <label>Ubicación exacta (Referencia)</label>
                        <input type="text" id="txtUbicacionRef" class="input-estandar" name="ubicacion" placeholder="Ej: Av. Estrella cuadra 4" required>
                    </div>
                    <div class="grupo-formulario">
                        <label>Descripción detallada</label>
                        <textarea class="input-estandar" name="descripcion" rows="3" required></textarea>
                    </div>

                    <button type="submit" class="btn-principal">Enviar Reporte</button>
                </form>
            </div>
        </div>

        <div class="modal-overlay" id="modalEncuesta">
            <div class="modal-content">
                <button class="btn-cerrar-modal" onclick="cerrarModal('modalEncuesta')">&times;</button>
                <h3 style="color: #0d6efd; margin-top: 0; margin-bottom: 10px; text-align: center;">Calificar Servicio</h3>

                <form id="formEncuesta">
                    <input type="hidden" name="idIncidencia" id="encuestaIdIncidencia">

                    <div style="margin-bottom: 15px;">
                        <label style="font-weight: 600; display: block; margin-bottom: 8px;">Puntuación</label>
                        <select name="puntuacion" class="input-estandar" required>
                            <option value="5">⭐⭐⭐⭐⭐ Excelente</option>
                            <option value="4">⭐⭐⭐⭐ Bueno</option>
                            <option value="3">⭐⭐⭐ Regular</option>
                            <option value="2">⭐⭐ Malo</option>
                            <option value="1">⭐ Pésimo</option>
                        </select>
                    </div>
                    <div style="margin-bottom: 20px;">
                        <label style="font-weight: 600; display: block; margin-bottom: 8px;">Comentario</label>
                        <textarea name="comentario" class="input-estandar" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn-principal" style="background-color: #0d6efd;">Enviar Calificación</button>
                </form>
            </div>
        </div>

        <script>
            const usuarioActual = JSON.parse(localStorage.getItem('usuarioLogueado'));

            let mapa = L.map('mapaSantaClara').setView([-12.01955, -76.88045], 15);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {maxZoom: 19}).addTo(mapa);
            let capaMarcadores = L.layerGroup().addTo(mapa);

            mapa.on('click', function (e) {
                document.getElementById('geoLatitud').value = e.latlng.lat;
                document.getElementById('geoLongitud').value = e.latlng.lng;
                document.getElementById('txtUbicacionRef').placeholder = "Coordenadas capturadas del mapa";
                abrirModal('modalNuevoReporte');
            });

            document.addEventListener("DOMContentLoaded", function () {
                if (!usuarioActual) {
                    window.location.href = 'login.jsp';
                    return;
                }
                document.getElementById('nombreUsuarioUI').innerText = "Hola, " + usuarioActual.nombres;
                document.getElementById('inputUsuarioId').value = usuarioActual.idUsuario;

                cargarZonasDropdown();
                cargarIncidencias();
            });

            function cerrarSesion() {
                localStorage.removeItem('usuarioLogueado');
                window.location.href = 'login.jsp';
            }
            function abrirModal(idModal) {
                document.getElementById(idModal).style.display = 'flex';
            }
            function cerrarModal(idModal) {
                document.getElementById(idModal).style.display = 'none';
            }

            function abrirEncuestaDesdeLista(idIncidencia) {
                document.getElementById('encuestaIdIncidencia').value = idIncidencia;
                abrirModal('modalEncuesta');
            }

            function cargarZonasDropdown() {
                fetch('/ProyectoIntegrador/api/zonas')
                        .then(res => res.json())
                        .then(datos => {
                            const select = document.getElementById('selectZonas');
                            select.innerHTML = '<option value="" disabled selected>Seleccione el sector...</option>';
                            datos.forEach(z => {
                                let idVal = z.idZona || z.id_zona || z.id;
                                let nombreVal = z.nombreZona || z.nombre_zona || z.nombre || "Sector Desconocido";
                                let tipoVal = z.tipoSector || z.tipo_sector || z.tipo || "";
                                if (idVal && idVal !== 'undefined') {
                                    select.innerHTML += '<option value="' + idVal + '">' + nombreVal + ' (' + tipoVal + ')</option>';
                                }
                            });
                        })
                        .catch(err => console.error("Error al cargar zonas:", err));
            }

            function cargarIncidencias() {
                fetch('/ProyectoIntegrador/api/incidencias')
                        .then(respuesta => respuesta.json())
                        .then(datos => {
                            const contenedor = document.getElementById('listaIncidencias');
                            contenedor.innerHTML = '';
                            capaMarcadores.clearLayers();

                            if (datos.length === 0) {
                                contenedor.innerHTML = '<div style="text-align:center; padding:20px;">No hay incidentes.</div>';
                                return;
                            }

                            let contTotales = datos.length;
                            let contAtendidos = 0;
                            let contProceso = 0;

                            datos.forEach(inc => {
                                let idVal = inc.idIncidencia || inc.id || inc.id_incidencia || "-";
                                let catVal = inc.categoria || "Sin categoría";
                                let ubiVal = inc.ubicacion || "Sin ubicación";
                                let estVal = inc.estado || "Pendiente";

                                let latReal = inc.latitud;
                                let lngReal = inc.longitud;

                                if (estVal === 'Atendido')
                                    contAtendidos++;
                                if (estVal === 'En proceso')
                                    contProceso++;

                                let claseColor = estVal === 'Pendiente' ? 'b-pendiente' : (estVal === 'En proceso' ? 'b-proceso' : 'b-atendido');
                                let colorBorde = estVal === 'Pendiente' ? '#6c757d' : (estVal === 'En proceso' ? '#ffc107' : '#198754');

                                let botonAccion = "";
                                if (estVal === 'Atendido') {
                                    botonAccion = '<button type="button" class="btn-calificar-sm" onclick="abrirEncuestaDesdeLista(' + idVal + ')">⭐ Calificar Servicio</button>';
                                }

                                let tarjetaHTML = '<div class="item-reporte" style="border-left-color: ' + colorBorde + ';">' +
                                        '<div class="item-titulo">' +
                                        '<span>#' + idVal + ' - ' + catVal + '</span>' +
                                        '<span class="badge ' + claseColor + '">' + estVal + '</span>' +
                                        '</div>' +
                                        '<div class="item-ubi">📍 ' + ubiVal + '</div>' +
                                        botonAccion +
                                        '</div>';
                                contenedor.innerHTML += tarjetaHTML;

                                if (latReal && lngReal && latReal !== 0) {
                                    let popupHTML = '<b>#' + idVal + ' - ' + catVal + '</b><br>' + ubiVal + '<br><span style="color:' + colorBorde + ';font-weight:bold;">' + estVal + '</span>';
                                    L.marker([latReal, lngReal]).addTo(capaMarcadores).bindPopup(popupHTML);
                                }
                            });

                            document.getElementById('statTotales').innerText = contTotales;
                            document.getElementById('statAtendidos').innerText = contAtendidos;
                            document.getElementById('statProceso').innerText = contProceso;
                        });
            }

            document.getElementById('formIncidencia').addEventListener('submit', function (event) {
                event.preventDefault();
                const formData = new URLSearchParams(new FormData(this));

                let zonaSeleccionada = formData.get('idZona');
                if (!zonaSeleccionada || zonaSeleccionada === 'undefined' || zonaSeleccionada === '') {
                    alert("ALERTA: Por favor, seleccione un sector válido antes de enviar.");
                    return;
                }

                fetch('/ProyectoIntegrador/api/incidencias', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: formData.toString()
                }).then(res => res.json()).then(datos => {
                    if (datos.status === 'success') {
                        alert('¡Registrado exitosamente!');
                        this.reset();
                        document.getElementById('txtUbicacionRef').placeholder = "Ej: Av. Estrella cuadra 4";
                        cerrarModal('modalNuevoReporte');
                        cargarIncidencias();
                    } else {
                        alert('Error: ' + datos.message);
                    }
                }).catch(err => {
                    alert("Error del servidor interno. Revisa NetBeans.");
                });
            });

            document.getElementById('formEncuesta').addEventListener('submit', function (event) {
                event.preventDefault();

                let idInc = document.getElementById('encuestaIdIncidencia').value;
                let punt = document.querySelector('select[name="puntuacion"]').value;
                let com = document.querySelector('textarea[name="comentario"]').value;

                let payload = "idIncidencia=" + idInc + "&puntuacion=" + punt + "&comentario=" + encodeURIComponent(com);

                fetch('/ProyectoIntegrador/api/encuesta', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: payload
                })
                        .then(async respuesta => {
                            const texto = await respuesta.text();
                            try {
                                const datos = JSON.parse(texto);
                                if (datos.status === 'success') {
                                    alert(datos.message);
                                    cerrarModal('modalEncuesta');
                                    this.reset();
                                } else {
                                    alert("Error BD: " + datos.message);
                                }
                            } catch (e) {
                                alert("Error interno en Tomcat. Revisa la consola.");
                            }
                        });
            });
        </script>
    </body>
</html>
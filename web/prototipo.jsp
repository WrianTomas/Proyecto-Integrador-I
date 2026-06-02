<%-- 
    Document   : prototipo
    Created on : 20 may. 2026, 11:00:16 p. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Santa Clara Conecta - Dashboard</title>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
        <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

        <link rel="stylesheet" href="CSS/prototipo.css">
    </head>
    <body>

        <nav class="navbar">
            <div class="logo">
                📍 Santa Clara Conecta <span style="font-size: 12px; font-weight: normal; color: #888;">Portal Ciudadano</span>
            </div>
            <div>
                <button class="btn-reportar" onclick="alert('¡Aquí abriremos el formulario de Nuevo Reporte!')">+ Nuevo Reporte</button>
            </div>
        </nav>

        <div class="stats-banner">
            <div class="stat-card">
                <div class="stat-valor">5</div>
                <div class="stat-label">Reportes Totales</div>
            </div>
            <div class="stat-card">
                <div class="stat-valor">1</div>
                <div class="stat-label">Casos Atendidos</div>
            </div>
            <div class="stat-card">
                <div class="stat-valor">2</div>
                <div class="stat-label">En Proceso</div>
            </div>
            <div class="stat-card">
                <div class="stat-valor">5</div>
                <div class="stat-label">Zonas Activas</div>
            </div>
        </div>

        <div class="contenedor-main">

            <div class="panel-mapa">
                <div class="panel-header">
                    <h2>Mapa de Incidencias en Vivo</h2>
                </div>
                <div id="mapaSantaClara"></div>
            </div>

            <div class="sidebar">
                <div class="tarjeta-side">
                    <h3>Categorías</h3>
                    <ul class="lista-categorias">
                        <li style="color: #1e52fd; font-weight: bold;">Todos <span class="badge-numero">5</span></li>
                        <li>🚨 Seguridad <span class="badge-numero">1</span></li>
                        <li>💡 Alumbrado <span class="badge-numero">1</span></li>
                        <li>🕳️ Vialidad (Baches) <span class="badge-numero">1</span></li>
                        <li>🗑️ Residuos <span class="badge-numero">1</span></li>
                        <li>💧 Fuga de Agua <span class="badge-numero">1</span></li>
                    </ul>
                </div>

                <div class="tarjeta-side">
                    <h3>Reportes Recientes</h3>
                    <div style="background: #f8f9fa; padding: 15px; border-radius: 8px; font-size: 13px; margin-bottom: 10px; border-left: 4px solid #ffc107;">
                        <strong>Fuga de agua</strong><br>
                        <span style="color: #777;">Av. Nicolás de Ayllón km 10</span>
                    </div>
                    <div style="background: #f8f9fa; padding: 15px; border-radius: 8px; font-size: 13px; border-left: 4px solid #198754;">
                        <strong>Alumbrado</strong><br>
                        <span style="color: #777;">Calle Los Laureles cdra 2</span>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var mapa = L.map('mapaSantaClara').setView([-12.016, -76.883], 15);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors',
                maxZoom: 19
            }).addTo(mapa);

            L.marker([-12.015, -76.885]).addTo(mapa)
                    .bindPopup("<b>Fuga de agua</b><br>Av. Nicolás de Ayllón.")
                    .openPopup();

            L.marker([-12.018, -76.880]).addTo(mapa)
                    .bindPopup("<b>Acumulación de Basura</b><br>Mercado de Santa Clara.");
        </script>

    </body>
</html>
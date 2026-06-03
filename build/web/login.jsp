<%-- 
    Document   : login
    Created on : 14 may. 2026, 8:24:35 a. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Santa Clara Conecta - Iniciar Sesión</title>
        <link rel="stylesheet" href="CSS/login.css">
    </head>
    <body>

        <div class="marca-contenedor">
            <div class="logo-app">
                <svg viewBox="0 0 24 24">
                <path d="M12 7V3H2v18h20V7H12zm-6 12H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm6 12h-2v-2h2v2zm0-4h-2v-2h2v2zm0-4h-2V9h2v2zm0-4h-2V5h2v2zm8 12h-2v-2h2v2zm0-4h-2v-2h2v2zm0-4h-2V9h2v2z"/>
                </svg>
            </div>
            <h1>Santa Clara Conecta</h1>
            <p>Conectando ciudadanos con su ciudad</p>
        </div>

        <div class="tarjeta-login">

            <div class="contenedor-tabs">
                <button type="button" class="tab-btn activo" onclick="location.href = 'login.jsp'">Iniciar Sesión</button>
                <button type="button" class="tab-btn" onclick="location.href = 'registro.jsp'">Registrarse</button>
            </div>

            <form id="formLogin">
                <div class="grupo-campo">
                    <label>Correo Electrónico</label>
                    <div class="contenedor-input">
                        <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                        <input type="email" id="txtCorreo" class="input-login" placeholder="correo@ejemplo.com" required>
                    </div>
                </div>

                <div class="grupo-campo">
                    <label>Contraseña</label>
                    <div class="contenedor-input">
                        <svg viewBox="0 0 24 24"><path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z"/></svg>
                        <input type="password" id="txtPassword" class="input-login" placeholder="••••••••" required>
                    </div>
                </div>

                <a href="#" class="olvido-contrasena" onclick="alert('Funcionalidad de recuperación en desarrollo para la siguiente entrega.')">¿Olvidaste tu contraseña?</a>

                <button type="submit" class="btn-ingresar">Iniciar Sesión</button>
            </form>

            <div class="divisor-social">O continúa con</div>

            <div class="grid-social">
                <button type="button" class="btn-social" onclick="alert('Autenticación con Google simulada para fines académicos.')">
                    <img src="https://fonts.gstatic.com/s/i/productlogos/googleg/v6/web-24dp/logo_googleg_color_24dp.png" alt="Google">
                    Google
                </button>
                <button type="button" class="btn-social" onclick="alert('Autenticación con Facebook simulada para fines académicos.')">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/2021_Facebook_icon.svg" alt="Facebook">
                    Facebook
                </button>
            </div>
        </div>

        <div class="enlaces-inferiores">
            <a href="index.jsp" class="enlace-footer">Ver Portal Ciudadano →</a>
            <a href="loginAdmin.jsp" class="enlace-footer">Acceso Institucional →</a>
        </div>

        <script>
            document.getElementById('formLogin').addEventListener('submit', function (e) {
                e.preventDefault();
                const correo = document.getElementById('txtCorreo').value;
                const pass = document.getElementById('txtPassword').value;

                let payload = "correo=" + encodeURIComponent(correo) + "&clave=" + encodeURIComponent(pass);

                fetch('/ProyectoIntegrador/api/login', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: payload
                })
                        .then(res => res.json())
                        .then(data => {
                            if (data.status === 'success') {
                                localStorage.setItem('usuarioLogueado', JSON.stringify(data.usuario));
                                window.location.href = 'index.jsp';
                            } else {
                                alert('Error: ' + data.message);
                            }
                        })
                        .catch(err => alert('Error de comunicación con el controlador.'));
            });
        </script>
    </body>
</html>
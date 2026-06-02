<%-- 
    Document   : loginAdmin
    Created on : 19 may. 2026, 9:56:07 a. m.
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Portal Administrativo - Santa Clara</title>
        <link rel="stylesheet" href="CSS/loginAd.css">
    </head>
    <body>

        <div class="tarjeta-admin">
            <h1 class="titulo">Portal Administrativo</h1>
            <p class="subtitulo">Solo personal autorizado - Santa Clara</p>

            <form id="formLoginAdmin">
                <div class="grupo-campo">
                    <label>Correo Institucional</label>
                    <input type="email" id="txtCorreoAdmin" class="input-admin" placeholder="admin@municipio.gob.pe" required>
                </div>

                <div class="grupo-campo">
                    <label>Contraseña</label>
                    <input type="password" id="txtPasswordAdmin" class="input-admin" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn-ingresar">Ingresar al Panel de Control</button>
            </form>

            <div class="alerta-error" id="mensajeError">
                Error de credenciales o conexión con el servidor interno.
            </div>

            <a href="login.jsp" class="enlace-volver">← Volver al portal ciudadano</a>
        </div>

        <script>
            document.getElementById('formLoginAdmin').addEventListener('submit', function (e) {
                e.preventDefault();
                document.getElementById('mensajeError').style.display = 'none';

                const correo = document.getElementById('txtCorreoAdmin').value;
                const pass = document.getElementById('txtPasswordAdmin').value;

                let payload = "correo=" + encodeURIComponent(correo) + "&clave=" + encodeURIComponent(pass);

                fetch('/ProyectoIntegrador/api/loginAdmin', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: payload
                })
                        .then(res => res.json())
                        .then(data => {
                            if (data.status === 'success') {
                                localStorage.setItem('adminLogueado', JSON.stringify(data.usuario || data.admin));
                                window.location.href = 'dashboardAdmin.jsp';
                            } else {
                                document.getElementById('mensajeError').innerText = data.message;
                                document.getElementById('mensajeError').style.display = 'block';
                            }
                        })
                        .catch(err => {
                            console.error(err);
                            document.getElementById('mensajeError').innerText = "Error de comunicación con el servidor interno.";
                            document.getElementById('mensajeError').style.display = 'block';
                        });
            });
        </script>
    </body>
</html>
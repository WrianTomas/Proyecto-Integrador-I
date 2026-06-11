/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectointegrador.controlador;

import com.proyectointegrador.dao.UsuarioDAO;
import com.proyectointegrador.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author david
 */
public class RegistroControlador extends HttpServlet {

    private UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setNombres(request.getParameter("nombres"));
            nuevoUsuario.setApellidos(request.getParameter("apellidos"));
            nuevoUsuario.setDni(request.getParameter("dni"));
            nuevoUsuario.setTelefono(request.getParameter("telefono"));
            nuevoUsuario.setCorreo(request.getParameter("correo"));
            nuevoUsuario.setClave(request.getParameter("clave"));

            boolean exito = dao.registrarUsuario(nuevoUsuario);

            try (PrintWriter out = response.getWriter()) {
                if (exito) {
                    out.print("{\"status\":\"success\", \"message\":\"Cuenta creada exitosamente. ¡Ya puedes iniciar sesión!\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"status\":\"error\", \"message\":\"El DNI o Correo ya se encuentran registrados.\"}");
                }
            }

        } catch (Exception e) {
            System.out.println("🚨 CRASH EN REGISTRO: " + e.getMessage());
            e.printStackTrace(); 
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"status\":\"error\", \"message\":\"Error interno del servidor.\"}");
            }
        }
    }
}

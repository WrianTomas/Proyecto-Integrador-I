/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectointegrador.dao;
import com.proyectointegrador.config.ConexionDB;
import com.proyectointegrador.modelo.Encuesta;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
/**
 *
 * @author david
 */
public class EncuestaDAO {
    
    public boolean registrarEncuesta(Encuesta enc) {
        
        String sql = "INSERT INTO encuesta_satisfaccion (id_incidencia, puntuacion, comentario_ciudadano) VALUES (?, ?, ?)";
        
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, enc.getIdIncidencia());
            ps.setInt(2, enc.getPuntuacion());
            ps.setString(3, enc.getComentario());
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.out.println("Error SQL en EncuestaDAO: " + e.getMessage());
            return false;
        }
    }
}
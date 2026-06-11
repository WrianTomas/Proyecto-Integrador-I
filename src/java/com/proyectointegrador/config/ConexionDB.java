/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.proyectointegrador.config;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author david
 */
public class ConexionDB {
    
    private static final String URL = "jdbc:mysql://localhost:3306/?user=root";
    private static final String USER = "root"; 
    private static final String PASSWORD = "";

    public static Connection conectar() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Falta el Driver de MySQL: " + e.getMessage());
            return null;
        } catch (SQLException e) {
            System.out.println("Error de credenciales o puerto en BD: " + e.getMessage());
            return null;
        }
    }
}

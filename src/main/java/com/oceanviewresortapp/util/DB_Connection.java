package com.oceanviewresortapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB_Connection {

    private static final String URL = "jdbc:sqlserver://HEARTBEAT\\SQLEXPRESS;"
            + "databaseName=OceanViewResort;"
            + "encrypt=true;"
            + "trustServerCertificate=true;";

    private static final String USER = "sa";  // Changed here
    private static final String PASSWORD = "MySAPassword123!";  // Changed here

    public static Connection getConnection() {
        try {
            System.out.println("Trying to connect...");
            Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("DB_Connection successful!");
            return con;
        } catch (SQLException e) {
            System.out.println("DB_Connection failed!");
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        Connection connection = getConnection();

        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
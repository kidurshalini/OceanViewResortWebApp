package com.oceanviewresortapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB_Connection {

    // JDBC URL for SQL Server Authentication
    private static final String URL = "jdbc:sqlserver://HEARTBEAT\\SQLEXPRESS;"
            + "databaseName=OceanViewResort;"
            + "encrypt=true;" // SSL encryption
            + "trustServerCertificate=true;"; // trust self-signed certificates

    private static final String USER = "myuser";
    private static final String PASSWORD = "MyPassword123!";

    public static Connection getConnection() {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connection successful!");
            return conn;
        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        Connection connection = getConnection();

        if (connection != null) {
            try {
                // Close connection when done
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
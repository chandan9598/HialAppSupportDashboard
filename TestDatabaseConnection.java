// File: src/Hial/TestDatabaseConnection.java
package Hial;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestDatabaseConnection {
    private static final String URL = "jdbc:sqlserver://10.102.153.28:1433;databaseName=EBOARDING_HYDERABAD;encrypt=true;trustServerCertificate=true";
    private static final String USER = "hialuser";
    private static final String PASSWORD = "hial$$user";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

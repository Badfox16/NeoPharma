package conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoMySQL {
    private static final String URL = "jdbc:mysql://localhost:3306/bdNeoPharma";
    private static final String USER = "root"; 
    private static final String PASSWORD = "";

   public static Connection getConnection() {
    Connection conn = null;
    try {
        // Registrar o driver explicitamente
        Class.forName("com.mysql.cj.jdbc.Driver"); // Driver do MySQL 8+
        conn = DriverManager.getConnection(URL, USER, PASSWORD);
    } catch (ClassNotFoundException e) {
        System.err.println("Driver JDBC não encontrado.");
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return conn;
}

    public static void closeConnection(Connection conn) {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

package Hial;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
 
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles both GET and POST requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect to the login page if accessed via GET
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input fields
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Hardcoded admin login check
        if ("ChandanKumar".equals(username) && "Spider@123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", "ChandanKumar");
            response.sendRedirect("dashboard.jsp");
            return;  // Exit after admin login
        }

        // Database connection details
        String jdbcUrl = "jdbc:mysql://10.102.153.28:3306/EBOARDING_HYDERABAD?useSSL=false";
        String dbUser = "hialuser";
        String dbPassword = "hial$$user";

        // Check user credentials in the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // Load MySQL JDBC driver

            try (Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                // Prepare SQL query to check username and password
                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, username);
                    ps.setString(2, password);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // Valid credentials, create session
                            HttpSession session = request.getSession();
                            session.setAttribute("user", username);
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            // Invalid credentials
                            response.sendRedirect("error.jsp");
                        }
                    }
                }
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            response.sendRedirect("error.jsp");
        }
    }
}

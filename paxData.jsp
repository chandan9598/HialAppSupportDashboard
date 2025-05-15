<%@ page import="java.sql.*" %>
<%@ page import="Hial.TestDatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PNR Search</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        /* Styling (unchanged) */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #74EBD5, #ACB6E5);
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            padding: 40px;
            max-width: 1400px;
            width: 100%;
            transition: 0.3s;
            overflow: auto;
        }
        h2 { font-size: 28px; color: #1976d2; text-align: center; margin-bottom: 30px; }
        form { display: flex; justify-content: center; gap: 15px; margin-bottom: 30px; flex-wrap: wrap; }
        .input-field {
            width: 100%; max-width: 400px; padding: 12px;
            border: 1px solid #ccc; border-radius: 8px; font-size: 16px;
        }
        button {
            background: #1976d2; color: white; border: none;
            padding: 12px 30px; font-size: 16px; border-radius: 8px;
            cursor: pointer; transition: background 0.3s ease;
        }
        button:hover { background: #0d47a1; }
        .details-table {
            width: 100%; border-collapse: collapse; margin-top: 20px;
        }
        .details-table th, .details-table td {
            padding: 12px; border: 1px solid #ddd; text-align: left;
            font-size: 14px; white-space: nowrap;
        }
        .details-table th { background: #1976d2; color: white; }
        .error-msg {
            color: #d9534f; background: #f8d7da; padding: 15px;
            border-radius: 8px; font-weight: bold; margin: 20px 0;
            text-align: center;
        }
        .btn {
            display: inline-block; background: #ff9800;
            color: white; padding: 12px 30px; font-size: 16px;
            border-radius: 8px; text-decoration: none; margin-top: 30px;
            cursor: pointer;
        }
        .btn:hover { background: #f57c00; }
        .table-container {
            max-height: 500px; overflow-y: auto; border-radius: 8px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
            .logo-img {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 200px; /* Increased from 150px */
            height: auto;
        }
    </style>
</head>
<body>
<img src="<%= request.getContextPath() %>/images/Waisl.png" alt="WAISL Logo" class="logo-img">

<div class="container">
    <h2>Search Passenger Details</h2>

    <!-- PNR Search Form -->
    <form method="GET" action="">
        <input type="text" name="pnr" class="input-field" placeholder="Enter PNR" required>
        <button type="submit">Search</button>
    </form>

    <%
        String pnr = request.getParameter("pnr");
        if (pnr != null && !pnr.trim().isEmpty()) {

            Connection conn = null;
            CallableStatement stmt = null;
            ResultSet rs = null;

            try {
                // ✅ Use custom connection class
                conn = TestDatabaseConnection.getConnection();

                // Call Stored Procedure
                String sql = "{CALL dbo.GetPaxDetails(?)}";
                stmt = conn.prepareCall(sql);
                stmt.setString(1, pnr);

                rs = stmt.executeQuery();

                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();

                if (rs.next()) {
    %>

    <div class="table-container">
        <table class="details-table">
            <thead>
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                        <th><%= metaData.getColumnName(i) %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
    <%
                    do {
    %>
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                        <td><%= rs.getString(i) %></td>
                    <% } %>
                </tr>
    <%
                    } while (rs.next());
    %>
            </tbody>
        </table>
    </div>

    <%
                } else {
    %>
        <p class="error-msg">No data found for PNR: <%= pnr %></p>
    <%
                }
            } catch (Exception e) {
                out.println("<p class='error-msg'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        }
    %>

    <a href="javascript:history.back()" class="btn"><i class="fas fa-arrow-left"></i>🔙 GO Back</a>

</div>

</body>
</html>

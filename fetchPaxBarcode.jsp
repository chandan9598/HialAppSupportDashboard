<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %> 
<%
    String paxName = request.getParameter("name");
    String barcodes = "No record found";  

    if (paxName != null && !paxName.isEmpty()) {
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:sqlserver://10.102.153.28:1433;databaseName=EBOARDING_HYDERABAD;encrypt=true;trustServerCertificate=true";
            String user = "hialuser";
            String password = "hial$$user";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "{CALL dbo.SearchPaxBarcode(?)}";
            stmt = conn.prepareCall(sql);
            stmt.setString(1, paxName);  

            rs = stmt.executeQuery();

            StringBuilder sb = new StringBuilder();
            int count = 0;

            while (rs.next() && count < 5) {
                sb.append(rs.getString("FullBarcode")).append("<br>");
                count++;
            }

            if (count > 0) {
                barcodes = sb.toString();
            }

        } catch (Exception e) {
            barcodes = "Error: " + e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>

<!-- Display barcode result -->
<div style="text-align: center; margin-top: 40px;">
    <pre style="font-size: 18px;"><%= barcodes %></pre>
</div>

<!-- Centered and styled Back button -->
<div style="text-align: center; margin-top: 30px;">
    <form action="searchPax.jsp" method="get">
        <input type="submit" value="🔙 GO Back" style="
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 12px 28px;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s ease;
        ">
    </form>
</div>

<!-- Hover effect -->
<style>
    input[type=submit]:hover {
        background-color: #0056b3;
    }
</style>

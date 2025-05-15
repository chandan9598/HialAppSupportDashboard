<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Hial.TestDatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Passenger Barcode</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74EBD5, #ACB6E5);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 60%;
            overflow-y: auto;
            max-height: 90vh;
        }
        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .button {
            background: linear-gradient(135deg, #4CAF50, #45A049);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin: 5px;
        }
        .button:hover {
            background: linear-gradient(135deg, #45A049, #4CAF50);
        }
        .barcode-result {
            margin-top: 20px;
            font-size: 18px;
            color: #333;
        }
        .barcode-list {
            margin-top: 20px;
            text-align: left;
        }
        .barcode-list li {
            list-style: none;
            padding: 8px;
            border-bottom: 1px solid #ddd;
            font-family: monospace;
            font-size: 16px;
            background: #f4f4f4;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
        }
        .logo-img {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 250px; /* Increased from 150px */
            height: auto;
        }
    </style>
</head>
<body>
<img src="<%= request.getContextPath() %>/images/Waisl.png" alt="WAISL Logo" class="logo-img">
<div class="container">
    <h2>Search Passenger Barcode</h2>
    <form action="fetchPaxBarcode.jsp" method="get">
        <input type="text" name="name" placeholder="Enter Passenger Name" required>
        <button class="button" type="submit">Search</button>
    </form>

    <%
        String paxName = request.getParameter("name");
        if (paxName != null && !paxName.trim().isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String todayDate = sdf.format(new Date());
    %>
        <h3>Search Results for: <%= paxName %></h3>
        <h4>Showing barcodes for: <%= todayDate %></h4>

        <div class="barcode-list">
            <h3>Passenger Barcodes:</h3>
            <ul>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    conn = TestDatabaseConnection.getConnection();

                    String sql = "SELECT barcode FROM PassengerBarcodeTable WHERE paxName = ? AND CONVERT(DATE, entryTime) = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, paxName);
                    stmt.setString(2, todayDate);
                    rs = stmt.executeQuery();

                    boolean hasResults = false;
                    int count = 0;

                    while (rs.next()) {
                        hasResults = true;
                        count++;
            %>
                        <li><strong>Barcode <%= count %>:</strong> <%= rs.getString("barcode") %></li>
            <%
                    }
                    if (!hasResults) {
                        out.println("<p class='barcode-result'>No barcode found for this passenger today.</p>");
                    } else {
                        out.println("<p class='barcode-result'>Total Barcodes Found: " + count + "</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='barcode-result' style='color: red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
            </ul>
        </div>
    <% } %>

    <!-- Back Button -->
    <a href="CreateBoardingPass.jsp">
        <button class="button">🔙 GO Back</button>
    </a>
</div>

</body>
</html>

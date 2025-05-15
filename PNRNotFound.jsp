<%@ page import="java.sql.*" %>
<%@ page import="Hial.TestDatabaseConnection" %> <!-- Import your connection class -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PNR Search</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(45deg, #f06, #48C9B0);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #fff;
            position: relative;
        }
        .container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            padding: 40px;
            max-width: 1200px;
            text-align: center;
        }
        h2 { color: #333; margin-bottom: 20px; }
        form { display: flex; justify-content: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px; }
        .input-field {
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            width: 250px;
        }
        button {
            padding: 12px 20px;
            background-color: #48C9B0;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .details-table-container {
            overflow-x: auto;
            margin-top: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .details-table {
            width: 100%;
            min-width: 800px;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
        }
        .details-table th,
        .details-table td {
            padding: 12px 16px;
            text-align: left;
            font-size: 14px;
            color: #333;
            border: 1px solid #ddd;
            white-space: nowrap;
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .details-table th {
            background-color: #48C9B0;
            color: white;
            font-weight: bold;
            position: sticky;
            top: 0;
            z-index: 1;
        }
        .details-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .error-msg { color: red; font-weight: bold; margin-top: 20px; }
        .btn-container { margin-top: 20px; text-align: center; }
        .back-btn {
            padding: 12px 20px;
            background-color: #ff9800;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        .back-btn:hover { background-color: #e68900; }

        /* Enlarged logo image */
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
    <h2>Search PNR or Flight Number</h2>
    <form method="GET" action="">
        <input type="text" name="pnr" class="input-field" placeholder="Enter PNR">
        <input type="text" name="flightNo" class="input-field" placeholder="Enter Flight No">
        <button type="submit">Search</button>
    </form>

    <%
       String pnr = request.getParameter("pnr");
       String flightNo = request.getParameter("flightNo");
       boolean hasData = false;

       if ((pnr != null && !pnr.trim().isEmpty()) || (flightNo != null && !flightNo.trim().isEmpty())) {
           try (Connection conn = TestDatabaseConnection.getConnection();
                CallableStatement stmt = conn.prepareCall("{CALL dbo.SearchPaxDetails(?, ?)}")) {

               stmt.setString(1, (pnr != null && !pnr.trim().isEmpty()) ? pnr : null);
               stmt.setString(2, (flightNo != null && !flightNo.trim().isEmpty()) ? flightNo : null);

               try (ResultSet rs = stmt.executeQuery()) {
                   ResultSetMetaData metaData = rs.getMetaData();
                   int columnCount = metaData.getColumnCount();

                   if (rs.next()) {
                       hasData = true;
    %>
    <div class="details-table-container">
        <table class="details-table">
            <thead>
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                        <th><%= metaData.getColumnName(i) %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% do { %>
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                        <td><%= rs.getString(i) %></td>
                    <% } %>
                </tr>
                <% } while (rs.next()); %>
            </tbody>
        </table>
    </div>
    <%   } else { %>
        <p class="error-msg">No data found for PNR: <%= pnr %> or Flight No: <%= flightNo %></p>
    <%   }
               }
           } catch (Exception e) {
               out.println("<p class='error-msg'>Error: " + e.getMessage() + "</p>");
           }
       }
    %>

    <div class="btn-container">
        <button class="back-btn" onclick="javascript:history.back();">🔙 GO Back</button>
    </div>
</div>

</body>
</html>

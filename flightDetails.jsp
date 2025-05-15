<%@ page import="java.sql.*, Hial.TestDatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e3f2fd;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            width: 600px;
            text-align: center;
        }
        .container h2 {
            color: #1565c0;
        }
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .details-table th, .details-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .details-table th {
            background-color: #1976d2;
            color: white;
        }
        .search-form {
            margin-bottom: 20px;
        }
        .input-field {
            padding: 10px;
            width: 80%;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .search-btn, .insert-btn, .back-btn {
            background-color: #1976d2;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }
        .search-btn:hover, .insert-btn:hover, .back-btn:hover {
            background-color: #0d47a1;
        }
        .error-msg {
            color: red;
            font-weight: bold;
        }
         .logo-img {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 300px; /* Increased from 150px */
            height: auto;
        }
    </style>
</head>
<body>
    
    <img src="<%= request.getContextPath() %>/images/Waisl.png" alt="WAISL Logo" class="logo-img">

    <div class="container">
        <h2>Search Flight Details</h2>

        <!-- Flight Search Form -->
        <form method="GET" action="flightDetails.jsp" class="search-form">
            <input type="text" name="flightNumber" class="input-field" placeholder="Enter Flight Number" required>
            <button type="submit" class="search-btn">Search Flight</button>
        </form>

        <%
            String flightNumber = request.getParameter("flightNumber");
            boolean flightNotFound = false;

            if (flightNumber != null && !flightNumber.trim().isEmpty()) {
                try (Connection conn = TestDatabaseConnection.getConnection()) {
                    String sql = "{CALL get_DepartureFlights(?)}";
                    try (CallableStatement stmt = conn.prepareCall(sql)) {
                        stmt.setString(1, flightNumber);
                        ResultSet rs = stmt.executeQuery();

                        if (rs.next()) { 
        %>
                            <table class="details-table">
                                <tr>
                                    <th>Flight Number(EB_FLNO1)</th>
                                    <td><%= rs.getString("EB_FLNO1") %></td>
                                </tr>
                                <tr>
                                    <th>Destination</th>
                                    <td><%= rs.getString("DES3") %></td>
                                </tr>
                                <tr>
                                    <th>Scheduled Departure(STOD)</th>
                                    <td><%= rs.getString("STOD") %></td>
                                </tr>
                                <tr>
                                    <th>Estimated Departure(ETDI)</th>
                                    <td><%= rs.getString("ETDI") %></td>
                                </tr>
                                <tr>
                                    <th>Entry Time</th>
                                    <td><%= rs.getString("ENTRYTIME") %></td>
                                </tr>
                                <tr>
                                    <th>Gate</th>
                                    <td><%= rs.getString("GATE1") %></td>
                                </tr>
                                <tr>
                                    <th>Remarks</th>
                                    <td><%= rs.getString("REMP") %></td>
                                </tr>
                                <tr>
                                    <th>URNO</th>
                                    <td><%= (rs.getString("URNO") != null) ? rs.getString("URNO") : "N/A" %></td>
                                </tr>
                            </table>
        <%
                        } else {
                            flightNotFound = true;
                            out.println("<p class='error-msg'>Oops! Flight Not Found in DB: " + flightNumber + "</p>");
                        }
                    }
                } catch (SQLException e) {
                    out.println("<p class='error-msg'>Error: " + e.getMessage() + "</p>");
                }
            }

            if (flightNotFound) {
        %>
            <form method="POST" action="insertFlight.jsp">
                <input type="hidden" name="flightNumber" value="<%= flightNumber %>">
                <button type="submit" class="insert-btn">Insert The Flight In DB</button>
            </form>
        <%
            }
        %>
        <a href="flightNotFound.jsp" class="back-btn">🔙 GO Back</a>

    </div>
</body>
</html>

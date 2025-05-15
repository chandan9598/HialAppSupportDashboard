<%@ page import="java.sql.*, Hial.TestDatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Details</title>

    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .container {
            background: #ffffff;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
            max-width: 900px;
            width: 100%;
            text-align: center;
            transition: 0.3s;
        }

        .container:hover {
            box-shadow: 0 18px 45px rgba(0, 0, 0, 0.3);
        }

        .image-container {
            width: 100%;
            height: 220px;
            overflow: hidden;
            border-radius: 12px;
            margin-bottom: 25px;
            transition: 0.3s;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.5s ease-in-out;
        }

        .image-container img:hover {
            transform: scale(1.05);
        }

        h2 {
            font-size: 32px;
            color: #1976d2;
            margin-bottom: 20px;
        }

        .search-form {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
            margin-bottom: 30px;
        }

        .input-field {
            padding: 14px 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 18px;
            width: 70%;
            transition: 0.3s;
        }

        .input-field:focus {
            border-color: #1976d2;
            outline: none;
            box-shadow: 0 0 12px rgba(25, 118, 210, 0.4);
        }

        .btn {
            background: #1976d2;
            color: #fff;
            padding: 14px 32px;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
        }

        .btn:hover {
            background: #0d47a1;
            transform: translateY(-3px);
        }

        .details {
            text-align: left;
            margin-top: 30px;
            line-height: 1.8;
        }

        .details p {
            font-size: 18px;
            color: #555;
        }

        .error-msg, .success-msg {
            font-weight: bold;
            padding: 18px;
            border-radius: 12px;
            margin: 25px 0;
        }

        .error-msg {
            color: #d9534f;
            background: #f8d7da;
        }

        .success-msg {
            color: #28a745;
            background: #d4edda;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            background: #ff9800;
            color: #fff;
            padding: 12px 30px;
            font-size: 18px;
            border-radius: 25px;
            text-decoration: none;
            transition: 0.3s;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            margin-top: 25px;
        }

        .back-btn:hover {
            background: #f57c00;
            transform: translateY(-3px);
        }

        .back-btn i {
            font-size: 20px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 25px;
            }

            .btn, .back-btn {
                padding: 10px 25px;
                font-size: 16px;
            }

            .image-container {
                height: 180px;
            }

            .input-field {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<img src="images/Waisl.png" alt="Waisl Logo" style="
    position: fixed;
    top: 20px;
    right: 20px;
    width: 180px; 
    height: auto;
    z-index: 1500;
    opacity: 0.9;
">

<div class="container">

    <!-- Image Section -->
    <div class="image-container">
        <img src="images/GMR_EB2.png" alt="E-Boarding System">
    </div>

    <h2>Search Flight Details</h2>

    <!-- Flight Search Form -->
    <form method="GET" action="flightDetails.jsp" class="search-form">
        <input type="text" name="flightNumber" class="input-field" placeholder="Enter Flight Number" required>
        <button type="submit" class="btn"><i class="fas fa-search"></i> Search </button>
    </form>

    <div class="details">
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
                            <div class="success-msg">✅ Flight Details Found!</div>
                            <p><strong>Scheduled Time of Departure (STOD):</strong> <%= rs.getString("STOD") %></p>
                            <p><strong>Estimated Time of Departure (ETDI):</strong> <%= rs.getString("ETDI") %></p>
                            <p><strong>Flight Number:</strong> <%= rs.getString("EB_FLNO1") %></p>
                            <p><strong>Destination:</strong> <%= rs.getString("DES3") %></p>
                            <p><strong>Gate:</strong> <%= rs.getString("GATE1") %></p>
                            <p><strong>Remarks:</strong> <%= rs.getString("REMP") %></p>
                            <p><strong>URNO:</strong> <%= (rs.getString("URNO") != null) ? rs.getString("URNO") : "N/A" %></p>
        <%
                        } else {
                            flightNotFound = true;
        %>
                            <div class="error-msg">❌ Oops! Flight Not Found: <%= flightNumber %></div>
        <%
                        }
                    }
                } catch (SQLException e) {
                    out.println("<div class='error-msg'>Error: " + e.getMessage() + "</div>");
                }
            }
        %>
    </div>

    <!-- Back Button -->
    <a href="dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i>🔙 GO Back</a>

</div>

</body>
</html>

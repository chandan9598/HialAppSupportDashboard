<%@ page import="java.sql.*" %>
<%@ page import="Hial.TestDatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Flight</title>
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
            width: 700px;
            text-align: center;
        }
        .container h2 {
            color: #1565c0;
        }
        .form-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            justify-content: center;
        }
        .input-field {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .full-width {
            grid-column: span 2;
        }
        .submit-btn {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            width: 100%;
        }
        .submit-btn:hover {
            background-color: #218838;
        }
        .error-msg, .success-msg {
            font-weight: bold;
            padding: 10px;
            margin-top: 10px;
        }
        .error-msg {
            color: red;
            background: #f8d7da;
        }
        .success-msg {
            color: green;
            background: #d4edda;
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
        <h2>Insert Flight</h2>

        <%
            String flightNumber = request.getParameter("flightNumber");
            boolean isFormSubmitted = request.getParameter("submit") != null;

            if (!isFormSubmitted) {
        %>
        <form method="POST" action="insertFlight.jsp" class="form-container">
            <input type="hidden" name="submit" value="true">
            <input type="hidden" name="flightNumber" value="<%= flightNumber %>">

            <input type="text" name="URNO" class="input-field" placeholder="Enter URNO" required>
            <input type="text" name="FLNO" class="input-field" placeholder="Enter FLNO" required>
            <input type="text" name="DES3" class="input-field" placeholder="Enter DES3" required>
            <input type="text" name="STOD" class="input-field" placeholder="Enter STOD" required>
            <input type="text" name="ETDI" class="input-field" placeholder="Enter ETDI" required>
            <input type="text" name="REMP" class="input-field" placeholder="Enter Remarks">
            <input type="text" name="GATE1" class="input-field" placeholder="Enter The Boarding GATE Number">
            <input type="text" name="FTYP" class="input-field" placeholder="Enter Flight Type(O)" required>
            <input type="text" name="FLTI" class="input-field" placeholder="Enter Aircraft Type (Domestic/International)" required>
            <input type="text" name="CITY" class="input-field" placeholder="Enter CITY" required>
            <input type="text" name="EBOARDING_FLAG" class="input-field" placeholder="Enter EBOARDING_FLAG(1)" required>
            <input type="date" name="FLIGHT_DATE" class="input-field" required>
            <input type="text" name="EB_FLNO1" class="input-field" placeholder="Enter EB_FLNO1" required>
            <input type="text" name="EB_FLNO2" class="input-field" placeholder="Enter EB_FLNO2" required>
            <input type="text" name="FlightNumeric" class="input-field" placeholder="Enter Numeric Flight Code" required>
            <input type="text" name="FLIGHT_TYPE" class="input-field" placeholder="Enter Flight Type(J)" required>

            <button type="submit" class="submit-btn full-width"> Submit </button>
        </form>
        <%
            } else {
                try {
                    String URNO = request.getParameter("URNO");
                    String FLNO = request.getParameter("FLNO");
                    String DES3 = request.getParameter("DES3");
                    String STOD = request.getParameter("STOD");
                    String ETDI = request.getParameter("ETDI");
                    String REMP = request.getParameter("REMP");
                    String GATE1 = request.getParameter("GATE1");
                    String FTYP = request.getParameter("FTYP");
                    String FLTI = request.getParameter("FLTI");
                    String CITY = request.getParameter("CITY");
                    int EBOARDING_FLAG = Integer.parseInt(request.getParameter("EBOARDING_FLAG"));
                    String FLIGHT_DATE = request.getParameter("FLIGHT_DATE");
                    String EB_FLNO1 = request.getParameter("EB_FLNO1");
                    String EB_FLNO2 = request.getParameter("EB_FLNO2");
                    String FlightNumeric = request.getParameter("FlightNumeric");
                    String FLIGHT_TYPE = request.getParameter("FLIGHT_TYPE");

                    try (Connection conn = TestDatabaseConnection.getConnection()) {
                        String sql = "INSERT INTO DEPARTURES (URNO, FLNO, DES3, STOD, ETDI, REMP, GATE1, FTYP, FLTI, CITY, EBOARDING_FLAG, FLIGHT_DATE, EB_FLNO1, EB_FLNO2, FlightNumeric, FLIGHT_TYPE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                            pstmt.setString(1, URNO);
                            pstmt.setString(2, FLNO);
                            pstmt.setString(3, DES3);
                            pstmt.setString(4, STOD);
                            pstmt.setString(5, ETDI);
                            pstmt.setString(6, REMP);
                            pstmt.setString(7, GATE1);
                            pstmt.setString(8, FTYP);
                            pstmt.setString(9, FLTI);
                            pstmt.setString(10, CITY);
                            pstmt.setInt(11, EBOARDING_FLAG);
                            pstmt.setString(12, FLIGHT_DATE);
                            pstmt.setString(13, EB_FLNO1);
                            pstmt.setString(14, EB_FLNO2);
                            pstmt.setString(15, FlightNumeric);
                            pstmt.setString(16, FLIGHT_TYPE);

                            int rowsInserted = pstmt.executeUpdate();
                            if (rowsInserted > 0) {
                                out.println("<p class='success-msg'>✅ Flight inserted successfully!</p>");
                            } else {
                                out.println("<p class='error-msg'>❌ Failed to insert flight.</p>");
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<p class='error-msg'>❌ Error: " + e.getMessage() + "</p>");
                }
            }
        %>

        <a href="CreateBoardingPass.jsp">🔙 GO Back</a>
    </div>
</body>
</html>

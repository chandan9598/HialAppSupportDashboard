<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Pax Data</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
        }
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #74EBD5, #ACB6E5);
            background-size: 400% 400%;
            animation: gradientBG 10s ease infinite;
        }
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 900px;
            text-align: center;
        }
        .form-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        .input-field {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .submit-btn {
            background: #28a745;
            color: #fff;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            border-radius: 5px;
            width: 150px;
        }
        .submit-btn:hover {
            background: #218838;
        }
        .back-btn {
            background-color: #007bff;
            color: #fff;
            padding: 12px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            width: 150px;
            text-align: center;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
        .success-msg, .error-msg {
            font-weight: bold;
            padding: 10px;
            margin-top: 10px;
            border-radius: 5px;
        }
        .success-msg {
            color: #155724;
            background: #d4edda;
        }
        .error-msg {
            color: #721c24;
            background: #f8d7da;
        }
        .logo-img {
            position: absolute;
            top: 0px;
            right: 0px;
            width: 200px;
            height: auto;
        }
    </style>
</head>
<body>
<img src="<%= request.getContextPath() %>/images/Waisl.png" alt="WAISL Logo" class="logo-img">

<div class="container">
    <h2>Insert Pax Data</h2>

    <%
        boolean isFormSubmitted = request.getParameter("submit") != null;
        if (!isFormSubmitted) {
    %>
    <form method="POST" action="InsertPax.jsp" class="form-container">
        <input type="hidden" name="submit" value="true">

        <input type="text" name="PNL_FLNO" class="input-field" placeholder="EB_FLNO1" required>
        <input type="date" name="PNL_FLIGHTDATE" class="input-field" required>
        <input type="text" name="PNL_PAX" class="input-field" placeholder="Pax Full Name" required>
        <input type="text" name="PNL_PNR" class="input-field" placeholder="PNR" required>
        <input type="text" name="PAXTYPE" class="input-field" placeholder="Pax Type(ADT)" required>
        <input type="text" name="PAXstatus" class="input-field" placeholder="Pax Status(Confirm)" required>
        <input type="text" name="EB_FLNO1" class="input-field" placeholder="EB_FLNO1" required>
        <input type="text" name="EB_FLNO2" class="input-field" placeholder="EB_FLNO2" required>
        <input type="text" name="ORIGIN" class="input-field" placeholder="Origin(HYD)" required>
        <input type="text" name="DESTINATION" class="input-field" placeholder="Destination" required>
        <input type="text" name="SEATNO" class="input-field" placeholder="Seat Number" required>
        <input type="text" name="SEQNO" class="input-field" placeholder="Sequence Number" required>
        <input type="text" name="PAXCURRENTSTATUS" class="input-field" placeholder="Current Status(CHECKEDIN)" required>
        <input type="text" name="PAX_LN" class="input-field" placeholder="Last Name" required>
        <input type="text" name="PAX_FN" class="input-field" placeholder="First Name" required>
        <input type="text" name="PAX_TITLE" class="input-field" placeholder="Title (Mr/Mrs)" required>
        <input type="text" name="ISTRANSIT" class="input-field" placeholder="Is Transit (No/Yes)" required>
        <input type="text" name="PAX_GENDER" class="input-field" placeholder="Gender (M/F)" required>
        <input type="text" name="FLIGHTURNO" class="input-field" placeholder="Flight URNO" required>
        <input type="text" name="FLIGHTPAXTYPE" class="input-field" placeholder="Flight Pax Type (Local)" required>

        <div class="button-group">
            <button type="submit" class="submit-btn">✅ Submit</button>
            <a href="CreateBoardingPass.jsp" class="back-btn">🔙 Go Back</a>
        </div>
    </form>

    <%
        } else {
            try {
                String[] params = {
                    "PNL_FLNO", "PNL_FLIGHTDATE", "PNL_PAX", "PNL_PNR", "PAXTYPE", "PAXstatus",
                    "EB_FLNO1", "EB_FLNO2", "ORIGIN", "DESTINATION", "SEATNO", "SEQNO", "PAXCURRENTSTATUS",
                    "PAX_LN", "PAX_FN", "PAX_TITLE", "ISTRANSIT", "PAX_GENDER", "FLIGHTURNO", "FLIGHTPAXTYPE"
                };

                String[] values = new String[params.length];
                for (int i = 0; i < params.length; i++) {
                    values[i] = request.getParameter(params[i]);
                }

                String url = "jdbc:sqlserver://10.102.153.28:1433;databaseName=EBOARDING_HYDERABAD;encrypt=true;trustServerCertificate=true";
                String user = "hialuser";
                String password = "hial$$user";

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

                try (Connection conn = DriverManager.getConnection(url, user, password)) {
                    String sql = "INSERT INTO PNLTAB (PNL_FLNO, PNL_FLIGHTDATE, PNL_PAX, PNL_PNR, PAXTYPE, PAXstatus, EB_FLNO1, EB_FLNO2, ORIGIN, DESTINATION, SEATNO, SEQNO, PAXCURRENTSTATUS, PAX_LN, PAX_FN, PAX_TITLE, ISTRANSIT, PAX_GENDER, FLIGHTURNO, FLIGHTPAXTYPE) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        for (int i = 0; i < values.length; i++) {
                            pstmt.setString(i + 1, values[i]);
                        }

                        int rowsInserted = pstmt.executeUpdate();
                        if (rowsInserted > 0) {
                            out.println("<p class='success-msg'>✅ Pax inserted successfully!</p>");
                        } else {
                            out.println("<p class='error-msg'>❌ No record inserted!</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p class='error-msg'>❌ Error: " + e.getMessage() + "</p>");
            }
    %>
        <div class="button-group">
            <a href="InsertPax.jsp" class="back-btn">⬅ Insert Another</a>
            <a href="CreateBoardingPass.jsp" class="back-btn">🔙 Go Back</a>
        </div>
    <%
        }
    %>
</div>
</body>
</html>

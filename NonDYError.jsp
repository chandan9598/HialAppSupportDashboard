<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FRS Registration Search</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #74EBD5 0%, #ACB6E5 100%);
            margin: 0;
            padding: 20px;
        }

        .container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            padding: 40px;
            max-width: 1100px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 40px;
            font-size: 28px;
        }

        .options-wrapper {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 40px;
        }

        .option-form {
            margin: 0;
        }

        .modern-option {
            background: linear-gradient(135deg, #1abc9c, #16a085);
            color: white;
            font-size: 18px;
            font-weight: 500;
            padding: 18px 28px;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modern-option:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.25);
            background: linear-gradient(135deg, #16a085, #149174);
        }

        input[type="text"] {
            padding: 12px 20px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 300px;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 12px 25px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 14px;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .success-msg, .error-msg {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
        }

        .success-msg {
            color: green;
        }

        .error-msg {
            color: red;
        }

        .btn-back {
            display: inline-block;
            margin-top: 30px;
            background: #e74c3c;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 16px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .btn-back:hover {
            background: #c0392b;
        }
         .logo-img {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 200px; 
            height: auto;
        }
    </style>
</head>
<body>
<img src="<%= request.getContextPath() %>/images/Waisl.png" alt="WAISL Logo" class="logo-img">

<div class="container">
    <h2>🔍 FRS Registration Search</h2>

    <!-- Modern Option Buttons -->
    <div class="options-wrapper">
        <form method="GET" action="NonDYError.jsp" class="option-form">
            <input type="hidden" name="option" value="1" />
            <button class="modern-option" type="submit">
                <i class="fas fa-search"></i> Search by PNR
            </button>
        </form>

        <form method="GET" action="NonDYError.jsp" class="option-form">
            <input type="hidden" name="option" value="2" />
            <button class="modern-option" type="submit">
                <i class="fas fa-users-viewfinder"></i> View Top DY Pax Records
            </button>
        </form>
    </div>

<%
    String option = request.getParameter("option");

    if ("1".equals(option)) {
%>

    <!-- PNR Search Form -->
    <form method="GET" action="NonDYError.jsp">
        <input type="text" name="pnr" placeholder="Enter PNR" required>
        <input type="hidden" name="option" value="1"/>
        <button type="submit"><i class="fas fa-search"></i> Search</button>
    </form>

<%
        String pnr = request.getParameter("pnr");

        if (pnr != null && !pnr.trim().isEmpty()) {
            String url = "jdbc:sqlserver://10.102.153.28:1433;databaseName=EBOARDING_HYDERABAD;encrypt=true;trustServerCertificate=true";
            String user = "hialuser";
            String password = "hial$$user";

            Connection conn = null;
            CallableStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(url, user, password);

                String sql = "{CALL dbo.SearchFrsRegistration(?)}";
                stmt = conn.prepareCall(sql);
                stmt.setString(1, pnr);

                rs = stmt.executeQuery();

                if (rs.next()) {
%>

    <div class="success-msg">Results for PNR: <strong><%= pnr %></strong></div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>BARCODE</th>
                    <th>EB_FLNO1</th>
                    <th>ORIGIN</th>
                    <th>DESTINATION</th>
                    <th>PNR</th>
                    <th>PAXNAME</th>
                    <th>SEATNO</th>
                    <th>SEQNO</th>
                    <th>BPFLIGHTDATE</th>
                    <th>ISREGISTERED</th>
                    <th>RESULT</th>
                    <th>BPFLIGHTDATE</th>
                    <th>CISFUSER</th>
                    <th>WS_RESP</th>
                    <th>WS_REQUEST</th>
                </tr>
            </thead>
            <tbody>
<%
                    do {
%>
                <tr>
                    <td><%= rs.getString("BARCODE") %></td>
                    <td><%= rs.getString("EB_FLNO1") %></td>
                    <td><%= rs.getString("ORIGIN") %></td>
                    <td><%= rs.getString("DESTINATION") %></td>
                    <td><%= rs.getString("PNR") %></td>
                    <td><%= rs.getString("PAXNAME") %></td>
                    <td><%= rs.getString("SEATNO") %></td>
                    <td><%= rs.getString("SEQNO") %></td>
                    <td><%= rs.getString("BPFLIGHTDATE") %></td>
                    <td><%= rs.getString("ISREGISTERED") %></td>
                    <td><%= rs.getString("RESULT") %></td>
                    <td><%= rs.getString("BPFLIGHTDATE") %></td>
                    <td><%= rs.getString("CISFUSER") %></td>
                    <td><%= rs.getString("WS_RESP") %></td>
                    <td><%= rs.getString("WS_REQUEST") %></td>
                </tr>
<%
                    } while (rs.next());
%>
            </tbody>
        </table>
    </div>

<%          } else { %>
    <div class="error-msg">No data found for PNR: <strong><%= pnr %></strong></div>
<%          }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        }
    } else if ("2".equals(option)) {
        String url = "jdbc:sqlserver://10.102.153.28:1433;databaseName=EBOARDING_HYDERABAD;encrypt=true;trustServerCertificate=true";
        String user = "hialuser";
        String password = "hial$$user";

        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "{CALL dbo.SearchFrsRegistration(NULL)}";
            stmt = conn.prepareCall(sql);
            rs = stmt.executeQuery();

            if (rs.next()) {
%>

    <div class="success-msg">Top 50 DY Pax Records</div>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>BARCODE</th>
                    <th>REC_CREATED_TIME</th>
                    <th>WS_RESP</th>
                </tr>
            </thead>
            <tbody>
<%
                do {
%>
                <tr>
                    <td><%= rs.getString("BARCODE") %></td>
                    <td><%= rs.getString("REC_CREATED_TIME") %></td>
                    <td><%= rs.getString("WS_RESP") %></td>
                </tr>
<%
                } while (rs.next());
%>
            </tbody>
        </table>
    </div>

<%      } else { %>
    <div class="error-msg">No data found for Top DY Pax Records.</div>
<%      }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>

    <%
    String backUrl = "dashboard.jsp";
    if ("2".equals(option)) {
        backUrl = "NonDYError.jsp";
    }
%>
<a href="<%= backUrl %>" class="btn-back"><i class="fas fa-arrow-left"></i>🔙 GO Back</a>

</div>

</body>
</html>

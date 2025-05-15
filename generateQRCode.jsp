<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate 2D QR Code</title>
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --secondary: #34d399;
            --secondary-dark: #059669;
            --background: #f9fafb;
            --text-dark: #1f2937;
            --text-muted: #6b7280;
            --card-bg: #ffffff;
            --shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        }

        * {
            box-sizing: border-box;
        }

        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #eef2ff, #fdf2f8);
            color: var(--text-dark);
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .container {
            background-color: var(--card-bg);
            padding: 30px 20px;
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 480px;
            max-height: 90vh;
            overflow-y: auto;
            text-align: center;
            animation: slideUp 0.8s ease-in-out;
        }

        @keyframes slideUp {
            0% {
                transform: translateY(30px);
                opacity: 0;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }

        h2 {
            margin-bottom: 20px;
            font-size: 26px;
            color: var(--primary-dark);
            animation: bounce 0.8s ease-in-out;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-5px);
            }
        }

        form input[type="text"] {
            width: 85%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
            background-color: #f3f4f6;
        }

        form input[type="text"]:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.3);
            outline: none;
            background-color: #fff;
        }

        form input[type="submit"] {
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            padding: 10px 24px;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        form input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
        }

        .qr-result {
            margin-top: 20px;
            animation: fadeIn 1s ease-in-out;
        }

        .qr-result h3 {
            color: var(--text-muted);
            font-weight: 500;
            margin-bottom: 10px;
        }

        .qr-result img {
            width: 220px;
            height: 220px;
            border-radius: 12px;
            border: 6px solid var(--background);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .qr-result img:hover {
            transform: scale(1.03);
        }

        .barcode-string {
            margin-top: 12px;
            font-size: 15px;
            color: var(--text-dark);
            background-color: #f3f4f6;
            padding: 10px 15px;
            border-radius: 8px;
            word-wrap: break-word;
        }

        .go-back {
            margin-top: 25px;
        }

        .go-back button {
            background: linear-gradient(to right, var(--secondary), var(--secondary-dark));
            color: white;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .go-back button:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.3);
        }

        .footer {
            position: fixed;
            bottom: 10px;
            right: 20px;
            color: #374151;
            font-size: 13px;
            z-index: 999;
            opacity: 0.7;
        }
        .logo-img {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 290px; /* Increased from 150px */
            height: auto;
        }
    </style>
</head>
<body>
    <img src="<%= request.getContextPath() %>/images/Waisl.png" alt="WAISL Logo" class="logo-img">
<div class="container">
    <h2>2D QR Code Generator</h2>

    <form method="get" action="generateQRCode.jsp">
        <%
            String barcodeData = request.getParameter("barcodeData");
            String valueToShow = barcodeData != null ? barcodeData : "";
        %>
        <input type="text" name="barcodeData" value="<%= valueToShow %>" placeholder="Enter text..." required />
        <br />
        <input type="submit" value="Generate QR Code" />
    </form>

    <%
        if (barcodeData != null && !barcodeData.trim().isEmpty()) {
    %>
    <div class="qr-result">
        <h3>Your QR Code</h3>
        <img src="<%= request.getContextPath() %>/generateQRCode?data=<%= barcodeData %>" alt="QR Code" />
        <div class="barcode-string">
            <strong>Input:</strong> <%= barcodeData %>
        </div>
    </div>
    <%
        }
    %>

    <div class="go-back">
        <form action="CreateBoardingPass.jsp" method="get">
            <button type="submit">🔙 GO Back</button>
        </form>
    </div>
</div>

<div class="footer">Made by Chandan Kumar</div>
</body>
</html>

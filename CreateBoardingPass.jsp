<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Boarding Pass</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #74EBD5, #ACB6E5);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

       
        .main-container {
            display: flex;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            transition: transform 0.3s;
        }

        .main-container:hover {
            transform: translateY(-5px);
        }

        .image-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f3f3f3;
            padding: 20px;
        }

        .image-container img {
            max-width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
            transition: transform 0.5s ease;
        }

        .image-container img:hover {
            transform: scale(1.05);
        }

        .content-container {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .btn-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .btn {
            padding: 12px 25px;
            font-size: 16px;
            color: white;
            background: linear-gradient(135deg, #4CAF50, #45A049);
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.4s ease;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            display: inline-block;
            text-align: center;
            font-weight: bold;
        }

        .btn:hover {
            background: linear-gradient(135deg, #45A049, #4CAF50);
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }

        .back-btn {
            background: linear-gradient(135deg, #ff5f6d, #ffc371);
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #ffc371, #ff5f6d);
        }

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                text-align: center;
            }
            .image-container, .content-container {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="main-container">
    <!-- Left Side - Image -->
    <div class="image-container"> 
         <img src="images/HYD_P.jpg" alt="E-Boarding System">  
          

    </div> 

    <!-- Right Side - Options -->
    <div class="content-container">
        <h2>Generate Boarding Pass</h2>
        <div class="btn-container">
            <a href="insertFlight.jsp" class="btn">✈️ Insert Flight</a>
            <a href="InsertPax.jsp" class="btn">👥 Insert Pax Data</a>
            <a href="searchPax.jsp" class="btn">🔍 Generate String of Pax</a>
            <a href="generateQRCode.jsp" class="btn">🔍 Generate QR Code</a>
            <a href="dashboard.jsp" class="btn back-btn">🔙 Back</a>
        </div>
    </div>
</div>

</body>
</html>

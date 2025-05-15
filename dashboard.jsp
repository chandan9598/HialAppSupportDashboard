<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74EBD5, #ACB6E5);
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .main-container {
            display: flex;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 1000px;
            width: 90%;
            transition: transform 0.3s;
        }

        .main-container:hover {
            transform: translateY(-10px);
        }

        /* Image section with overlay */
        .image-container {
            flex: 1;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f3f3f3;
            overflow: hidden;
        }

        .image-container img.bg-image {
            width: 100%;
            height: auto;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .image-container img.bg-image:hover {
            transform: scale(1.05);
        }

        .overlay-logo {
            position: absolute;
            top: 12%; /* Show logo near top */
            left: 78%;
            transform: translate(-50%, 0); /* Center horizontally only */
            max-width: 55%;
            max-height: 55%;
            pointer-events: none;
        }

        .dashboard-container {
            flex: 1;
            padding: 60px;
            text-align: center;
        }

        .dashboard-container h2 {
            font-size: 36px;
            color: #333;
            margin-bottom: 20px;
        }

        .dashboard-container p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        .dashboard-btn {
            background: linear-gradient(135deg, #28a745, #218838);
            color: #fff;
            border: none;
            width: 80%;
            padding: 15px;
            margin: 15px 0;
            font-size: 18px;
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.4s ease;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            display: inline-block;
        }

        .dashboard-btn:hover {
            background: linear-gradient(135deg, #218838, #28a745);
            transform: translateY(-5px);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.3);
        }

        .logout-btn {
            background: linear-gradient(135deg, #dc3545, #c82333);
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #c82333, #dc3545);
        }

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
            }

            .image-container,
            .dashboard-container {
                width: 100%;
            }

            .dashboard-container {
                padding: 40px;
            }
        }
    </style>
</head>
<body>

<!-- Main container with image and dashboard options -->
<div class="main-container">

    <!-- Left Section - Image with overlay -->
    <div class="image-container">
        <img src="images/HYD_P.jpg" alt="E-Boarding System" class="bg-image">
        <img src="images/Waisl.png" alt="Waisl Logo" class="overlay-logo">
    </div>

    <!-- Right Section - Dashboard -->
    <div class="dashboard-container">
        <h2>Welcome to Dashboard</h2>
        <p>Select an option below:</p>

        <a href="flightNotFound.jsp" class="dashboard-btn">Flight Not Found</a>
        <a href="paxData.jsp" class="dashboard-btn">Pax Data</a>
        <a href="PNRNotFound.jsp" class="dashboard-btn">PNR Not Found</a>
        <a href="NonDYError.jsp" class="dashboard-btn">Non DY ERROR</a>
        <a href="CreateBoardingPass.jsp" class="dashboard-btn">Create Boarding Pass</a>

        <br><br>
        <a href="login.jsp" class="dashboard-btn logout-btn">Logout</a>
    </div>

</div>

</body>
</html>

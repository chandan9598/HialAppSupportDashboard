<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        /* Styling the entire page */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #2c3e50, #4ca1af);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Main container for image and login form */
        .main-container {
            display: flex;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 950px;
            width: 90%;
            transition: transform 0.3s;
        }

        .main-container:hover {
            transform: translateY(-10px);  /* Subtle hover effect */
        }

        /* Image container */
        .image-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f3f3f3;
            overflow: hidden;
        }

        .image-container img {
            max-width: 100%;
            max-height: 450px; /* Increased image size */
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .image-container img:hover {
            transform: scale(1.1); /* Smooth zoom effect */
        }

        /* Login form container */
        .login-container {
            flex: 1;
            padding: 60px;
            text-align: center;
        }

        .login-container h2 {
            font-size: 32px;
            color: #333;
            margin-bottom: 30px;
        }

        .input-container {
            position: relative;
            width: 100%;
        }

        .input-box {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }

        .input-box:focus {
            border-color: #007BFF;
            outline: none;
        }

        /* Toggle password visibility */
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #555;
        }

        /* Stylish login button */
        .login-btn {
            background: linear-gradient(135deg, #4CAF50, #45A049);
            color: #fff;
            border: none;
            width: 100%;
            padding: 15px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 18px;
            transition: all 0.4s ease;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .login-btn:hover {
            background: linear-gradient(135deg, #45A049, #4CAF50);
            transform: translateY(-5px);
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.3);
        }

        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
            }
            .image-container, .login-container {
                width: 100%;
            }
            .login-container {
                padding: 40px;
            }
        }
    </style>
</head>
<body>

<!-- Main container for image and login form -->
<div class="main-container">

    <div class="image-container">
        <img src="${pageContext.request.contextPath}/images/Waisl_C.png" alt="E-Boarding System">
    </div>

    <!-- Right Section - Login Form -->
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <div class="input-container">
                <input type="text" name="username" class="input-box" placeholder="Username" required>
            </div>

            <div class="input-container">
                <input type="password" name="password" id="password" class="input-box" placeholder="Password" required>
                <span class="toggle-password" onclick="togglePassword()">👁</span>
            </div>

            <button type="submit" class="login-btn">Login</button>
        </form>
    </div>

</div>

<script>
    function togglePassword() {
        var passwordField = document.getElementById("password");
        if (passwordField.type === "password") {
            passwordField.type = "text";
        } else {
            passwordField.type = "password";
        }
    }
</script>

</body>
</html>

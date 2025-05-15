<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Failed</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #00695c, #004d40); /* Dark Teal to Navy */
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }

        .container {
            background-color: rgba(0, 0, 0, 0.7); /* Darker semi-transparent background */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 100%;
        }

        h2 {
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: bold;
            color: #ff4d4d; /* Red color for error message */
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .go-back-btn {
            background: linear-gradient(135deg, #28a745, #218838); /* Green button for positive action */
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .go-back-btn:hover {
            background: linear-gradient(135deg, #218838, #28a745);
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }

        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
                width: 90%;
            }

            h2 {
                font-size: 28px;
            }

            p {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Login Failed</h2>
    <p>Invalid username or password. Please try again.</p>
    <a href="login.jsp" class="go-back-btn">🔙 GO Back</a>
</div>

</body>
</html>

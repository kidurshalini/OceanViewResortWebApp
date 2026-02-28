<%@ page import="com.oceanviewresortapp.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("Login.jsp?msg=Please login first");
        return;
    }
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .navbar-ocean {
            background: linear-gradient(90deg, #0d6efd, #0aa2c0);
            padding: 12px 20px;
        }

        .navbar-brand {
            font-size: 1.6rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            color: #fff;
        }

        .navbar-brand img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .nav-link {
            font-size: 1rem;
            font-weight: 500;
            margin: 0 6px;
            padding: 6px 14px;
            border-radius: 20px;
            color: #e9f8ff !important;
            transition: 0.3s;
        }

        .nav-link:hover {
            background-color: rgba(255,255,255,0.15);
            color: #fff !important;
            transform: translateY(-2px);
        }

        .nav-link.text-danger {
            background-color: rgba(255, 0, 0, 0.2);
            color: #ffd6d6 !important;
        }

        .navbar-text.welcome-text {
            color: #fff;
            font-weight: 500;
            text-align: center;
        }

        .welcome-badge {
            background: rgba(255,255,255,0.15);
            padding: 6px 12px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .welcome-badge i {
            font-size: 1.4rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-ocean shadow">
    <div class="container-fluid">

        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="Component/images/logo.jpg" alt="Logo">
            Ocean View Resort
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">

                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="bi bi-house-door"></i> Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="AddRoomDetails.jsp"><i class="bi bi-door-open"></i> Room Booking</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="ViewRoomDetails.jsp"><i class="bi bi-calendar-check"></i> View Rooms</a>
                </li>

                <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
                <li class="nav-item">
                    <a class="nav-link" href="ViewUser.jsp"><i class="bi bi-people"></i> Users</a>
                </li>
                <% } %>

                <li class="nav-item">
                    <a class="nav-link text-danger" href="LogoutServlet"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </li>

                <li class="nav-item ms-3">
                    <div class="welcome-badge">
                        <i class="bi bi-person-circle"></i>
                        <div>
                            <small>Welcome</small><br>
                            <strong><%= user.getFullName() %></strong>
                        </div>
                    </div>
                </li>

            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
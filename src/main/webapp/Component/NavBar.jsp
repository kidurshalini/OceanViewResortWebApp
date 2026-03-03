<%@ page import="com.oceanviewresortapp.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("Login.jsp?msg=Please login first");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        .navbar-ocean {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            padding: 12px 25px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-size: 1.6rem;
            font-weight: 700;
            color: #fff;
        }

        .navbar-brand img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
            border: 2px solid #fff;
        }

        .navbar-nav {
            flex-direction: row !important;
        }

        .nav-item {
            margin-left: 12px;
        }

        .nav-link {
            color: #e0f0ff !important;
            padding: 8px 16px;
            border-radius: 25px;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .nav-link:hover, .dropdown-item:hover {
            background-color: rgba(255,255,255,0.2);
            color: #fff !important;
            transform: translateY(-2px);
        }

        .dropdown-menu {
            background-color: rgba(255,255,255,0.95);
            border-radius: 10px;
            min-width: 180px;
        }

        .dropdown-item {
            color: #2a5298 !important;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .dropdown-item:hover {
            color: #1e3c72 !important;
        }

        .nav-link.text-danger {
            background-color: rgba(255, 0, 0, 0.2);
            color: #ffd6d6 !important;
        }

        .welcome-badge {
            background: rgba(255,255,255,0.15);
            padding: 6px 14px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }
        .welcome-badge i {
            font-size: 1.3rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-ocean">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="Component/images/logo.jpg" alt="Logo">
            Ocean View Resort
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a>
                </li>

                <!-- Rooms Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-door-open me-1"></i>Rooms
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="AddRoomDetails.jsp">Add Room</a></li>
                        <li><a class="dropdown-item" href="ViewRoomDetails.jsp">View Rooms</a></li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/ViewGuestReservations"><i class="bi bi-journal-text me-1"></i>Reservations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/ViewGuestsDetails.jsp"><i class="bi bi-people me-1"></i>Guest Details</a>
                </li>
                <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
                <li class="nav-item">
                    <a class="nav-link" href="ViewUser.jsp"><i class="bi bi-people-fill me-1"></i>Users</a>
                </li>
                <% } %>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="LogoutServlet"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
                </li>
            </ul>

            <div class="welcome-badge text-white ms-auto">
                <i class="bi bi-person-circle"></i>
                <div>
                    <small>Welcome</small><br>
                    <strong><%= user.getFullName() %></strong>
                </div>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
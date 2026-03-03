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
            background: #2193b0;
            padding: 12px 25px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-size: 1.6rem;
            font-weight: 500;
            color: #fff;
        }

        .navbar-brand img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
            border: 2px solid #fff;
        }

        .nav-link {
            color: #fff !important;
            padding: 8px 16px;
            border-radius: 25px;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .nav-link:hover {
            background-color: rgba(255,255,255,0.2);
            color: #fff !important;
            transform: translateY(-2px);
        }

        .welcome-badge {
            background: rgba(255,255,255,0.15);
            padding: 6px 14px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            color: #fff;
        }

        .welcome-badge i {
            font-size: 1.3rem;
        }

        .navbar-nav.mx-auto {
            justify-content: center;
        }

        .logout-link {
            margin-left: auto;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark navbar-ocean">
    <div class="container-fluid">

        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="Component/images/icon.jfif" alt="Logo">
            Ocean View Resort
        </a>


        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">


            <ul class="navbar-nav mx-auto flex-row align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </li>

                    <li class="nav-item">
                        <a class="nav-link" href="ViewRoomDetails.jsp">
                            <i class="bi bi-door-open me-1"></i>View Rooms
                        </a>
                    </li>

                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/ViewGuestReservations">
                        <i class="bi bi-journal-text me-1"></i>Reservations
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/ViewGuestsDetails.jsp">
                        <i class="bi bi-people me-1"></i>Guest Details
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="AddRoomDetails.jsp">
                        <i class="bi bi-door-open me-1"></i>Add Room
                    </a>
                </li>



                <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
                <li class="nav-item">
                    <a class="nav-link" href="ViewUser.jsp">
                        <i class="bi bi-people-fill me-1"></i>Users
                    </a>
                </li>
                <% } %>
            </ul>


            <ul class="navbar-nav logout-link flex-row align-items-center">
                <li class="nav-item me-3">
                    <div class="welcome-badge">
                        <i class="bi bi-person-circle"></i>
                        <div>
                            <small>Welcome</small><br>
                            <strong><%= user.getFullName() %></strong>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="LogoutServlet">
                        <i class="bi bi-box-arrow-right me-1"></i>Logout
                    </a>
                </li>
            </ul>

        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
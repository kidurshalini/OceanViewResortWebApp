<%@ page import="com.oceanviewresortapp.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("Login.jsp?msg=Please login first");
        return;
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Ocean View Resort</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">
                        <i class="bi bi-house-door-fill me-2"></i>
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="AddRoomDetails.jsp">
                        <i class="bi bi-door-open-fill me-2"></i>
                        Room Booking
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="ViewRoomDetails.jsp">
                        <i class="bi bi-calendar-check-fill me-2"></i>
                        View Room
                    </a>
                </li>

                <%-- Show View User only for Admins --%>
                <%
                    if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="ViewUser.jsp">
                        <i class="bi bi-people-fill me-2"></i>
                        View User
                    </a>
                </li>
                <%
                    }
                %>

                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">
                        <i class="bi bi-box-arrow-right me-2"></i>
                        Logout
                    </a>
                </li>

                <li class="nav-item">
                    <span class="navbar-text text-white ms-3">
                        Welcome, <%= user.getFullName() %>
                    </span>
                </li>

            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
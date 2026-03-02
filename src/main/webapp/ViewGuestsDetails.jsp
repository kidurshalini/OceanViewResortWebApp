<%@ page import="java.util.List, com.oceanviewresortapp.model.Guest" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Guests</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="Component/NavBar.jsp" />
<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            <h3 class="mb-0">All Guests</h3>
        </div>
      </div>

             <div class="card-body">
                 <div class="table-responsive">
                     <table class="table table-bordered table-striped table-hover align-middle">
                         <thead class="table-dark text-center">

                        <tr>
                            <th>Guest ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Contact Number</th>
                            <th>Guest ID No</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Guest> guests = (List<Guest>) request.getAttribute("guests");
                        if (guests != null && !guests.isEmpty()) {
                            for (Guest g : guests) {
                    %>
                        <tr>
                            <td><%= g.getGuestId() %></td>
                            <td><%= g.getFirstName() %></td>
                            <td><%= g.getLastName() %></td>
                            <td><%= g.getEmail() %></td>
                            <td><%= g.getContactNumber() %></td>
                            <td><%= g.getGuestIdNo() %></td>
                            <td>
                                <a class="btn btn-warning btn-sm" href="GuestServlet?action=view&guestId=<%= g.getGuestId() %>">
                                    <i class="bi bi-pencil-square"></i>   Update
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="7" class="text-center text-muted">No guests found.</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
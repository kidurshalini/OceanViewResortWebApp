<%@ page import="com.oceanviewresortapp.model.Guest" %>
<%
    Guest g = (Guest) request.getAttribute("guest");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Guest Details</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <div class="card shadow">
            <div class="card-header bg-secondary text-white text-center">
                <h4>Update Guest Details</h4>
            </div>
<div class="card-body">
    <form action="GuestServlet" method="post" class="row g-3">
        <input type="hidden" name="guestId" value="<%= g.getGuestId() %>" />

        <div class="col-md-6">
            <label for="firstName" class="form-label">First Name</label>
            <input type="text" class="form-control" id="firstName" name="firstName" value="<%= g.getFirstName() %>" required>
        </div>

        <div class="col-md-6">
            <label for="lastName" class="form-label">Last Name</label>
            <input type="text" class="form-control" id="lastName" name="lastName" value="<%= g.getLastName() %>" required>
        </div>

        <div class="col-md-6">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= g.getEmail() %>" required>
        </div>

        <div class="col-md-6">
            <label for="contactNumber" class="form-label">Contact Number</label>
            <input type="text" class="form-control" id="contactNumber" name="contactNumber" value="<%= g.getContactNumber() %>" required>
        </div>

        <div class="col-md-6">
            <label for="guestIdNo" class="form-label">ID Number</label>
            <input type="text" class="form-control" id="guestIdNo" name="guestIdNo" value="<%= g.getGuestIdNo() %>">
        </div>

        <div class="col-md-6">
            <label for="birthOfDate" class="form-label">Birth Date</label>
            <input type="date" class="form-control" id="birthOfDate" name="birthOfDate" value="<%= g.getBirthOfDate() %>">
        </div>

        <div class="col-12">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="3"><%= g.getAddress() %></textarea>
        </div>

        <div class="col-12 text-center">
            <button type="submit" class="btn btn-success mt-3">Update Guest</button>
        </div>
    </form>
    </div>
    </div>
</div>
<!-- Bootstrap JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
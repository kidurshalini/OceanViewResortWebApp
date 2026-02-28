<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanviewresortapp.model.User" %>
<%@ page import="com.oceanviewresortapp.DAO.UserDAOImpl" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>


<jsp:include page="Component/NavBar.jsp" />


<div class="container mt-5">
    <h2 class="mb-4">Add New User</h2>

    <% String msg = request.getParameter("msg");
        if(msg != null){ %>
    <div class="alert alert-info"><%= msg %></div>
    <% } %>

    <form action="UserServlet" method="post">
        <div class="mb-3">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="contact" class="form-label">Contact</label>
            <input type="text" class="form-control" id="contact" name="contact" required>
        </div>
        <div class="mb-3">
            <label for="contact" class="form-label">Id Number</label>
            <input type="text" class="form-control" id="idnumber" name="idnumber" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" id="role" name="role" required>
                <option value="ADMIN">Admin</option>
                <option value="STAFF">Staff</option>
            </select>
        </div>



        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="isActive" name="isActive" checked>
            <label class="form-check-label" for="isActive">Active</label>
        </div>
        <button type="submit" class="btn btn-primary"  name="action" value="add">Add User</button>
    </form>
</div>
</body>
</html>
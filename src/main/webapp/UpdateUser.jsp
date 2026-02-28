<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanviewresortapp.model.User" %>
<%@ page import="com.oceanviewresortapp.DAO.UserDAOImpl" %>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    UserDAOImpl dao = new UserDAOImpl();
    User user = dao.getById(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update User</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Update User</h2>

    <% String msg = request.getParameter("msg");
        if(msg != null){ %>
    <div class="alert alert-info"><%= msg %></div>
    <% } %>

    <form action="UpdateUserServlet" method="post">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
        <div class="mb-3">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName"
                   value="<%= user.getFullName() %>" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email"
                   value="<%= user.getEmail() %>" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password"
                   value="<%= user.getPassword() %>" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" id="role" name="role" required>
                <option value="ADMIN" <%= "ADMIN".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                <option value="STAFF" <%= "STAFF".equals(user.getRole()) ? "selected" : "" %>>Staff</option>
            </select>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="isActive" name="isActive"
                <%= user.isIsActive() ? "checked" : "" %>>
            <label class="form-check-label" for="isActive">Active</label>
        </div>
        <button type="submit" class="btn btn-success">Update User</button>
    </form>
</div>
</body>
</html>
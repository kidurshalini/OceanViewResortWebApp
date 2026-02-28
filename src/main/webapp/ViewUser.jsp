<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanviewresortapp.model.User" %>
<%@ page import="com.oceanviewresortapp.DAO.UserDAOImpl" %>
<%@ page import="java.util.List" %>

<%
    UserDAOImpl dao = new UserDAOImpl();
    List<User> users = dao.getAll();
    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>


<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-5">
    <h2 class="mb-4">User List</h2>

    <% if(msg != null){ %>
    <div class="alert alert-info"><%= msg %></div>
    <% } %>

    <a href="AddUser.jsp" class="btn btn-primary mb-3">Add New User</a>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>User ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for(User user : users) { %>
        <tr>
            <td><%= user.getUserId() %></td>
            <td><%= user.getFullName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getRole() %></td>
            <td>
                <%= user.isIsActive() ? "Active" : "Inactive" %>
            </td>
            <td>
                <a href="UpdateUser.jsp?userId=<%= user.getUserId() %>" class="btn btn-sm btn-success">Edit</a>
                <a href="DeleteUserServlet?userId=<%= user.getUserId() %>"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Are you sure you want to delete this user?');">
                    Delete
                </a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
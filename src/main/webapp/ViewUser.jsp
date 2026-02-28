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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="css/open-iconic/font/css/open-iconic-bootstrap.min.css" rel="stylesheet">
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
            <th>Contact</th>
            <th>Id number</th>
            <th>Role</th>
            <th>Password</th>
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
            <td><%= user.getContact() %></td>
            <td><%= user.getIdNumber() %></td>
            <td><%= user.getPassword() %></td>
            <td><%= user.getRole() %></td>
            <td class="text-center">
                <% if (user.isIsActive()) { %>
                <span class="badge bg-success">
            <i class="bi bi-check-circle me-1"></i> Active
        </span>
                <% } else { %>
                <span class="badge bg-danger">
            <i class="bi bi-x-circle me-1"></i> Inactive
        </span>
                <% } %>
            </td>
            <td>
                <a href="UpdateUser.jsp?action=update&userId=<%= user.getUserId()%>"
                   class="btn btn-warning btn-sm">
                    <i class="bi bi-pencil-square"></i> Update
                </a>
                <button class="btn btn-sm btn-danger delete-btn" data-userid="<%= user.getUserId() %>">
                    <i class="bi bi-trash"></i>  Delete
                </button>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</body>
</html>

<script>
    $(document).ready(function() {
        $('.delete-btn').click(function() {
            if(confirm('Are you sure you want to delete this user?')) {
                let btn = $(this);
                let userId = btn.data('userid');

                $.ajax({
                    url: 'UserServlet',
                    type: 'POST',
                    data: { action: 'delete', userId: userId },
                    success: function(response) {
                        // Remove the table row
                        btn.closest('tr').fadeOut(500, function() {
                            $(this).remove();
                        });
                        alert('User deleted successfully!');
                    },
                    error: function(xhr, status, error) {
                        alert('Error deleting user: ' + error);
                    }
                });
            }
        });
    });
</script>
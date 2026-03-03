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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f7fa;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: #2193b0 !important;
            color: #fff;
            font-weight: 600;
            font-size: 1.3rem;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .table thead {
            background-color: #0288d1;
            color: #fff;
            text-align: center;
        }

        .table tbody tr:hover {
            background-color: #b2ebf2;
        }

        .badge-active {
            background-color: #00c853 !important;
            color: #fff;
        }

        .badge-inactive {
            background-color: #d50000 !important;
            color: #fff;
        }

        .btn-update {
            background-color: #ffc107 !important;
            color: #000 !important;
            border-radius: 25px;
            margin-right: 5px;
        }

        .btn-delete {
            background-color: #d50000 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .btn-add {
            background-color: #2193b0 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .alert-info {
            border-radius: 12px;
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-white">
            <i class="bi bi-people-fill me-2"></i>User List
        </div>
        <div class="card-body">
            <% if(msg != null){ %>
            <div class="alert alert-info"><%= msg %></div>
            <% } %>

            <a href="AddUser.jsp" class="btn btn-add mb-3">
                <i class="bi bi-plus-circle me-1"></i> Add New User
            </a>

            <div class="table-responsive">
                <table class="table table-bordered table-striped align-middle">
                    <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>ID Number</th>
                        <th>Password</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
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
                            <span class="badge badge-active">
                                <i class="bi bi-check-circle me-1"></i> Active
                            </span>
                            <% } else { %>
                            <span class="badge badge-inactive">
                                <i class="bi bi-x-circle me-1"></i> Inactive
                            </span>
                            <% } %>
                        </td>
                        <td class="text-center">
                            <a href="UpdateUser.jsp?action=update&userId=<%= user.getUserId()%>" class="btn btn-update btn-sm mb-1">
                                <i class="bi bi-pencil-square"></i> Update
                            </a>
                            <button class="btn btn-delete btn-sm delete-btn mb-1" data-userid="<%= user.getUserId() %>">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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

</body>
</html>
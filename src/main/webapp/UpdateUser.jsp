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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .card-header {
            background-color: #17a2b8;
            color: #fff;
            font-weight: 600;
            font-size: 1.3rem;
            text-align: center;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
            font-weight: 500;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        hr {
            border-top: 2px solid #dee2e6;
        }

        .form-control, .form-select {
            border-radius: 8px;
        }

        .form-check-label {
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header">
            <h4><i class="bi bi-person-lines-fill me-2"></i>Update User</h4>
        </div>
        <div class="card-body">

            <% String msg = request.getParameter("msg");
                if(msg != null){ %>
                <div class="alert alert-info"><%= msg %></div>
            <% } %>

            <form action="UserServlet" method="post">
                <input type="hidden" name="action" value="update">
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

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="contact" class="form-label">Contact</label>
                        <input type="text" class="form-control" id="contact" name="contact"
                               value="<%= user.getContact() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label for="idnumber" class="form-label">ID Number</label>
                        <input type="text" class="form-control" id="idnumber" name="idnumber"
                               value="<%= user.getIdNumber() %>" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password"
                               value="<%= user.getPassword() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label for="role" class="form-label">Role</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="ADMIN" <%= "ADMIN".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                            <option value="STAFF" <%= "STAFF".equals(user.getRole()) ? "selected" : "" %>>Staff</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="isActive" name="isActive"
                        <%= user.isIsActive() ? "checked" : "" %>>
                    <label class="form-check-label" for="isActive">Active</label>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">
                        <i class="bi bi-pencil-square me-1"></i>
                        Update User
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
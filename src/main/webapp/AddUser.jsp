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
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow-sm">
                <div class="card-header bg-secondary text-white">
                    <h4 class="mb-0">Add New User</h4>
                </div>

                <div class="card-body">

                    <% String msg = request.getParameter("msg");
                        if(msg != null){ %>
                    <div class="alert alert-info"><%= msg %></div>
                    <% } %>

                    <form action="UserServlet" method="post">


                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>


                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Contact</label>
                                <input type="text" class="form-control" name="contact" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">ID Number</label>
                                <input type="text" class="form-control" name="idnumber" required>
                            </div>
                        </div>


                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" required>
                                    <span class="input-group-text" style="cursor:pointer;" onclick="togglePassword()">
                                        <i class="bi bi-eye" id="eyeIcon"></i>
                                    </span>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="ADMIN">Admin</option>
                                    <option value="STAFF">Staff</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="isActive" checked>
                            <label class="form-check-label">Active</label>
                        </div>


                        <div class="d-grid">
                            <button type="submit" class="btn btn-success" name="action" value="add">
                                Add User
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</body>
</html>
<script>
    function togglePassword() {
        const password = document.getElementById("password");
        const icon = document.getElementById("eyeIcon");

        if (password.type === "password") {
            password.type = "text";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        } else {
            password.type = "password";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }
</script>
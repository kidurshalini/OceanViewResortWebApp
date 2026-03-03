<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanviewresortapp.model.User" %>
<%@ page import="com.oceanviewresortapp.DAO.UserDAOImpl" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: #17a2b8;
            color: #fff;
            font-weight: 600;
            font-size: 1.5rem;
            text-align: center;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
            font-weight: 500;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .input-group-text {
            background-color: #e9ecef;
        }

        .card-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow-sm">
                <div class="card-header">
                    <h4 class="mb-0"><i class="bi bi-person-plus me-2"></i>Add New User</h4>
                </div>

                <div class="card-body">

                    <% String msg = request.getParameter("msg");
                       if(msg != null){ %>
                        <div class="alert alert-info"><%= msg %></div>
                    <% } %>

                    <form action="UserServlet" method="post">

                        <!-- Full Name -->
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" placeholder="Enter full name" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" placeholder="Enter email" required>
                        </div>

                        <!-- Contact + ID Type + ID Number -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Contact Number</label>
                                <div class="input-group">
                                    <select class="form-select" id="countryCode" name="countryCode" required>
                                        <option value="+1">US (+1)</option>
                                        <option value="+44">UK (+44)</option>
                                        <option value="+91">India (+91)</option>
                                        <option value="+94" selected>Sri Lanka (+94)</option>
                                        <option value="+93">Afghanistan (+93)</option>
                                    </select>
                                    <input type="tel" class="form-control" name="contact" pattern="[0-9]{7,15}" maxlength="15" minlength="7" placeholder="Enter number" required>
                                </div>
                                <div class="form-text">7–15 digits including country code</div>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">ID Type</label>
                                <select class="form-select" id="idType" name="idType" required onchange="updateIdValidation()">
                                    <option value="NIC">NIC</option>
                                    <option value="PASSPORT">Passport</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">ID Number</label>
                                <input type="text" class="form-control" id="idNumber" name="idnumber" placeholder="Enter ID Number" required>
                                <div class="form-text" id="idHelpText"></div>
                            </div>
                        </div>

                        <!-- Password + Role -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                                    <span class="input-group-text" style="cursor:pointer;" onclick="togglePassword()">
                                        <i class="bi bi-eye" id="eyeIcon"></i>
                                    </span>
                                </div>
                                <div class="form-text">Min 6 characters, letters & numbers</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="ADMIN">Admin</option>
                                    <option value="STAFF">Staff</option>
                                </select>
                            </div>
                        </div>

                        <!-- Active -->
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="isActive" checked>
                            <label class="form-check-label">Active</label>
                        </div>

                        <!-- Submit -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-success" name="action" value="add">
                                <i class="bi bi-person-plus me-1"></i> Add User
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<script>
    // Toggle password visibility
    function togglePassword() {
        const password = document.getElementById("password");
        const icon = document.getElementById("eyeIcon");
        if(password.type === "password") {
            password.type = "text";
            icon.classList.replace("bi-eye", "bi-eye-slash");
        } else {
            password.type = "password";
            icon.classList.replace("bi-eye-slash", "bi-eye");
        }
    }

    // ID Validation
    function updateIdValidation() {
        const idType = document.getElementById("idType").value;
        const idInput = document.getElementById("idNumber");
        const helpText = document.getElementById("idHelpText");

        idInput.value = "";
        idInput.removeAttribute("pattern");
        idInput.removeAttribute("maxlength");
        idInput.removeAttribute("minlength");

        if(idType === "NIC") {
            idInput.setAttribute("pattern","[0-9]{12}");
            idInput.setAttribute("maxlength","12");
            idInput.setAttribute("minlength","12");
            idInput.placeholder = "Enter 12-digit NIC";
            helpText.innerText = "NIC must contain exactly 12 digits.";
        } else {
            idInput.setAttribute("pattern","[A-Za-z0-9]{9}");
            idInput.setAttribute("maxlength","9");
            idInput.setAttribute("minlength","9");
            idInput.placeholder = "Enter 9-character Passport";
            helpText.innerText = "Passport must contain exactly 9 letters or numbers.";
        }

        idInput.focus();
    }

    document.addEventListener("DOMContentLoaded", function() {
        updateIdValidation();
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
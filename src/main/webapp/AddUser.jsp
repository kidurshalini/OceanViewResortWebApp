<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanviewresortapp.model.User" %>
<%@ page import="com.oceanviewresortapp.DAO.UserDAOImpl" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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

                        <!-- Full Name -->
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>


                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Contact Number</label>
                                <div class="input-group">
                                    <select class="form-select" id="countryCode" name="countryCode" required>
                                        <option value="+1">United States (+1)</option>
                                        <option value="+44">United Kingdom (+44)</option>
                                        <option value="+91">India (+91)</option>
                                        <option value="+94" selected>Sri Lanka (+94)</option>
                                        <option value="+93">Afghanistan (+93)</option>
                                    </select>

                                    <input
                                        type="tel"
                                        class="form-control"
                                        name="contact"
                                        pattern="[0-9]{7,15}"
                                        maxlength="15"
                                        minlength="7"
                                        placeholder="Enter phone number"
                                        required
                                    >
                                </div>
                                <div class="form-text">
                                    Select country code and enter 7 to 15 digits.
                                </div>
                            </div>

                            <!-- ID Type + ID Number -->
                            <div class="col-md-6">
                                <label class="form-label">ID Type</label>
                                <select class="form-select" id="idType" name="idType" required onchange="updateIdValidation()">
                                    <option value="NIC">National ID (NIC)</option>
                                    <option value="PASSPORT">Passport</option>
                                </select>

                                <label class="form-label mt-2">ID Number</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    id="idNumber"
                                    name="idnumber"
                                    required
                                >

                                <div class="form-text" id="idHelpText"></div>
                            </div>
                        </div>

                        <!-- Password + Role -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Password</label>
                                <div class="input-group">
                                    <input
                                        type="password"
                                        class="form-control"
                                        id="password"
                                        name="password"

                                        title="Minimum 6 characters, must contain letters and numbers"
                                        required
                                    >
                                    <span class="input-group-text" style="cursor:pointer;" onclick="togglePassword()">
                                        <i class="bi bi-eye" id="eyeIcon"></i>
                                    </span>
                                </div>
                                <div class="form-text">
                                    Minimum 6 characters with letters and numbers.
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

                        <!-- Active -->
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="isActive" checked>
                            <label class="form-check-label">Active</label>
                        </div>

                        <!-- Submit -->
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

<!-- JavaScript -->
<script>

    // Toggle password visibility
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

    // ID Validation (Fixed)
    function updateIdValidation() {
        const idType = document.getElementById("idType").value;
        const idInput = document.getElementById("idNumber");
        const helpText = document.getElementById("idHelpText");

        // Reset old validation
        idInput.value = "";
        idInput.removeAttribute("pattern");
        idInput.removeAttribute("minlength");
        idInput.removeAttribute("maxlength");

        if (idType === "NIC") {
            idInput.setAttribute("pattern", "[0-9]{12}");
            idInput.setAttribute("minlength", "12");
            idInput.setAttribute("maxlength", "12");
            idInput.placeholder = "Enter 12-digit NIC";
            helpText.innerText = "NIC must contain exactly 12 digits.";
        } else {
            idInput.setAttribute("pattern", "[A-Za-z0-9]{9}");
            idInput.setAttribute("minlength", "9");
            idInput.setAttribute("maxlength", "9");
            idInput.placeholder = "Enter 9-character Passport";
            helpText.innerText = "Passport must contain exactly 9 letters or numbers.";
        }

        idInput.focus();
    }

    // Run on page load
    document.addEventListener("DOMContentLoaded", function() {
        updateIdValidation();
    });

</script>

</body>
</html>
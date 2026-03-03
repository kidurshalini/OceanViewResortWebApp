<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* Gradient background */
        body {
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Login card */
        .login-card {
            border-radius: 1.5rem;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            background: rgba(255,255,255,0.95);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        .login-card .card-body {
            padding: 2.5rem;
        }

        /* Login icon */
        .login-icon {
            font-size: 2rem;
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            color: white;
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto 1.5rem auto;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        /* Form elements */
        .form-control:focus {
            border-color: #2193b0;
            box-shadow: 0 0 0 0.2rem rgba(33,147,176,0.25);
        }

        /* Gradient login button */
        .btn-login {
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            color: white;
            font-weight: 600;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #2193b0, #6dd5ed);
            transform: scale(1.05);
        }

        /* Custom alert */
        .alert-custom {
            margin-bottom: 1rem;
            border-radius: 1rem;
            font-size: 0.95rem;
        }

        /* Text muted */
        .text-muted {
            font-size: 0.875rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card login-card shadow-lg">
                <div class="card-body text-center">
                    <div class="login-icon mb-3">
                        <i class="bi bi-lock-fill"></i>
                    </div>
                    <h3 class="card-title mb-2">Welcome Back!</h3>
                    <p class="text-muted mb-4">Sign in to continue to your account</p>

                    <% if (msg != null) { %>
                        <div class="alert alert-danger alert-custom alert-dismissible fade show rounded-3" role="alert">
                            <%= msg %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>

                    <form action="LoginServlet" method="post">
                        <div class="mb-3 text-start">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control rounded-3" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3 text-start">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control rounded-3" name="password" placeholder="Enter your password" required>
                        </div>
                        <button type="submit" class="btn btn-login w-100 rounded-3">Login</button>
                    </form>

                    <small class="text-muted mt-3 d-block">Contact your administrator if you need access.</small>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
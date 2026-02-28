<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-secondary d-flex align-items-center vh-100">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-lg rounded-4">
                <div class="card-body p-4">
                    <h2 class="card-title text-center mb-4 text-dark">Login</h2>

                    <% if (msg != null) { %>
                    <div class="alert alert-danger text-center rounded-3"><%= msg %></div>
                    <% } %>

                    <form action="LoginServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control rounded-3" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control rounded-3" name="password" placeholder="Enter your password" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100 rounded-3">Login</button>
                    </form>


                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
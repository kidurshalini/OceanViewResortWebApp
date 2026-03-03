<%@ page import="java.util.*" %>
<%
    Map<String, Integer> bookingMap =
        (Map<String, Integer>) request.getAttribute("bookingMap");
%>

<html>
<head>
    <title>Monthly Booking Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .card-header {
            background: #17a2b8;
            color: #fff;
            font-weight: 600;
            font-size: 1.25rem;
            text-align: center;
        }

        .table thead th {
            vertical-align: middle;
        }

        .progress {
            height: 28px;
            border-radius: 12px;
            overflow: hidden;
        }

        .progress-bar {
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .table tbody tr:hover {
            background-color: #e9f7f9;
        }

        @media (max-width: 576px) {
            .progress span {
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4 mb-5">
    <div class="card shadow">
        <div class="card-header">
            <i class="bi bi-file-earmark-bar-graph me-2"></i>Reservation Report By Room Type
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Room Type</th>
                            <th>Total Bookings</th>
                            <th>Progress</th>
                        </tr>
                    </thead>
                    <tbody>

                    <% if (bookingMap != null && !bookingMap.isEmpty()) {
                           for (Map.Entry<String, Integer> entry : bookingMap.entrySet()) {
                               int count = entry.getValue();
                               int progress = Math.min(100, (count * 100) / 30); // assuming 30 max
                    %>
                    <tr>
                        <td><%= entry.getKey() %></td>
                        <td class="text-center"><%= count %></td>
                        <td>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-animated
                                    <%= count == 0 ? "bg-secondary"
                                         : progress < 50 ? "bg-warning"
                                         : "bg-success" %>"
                                     role="progressbar"
                                     style="width: <%= progress %>%;">
                                    <span><%= progress %>%</span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="3" class="text-center">No booking data available</td>
                    </tr>
                    <% } %>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
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
</head>
<body class="bg-light">

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0"><i class="bi bi-file-earmark-bar-graph me-2"></i>Reservation Report By Room Type</h5>
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
                   int progress = Math.min(100, (count * 100) / 30);
        %>
        <tr>
            <td><%= entry.getKey() %></td>
            <td><%= count %></td>
            <td>
          <div class="progress" style="height: 25px; background-color: #e9ecef;">
              <div class="progress-bar progress-bar-striped progress-bar-animated
                   <%= count == 0 ? "bg-secondary"
                        : progress < 50 ? "bg-warning"
                        : "bg-success" %>"
                   role="progressbar"
                   style="width: <%= progress %>%; color: #212529; font-weight: bold;">
                  <span><%= progress %>%</span>
              </div>
          </div>
            </td>
        </tr>
        <% } } else { %>
        <tr>
            <td colspan="3">No booking data available</td>
        </tr>
        <% } %>

        </tbody>
    </table>
</div>
        </div>
    </div>
</div>


</body>
</html>
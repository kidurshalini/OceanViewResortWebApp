<%@ page import="java.util.List, com.oceanviewresortapp.model.GuestReservationView, java.text.SimpleDateFormat" %>
<%
    String msg = request.getParameter("msg");
    if (msg != null) {
%>
<script>
    alert("<%= msg %>");
</script>
<%
    }
%>

<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>


<html>
<head>
    <title>Guest Reservations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body class="bg-light">

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0"><i class="bi bi-journal-text me-2"></i>Guest & Reservation Details</h5>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark text-center">
                        <tr>

                            <th>Guest Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Room Number</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Nights</th>
                            <th>Total Price</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
<%
    List<GuestReservationView> reservations =
        (List<GuestReservationView>) request.getAttribute("reservations");

    if (reservations != null && !reservations.isEmpty()) {
        for (GuestReservationView r : reservations) {
%>
<tr>

    <td><strong><%= r.getFirstName() %> <%= r.getLastName() %></strong></td>
    <td><%= r.getEmail() %></td>
    <td><%= r.getContactNumber() %></td>
    <td class="text-center"><%= r.getRoomNumber() %></td>
   <td class="text-center"><%= (r.getCheckIn() != null) ? sdf.format(r.getCheckIn()) : "" %></td>
   <td class="text-center"><%= (r.getCheckOut() != null) ? sdf.format(r.getCheckOut()) : "" %></td>
    <td class="text-center"><%= r.getTotalNights() %></td>
    <td class="text-center"><strong><%= r.getTotalPrice() %></strong></td>
    <td class="text-center">
        <% if ("Pending".equalsIgnoreCase(r.getServiceStatus())) { %>
            <span class="badge bg-warning text-dark"><i class="bi bi-hourglass-split me-1"></i> Pending</span>
        <% } else if ("Confirmed".equalsIgnoreCase(r.getServiceStatus())) { %>
            <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i> Confirmed</span>
        <% } else { %>
            <span class="badge bg-danger"><i class="bi bi-x-circle me-1"></i> Cancelled</span>
        <% } %>
    </td>
   <td class="text-center">
       <!-- Update Button -->
       <a href="UpdateReservationServlet?reservationId=<%= r.getReservationId() %>"
          class="btn btn-warning btn-sm me-1 mb-1">
           <i class="bi bi-pencil-square"></i> Update
       </a>

       <!-- Print Bill Button -->
       <a href="PrintBillServlet?reservationId=<%= r.getReservationId() %>"
          class="btn btn-primary btn-sm me-1 mb-1">
           <i class="bi bi-printer"></i> Print Bill
       </a>

     <!-- Send Email Button -->
     <a href="SendEmailServlet?reservationId=<%= r.getReservationId() %>"
        class="btn btn-success btn-sm me-1 mb-1"
        onclick="return confirm('Are you sure you want to send the email?');">
         <i class="bi bi-envelope-fill"></i> Send Email
     </a>
   </td>
</tr>
<%
        }
    } else {
%>
<tr>
    <td colspan="11" class="text-center text-muted">No reservations found</td>
</tr>
<%
    }
%>
                    </tbody>
                </table>
            </div>


        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
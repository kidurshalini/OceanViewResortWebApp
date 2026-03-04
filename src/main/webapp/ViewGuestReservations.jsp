<%@ page import="java.util.List, java.util.ArrayList, com.oceanviewresortapp.model.GuestReservationView, java.text.SimpleDateFormat" %>
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

    List<GuestReservationView> reservations =
        (List<GuestReservationView>) request.getAttribute("reservations");

    List<GuestReservationView> pendingReservations = new ArrayList<>();
    List<GuestReservationView> confirmedReservations = new ArrayList<>();
    List<GuestReservationView> cancelledReservations = new ArrayList<>();

    if (reservations != null) {
        for (GuestReservationView r : reservations) {
            if ("Pending".equalsIgnoreCase(r.getServiceStatus())) {
                pendingReservations.add(r);
            } else if ("Confirmed".equalsIgnoreCase(r.getServiceStatus())) {
                confirmedReservations.add(r);
            } else if ("Cancelled".equalsIgnoreCase(r.getServiceStatus())) {
                cancelledReservations.add(r);
            }
        }
    }
%>

<html>
<head>
    <title>Guest Reservations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f7fa;
        }

        .card-header {
            color: #fff;
        }

        .table thead {
            color: #fff;
        }

        .badge-pending {
            background-color: #ffc107 !important;
            color: #000;
        }
        .badge-confirmed {
            background-color: #00c853 !important;
            color: #fff;
        }
        .badge-cancelled {
            background-color: #d50000 !important;
            color: #fff;
        }

        .btn-update {
            background-color: #ffc107 !important;
            color: #000 !important;
            border-radius: 25px;
        }

        .btn-print {
            background-color: #2193b0 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .btn-email {
            background-color: #ff9800 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .btn-delete {
            background-color: #d50000 !important;
            color: #fff !important;
            border-radius: 25px;

        }

        .btn {
            margin-right: 5px;
        }

        .action-buttons {
            white-space: nowrap;
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<!-- CONFIRMED RESERVATIONS -->
<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="bi bi-check-circle me-2"></i>Confirmed Reservations</h5>
        </div>
        <div class="card-body">
            <!-- Search box -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <input type="text" id="confirmedSearch" class="form-control" placeholder="Search Confirmed Reservations..." onkeyup="filterTable('confirmedTable', 'confirmedSearch')">
                </div>
            </div>
            <div class="table-responsive">
                <table id="confirmedTable" class="table table-bordered table-striped align-middle text-center">
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Contact</th>
                            <th>Room Number</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Nights</th>
                            <th>Total Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!confirmedReservations.isEmpty()) {
                                for (GuestReservationView r : confirmedReservations) {
                        %>
                        <tr>
                            <td><%= r.getFirstName() %> <%= r.getLastName() %></td>
                            <td><%= r.getContactNumber() %></td>
                            <td><%= r.getRoomNumber() %></td>
                            <td><%= (r.getCheckIn() != null) ? sdf.format(r.getCheckIn()) : "" %></td>
                            <td><%= (r.getCheckOut() != null) ? sdf.format(r.getCheckOut()) : "" %></td>
                            <td><%= r.getTotalNights() %></td>
                            <td><%= r.getTotalPrice() %></td>
                            <td class="action-buttons">
                                <a href="UpdateReservationServlet?reservationId=<%= r.getReservationId() %>" class="btn btn-update btn-sm mb-1">
                                    <i class="bi bi-pencil-square"></i> Update
                                </a>
                                <a href="PrintBillServlet?reservationId=<%= r.getReservationId() %>" class="btn btn-print btn-sm mb-1">
                                    <i class="bi bi-printer"></i> Print Bill
                                </a>
                                <a href="SendEmailServlet?reservationId=<%= r.getReservationId() %>" class="btn btn-email btn-sm mb-1"
                                   onclick="return confirm('Are you sure you want to send the email?');">
                                    <i class="bi bi-envelope-fill"></i> Send Email
                                </a>
                                <button class="btn btn-delete btn-sm mb-1" onclick="deleteReservation(<%= r.getReservationId() %>, this)">
                                    <i class="bi bi-trash"></i> Delete
                                </button>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center text-muted">No confirmed reservations</td>
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

<!-- PENDING RESERVATIONS -->
<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0"><i class="bi bi-hourglass-split me-2"></i>Pending Reservations</h5>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <input type="text" id="pendingSearch" class="form-control" placeholder="Search Pending Reservations..." onkeyup="filterTable('pendingTable', 'pendingSearch')">
                </div>
            </div>
            <div class="table-responsive">
                <table id="pendingTable" class="table table-bordered table-striped align-middle text-center">
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Contact</th>
                            <th>Room Number</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Nights</th>
                            <th>Total Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!pendingReservations.isEmpty()) {
                                for (GuestReservationView r : pendingReservations) {
                        %>
                        <tr>
                            <td><%= r.getFirstName() %> <%= r.getLastName() %></td>
                            <td><%= r.getContactNumber() %></td>
                            <td><%= r.getRoomNumber() %></td>
                            <td><%= (r.getCheckIn() != null) ? sdf.format(r.getCheckIn()) : "" %></td>
                            <td><%= (r.getCheckOut() != null) ? sdf.format(r.getCheckOut()) : "" %></td>
                            <td><%= r.getTotalNights() %></td>
                            <td><%= r.getTotalPrice() %></td>
                            <td class="action-buttons">
                                <a href="UpdateReservationServlet?reservationId=<%= r.getReservationId() %>" class="btn btn-update btn-sm mb-1">
                                    <i class="bi bi-pencil-square"></i> Update
                                </a>
                                <button class="btn btn-delete btn-sm mb-1" onclick="deleteReservation(<%= r.getReservationId() %>, this)">
                                    <i class="bi bi-trash"></i> Delete
                                </button>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center text-muted">No pending reservations</td>
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

<!-- CANCELLED RESERVATIONS -->
<div class="container mt-4 mb-4">
    <div class="card shadow">
        <div class="card-header bg-danger text-white">
            <h5 class="mb-0"><i class="bi bi-x-circle me-2"></i>Cancelled Reservations</h5>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <input type="text" id="cancelledSearch" class="form-control" placeholder="Search Cancelled Reservations..." onkeyup="filterTable('cancelledTable', 'cancelledSearch')">
                </div>
            </div>
            <div class="table-responsive">
                <table id="cancelledTable" class="table table-bordered table-striped align-middle text-center">
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Contact</th>
                            <th>Room Number</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Nights</th>
                            <th>Total Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!cancelledReservations.isEmpty()) {
                                for (GuestReservationView r : cancelledReservations) {
                        %>
                        <tr>
                            <td><%= r.getFirstName() %> <%= r.getLastName() %></td>
                            <td><%= r.getContactNumber() %></td>
                            <td><%= r.getRoomNumber() %></td>
                            <td><%= (r.getCheckIn() != null) ? sdf.format(r.getCheckIn()) : "" %></td>
                            <td><%= (r.getCheckOut() != null) ? sdf.format(r.getCheckOut()) : "" %></td>
                            <td><%= r.getTotalNights() %></td>
                            <td><%= r.getTotalPrice() %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted">No cancelled reservations</td>
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

<script>
    // Delete reservation
    function deleteReservation(id, btn){
        if(confirm('Are you sure you want to delete this reservation?')){
            fetch('<%= request.getContextPath() %>/DeleteReservationServlet?reservationId=' + id, {
                method: 'POST'
            })
            .then(res => {
                if(res.ok){
                    btn.closest('tr').remove();
                    alert('Reservation deleted successfully!');
                } else {
                    alert('Failed to delete reservation.');
                }
            })
            .catch(err => alert('Error: ' + err));
        }
    }

    // Generic filter function
    function filterTable(tableId, inputId){
        const input = document.getElementById(inputId);
        const filter = input.value.toLowerCase();
        const table = document.getElementById(tableId);
        const tr = table.getElementsByTagName('tr');

        for(let i = 1; i < tr.length; i++){
            const tdArray = tr[i].getElementsByTagName('td');
            let rowText = "";
            for(let j = 0; j < tdArray.length - 1; j++){ // skip action column
                rowText += tdArray[j].textContent.toLowerCase() + " ";
            }
            tr[i].style.display = rowText.indexOf(filter) > -1 ? "" : "none";
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
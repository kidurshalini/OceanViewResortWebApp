<%@ page import="com.oceanviewresortapp.model.Reservation, com.oceanviewresortapp.model.RoomDetails, java.util.List" %>
<%
    Reservation res = (Reservation) request.getAttribute("reservation");
    List<RoomDetails> rooms = (List<RoomDetails>) request.getAttribute("roomsList");

    if (res == null) {
%>
<div class="alert alert-danger mt-4" role="alert">
    Reservation not found!
</div>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            background-color: #17a2b8; /* soft blue */
            color: #fff;
            font-weight: 600;
            font-size: 1.4rem;
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

        .room-info {
            font-size: 1rem;
            font-weight: 500;
            color: #495057;
            margin-bottom: 25px;
            text-align: center;
        }

        .card-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="room-info">
        <h2>Update Reservation</h2>
        <p>Reservation ID: <strong><%= res.getReservationId() %></strong></p>
    </div>

    <div class="card shadow-sm">
        <div class="card-header">Reservation Details</div>
        <div class="card-body">
            <form action="UpdateReservationServlet" method="post">
                <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>" />

                <div class="mb-3">
                    <label for="checkIn" class="form-label">Check-In Date</label>
                    <input type="date" class="form-control" id="checkIn" name="checkIn"
                           value="<%= res.getCheckIn().toLocalDate() %>" required/>
                </div>

                <div class="mb-3">
                    <label for="checkOut" class="form-label">Check-Out Date</label>
                    <input type="date" class="form-control" id="checkOut" name="checkOut"
                           value="<%= res.getCheckOut().toLocalDate() %>" required/>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="totalNights" class="form-label">Total Nights</label>
                        <input type="number" class="form-control" id="totalNights" name="totalNights"
                               value="<%= res.getTotalNights() %>" required/>
                    </div>
                    <div class="col-md-6">
                        <label for="totalPrice" class="form-label">Total Price</label>
                        <input type="text" class="form-control" id="totalPrice" name="totalPrice"
                               value="<%= res.getTotalPrice() %>" required/>
                    </div>
                </div>

                <!-- Service Status & Room Selection in one row -->
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label for="serviceStatus" class="form-label">Service Status</label>
                        <select class="form-select" id="serviceStatus" name="serviceStatus">
                            <option value="Pending" <%= res.getServiceStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="Confirmed" <%= res.getServiceStatus().equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                            <option value="Cancelled" <%= res.getServiceStatus().equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="roomId" class="form-label">Select Room</label>
                        <select class="form-select" id="roomId" name="roomId" required>
                            <% for (RoomDetails room : rooms) { %>
                                <option value="<%= room.getRoomId() %>" <%= room.getRoomId() == res.getRoomId() ? "selected" : "" %>>
                                    <%= room.getRoomName() %> - <%= room.getRoomNumber() %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="card-footer text-end">
                    <button type="submit" class="btn btn-success">Update Reservation</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(function () {
    function calculateTotal() {
        const checkInEl  = document.getElementById("checkIn");
        const checkOutEl = document.getElementById("checkOut");
        const nightsEl   = document.getElementById("totalNights");
        const priceEl    = document.getElementById("totalPrice");

        if (!checkInEl.value || !checkOutEl.value) {
            nightsEl.value = 0;
            priceEl.value = "0.00";
            return;
        }

        const checkIn  = new Date(checkInEl.value);
        const checkOut = new Date(checkOutEl.value);

        if (checkOut <= checkIn) {
            nightsEl.value = 0;
            priceEl.value = "0.00";
            return;
        }

        const diffTime = checkOut - checkIn;
        const nights = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

        const currentNights = parseInt(nightsEl.value) || 1;
        const currentTotal  = parseFloat(priceEl.value) || 0;
        const pricePerNight = currentTotal / currentNights;

        nightsEl.value = nights;
        priceEl.value = (nights * pricePerNight).toFixed(2);
    }

    document.getElementById("checkIn").addEventListener("change", calculateTotal);
    document.getElementById("checkOut").addEventListener("change", calculateTotal);
})();
</script>
</body>
</html>
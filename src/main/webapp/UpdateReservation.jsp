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

<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-secondary text-white">
            <h4 class="mb-0">Update Reservation</h4>
        </div>
        <div class="card-body">
            <form action="UpdateReservationServlet" method="post">
                <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>" />

                <div class="mb-3">
                    <label for="checkIn" class="form-label">Check-In Date</label>
                    <input type="date" class="form-control" id="checkIn" name="checkIn" value="<%= res.getCheckIn().toLocalDate() %>" required/>
                </div>

                <div class="mb-3">
                    <label for="checkOut" class="form-label">Check-Out Date</label>
                    <input type="date" class="form-control" id="checkOut" name="checkOut" value="<%= res.getCheckOut().toLocalDate() %>" required/>
                </div>

                <div class="mb-3">
                    <label for="totalNights" class="form-label">Total Nights</label>
                    <input type="number" class="form-control" id="totalNights" name="totalNights" value="<%= res.getTotalNights() %>" required/>
                </div>

                <div class="mb-3">
                    <label for="totalPrice" class="form-label">Total Price</label>
                    <input type="text" class="form-control" id="totalPrice" name="totalPrice" value="<%= res.getTotalPrice() %>" required/>
                </div>

                <div class="mb-3">
                    <label for="serviceStatus" class="form-label">Service Status</label>
                    <select class="form-select" id="serviceStatus" name="serviceStatus">
                        <option value="Pending" <%= res.getServiceStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                        <option value="Confirmed" <%= res.getServiceStatus().equals("Confirmed") ? "selected" : "" %>>Confirmed</option>
                        <option value="Cancelled" <%= res.getServiceStatus().equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label for="roomId" class="form-label">Select Room</label>
                    <select class="form-select" id="roomId" name="roomId" required>
                        <% for (RoomDetails room : rooms) { %>
                            <option value="<%= room.getRoomId() %>" <%= room.getRoomId() == res.getRoomId() ? "selected" : "" %>>
                                <%= room.getRoomName() %> - <%= room.getRoomNumber() %>
                            </option>
                        <% } %>
                    </select>
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

        // derive price per night from existing values
        const currentNights = parseInt(nightsEl.value) || 1;
        const currentTotal  = parseFloat(priceEl.value) || 0;
        const pricePerNight = currentTotal / currentNights;

        nightsEl.value = nights;
        priceEl.value = (nights * pricePerNight).toFixed(2);
    }

    // Attach listeners WITHOUT changing HTML
    document.getElementById("checkIn").addEventListener("change", calculateTotal);
    document.getElementById("checkOut").addEventListener("change", calculateTotal);

})();
</script>
</body>

</html>
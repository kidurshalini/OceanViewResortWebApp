<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="com.oceanviewresortapp.model.Guest" %>

<!DOCTYPE html>
<html>
<head>
    <title>Existing Guest Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">

<%
    Guest guest = (Guest) request.getAttribute("guest");
    String roomId = request.getParameter("roomId");
    String pricePerNight = request.getParameter("pricePerNight");
    String currency = request.getParameter("currency");
%>

<% if (guest == null) { %>
    <div class="alert alert-warning text-center">
        Guest not found! Please check Email or Contact Number.
    </div>
<% } else { %>

    <div class="card shadow">
        <div class="card-header bg-secondary text-white text-center">
            <h4>Existing Guest Details</h4>
        </div>
        <div class="card-body">

            <!-- Guest Info -->
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Name:</div>
                <div class="col-md-8"><%= guest.getFirstName() %> <%= guest.getLastName() %></div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Email:</div>
                <div class="col-md-8"><%= guest.getEmail() %></div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Contact:</div>
                <div class="col-md-8"><%= guest.getContactNumber() %></div>
            </div>

            <!-- Reservation Form -->
            <hr>
            <h5>Reservation Details</h5>

            <form action="BookRoomServlet" method="post">

                <input type="hidden" name="guestId" value="<%= guest.getGuestId() %>" />
                <input type="hidden" name="roomId" value="<%= roomId %>" />
                <input type="hidden" id="pricePerNight" value="<%= pricePerNight %>" />

                <div class="row mb-2">
                    <div class="col-md-6">
                        <label>Check-In</label>
                        <input type="date" name="checkIn" class="form-control" required onchange="calculateTotal()" />
                    </div>
                    <div class="col-md-6">
                        <label>Check-Out</label>
                        <input type="date" name="checkOut" class="form-control" required onchange="calculateTotal()" />
                    </div>
                </div>

                <div class="row mb-2">
                    <div class="col-md-6">
                        <label>Total Nights</label>
                        <input type="number" name="totalNights" id="totalNights" class="form-control" readonly />
                    </div>
                    <div class="col-md-6">
                        <label>Total Price (<%= currency %>)</label>
                        <input type="text" name="totalPrice" id="totalPrice" class="form-control" readonly />
                    </div>
                </div>

        <div class="row mb-2">
                                    <div class="col-md-6">
                                        <label>Service Status:</label>
                                        <select name="serviceStatus" class="form-control" required>
                                            <option value="Pending" selected>Pending</option>
                                            <option value="Confirmed">Confirmed</option>
                                            <option value="Cancelled">Cancelled</option>
                                        </select>
                                    </div>
                <div class="text-center mt-3">
                    <button type="submit" class="btn btn-success">
                        Confirm Booking
                    </button>
                </div>

            </form>
        </div>
    </div>

<% } %>

</div>

<script>
function calculateTotal() {
    const price = parseFloat(document.getElementById("pricePerNight").value);
    const checkIn = document.getElementsByName("checkIn")[0].value;
    const checkOut = document.getElementsByName("checkOut")[0].value;

    if (checkIn && checkOut) {
        const d1 = new Date(checkIn);
        const d2 = new Date(checkOut);

        if (d2 > d1) {
            const nights = Math.ceil((d2 - d1) / (1000 * 60 * 60 * 24));
            document.getElementById("totalNights").value = nights;
            document.getElementById("totalPrice").value = (nights * price).toFixed(2);
        }
    }
}
</script>

</body>
</html>
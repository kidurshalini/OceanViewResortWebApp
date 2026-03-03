<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="com.oceanviewresortapp.model.Guest" %>

<!DOCTYPE html>
<html>
<head>
    <title>Existing Guest Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .card-header {
            background-color: #17a2b8;
            color: #fff;
            font-weight: 600;
            font-size: 1.3rem;
            text-align: center;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
            font-weight: 500;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        hr {
            border-top: 2px solid #dee2e6;
        }

        .fw-bold {
            font-weight: 600;
        }

        .row > .col-md-6 > input,
        .row > .col-md-6 > select {
            border-radius: 8px;
        }

        @media (max-width: 576px) {
            .card-header h4 {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>

<div class="container mt-4">

<%
    Guest guest = (Guest) request.getAttribute("guest");
    String roomId = request.getParameter("roomId");
    String pricePerNight = request.getParameter("pricePerNight");
    String currency = request.getParameter("currency");
%>

<% if (guest == null) { %>
    <div class="alert alert-warning text-center">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        Guest not found! Please check Email or Contact Number.
    </div>
<% } else { %>

    <div class="card shadow">
        <div class="card-header">
            <h4><i class="bi bi-person-lines-fill me-2"></i>Existing Guest Details</h4>
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

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Check-In</label>
                        <input
                            type="date"
                            name="checkIn"
                            class="form-control"
                            required
                            onchange="calculateTotal()"
                            id="checkIn"
                            min=""
                        />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Check-Out</label>
                        <input
                            type="date"
                            name="checkOut"
                            class="form-control"
                            required
                            onchange="calculateTotal()"
                            id="checkOut"
                            min=""
                        />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Total Nights</label>
                        <input type="number" name="totalNights" id="totalNights" class="form-control" readonly />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Total Price (<%= currency %>)</label>
                        <input type="text" name="totalPrice" id="totalPrice" class="form-control" readonly />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Service Status</label>
                        <select name="serviceStatus" class="form-select" required>
                            <option value="Pending" selected>Pending</option>
                            <option value="Confirmed">Confirmed</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>
                    <div class="col-md-6 d-flex align-items-end justify-content-center mt-3 mt-md-0">
                        <button type="submit" class="btn btn-success px-4">
                            <i class="bi bi-check2-circle me-1"></i>
                            Confirm Booking
                        </button>
                    </div>
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
        } else {
            document.getElementById("totalNights").value = 0;
            document.getElementById("totalPrice").value = "0.00";
        }
    }
}

const today = new Date().toISOString().split('T')[0];
document.getElementById('checkIn').setAttribute('min', today);
document.getElementById('checkOut').setAttribute('min', today);

document.getElementById('checkIn').addEventListener('change', function() {
    const checkOut = document.getElementById('checkOut');
    checkOut.min = this.value;
    if (checkOut.value < this.value) {
        checkOut.value = this.value;
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
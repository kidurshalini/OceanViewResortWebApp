<%@ page import="com.oceanviewresortapp.model.RoomDetails,
                 com.oceanviewresortapp.model.RoomPriceDetails,
                 com.oceanviewresortapp.DAO.RoomDetailsDAOImpl" %>

<%
    int roomId = 0;
    try {
        roomId = Integer.parseInt(request.getParameter("roomId"));
    } catch (Exception e) {
        roomId = 0;
    }

    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
    RoomDetails room = dao.getRoomDetailsById(roomId);
    RoomPriceDetails price = dao.getPriceByRoomId(roomId);

    if (price == null) {
        price = new RoomPriceDetails();
        price.setCurrency("LKR");
        price.setPricePerNight(new java.math.BigDecimal("0.00"));
    }

    double pricePerNightDouble = price.getPricePerNight().doubleValue();

    // Success/Error message from servlet
    String msg = request.getParameter("msg");
    String type = request.getParameter("type");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Room Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4">

<% if (msg != null && !msg.isEmpty()) { %>
    <div class="alert alert-<%= "success".equals(type) ? "success" : "danger" %> alert-dismissible fade show text-center" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>

<% if (room == null) { %>
    <div class="alert alert-warning text-center mt-4">
        Room not found!
    </div>
<% } else { %>
    <div class="card shadow mb-4">
        <div class="card-header bg-secondary text-white text-center">
            <h4 class="mb-0">Room Details</h4>
        </div>
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Room Type:</div>
                <div class="col-md-8"><%= room.getRoomType() %></div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Room Number:</div>
                <div class="col-md-8"><%= room.getRoomNumber() %></div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Room Name:</div>
                <div class="col-md-8"><%= room.getRoomName() %></div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Description:</div>
                <div class="col-md-8"><%= room.getRoomDescription() %></div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Availability:</div>
                <div class="col-md-8">
                    <span class="badge <%= "Available".equals(room.getRoomAvailabilityStatus()) ? "bg-success" : "bg-danger" %>">
                        <%= room.getRoomAvailabilityStatus() %>
                    </span>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Capacity:</div>
                <div class="col-md-8"><%= room.getRoomCapacity() %> Persons</div>
            </div>
        </div>

        <div class="card-header bg-secondary text-white text-center">
            <h4 class="mb-0">Room Price</h4>
        </div>
        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Currency:</div>
                <div class="col-md-8"><%= price.getCurrency() %></div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Price Per Night:</div>
                <div class="col-md-8"><%= price.getPricePerNight().setScale(2, java.math.RoundingMode.HALF_UP) %></div>
            </div>
        </div>
    </div>

    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bookingModal">
            Book Now
        </button>
    </div>

    <!-- Booking Modal -->
    <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-secondary text-white">
                    <h5 class="modal-title" id="bookingModalLabel">Book Room</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="guestReservationForm" action="BookRoomServlet" method="post">
                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />

                        <h5>Guest Details</h5>
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <input type="text" name="firstName" class="form-control" placeholder="First Name" required />
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="lastName" class="form-control" placeholder="Last Name" required />
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <input type="email" name="email" class="form-control" placeholder="Email" required />
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="contactNumber" class="form-control" placeholder="Contact Number" required />
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <input type="text" name="guestIdNo" class="form-control" placeholder="ID Number" required />
                            </div>
                            <div class="col-md-6">
                                <input type="date" name="birthOfDate" class="form-control" placeholder="Date of Birth" required />
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-12">
                                <input type="text" name="address" class="form-control" placeholder="Address" required />
                            </div>
                        </div>

                        <h5>Reservation Details</h5>
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <label>Check-In:</label>
                                <input type="date" name="checkIn" class="form-control" required onchange="calculateTotal()" />
                            </div>
                            <div class="col-md-6">
                                <label>Check-Out:</label>
                                <input type="date" name="checkOut" class="form-control" required onchange="calculateTotal()" />
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <label>Total Nights:</label>
                                <input type="number" name="totalNights" id="totalNights" class="form-control" readonly />
                            </div>
                            <div class="col-md-6">
                                <label>Total Price (<%= price.getCurrency() %>):</label>
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
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">Confirm Booking</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<% } %>

<script>
    const pricePerNight = <%= pricePerNightDouble %>;

    function calculateTotal() {
        const checkInEl = document.getElementsByName('checkIn')[0];
        const checkOutEl = document.getElementsByName('checkOut')[0];

        if (checkInEl.value && checkOutEl.value) {
            const checkIn = new Date(checkInEl.value);
            const checkOut = new Date(checkOutEl.value);

            if (checkOut > checkIn) {
                const diffTime = checkOut - checkIn;
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                document.getElementById('totalNights').value = diffDays;
                document.getElementById('totalPrice').value = (diffDays * pricePerNight).toFixed(2);
                return;
            }
        }

        document.getElementById('totalNights').value = 0;
        document.getElementById('totalPrice').value = "0.00";
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
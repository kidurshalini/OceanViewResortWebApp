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
    <!-- Room Details Card -->
    <div class="card shadow mb-4">
        <div class="card-header bg-secondary text-white text-center">
            <h4 class="mb-0">Room Details</h4>
        </div>
        <div class="card-body">
            <div class="row mb-2"><div class="col-md-4 fw-bold">Room Type:</div><div class="col-md-8"><%= room.getRoomType() %></div></div>
            <div class="row mb-2"><div class="col-md-4 fw-bold">Room Number:</div><div class="col-md-8"><%= room.getRoomNumber() %></div></div>
            <div class="row mb-2"><div class="col-md-4 fw-bold">Room Name:</div><div class="col-md-8"><%= room.getRoomName() %></div></div>
            <div class="row mb-2"><div class="col-md-4 fw-bold">Description:</div><div class="col-md-8"><%= room.getRoomDescription() %></div></div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Availability:</div>
                <div class="col-md-8">
                    <span class="badge <%= "Available".equals(room.getRoomAvailabilityStatus()) ? "bg-success" : "bg-danger" %>">
                        <%= room.getRoomAvailabilityStatus() %>
                    </span>
                </div>
            </div>
            <div class="row mb-2"><div class="col-md-4 fw-bold">Capacity:</div><div class="col-md-8"><%= room.getRoomCapacity() %> Persons</div></div>
        </div>

        <div class="card-header bg-secondary text-white text-center">
            <h4 class="mb-0">Room Price</h4>
        </div>
        <div class="card-body">
            <div class="row mb-2"><div class="col-md-4 fw-bold">Currency:</div><div class="col-md-8"><%= price.getCurrency() %></div></div>
            <div class="row mb-2"><div class="col-md-4 fw-bold">Price Per Night:</div><div class="col-md-8"><%= price.getPricePerNight().setScale(2, java.math.RoundingMode.HALF_UP) %></div></div>
        </div>
    </div>

    <!-- Buttons -->
    <div class="text-center my-3">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bookingModal">Book Now</button>
        <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#oldGuestModal">Book for Existing Guest</button>
    </div>

    <!-- New Guest Modal -->
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
                            <div class="col-md-6"><input type="text" name="firstName" class="form-control" placeholder="First Name" required /></div>
                            <div class="col-md-6"><input type="text" name="lastName" class="form-control" placeholder="Last Name" required /></div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-6"><input type="email" name="email" class="form-control" placeholder="Email" required /></div>
                        </div>

                        <div class="row mb-3">
                            <!-- ID Type & Number -->
                            <div class="col-md-6">
                                <label class="form-label">ID Type</label>
                                <select class="form-select" id="idType" name="idType" onchange="updateIdValidation()" required>
                                    <option value="NIC" selected>National ID (NIC)</option>
                                    <option value="PASSPORT">Passport</option>
                                </select>
                                <label class="form-label mt-2">ID Number</label>
                                <input type="text" class="form-control" id="guestIdNo" name="guestIdNo" placeholder="Enter ID Number" required>
                                <div class="form-text" id="idHelpText">NIC should be 10 or 12 digits; Passport can be alphanumeric.</div>
                            </div>

                            <!-- Contact -->
                            <div class="col-md-6">
                                <label class="form-label">Contact Number</label>
                                <div class="input-group">
                                    <select class="form-select" id="countryCode" required>
                                        <option value="+1">United States (+1)</option>
                                        <option value="+44">United Kingdom (+44)</option>
                                        <option value="+91">India (+91)</option>
                                        <option value="+94" selected>Sri Lanka (+94)</option>
                                        <option value="+93">Afghanistan (+93)</option>
                                    </select>
                                    <input type="tel" class="form-control" id="contactNumber" pattern="[0-9]{7,15}" maxlength="15" minlength="7" placeholder="Enter phone number" required>
                                </div>
                                <div class="form-text">Select country code and enter 7–15 digits.</div>
                            </div>
                        </div>

                        <div class="row mb-2">
                            <div class="col-md-6">
                                <input type="date" name="birthOfDate" id="birthOfDate" class="form-control" placeholder="Date of Birth" required />
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="address" class="form-control" placeholder="Address" required />
                            </div>
                        </div>

                        <h5>Reservation Details</h5>
                        <div class="row mb-2">
                            <div class="col-md-6"><label>Check-In:</label><input type="date" name="checkIn" id="checkIn" class="form-control" required onchange="calculateTotal(); updateCheckOutMin()" /></div>
                            <div class="col-md-6"><label>Check-Out:</label><input type="date" name="checkOut" id="checkOut" class="form-control" required onchange="calculateTotal()" /></div>
                        </div>

                        <div class="row mb-2">
                            <div class="col-md-6"><label>Total Nights:</label><input type="number" id="totalNights" name="totalNights" class="form-control" readonly /></div>
                            <div class="col-md-6"><label>Total Price (<%= price.getCurrency() %>):</label><input type="text" id="totalPrice" name="totalPrice" class="form-control" readonly /></div>
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

                        <div class="text-center"><button type="submit" class="btn btn-success">Confirm Booking</button></div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Existing Guest Modal -->
    <div class="modal fade" id="oldGuestModal" tabindex="-1" aria-labelledby="oldGuestModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-secondary text-white">
                    <h5 class="modal-title" id="oldGuestModalLabel">Book for Existing Guest</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="oldGuestSearchForm" method="get" action="BookRoomServlet">
                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />
                        <input type="hidden" name="pricePerNight" value="<%= pricePerNightDouble %>" />
                        <input type="hidden" name="currency" value="<%= price.getCurrency() %>" />
                        <div class="row mb-3">
                            <div class="col-md-6"><input type="email" name="email" class="form-control" placeholder="Enter Guest Email" /></div>
                            <div class="col-md-6"><input type="text" name="contactNumber" class="form-control" placeholder="Enter Contact Number" /></div>
                        </div>
                        <div class="text-center"><button type="submit" class="btn btn-primary">Find Guest</button></div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<% } %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const pricePerNight = <%= pricePerNightDouble %>;

    // Calculate total
    function calculateTotal() {
        const checkInEl = document.getElementById('checkIn');
        const checkOutEl = document.getElementById('checkOut');
        if (checkInEl.value && checkOutEl.value) {
            const diffDays = Math.ceil((new Date(checkOutEl.value) - new Date(checkInEl.value)) / (1000*60*60*24));
            if(diffDays > 0){
                document.getElementById('totalNights').value = diffDays;
                document.getElementById('totalPrice').value = (diffDays * pricePerNight).toFixed(2);
                return;
            }
        }
        document.getElementById('totalNights').value = 0;
        document.getElementById('totalPrice').value = "0.00";
    }

    const checkInEl = document.getElementById('checkIn');
    const checkOutEl = document.getElementById('checkOut');

    // Set min dates
    const todayISO = new Date().toISOString().split('T')[0];
    checkInEl.setAttribute('min', todayISO);
    checkOutEl.setAttribute('min', todayISO);

    checkInEl.addEventListener('change', function() { updateCheckOutMin(); calculateTotal(); });
    checkOutEl.addEventListener('change', calculateTotal);

    function updateCheckOutMin(){
        if(checkInEl.value){
            checkOutEl.min = checkInEl.value;
            if(checkOutEl.value < checkInEl.value) checkOutEl.value = checkInEl.value;
        }
    }

    // Set max DOB
    const dobEl = document.getElementById("birthOfDate");
    const today = new Date();
    const year18 = today.getFullYear() - 18;
    dobEl.setAttribute("max", `${year18}-${String(today.getMonth()+1).padStart(2,'0')}-${String(today.getDate()).padStart(2,'0')}`);

    // ID Validation
    window.updateIdValidation = function(){
        const idType = document.getElementById("idType").value;
        const idInput = document.getElementById("guestIdNo");
        const helpText = document.getElementById("idHelpText");
        if(idType === "NIC"){
            idInput.pattern = "^[0-9]{9}[vVxX]|[0-9]{12}$";
            helpText.textContent = "NIC should be 10 digits with letter or 12 digits numeric.";
        } else {
            idInput.pattern = "^[A-Za-z0-9]{5,20}$";
            helpText.textContent = "Passport number can be 5–20 alphanumeric characters.";
        }
    }

    // Contact + Country code on submit
    const guestForm = document.getElementById("guestReservationForm");
    guestForm.addEventListener("submit", function(){
        const code = document.getElementById("countryCode").value;
        const number = document.getElementById("contactNumber");
        const hidden = document.createElement("input");
        hidden.type="hidden"; hidden.name="contactNumber"; hidden.value = code + number.value;
        guestForm.appendChild(hidden);
        number.removeAttribute("name");
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>
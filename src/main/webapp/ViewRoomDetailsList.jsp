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
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
     body {
         font-family: 'Roboto', sans-serif;
         background: #f0f8ff;
         margin: 0;
         padding: 0;
     }

     /* Main card styling */
     .main-card {
         border-radius: 15px;
         border: none;
         overflow: hidden;
         box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
         margin-bottom: 2rem;
     }

     /* Card headers */
     .card-header-custom {
         background-color: #2193b0; /* Replaced gradient with solid color */
         color: white;
         font-weight: 600;
         letter-spacing: 1px;
         text-align: center;
         padding: 1rem;
     }

     /* Room info rows */
     .room-info-row {
         padding: 0.75rem 0;
         display: flex;
         justify-content: space-between;
         border-bottom: 1px solid #e0e0e0;
     }

     .room-info-row .fw-bold {
         flex: 0 0 35%;
     }

     .room-info-row div:nth-child(2) {
         flex: 1;
     }

     /* Price section */
     .price-section {
         background-color: #f8fcff;
         padding: 1rem;
     }

     /* Buttons */
     .btn-primary-custom {
         background-color: #2193b0; /* solid color instead of gradient */
         border: none;
         border-radius: 25px;
         padding: 8px 25px;
         font-weight: 500;
         color: white;
         transition: 0.3s;
     }

     .btn-primary-custom:hover {
         opacity: 0.9;
     }

     .btn-secondary-custom {
         border-radius: 25px;
         padding: 8px 25px;
     }

     /* Modal headers */
     .modal-header {
         background-color: #2193b0; /* solid color instead of gradient */
         color: white;
     }

     /* Badge styling */
     .badge-status {
         font-size: 14px;
         padding: 6px 12px;
         border-radius: 20px;
     }

     /* Form focus effect */
     .form-control:focus,
     .form-select:focus {
         border-color: #2193b0;
         box-shadow: 0 0 0 0.2rem rgba(33, 147, 176, 0.25);
     }

     .form-text {
         font-size: 0.8rem;
         color: #555;
     }

     /* Compact ID Type + Number group */
     .id-input-group {
         display: flex;
         gap: 10px;
         align-items: flex-end;
     }

     .id-input-group .form-select {
         width: 30%;
     }

     .id-input-group .form-control {
         flex: 1;
     }

     /* Responsive adjustments for small screens */
     @media (max-width: 576px) {
         .id-input-group {
             flex-direction: column;
             align-items: stretch;
         }
         .id-input-group .form-select {
             width: 100%;
         }

         .room-info-row {
             flex-direction: column;
             gap: 0.3rem;
         }

         .room-info-row .fw-bold {
             flex: 0 0 auto;
         }
     }
    </style>
</head>

<body>
<jsp:include page="Component/NavBar.jsp" />

<div class="container my-4">

<% if (msg != null && !msg.isEmpty()) { %>
    <div class="alert alert-<%= "success".equals(type) ? "success" : "danger" %> alert-dismissible fade show text-center" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>

<% if (room == null) { %>
    <div class="alert alert-warning text-center mt-4">Room not found!</div>
<% } else { %>

    <!-- Room Details Card -->
    <div class="card main-card mb-4">
        <div class="card-header card-header-custom py-3">
            <h4 class="mb-0">Room Details</h4>
        </div>
        <div class="card-body">
            <div class="row room-info-row">
                <div class="col-md-4 fw-bold">Room Type:</div>
                <div class="col-md-8"><%= room.getRoomType() %></div>
            </div>
            <div class="row room-info-row">
                <div class="col-md-4 fw-bold">Room Number:</div>
                <div class="col-md-8"><%= room.getRoomNumber() %></div>
            </div>
            <div class="row room-info-row">
                <div class="col-md-4 fw-bold">Room Name:</div>
                <div class="col-md-8"><%= room.getRoomName() %></div>
            </div>
            <div class="row room-info-row">
                <div class="col-md-4 fw-bold">Description:</div>
                <div class="col-md-8"><%= room.getRoomDescription() %></div>
            </div>
            <div class="row room-info-row">
                <div class="col-md-4 fw-bold">Availability:</div>
                <div class="col-md-8">
                    <span class="badge <%= "Available".equals(room.getRoomAvailabilityStatus()) ? "bg-success" : "bg-danger" %> badge-status">
                        <%= room.getRoomAvailabilityStatus() %>
                    </span>
                </div>
            </div>
            <div class="row room-info-row">
                <div class="col-md-4 fw-bold">Capacity:</div>
                <div class="col-md-8"><%= room.getRoomCapacity() %> Persons</div>
            </div>
        </div>

        <div class="card-header card-header-custom py-3">
            <h4 class="mb-0">Room Price</h4>
        </div>
        <div class="card-body price-section">
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

    <!-- Action Buttons -->
    <div class="text-center mb-4">
        <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#bookingModal">Book Now</button>
        <button class="btn btn-secondary btn-secondary-custom" data-bs-toggle="modal" data-bs-target="#oldGuestModal">Book for Existing Guest</button>
    </div>

    <!-- New Guest Modal -->
    <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="bookingModalLabel">Book Room</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="guestReservationForm" action="BookRoomServlet" method="post">
                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />

                        <h5 class="mb-3 text-dark">Guest Details</h5>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" id="firstName" name="firstName" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" id="lastName" name="lastName" class="form-control" required>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label for="birthOfDate" class="form-label">Date of Birth</label>
                                <input type="date" id="birthOfDate" name="birthOfDate" class="form-control" required>
                            </div>
                        </div>

                        <!-- Compact ID Type + Number -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">ID Details</label>
                                <div class="id-input-group">
                                    <select id="idType" name="idType" class="form-select" onchange="updateIdValidation()">
                                        <option value="NIC" selected>NIC</option>
                                        <option value="PASSPORT">Passport</option>
                                    </select>
                                    <input type="text" id="guestIdNo" name="guestIdNo" class="form-control" placeholder="Enter ID" required>
                                </div>
                                <div class="form-text" id="idHelpText">NIC should be 10 or 12 digits; Passport alphanumeric.</div>
                            </div>

                            <div class="col-md-6">
                                <label for="contactNumber" class="form-label">Contact Number</label>
                                <div class="input-group">
                                    <select id="countryCode" class="form-select">
                                        <option value="+1">US (+1)</option>
                                        <option value="+44">UK (+44)</option>
                                        <option value="+91">IN (+91)</option>
                                        <option value="+94" selected>SL (+94)</option>
                                        <option value="+93">AF (+93)</option>
                                    </select>
                                    <input type="tel" id="contactNumber" class="form-control" placeholder="Phone" pattern="[0-9]{7,15}" required>
                                </div>
                                <div class="form-text">Select country code + 7–15 digits.</div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-12">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" id="address" name="address" class="form-control" required>
                            </div>
                        </div>

                        <!-- Reservation Details -->
                        <h5 class="mb-3 text-dark mt-4">Reservation Details</h5>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="checkIn" class="form-label">Check-In</label>
                                <input type="date" id="checkIn" name="checkIn" class="form-control" required onchange="calculateTotal(); updateCheckOutMin()">
                            </div>
                            <div class="col-md-6">
                                <label for="checkOut" class="form-label">Check-Out</label>
                                <input type="date" id="checkOut" name="checkOut" class="form-control" required onchange="calculateTotal()">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="totalNights" class="form-label">Total Nights</label>
                                <input type="number" id="totalNights" name="totalNights" class="form-control" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="totalPrice" class="form-label">Total Price (<%= price.getCurrency() %>)</label>
                                <input type="text" id="totalPrice" name="totalPrice" class="form-control" readonly>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="serviceStatus" class="form-label">Service Status</label>
                                <select id="serviceStatus" name="serviceStatus" class="form-select" required>
                                    <option value="Pending" selected>Pending</option>
                                    <option value="Confirmed">Confirmed</option>
                                    <option value="Cancelled">Cancelled</option>
                                </select>
                            </div>
                        </div>

                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary">Confirm Booking</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Existing Guest Modal (unchanged, similar style) -->
    <div class="modal fade" id="oldGuestModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Book for Existing Guest</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="oldGuestSearchForm" method="get" action="BookRoomServlet">
                        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />
                        <input type="hidden" name="pricePerNight" value="<%= pricePerNightDouble %>" />
                        <input type="hidden" name="currency" value="<%= price.getCurrency() %>" />
                        <div class="row mb-3">
                            <div class="col-md-6"><input type="email" name="email" class="form-control" placeholder="Guest Email" /></div>
                            <div class="col-md-6"><input type="text" name="contactNumber" class="form-control" placeholder="Contact Number" /></div>
                        </div>
                        <div class="text-center"><button type="submit" class="btn btn-primary-custom">Find Guest</button></div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<% } %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const pricePerNight = <%= pricePerNightDouble %>;
    const checkInEl = document.getElementById('checkIn');
    const checkOutEl = document.getElementById('checkOut');
    const dobEl = document.getElementById("birthOfDate");

    function calculateTotal() {
        if (checkInEl.value && checkOutEl.value) {
            const diffDays = Math.ceil((new Date(checkOutEl.value) - new Date(checkInEl.value)) / (1000*60*60*24));
            document.getElementById('totalNights').value = diffDays > 0 ? diffDays : 0;
            document.getElementById('totalPrice').value = diffDays > 0 ? (diffDays*pricePerNight).toFixed(2) : "0.00";
        }
    }

    function updateCheckOutMin() {
        if (checkInEl.value) {
            checkOutEl.min = checkInEl.value;
            if (checkOutEl.value < checkInEl.value) checkOutEl.value = checkInEl.value;
        }
    }

    checkInEl.min = new Date().toISOString().split('T')[0];
    checkOutEl.min = new Date().toISOString().split('T')[0];

    checkInEl.addEventListener('change', () => { updateCheckOutMin(); calculateTotal(); });
    checkOutEl.addEventListener('change', calculateTotal);

    const today = new Date();
    const year18 = today.getFullYear() - 18;
    dobEl.max = `${year18}-${String(today.getMonth()+1).padStart(2,'0')}-${String(today.getDate()).padStart(2,'0')}`;

    window.updateIdValidation = function() {
        const idType = document.getElementById("idType").value;
        const idInput = document.getElementById("guestIdNo");
        const helpText = document.getElementById("idHelpText");
        if(idType === "NIC") {
            idInput.pattern = "^[0-9]{9}[vVxX]|[0-9]{12}$";
            helpText.textContent = "NIC should be 10 digits with letter or 12 digits numeric.";
        } else {
            idInput.pattern = "^[A-Za-z0-9]{5,20}$";
            helpText.textContent = "Passport number can be 5–20 alphanumeric characters.";
        }
    }

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
</body>
</html>
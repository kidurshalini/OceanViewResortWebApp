<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help Section - Resort Booking System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }
        .header-section {
            background: linear-gradient(90deg, #6dd5ed, #2193b0);
            color: white;
            padding: 30px 0;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 10px;
        }
        .section-card {
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .section-card .card-header {
            background-color: #2193b0;
            color: white;
        }
        .contact-section {
            background-color: #2193b0;
            color: white;
            padding: 20px;
            margin-top: 30px;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-5">

    <!-- Header -->
    <div class="header-section">
        <h1>Help Section</h1>
        <p>Ocean View Resort Booking System User Guide</p>
    </div>

    <!-- Accordion for sections -->
    <div class="accordion" id="helpAccordion">

        <!-- Welcome / Index Page -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingWelcome">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseWelcome" aria-expanded="false" aria-controls="collapseWelcome">
                    1. Welcome / Index Page
                </button>
            </h2>
            <div id="collapseWelcome" class="accordion-collapse collapse" aria-labelledby="headingWelcome" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Displays a welcome message to users.</li>
                        <li><strong>Login to Book</strong> button navigates to the login page.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Login Page -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingLogin">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLogin" aria-expanded="false" aria-controls="collapseLogin">
                    2. Login Page
                </button>
            </h2>
            <div id="collapseLogin" class="accordion-collapse collapse" aria-labelledby="headingLogin" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Requires <strong>Email</strong> and <strong>Password</strong> credentials.</li>
                        <li>Admin: full navigation bar visible.</li>
                        <li>Staff: limited navigation bar (no "User" tab).</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Navigation Bar -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingNav">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseNav" aria-expanded="false" aria-controls="collapseNav">
                    3. Navigation Bar
                </button>
            </h2>
            <div id="collapseNav" class="accordion-collapse collapse" aria-labelledby="headingNav" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <p><strong>Admin:</strong> Home, Rooms, River Reservation, Guest Details, Add Room, User</p>
                    <p><strong>Staff:</strong> Home, Rooms, River Reservation, Guest Details, Add Room</p>
                </div>
            </div>
        </div>

        <!-- Home Page -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingHome">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseHome" aria-expanded="false" aria-controls="collapseHome">
                    4. Home Page
                </button>
            </h2>
            <div id="collapseHome" class="accordion-collapse collapse" aria-labelledby="headingHome" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Shows "About Us" section with images and transactions.</li>
                        <li><strong>View Available Rooms</strong> button navigates to the View Rooms page.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- View Rooms Page -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingRooms">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseRooms" aria-expanded="false" aria-controls="collapseRooms">
                    5. View Rooms Page
                </button>
            </h2>
            <div id="collapseRooms" class="accordion-collapse collapse" aria-labelledby="headingRooms" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Displays all rooms with buttons: Edit View, Edit Price, Delete.</li>
                        <li>Search bar available for filtering rooms.</li>
                        <li>Booking Options:
                            <ul>
                                <li><strong>Book Now</strong> → Add new guest and reserve room.</li>
                                <li><strong>Book for Existing Guest</strong> → Search by Email or Contact Number.</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Reservation Tab -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingReservation">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseReservation" aria-expanded="false" aria-controls="collapseReservation">
                    6. Reservation Tab
                </button>
            </h2>
            <div id="collapseReservation" class="accordion-collapse collapse" aria-labelledby="headingReservation" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Sections: Confirmed, Pending, Cancelled Reservations.</li>
                        <li>Available actions: Update, Print Bill, Send Email, Delete.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Guest Details -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingGuest">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGuest" aria-expanded="false" aria-controls="collapseGuest">
                    7. Guest Details
                </button>
            </h2>
            <div id="collapseGuest" class="accordion-collapse collapse" aria-labelledby="headingGuest" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Search/filter guests by name, email, or contact.</li>
                        <li>Update guest details.</li>

                    </ul>
                </div>
            </div>
        </div>

        <!-- Add Room -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingAddRoom">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseAddRoom" aria-expanded="false" aria-controls="collapseAddRoom">
                    8. Add Room
                </button>
            </h2>
            <div id="collapseAddRoom" class="accordion-collapse collapse" aria-labelledby="headingAddRoom" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Add new room details: type, bed count, amenities, etc.</li>
                        <li>Add room pricing details.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- User Tab -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingUser">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUser" aria-expanded="false" aria-controls="collapseUser">
                    9. User Tab (Admin Only)
                </button>
            </h2>
            <div id="collapseUser" class="accordion-collapse collapse" aria-labelledby="headingUser" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Add and update user accounts.</li>
                        <li>Set Active / Inactive status.</li>
                        <li>Login / Logout controls and welcome badges.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Reports -->
        <div class="accordion-item section-card">
            <h2 class="accordion-header" id="headingReports">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseReports" aria-expanded="false" aria-controls="collapseReports">
                    10. Reports
                </button>
            </h2>
            <div id="collapseReports" class="accordion-collapse collapse" aria-labelledby="headingReports" data-bs-parent="#helpAccordion">
                <div class="accordion-body">
                    <ul>
                        <li>Room status: Available / Unavailable.</li>
                        <li>User status: Active / Inactive.</li>
                        <li>Monthly booking statistics by room type (example: Double Rooms → 16%).</li>
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <!-- Contact Section -->
    <div class="contact-section text-center">
        <h3>Contact Us</h3>
        <p>Email: support@oceanresortbooking.com</p>
        <p>Phone: +94 77 123 4567</p>
        <p>Address: 123 Ocean View Road, Negombo, Sri Lanka</p>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
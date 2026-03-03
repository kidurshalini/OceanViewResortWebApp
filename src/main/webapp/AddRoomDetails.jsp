<html>
<head>
    <title>Room Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
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
            background-color: #17a2b8;
            color: #fff;
            font-weight: 600;
            font-size: 1.5rem;
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

        .btn-outline-secondary {
            font-weight: 500;
        }

        .card-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        textarea.form-control {
            resize: none;
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 1rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<form action="RoomDetailsServlet" method="post" class="container mt-5 mb-5">

    <div class="card shadow-lg">

        <!-- Header -->
        <div class="card-header">
            <i class="bi bi-building me-2"></i> Room Details Form
        </div>

        <div class="card-body">

            <!-- Room Type & Room Name -->
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Room Type</label>
                    <select name="roomType" class="form-select" required>
                        <option value="" disabled selected>Select Room Type</option>
                        <option value="Single">Single</option>
                        <option value="Double">Double</option>
                        <option value="Suite">Suite</option>
                        <option value="Deluxe">Deluxe</option>
                        <option value="Family">Family</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Room Name</label>
                    <select name="roomName" class="form-select" required>
                        <option value="" disabled selected>Select Room Name</option>
                        <option value="Ocean View">Ocean View</option>
                        <option value="Mountain View">Mountain View</option>
                        <option value="Garden View">Garden View</option>
                        <option value="Presidential Suite">Presidential Suite</option>
                        <option value="Deluxe Room">Deluxe Room</option>
                    </select>
                </div>
            </div>

            <!-- Room Number & Room Description -->
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Room Number</label>
                    <input type="text" name="roomNumber" class="form-control" placeholder="Enter Room Number" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Room Description</label>
                    <input type="text" name="roomDescription" class="form-control" placeholder="Enter room description" required>
                </div>
            </div>

            <!-- Capacity & Availability -->
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Capacity</label>
                    <input type="number" name="roomCapacity" class="form-control" min="1" placeholder="Enter capacity" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Availability</label>
                    <select name="roomAvailabilityStatus" class="form-select" required>
                        <option value="" disabled selected>Select Availability</option>
                        <option value="Available">Available</option>
                        <option value="Not Available">Not Available</option>
                    </select>
                </div>
            </div>

            <!-- Currency & Price -->
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Currency</label>
                    <select name="Currency" class="form-select" required>
                        <option value="" disabled selected>Select Currency</option>
                        <option value="LKR">LKR</option>
                        <option value="USD">USD</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Price per Night</label>
                    <input type="number" name="PricePerNight" class="form-control" placeholder="Enter price per night" required>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <div class="card-footer text-center">
            <button type="submit" class="btn btn-success px-4 me-2">
                <i class="bi bi-plus-circle me-1"></i> Add Room
            </button>
            <button type="reset" class="btn btn-outline-secondary px-4">
                Reset
            </button>
        </div>

    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
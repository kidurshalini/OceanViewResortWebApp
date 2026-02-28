<html>
<head>
    <title>Home</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body class="bg-light">

<jsp:include page="Component/NavBar.jsp" />

<form action="RoomDetailsServlet" method="post" class="container mt-4 mb-5">

    <div class="card shadow-lg">

        <!-- Header -->
        <div class="card-header bg-secondary text-white text-center">
            <h2 class="mb-0">
                <i class="bi bi-building me-2"></i>
                Room Details Form
            </h2>
        </div>

        <!-- Body -->
        <div class="card-body">

            <!-- Room Type -->
            <div class="mb-3">
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

            <!-- Room Number -->
            <div class="mb-3">
                <label class="form-label">Room Number</label>
                <input type="text" name="roomNumber" class="form-control" required>
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label class="form-label">Room Description</label>
                <textarea name="roomDescription" class="form-control" rows="3" required></textarea>
            </div>

            <!-- Room Name -->
            <div class="mb-3">
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

            <!-- Capacity + Availability -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Capacity</label>
                    <input type="number" name="roomCapacity" class="form-control" min="1" required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Availability</label>
                    <select name="roomAvailabilityStatus" class="form-select" required>
                        <option value="">-- Select --</option>
                        <option value="Available">Available</option>
                        <option value="Not Available">Not Available</option>
                    </select>
                </div>
            </div>

            <!-- Currency + Price -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Currency</label>
                    <select name="Currency" class="form-select" required>
                        <option value="">-- Select Currency --</option>
                        <option value="LKR">LKR</option>
                        <option value="USD">USD</option>
                    </select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Price per Night</label>
                    <input type="number" name="PerNightPrice" class="form-control" required>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <div class="card-footer text-center bg-white">
            <button type="submit" class="btn btn-success px-4 me-2">
                <i class="bi bi-plus-circle me-1"></i>
                Add Room
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
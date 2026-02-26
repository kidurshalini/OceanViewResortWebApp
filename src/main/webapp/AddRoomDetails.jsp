
<html>
<head>
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="css/open-iconic/font/css/open-iconic-bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<form action="RoomDetailsServlet" method="post" class="container mt-4">

    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">Add Room Details</h5>
        </div>

        <div class="card-body">

            <div class="mb-3">
                <label class="form-label">Room Type</label>
                <input type="text" name="roomType" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Room Number</label>
                <input type="text" name="roomNumber" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Room Description</label>
                <textarea name="roomDescription" class="form-control" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Room Name</label>
                <input type="text" name="roomName" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Availability</label>
                <select name="roomAvailabilityStatus" class="form-select" required>
                    <option value="">-- Select --</option>
                    <option value="Available">Available</option>
                    <option value="Not Available">Not Available</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Capacity</label>
                <input type="number" name="roomCapacity" class="form-control" min="1" required>
            </div>

        </div>

        <div class="card-footer text-end">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-plus-circle me-1"></i>
                Add Room
            </button>
            <button type="reset" class="btn btn-secondary ms-2">
                Reset
            </button>
        </div>
    </div>
</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
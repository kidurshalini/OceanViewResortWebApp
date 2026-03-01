<%@ page import="com.oceanviewresortapp.model.RoomDetails, com.oceanviewresortapp.DAO.RoomDetailsDAOImpl" %>

<%
    int roomId = Integer.parseInt(request.getParameter("roomId"));
    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
    RoomDetails room = dao.getRoomDetailsById(roomId);
%>

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

<form action="RoomDetailsServlet" method="post" class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark text-center">
            <h2 class="mb-0">Room Details Updating Form</h2>
        </div>
        <div class="card-body">

        <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />


            <div class="mb-3">
                <label class="form-label">Room Type</label>
                <select name="roomType" class="form-control" required>
                    <option value="" disabled>Select Room Type</option>
                    <option value="Single" <%= "Single".equals(room.getRoomType()) ? "selected" : "" %>>Single</option>
                    <option value="Double" <%= "Double".equals(room.getRoomType()) ? "selected" : "" %>>Double</option>
                    <option value="Suite" <%= "Suite".equals(room.getRoomType()) ? "selected" : "" %>>Suite</option>
                    <option value="Deluxe" <%= "Deluxe".equals(room.getRoomType()) ? "selected" : "" %>>Deluxe</option>
                    <option value="Family" <%= "Family".equals(room.getRoomType()) ? "selected" : "" %>>Family</option>
                </select>
            </div>
                <div class="mb-3">
                <label class="form-label">Room Number</label>
                <input type="text" name="roomNumber" class="form-control" value="<%= room.getRoomNumber() %>">
            </div>

            <div class="mb-3">
                <label class="form-label">Room Description</label>
                <textarea name="roomDescription" class="form-control" rows="3" required><%= room.getRoomDescription() %></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Room Name</label>
                <select name="roomName" class="form-control" required>
                    <option value="" disabled>Select Room Name</option>
                    <option value="Ocean View" <%= "Ocean View".equals(room.getRoomName()) ? "selected" : "" %>>Ocean View</option>
                    <option value="Mountain View" <%= "Mountain View".equals(room.getRoomName()) ? "selected" : "" %>>Mountain View</option>
                    <option value="Garden View" <%= "Garden View".equals(room.getRoomName()) ? "selected" : "" %>>Garden View</option>
                    <option value="Presidential Suite" <%= "Presidential Suite".equals(room.getRoomName()) ? "selected" : "" %>>Presidential Suite</option>
                    <option value="Deluxe Room" <%= "Deluxe Room".equals(room.getRoomName()) ? "selected" : "" %>>Deluxe Room</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Availability</label>
                <select name="roomAvailabilityStatus" class="form-select" required>
                    <option value="">-- Select --</option>
                    <option value="Available" <%= "Available".equals(room.getRoomAvailabilityStatus()) ? "selected" : "" %>>Available</option>
                    <option value="Not Available" <%= "Not Available".equals(room.getRoomAvailabilityStatus()) ? "selected" : "" %>>Not Available</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Capacity</label>
                <input type="number" name="roomCapacity" class="form-control" min="1" value="<%= room.getRoomCapacity() %>" required>
            </div>
        </div>

        <div class="card-footer text-end">
            <button type="submit" name="action" value="update" class="btn btn-warning">
                <i class="bi bi-plus-circle me-1"></i>
                Update Room
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

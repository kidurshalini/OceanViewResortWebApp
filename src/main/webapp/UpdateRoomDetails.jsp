<%@ page import="com.oceanviewresortapp.model.RoomDetails, com.oceanviewresortapp.DAO.RoomDetailsDAOImpl" %>

<%
    int roomId = Integer.parseInt(request.getParameter("roomId"));
    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
    RoomDetails room = dao.getRoomDetailsById(roomId);
%>

<html>
<head>
    <title>Update Room</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f7fa;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: #ffc107 !important;
            color: #212529 !important;
            font-weight: 600;
            font-size: 1.5rem;
            text-align: center;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        /* Labels styling */
        .form-label {
            font-weight: 600;
            color: #37474f; /* dark gray-blue */
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }

        /* Input styling */
        .form-control, .form-select, textarea {
            border-radius: 12px;
            background-color: #f9f9f9;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus, textarea:focus {
            border-color: #2193b0;
            box-shadow: 0 0 5px rgba(33,147,176,0.3);
            background-color: #fff;
        }

        .card-footer {
            background-color: #f8f9fa;
            border-top: none;
        }

        .btn-warning {
            border-radius: 25px;
            font-weight: 500;
        }
    </style>
</head>
<body>

<form action="RoomDetailsServlet" method="post" class="container mt-5" style="max-width: 800px;">
    <div class="card">
        <div class="card-header">
            <i class="bi bi-pencil-square me-2"></i> Update Room Details
        </div>
        <div class="card-body">

            <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />

            <div class="mb-3">
                <label class="form-label">Room Type</label>
                <select name="roomType" class="form-select" required>
                    <option value="" disabled>Select Room Type</option>
                    <option value="Single" <%= "Single".equals(room.getRoomType()) ? "selected" : "" %>>Single</option>
                    <option value="Double" <%= "Double".equals(room.getRoomType()) ? "selected" : "" %>>Double</option>
                    <option value="Suite" <%= "Suite".equals(room.getRoomType()) ? "selected" : "" %>>Suite</option>
                    <option value="Deluxe" <%= "Deluxe".equals(room.getRoomType()) ? "selected" : "" %>>Deluxe</option>
                    <option value="Family" <%= "Family".equals(room.getRoomType()) ? "selected" : "" %>>Family</option>
                </select>
            </div>

            <!-- Room Number and Room Name side by side -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Room Number</label>
                    <input type="text" name="roomNumber" class="form-control" value="<%= room.getRoomNumber() %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Room Name</label>
                    <select name="roomName" class="form-select" required>
                        <option value="" disabled>Select Room Name</option>
                        <option value="Ocean View" <%= "Ocean View".equals(room.getRoomName()) ? "selected" : "" %>>Ocean View</option>
                        <option value="Mountain View" <%= "Mountain View".equals(room.getRoomName()) ? "selected" : "" %>>Mountain View</option>
                        <option value="Garden View" <%= "Garden View".equals(room.getRoomName()) ? "selected" : "" %>>Garden View</option>
                        <option value="Presidential Suite" <%= "Presidential Suite".equals(room.getRoomName()) ? "selected" : "" %>>Presidential Suite</option>
                        <option value="Deluxe Room" <%= "Deluxe Room".equals(room.getRoomName()) ? "selected" : "" %>>Deluxe Room</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Room Description</label>
                <textarea name="roomDescription" class="form-control" rows="3" required><%= room.getRoomDescription() %></textarea>
            </div>

            <!-- Availability and Capacity side by side -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Availability</label>
                    <select name="roomAvailabilityStatus" class="form-select" required>
                        <option value="">-- Select --</option>
                        <option value="Available" <%= "Available".equals(room.getRoomAvailabilityStatus()) ? "selected" : "" %>>Available</option>
                        <option value="Not Available" <%= "Not Available".equals(room.getRoomAvailabilityStatus()) ? "selected" : "" %>>Not Available</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Capacity</label>
                    <input type="number" name="roomCapacity" class="form-control" min="1" value="<%= room.getRoomCapacity() %>" required>
                </div>
            </div>

        </div>

        <div class="card-footer text-end">
            <button type="submit" name="action" value="update" class="btn btn-warning">
                <i class="bi bi-check-circle me-1"></i> Update Room
            </button>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
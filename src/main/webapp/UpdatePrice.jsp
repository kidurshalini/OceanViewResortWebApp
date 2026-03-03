<%@ page import="com.oceanviewresortapp.model.RoomDetails, com.oceanviewresortapp.model.RoomPriceDetails, com.oceanviewresortapp.DAO.RoomDetailsDAOImpl" %>
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
        price.setRoomPriceDetailsId(0);
        price.setRoomDetailsId(roomId);
        price.setCurrency("LKR");
        price.setPricePerNight(new java.math.BigDecimal("0.00"));
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Room Price</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: #17a2b8; /* soft blue */
            color: #fff;
            font-weight: 600;
            font-size: 1.3rem;
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

        .room-info {
            font-size: 1rem;
            font-weight: 500;
            color: #495057;
            margin-bottom: 20px;
            text-align: center;
        }

        .container {
            max-width: 500px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="room-info">
        <h2>Update Room Price</h2>
        <p>Room: <strong><%= room != null ? room.getRoomName() : "Unknown" %></strong></p>
    </div>

    <form action="RoomDetailsServlet" method="post">
        <div class="card">
            <div class="card-header">
                Price Details
            </div>
            <div class="card-body">
                <!-- Hidden fields -->
                <input type="hidden" name="action" value="updateprice">
                <input type="hidden" name="roomId" value="<%= price.getRoomDetailsId() %>">
                <input type="hidden" name="roompricedetaildid" value="<%= price.getRoomPriceDetailsId() %>">

                <!-- Currency -->
                <div class="mb-3">
                    <label class="form-label">Currency</label>
                    <select name="Currency" class="form-select" required>
                        <option value="LKR" <%= "LKR".equals(price.getCurrency()) ? "selected" : "" %>>LKR</option>
                        <option value="USD" <%= "USD".equals(price.getCurrency()) ? "selected" : "" %>>USD</option>
                    </select>
                </div>

                <!-- Price per night -->
                <div class="mb-3">
                    <label class="form-label">Price Per Night</label>
                    <input type="number" step="0.01" min="0"
                           name="PricePerNight"
                           class="form-control"
                           value="<%= price.getPricePerNight().setScale(2, java.math.RoundingMode.HALF_UP) %>"
                           required>
                </div>
            </div>
            <div class="card-footer text-end">
                <button type="submit" class="btn btn-success">Update Price</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
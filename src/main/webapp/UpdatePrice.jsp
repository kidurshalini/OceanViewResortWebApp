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
</head>
<body>
<div class="container mt-4">
    <form action="RoomDetailsServlet" method="post">
        <div class="card shadow">
            <div class="card-header bg-info text-white text-center">
                <h4>Update Room Price</h4>
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
                <button type="submit" class="btn btn-info">Update Price</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
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

    <div class="card shadow mb-4">
        <div class="card-header bg-secondary text-white text-center">
            <h4 class="mb-0">Room Details</h4>
        </div>

        <div class="card-body">
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Room Type:</div>
                <div class="col-md-8"><%= room.getRoomType() %></div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Room Number:</div>
                <div class="col-md-8"><%= room.getRoomNumber() %></div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Room Name:</div>
                <div class="col-md-8"><%= room.getRoomName() %></div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Description:</div>
                <div class="col-md-8"><%= room.getRoomDescription() %></div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Availability:</div>
                <div class="col-md-8">
                    <span class="badge <%= "Available".equals(room.getRoomAvailabilityStatus())
                            ? "bg-success" : "bg-danger" %>">
                        <%= room.getRoomAvailabilityStatus() %>
                    </span>
                </div>
            </div>

            <div class="row mb-2">
                <div class="col-md-4 fw-bold">Capacity:</div>
                <div class="col-md-8"><%= room.getRoomCapacity() %> Persons</div>
            </div>
        </div>

         <div class="card-header bg-secondary text-white  text-center">
                    <h4 class="mb-0">Room Price</h4>
                </div>

                <div class="card-body">
                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Currency:</div>
                        <div class="col-md-8"><%= price.getCurrency() %></div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-md-4 fw-bold">Price Per Night:</div>
                        <div class="col-md-8">
                            <%= price.getPricePerNight().setScale(2, java.math.RoundingMode.HALF_UP) %>
                        </div>
                    </div>
                </div>
           </div>
    </div>

</div>
</body>
</html>
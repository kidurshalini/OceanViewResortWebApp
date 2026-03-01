<%@ page import="java.util.*, com.oceanviewresortapp.DAO.*, com.oceanviewresortapp.model.*" %>

<%
    String msg = request.getParameter("msg");
    if (msg != null) {
%>
<script>
    alert("<%= msg %>");
</script>
<%
    }
%>

<%
    RoomDetailsDAOImpl roomDAO = new RoomDetailsDAOImpl();
    List<RoomDetails> rooms = new ArrayList<>();
    try {
        rooms = roomDAO.getAll(); // fetch all rooms
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>Room List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0">Room Details</h5>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Room Type</th>
                            <th>Room Number</th>
                            <th>Room Name</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Capacity</th>
                            <th>Currency</th>
                            <th>Price per Night</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for (RoomDetails r : rooms) {
                            RoomPriceDetails price = null;
                            try {
                                price = roomDAO.getPriceByRoomId(r.getRoomId()); // fetch price
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                    %>
                        <tr>
                            <td><%= r.getRoomType() %></td>
                            <td><%= r.getRoomNumber() %></td>
                            <td><%= r.getRoomName() %></td>
                            <td><%= r.getRoomDescription() %></td>
                            <td class="text-center">
                                <% if ("Available".equalsIgnoreCase(r.getRoomAvailabilityStatus())) { %>
                                    <span class="badge bg-success">
                                        <i class="bi bi-check-circle me-1"></i>Available
                                    </span>
                                <% } else { %>
                                    <span class="badge bg-danger">
                                        <i class="bi bi-x-circle me-1"></i>Not Available
                                    </span>
                                <% } %>
                            </td>
                            <td class="text-center"><%= r.getRoomCapacity() %></td>
                            <td class="text-center"><%= (price != null) ? price.getCurrency() : "No price set" %></td>
                      <td class="text-center">
                          <%= (price != null && price.getPricePerNight() != null) ? price.getPricePerNight() : "No price set" %>
                      </td>
                            <td class="text-center">
                                <a href="UpdateRoomDetails.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-sm btn-warning me-2">
                                    <i class="bi bi-pencil-square"></i> Edit
                                </a>
                                <a href="ViewRoomDetailsList.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-sm btn-warning me-2">
                                    <i class="bi bi-eye"></i>  View
                                </a>
                               <a href="UpdatePrice.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-sm btn-info me-2">
                                    <i class="bi bi-cash-coin"></i> Edit Price
                              </a>
                                <a href="RoomDetailsServlet?roomId=<%= r.getRoomId() %>&action=delete" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this room?')">
                                    <i class="bi bi-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
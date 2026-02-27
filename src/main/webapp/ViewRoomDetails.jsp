<%@ page import="java.util.*,com.oceanviewresortapp.DAO.*,com.oceanviewresortapp.model.*" %>

<%
    String msg = request.getParameter("msg"); // read message from URL
    if (msg != null) {
%>
<script>
    alert("<%= msg %>");
</script>
<%
    }
%>
<%
    RoomDetailsDAOImpl R1 = new RoomDetailsDAOImpl();
    List<RoomDetails> rooms = R1.getAll();
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

<%--Nav bar inserting--%>
<jsp:include page="Component/NavBar.jsp" />

<%--Roomdetails view as a table with action--%>
<div class="container mt-4">

    <div class="card shadow">
        <div class="card-header bg-dark text-white">
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
                        <th>Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        for (RoomDetails r : rooms) {
                    %>
                    <tr>
                        <td><%= r.getRoomType() %></td>
                        <td><%= r.getRoomNumber() %></td>
                        <td><%= r.getRoomName() %></td>
                        <td><%= r.getRoomDescription() %></td>

                        <td class="text-center">
                            <% if ("Available".equalsIgnoreCase(r.getRoomAvailabilityStatus())) { %>
                            <span class="badge bg-success">
                                        <i class="bi bi-check-circle me-1"></i>
                                        Available
                                    </span>
                            <% } else { %>
                            <span class="badge bg-danger">
                                        <i class="bi bi-x-circle me-1"></i>
                                        Not Available
                                    </span>
                            <% } %>
                        </td>

                        <td class="text-center">
                                <span class="badge text-dark">
                                    <%= r.getRoomCapacity() %>
                                </span>
                        </td>
                    <td>
                        <a href="UpdateRoomDetails.jsp?roomId=<%= r.getRoomId() %>">Update</a>
                        <a href="RoomDetailsServlet?roomId=<%= r.getRoomId() %>&action=delete"
                           onclick="return confirm('Are you sure you want to delete this room?')"> Delete</a>
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
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
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("Login.jsp?msg=Please login first");
        return;
    }
%>

<html>
<head>
    <title>Room List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f7fa;
        }

        .card-header {
            background-color: #2193b0 !important;
            color: #fff;
        }

        .table thead {
            background-color: #6dd5ed !important;
            color: #fff;
        }

        .badge-available {
            background-color: #00c853 !important;
            color: #fff;
        }

        .badge-notavailable {
            background-color: #d50000 !important;
            color: #fff;
        }

        /* Action buttons */
        .btn-edit-room {
            background-color: #ffc107 !important; /* yellow */
            color: #000 !important;
            border-radius: 25px;
            transition: all 0.3s ease;
        }


        .btn-view-room {
            background-color: #2193b0 !important; /* blue */
            color: #fff !important;
            border-radius: 25px;
            transition: all 0.3s ease;
        }


        .btn-edit-price {
            background-color: #ff9800 !important; /* orange */
            color: #fff !important;
            border-radius: 25px;
        }

        .btn-danger {
            border-radius: 25px;
        }


    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header">
            <h5 class="mb-0 text-white">Room Details</h5>
        </div>

     <div class="card-body">
         <!-- Search Bar -->
         <div class="row mb-3">
             <div class="col-md-6">
                 <input type="text" id="roomSearch" class="form-control" placeholder="Search by Room Type, Number, Name or Status..." onkeyup="filterRooms()">
             </div>
         </div>

         <div class="table-responsive">
             <table class="table table-bordered table-striped table-hover align-middle" id="roomsTable">
                 <thead class="text-center">
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
                     <% for (RoomDetails r : rooms) {
                             RoomPriceDetails price = null;
                             try {
                                 price = roomDAO.getPriceByRoomId(r.getRoomId());
                             } catch (Exception e) { e.printStackTrace(); }
                     %>
                     <tr>
                         <td><%= r.getRoomType() %></td>
                         <td><%= r.getRoomNumber() %></td>
                         <td><%= r.getRoomName() %></td>
                         <td><%= r.getRoomDescription() %></td>
                         <td class="text-center">
                             <% if ("Available".equalsIgnoreCase(r.getRoomAvailabilityStatus())) { %>
                                 <span class="badge badge-available">
                                     <i class="bi bi-check-circle me-1"></i>Available
                                 </span>
                             <% } else { %>
                                 <span class="badge badge-notavailable">
                                     <i class="bi bi-x-circle me-1"></i>Not Available
                                 </span>
                             <% } %>
                         </td>
                         <td class="text-center"><%= r.getRoomCapacity() %></td>
                         <td class="text-center"><%= (price != null) ? price.getCurrency() : "No price set" %></td>
                         <td class="text-center"><%= (price != null && price.getPricePerNight() != null) ? price.getPricePerNight() : "No price set" %></td>
                         <td class="text-center">
                             <a href="UpdateRoomDetails.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-sm btn-edit-room me-2">
                                 <i class="bi bi-pencil-square"></i>
                             </a>
                             <a href="ViewRoomDetailsList.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-sm btn-view-room me-2">
                                 <i class="bi bi-eye"></i>
                             </a>
                             <a href="UpdatePrice.jsp?roomId=<%= r.getRoomId() %>" class="btn btn-sm btn-edit-price me-2">
                                 <i class="bi bi-cash-coin"></i> Edit Price
                             </a>
                             <a href="RoomDetailsServlet?roomId=<%= r.getRoomId() %>&action=delete" class="btn btn-sm btn-danger"
                                onclick="return confirm('Are you sure you want to delete this room?')">
                                 <i class="bi bi-trash"></i>
                             </a>
                         </td>
                     </tr>
                     <% } %>
                 </tbody>
             </table>
         </div>

         <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>
         <div class="mt-4 text-end">
             <a href="MonthlyBookingReportServlet" class="btn btn-view-room">
                 <i class="bi bi-bar-chart-line"></i> View Monthly Booking Report
             </a>
         </div>
         <% } %>
     </div>

     <script>
     function filterRooms() {
         const input = document.getElementById("roomSearch");
         const filter = input.value.toLowerCase();
         const table = document.getElementById("roomsTable");
         const tr = table.getElementsByTagName("tr");

         for (let i = 1; i < tr.length; i++) { // skip header row
             const tdArray = tr[i].getElementsByTagName("td");
             let rowText = "";
             for (let j = 0; j < tdArray.length; j++) {
                 rowText += tdArray[j].textContent.toLowerCase() + " ";
             }
             if (rowText.indexOf(filter) > -1) {
                 tr[i].style.display = "";
             } else {
                 tr[i].style.display = "none";
             }
         }
     }
     </script>
</body>
</html>
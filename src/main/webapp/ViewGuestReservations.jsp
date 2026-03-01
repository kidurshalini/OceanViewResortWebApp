<%@ page import="java.sql.ResultSet" %>

<h2 align="center">Guest & Reservation Details</h2>

<table border="1" width="100%" cellpadding="6" cellspacing="0">
    <tr style="background:#f2f2f2">
        <th>Reservation ID</th>
        <th>Guest Name</th>
        <th>Email</th>
        <th>Contact</th>
        <th>Room ID</th>
        <th>Check-In</th>
        <th>Check-Out</th>
        <th>Nights</th>
        <th>Total Price</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

<%
    ResultSet rs = (ResultSet) request.getAttribute("rs");

    if (rs != null) {
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("ReservationId") %></td>
        <td><%= rs.getString("FirstName") %> <%= rs.getString("LastName") %></td>
        <td><%= rs.getString("Email") %></td>
        <td><%= rs.getString("ContactNumber") %></td>
        <td><%= rs.getInt("RoomId") %></td>
        <td><%= rs.getTimestamp("CheckIn") %></td>
        <td><%= rs.getTimestamp("CheckOut") %></td>
        <td><%= rs.getInt("TotalNights") %></td>
        <td><%= rs.getBigDecimal("TotalPrice") %></td>
        <td><%= rs.getString("ServiceStatus") %></td>

        <td>
            <form action="UpdateReservation.jsp" method="get">
                <input type="hidden" name="reservationId"
                       value="<%= rs.getInt("ReservationId") %>">
                <input type="submit" value="Update">
            </form>
        </td>
    </tr>
<%
        }
    }
%>
</table>
<%@ page import="java.util.*,com.oceanviewresortapp.DAO.*,com.oceanviewresortapp.model.*" %>

<%
    RoomDetailsDAOImpl R1 = new RoomDetailsDAOImpl();
    List<RoomDetails> rooms = R1.getAll();
%>

<table border="1">
    <tr>

        <th>RoomType</th>
        <th>RoomNumber</th>
        <th>RoomName</th>
        <th>RoomDescription</th>
        <th>RoomAvailabilityStatus</th>
        <th>RoomCapacity</th>
    </tr>

    <%
        for(RoomDetails r : rooms){
    %>
    <tr>

        <td><%= r.getRoomType() %></td>
        <td><%= r.getRoomNumber() %></td>
        <td><%= r.getRoomName() %></td>
        <td><%= r.getRoomDescription() %></td>
        <td><%= r.getRoomAvailabilityStatus() %></td>
        <td><%= r.getRoomCapacity() %></td>
    </tr>
    <%
        }
    %>
</table>
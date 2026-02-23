<%@ page import="java.util.*,com.oceanviewresortapp.DAO.*,com.oceanviewresortapp.model.*" %>

<%
    RoomDetailsDAOImpl R1 = new RoomDetailsDAOImpl();
    List<RoomDetails> rooms = R1.getAll();
%>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Type</th>
        <th>Number</th>
    </tr>

    <%
        for(RoomDetails r : rooms){
    %>
    <tr>
        <td><%= r.getRoomId() %></td>
        <td><%= r.getRoomType() %></td>
        <td><%= r.getRoomNumber() %></td>
    </tr>
    <%
        }
    %>
</table>
<%@ page import="com.oceanviewresortapp.model.RoomDetails, com.oceanviewresortapp.DAO.RoomDetailsDAOImpl" %>

<%
    int roomId = Integer.parseInt(request.getParameter("roomId"));
    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
    RoomDetails room = dao.getRoomDetailsById(roomId); // Get room from DB
%>

<h3>Edit Room</h3>
<form action="RoomDetailsServlet" method="post">
    <input type="hidden" name="roomId" value="<%= room.getRoomId() %>" />

    Room Type:
    <input type="text" name="roomType" value="<%= room.getRoomType() %>" required/><br/>

    Room Number:
    <input type="text" name="roomNumber" value="<%= room.getRoomNumber() %>" required/><br/>

    Room Description:
    <textarea name="roomDescription" rows="3" cols="30"><%= room.getRoomDescription() %></textarea><br/>

    Room Name:
    <input type="text" name="roomName" value="<%= room.getRoomName() %>" required/><br/>

    Room Availability:
    <select name="roomAvailabilityStatus">
        <option >Available</option>
        <option>Not Available</option>
    </select><br/>

    Room Capacity:
    <input type="number" name="roomCapacity" value="<%= room.getRoomCapacity() %>" min="1"/><br/><br/>

    <button type="submit" name="action" value="update">Update Room</button>
</form>
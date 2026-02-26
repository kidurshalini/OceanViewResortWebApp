<%@ page import="com.oceanviewresortapp.model.RoomDetails, com.oceanviewresortapp.DAO.RoomDetailsDAOImpl" %>
<%
    int roomId = Integer.parseInt(request.getParameter("roomId"));
    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
    RoomDetails room = dao.getById(roomId); // Get room from DB
%>

<h3>Edit Room</h3>
<form action="RoomDetailsServlet" method="post">
    <input type="hidden" name="roomId" value="<%= room.getRoomId() %>"/>
    Room Type: <input type="text" name="roomType" value="<%= room.getRoomType() %>"/><br/>
    Room Number: <input type="text" name="roomNumber" value="<%= room.getRoomNumber() %>"/><br/>
    <button type="submit" name="action" value="update">Update Room</button>
</form>
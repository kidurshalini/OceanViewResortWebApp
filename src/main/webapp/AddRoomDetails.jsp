String roomType = request.getParameter("roomType");
String roomNumber = request.getParameter("roomNumber");
String roomDescription = request.getParameter("roomDescription");
String roomName = request.getParameter("roomName");
String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));

RoomDetails room = new RoomDetails(roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity);
RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
dao.insert(room);
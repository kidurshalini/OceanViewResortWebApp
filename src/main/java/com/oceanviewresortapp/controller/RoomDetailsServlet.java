package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;
import javax.servlet.http.HttpSession;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RoomDetailsServlet")
public class RoomDetailsServlet extends HttpServlet {

    protected void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String msg = "";
    String action = request.getParameter("action");
    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

    try {
        if ("update".equals(action)) {

            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String roomType = request.getParameter("roomType");
            String roomNumber = request.getParameter("roomNumber");
            String roomName = request.getParameter("roomName");
            String roomDescription = request.getParameter("roomDescription");
            String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
            int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));
            int roomId = Integer.parseInt(request.getParameter("roomCapacity"));

            RoomDetails room = new RoomDetails();
            room.setRoomId(roomId);
            room.setRoomType(roomType);
            room.setRoomNumber(roomNumber);
            room.setRoomName(roomName);
            room.setRoomDescription(roomDescription);
            room.setRoomAvailabilityStatus(roomAvailabilityStatus);
            room.setRoomCapacity(roomCapacity);

            dao.update(room);
            msg = "Room details inserted successfully!";
        } else {

            String roomType = request.getParameter("roomType");
            String roomNumber = request.getParameter("roomNumber");
            String roomDescription = request.getParameter("roomDescription");
            String roomName = request.getParameter("roomName");
            String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
            int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));

            RoomDetails room = new RoomDetails(
                    roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity
            );

            dao.insert(room);
            msg = "Room details updated successfully!";
        }

        response.sendRedirect("ViewRoomDetails.jsp");

    } catch (Exception e) {
        e.printStackTrace();

        msg = "Operation failed!";
        response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
    }
}

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String msg = "";
        String action = request.getParameter("action");
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            if ("delete".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                dao.delete(roomId);

            }
            msg = "Room details deleted successfully!";
            response.sendRedirect("ViewRoomDetails.jsp");
        } catch (Exception e) {
            msg = "Operation failed!";
            response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
        }

    }

}



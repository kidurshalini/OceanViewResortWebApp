package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RoomDetailsServlet")
public class RoomDetailsServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//        String roomType = request.getParameter("roomType");
//        String roomNumber = request.getParameter("roomNumber");
//        String roomDescription = request.getParameter("roomDescription");
//        String roomName = request.getParameter("roomName");
//        String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
//        int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));
//
//        RoomDetails room = new RoomDetails(
//                roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity
//        );
//
//        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
//
//        try {
//            dao.insert(room);
//            response.sendRedirect("ViewRoomDetails.jsp");
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().println("Error inserting room: " + e.getMessage());
//        }
//    }

    protected void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    String action = request.getParameter("action"); // "insert" or "update"
    RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

    try {
        if ("update".equals(action)) {
            // --- UPDATE logic ---
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String roomType = request.getParameter("roomType");
            String roomNumber = request.getParameter("roomNumber");
            String roomName = request.getParameter("roomName");
            String roomDescription = request.getParameter("roomDescription");
            String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
            int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));

            RoomDetails room = new RoomDetails();
            room.setRoomId(roomId);
            room.setRoomType(roomType);
            room.setRoomNumber(roomNumber);
            room.setRoomName(roomName);
            room.setRoomDescription(roomDescription);
            room.setRoomAvailabilityStatus(roomAvailabilityStatus);
            room.setRoomCapacity(roomCapacity);

            dao.update(room); // call update

        } else {
            // --- INSERT logic (unchanged) ---
            String roomType = request.getParameter("roomType");
            String roomNumber = request.getParameter("roomNumber");
            String roomDescription = request.getParameter("roomDescription");
            String roomName = request.getParameter("roomName");
            String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
            int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));

            RoomDetails room = new RoomDetails(
                    roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity
            );

            dao.insert(room); // call insert
        }

        response.sendRedirect("ViewRoomDetails.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Error: " + e.getMessage());
    }
}
    // Handle GET → Delete
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            if ("delete".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                dao.delete(roomId); // DAO deletes DB
            }

            response.sendRedirect("ViewRoomDetails.jsp"); // Back to list
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}



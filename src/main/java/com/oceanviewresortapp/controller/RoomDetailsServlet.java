package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RoomDetailsServlet")
public class RoomDetailsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomType = request.getParameter("roomType");
        String roomNumber = request.getParameter("roomNumber");
        String roomDescription = request.getParameter("roomDescription");
        String roomName = request.getParameter("roomName");
        String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
        int roomCapacity = Integer.parseInt(request.getParameter("roomCapacity"));

        RoomDetails room = new RoomDetails(
                roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity
        );

        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            dao.insert(room);
            response.sendRedirect("ViewRoomDetails.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error inserting room: " + e.getMessage());
        }
    }
    protected void doPostUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            if ("update".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                String roomType = request.getParameter("roomType");
                String roomNumber = request.getParameter("roomNumber");

                RoomDetails room = new RoomDetails();
                room.setRoomId(roomId);
                room.setRoomType(roomType);
                room.setRoomNumber(roomNumber);

                dao.update(room); // DAO updates DB
            }

            response.sendRedirect("ViewRoomDetails.jsp"); // Back to list
        } catch (Exception e) {
            e.printStackTrace();
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



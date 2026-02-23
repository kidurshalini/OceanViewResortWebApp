
package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;

import javax.servlet.*;
        import javax.servlet.http.*;
        import java.io.IOException;

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
                roomType,
                roomNumber,
                roomDescription,
                roomName,
                roomAvailabilityStatus,
                roomCapacity
        );

        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            dao.insert(room);
            response.sendRedirect("viewRooms.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
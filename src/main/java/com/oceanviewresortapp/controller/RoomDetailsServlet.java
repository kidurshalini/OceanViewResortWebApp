package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;

import javax.servlet.http.HttpSession;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Currency;

@WebServlet("/RoomDetailsServlet")
public class RoomDetailsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String msg = "";
        String action = request.getParameter("action");
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            // Common room fields
            String roomType = request.getParameter("roomType");
            String roomNumber = request.getParameter("roomNumber");
            String roomDescription = request.getParameter("roomDescription");
            String roomName = request.getParameter("roomName");
            String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
            String roomCapacityStr = request.getParameter("roomCapacity");

         int roomCapacity = Integer.parseInt(roomCapacityStr);

            if("update".equals(action)) {
                // --- UPDATE ROOM ONLY ---
                int roomId = Integer.parseInt(request.getParameter("roomId"));

                RoomDetails room = new RoomDetails();
                room.setRoomId(roomId);
                room.setRoomType(roomType);
                room.setRoomNumber(roomNumber);
                room.setRoomName(roomName);
                room.setRoomDescription(roomDescription);
                room.setRoomAvailabilityStatus(roomAvailabilityStatus);
                room.setRoomCapacity(roomCapacity);

                dao.update(room); // ✅ Only room, ignore price/currency
                msg = "Room details updated successfully!";

            } else {
                // --- INSERT ROOM + PRICE ---
                String currency = request.getParameter("Currency");
                String priceStr = request.getParameter("PerNightPrice");

                if(currency == null || currency.isEmpty() ||
                        priceStr == null || priceStr.isEmpty()) {
                    msg = "Insert failed! Please fill in currency and price.";
                    response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
                    return;
                }

                BigDecimal perNightPrice;
                try {
                    perNightPrice = new BigDecimal(priceStr);
                } catch(NumberFormatException e) {
                    msg = "Insert failed! Price must be a valid number.";
                    response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
                    return;
                }

                RoomDetails room = new RoomDetails(roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity);
                RoomPriceDetails price = new RoomPriceDetails(currency, perNightPrice);

                dao.insert(room, price); // ✅ Insert room + price
                msg = "Room details inserted successfully!";
            }

            response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));

        } catch(Exception e) {
            e.printStackTrace();
            msg = "Operation failed! " + e.getMessage();
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

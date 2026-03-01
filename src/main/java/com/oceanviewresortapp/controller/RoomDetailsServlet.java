package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;
import org.jetbrains.annotations.NotNull;

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


            String roomType = request.getParameter("roomType");
            String roomNumber = request.getParameter("roomNumber");
            String roomDescription = request.getParameter("roomDescription");
            String roomName = request.getParameter("roomName");
            String roomAvailabilityStatus = request.getParameter("roomAvailabilityStatus");
            String roomCapacityStr = request.getParameter("roomCapacity");

            if("update".equals(action)) {

                if (roomCapacityStr == null || roomCapacityStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room capacity is required!");
                    return;
                }

                String roomIdStr = request.getParameter("roomId");
                if (roomIdStr == null || roomIdStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room ID is required!");
                    return;
                }

                int roomId = Integer.parseInt(roomIdStr.trim());
                int roomCapacity = Integer.parseInt(roomCapacityStr.trim());

                RoomDetails room = new RoomDetails();
                room.setRoomId(roomId);
                room.setRoomType(roomType);
                room.setRoomNumber(roomNumber);
                room.setRoomName(roomName);
                room.setRoomDescription(roomDescription);
                room.setRoomAvailabilityStatus(roomAvailabilityStatus);
                room.setRoomCapacity(roomCapacity);

                dao.update(room);
                msg = "Room details updated successfully!";
                response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));

            } else if ("updateprice".equalsIgnoreCase(action)) {
                String roomPriceIdStr = request.getParameter("roompricedetaildid");
                String roomIdStr = request.getParameter("roomId");
                String currency = request.getParameter("Currency");
                String priceStr = request.getParameter("PricePerNight");


                if (roomIdStr == null || roomIdStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room ID is required for price update!");
                    return;
                }

                if (currency == null || currency.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Currency is required!");
                    return;
                }

                if (priceStr == null || priceStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Price is required!");
                    return;
                }

                try {
                    int roomPriceId = 0;
                    if (roomPriceIdStr != null && !roomPriceIdStr.trim().isEmpty()) {
                        roomPriceId = Integer.parseInt(roomPriceIdStr.trim());
                    }

                    int roomId = Integer.parseInt(roomIdStr.trim());
                    BigDecimal pricePerNight = new BigDecimal(priceStr.trim());

                    RoomPriceDetails price = new RoomPriceDetails();
                    price.setRoomPriceDetailsId(roomPriceId);
                    price.setRoomDetailsId(roomId);
                    price.setCurrency(currency.trim());
                    price.setPricePerNight(pricePerNight);

                    dao.updatePrice(price);
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Price updated successfully!");

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Invalid number format! Please check Room ID and Price values.");
                }

            } else {

                String currency = request.getParameter("Currency");
                String priceStr = request.getParameter("PricePerNight");


                if (roomType == null || roomType.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room type is required!");
                    return;
                }

                if (roomNumber == null || roomNumber.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room number is required!");
                    return;
                }

                if (roomName == null || roomName.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room name is required!");
                    return;
                }

                if (roomAvailabilityStatus == null || roomAvailabilityStatus.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room availability status is required!");
                    return;
                }

                if (roomCapacityStr == null || roomCapacityStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room capacity is required!");
                    return;
                }

                if (currency == null || currency.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Currency is required!");
                    return;
                }

                if (priceStr == null || priceStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Price is required!");
                    return;
                }

                try {
                    int roomCapacity = Integer.parseInt(roomCapacityStr.trim());
                    BigDecimal PricePerNight = new BigDecimal(priceStr.trim());

                    RoomDetails room = new RoomDetails(roomType, roomNumber, roomDescription, roomName, roomAvailabilityStatus, roomCapacity);
                    RoomPriceDetails price = new RoomPriceDetails(currency, PricePerNight);

                    dao.insert(room, price);
                    msg = "Room details inserted successfully!";
                    response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));

                } catch (NumberFormatException e) {
                    msg = "Insert failed! Please enter valid numbers for capacity and price.";
                    response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            msg = "Operation failed! " + e.getMessage();
            response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
        }
    }

    protected void doGet(@NotNull HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String msg = "";
        String action = request.getParameter("action");
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        try {
            if ("delete".equals(action)) {
                String roomIdStr = request.getParameter("roomId");
                if (roomIdStr == null || roomIdStr.trim().isEmpty()) {
                    response.sendRedirect("ViewRoomDetails.jsp?msg=Room ID is required for deletion!");
                    return;
                }

                int roomId = Integer.parseInt(roomIdStr.trim());
                dao.delete(roomId);
                msg = "Room details deleted successfully!";
            }
            response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));

        } catch (NumberFormatException e) {
            msg = "Invalid room ID format!";
            response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
        } catch (Exception e) {
            msg = "Operation failed!";
            response.sendRedirect("ViewRoomDetails.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
        }
    }
}
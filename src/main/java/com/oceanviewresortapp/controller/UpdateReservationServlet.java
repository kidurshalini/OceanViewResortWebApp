package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/UpdateReservationServlet")
public class UpdateReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));

        try (Connection conn = DB_Connection.getConnection()) {

            ReservationDAO dao = new ReservationDAO(conn);
            Reservation res = dao.getReservationById(reservationId);
            List<RoomDetails> rooms = dao.getAllRooms();

            request.setAttribute("reservation", res);
            request.setAttribute("roomsList", rooms);

            request.getRequestDispatcher("/UpdateReservation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error loading reservation: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DB_Connection.getConnection()) {

            ReservationDAO dao = new ReservationDAO(conn);
            Reservation res = new Reservation();

            res.setReservationId(Integer.parseInt(request.getParameter("reservationId")));
            res.setCheckIn(LocalDateTime.parse(request.getParameter("checkIn") + "T00:00:00"));
            res.setCheckOut(LocalDateTime.parse(request.getParameter("checkOut") + "T00:00:00"));
            res.setTotalNights(Integer.parseInt(request.getParameter("totalNights")));
            res.setTotalPrice(new BigDecimal(request.getParameter("totalPrice")));
            res.setServiceStatus(request.getParameter("serviceStatus"));
            res.setRoomId(Integer.parseInt(request.getParameter("roomId")));

            dao.updateReservation(res);

            response.sendRedirect("ViewGuestReservations?msg=Reservation updated successfully&type=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewGuestReservations?msg=Failed to update reservation&type=danger");
        }
    }
}
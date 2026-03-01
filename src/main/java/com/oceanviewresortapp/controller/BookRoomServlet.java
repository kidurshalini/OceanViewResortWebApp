package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.time.LocalDateTime;

@WebServlet("/BookRoomServlet")
public class BookRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DB_Connection.getConnection()) {

            ReservationDAO resDAO = new ReservationDAO(conn);
            String guestIdParam = request.getParameter("guestId");


            if (guestIdParam != null && !guestIdParam.isEmpty()) {

                Reservation res = new Reservation();
                res.setGuestId(Integer.parseInt(guestIdParam));
                res.setRoomId(Integer.parseInt(request.getParameter("roomId")));
                res.setCheckIn(LocalDateTime.parse(request.getParameter("checkIn") + "T00:00:00"));
                res.setCheckOut(LocalDateTime.parse(request.getParameter("checkOut") + "T00:00:00"));
                res.setTotalNights(Integer.parseInt(request.getParameter("totalNights")));
                res.setTotalPrice(new BigDecimal(request.getParameter("totalPrice")));
                res.setServiceStatus("Pending");

                resDAO.saveReservation(res);

                response.sendRedirect("ViewRoomDetails.jsp?msg=Booking Successful&type=success");
                return;
            }

        /* =========================
           NEW GUEST (UNCHANGED)
           ========================= */
            Guest guest = new Guest();
            guest.setFirstName(request.getParameter("firstName"));
            guest.setLastName(request.getParameter("lastName"));
            guest.setEmail(request.getParameter("email"));
            guest.setContactNumber(request.getParameter("contactNumber"));
            guest.setGuestIdNo(request.getParameter("guestIdNo"));
            guest.setBirthOfDate(java.sql.Date.valueOf(request.getParameter("birthOfDate")));
            guest.setAddress(request.getParameter("address"));

            GuestDAO guestDAO = new GuestDAO(conn);
            int guestId = guestDAO.saveGuest(guest);

            Reservation res = new Reservation();
            res.setGuestId(guestId);
            res.setRoomId(Integer.parseInt(request.getParameter("roomId")));
            res.setCheckIn(LocalDateTime.parse(request.getParameter("checkIn") + "T00:00:00"));
            res.setCheckOut(LocalDateTime.parse(request.getParameter("checkOut") + "T00:00:00"));
            res.setTotalNights(Integer.parseInt(request.getParameter("totalNights")));
            res.setTotalPrice(new BigDecimal(request.getParameter("totalPrice")));
            res.setServiceStatus("Pending");

            resDAO.saveReservation(res);

            response.sendRedirect("ViewRoomDetails.jsp?msg=Successfully booked&type=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewRoomDetails.jsp?msg=Booking Failed&type=danger");
        }
    }

    /* =========================
       GET → Search Existing Guest
       ========================= */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String contact = request.getParameter("contactNumber");

        try (Connection conn = DB_Connection.getConnection()) {

            GuestDAO guestDAO = new GuestDAO(conn);
            Guest guest = null;

            if (email != null && !email.trim().isEmpty()) {
                guest = guestDAO.getGuestByEmail(email);
            } else if (contact != null && !contact.trim().isEmpty()) {
                guest = guestDAO.getGuestByContact(contact);
            }

            request.setAttribute("guest", guest);
            request.getRequestDispatcher("OldGuestReservation.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewRoomDetails.jsp?msg=Guest search failed&type=danger"+e.getMessage());
        }
    }

}
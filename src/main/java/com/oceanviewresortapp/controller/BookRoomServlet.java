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
import java.time.LocalDateTime;

@WebServlet("/BookRoomServlet")

    public class BookRoomServlet extends HttpServlet {

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try (Connection conn = DB_Connection.getConnection()) {

                // Guest
                Guest guest = new Guest();
                guest.setFirstName(request.getParameter("firstName"));
                guest.setLastName(request.getParameter("lastName"));
                guest.setEmail(request.getParameter("email"));
                guest.setContactNumber(request.getParameter("contactNumber"));
                guest.setGuestIdNo(request.getParameter("guestIdNo"));
                guest.setBirthOfDate(java.sql.Date.valueOf(request.getParameter("birthOfDate")));
                guest.setAddress(request.getParameter("address"));

                GuestDAO guestDAO = new GuestDAO();
                int guestId = guestDAO.saveGuest(guest);

                // Reservation
                Reservation res = new Reservation();
                res.setGuestId(guestId);
                res.setRoomId(Integer.parseInt(request.getParameter("roomId")));
                res.setCheckIn(LocalDateTime.parse(request.getParameter("checkIn") + "T00:00:00"));
                res.setCheckOut(LocalDateTime.parse(request.getParameter("checkOut") + "T00:00:00"));
                res.setTotalNights(Integer.parseInt(request.getParameter("totalNights")));
                res.setTotalPrice(new BigDecimal(request.getParameter("totalPrice")));
                res.setServiceStatus("Pending");

                ReservationDAO resDAO = new ReservationDAO(conn);
                int reservationId = resDAO.saveReservation(res);

                response.sendRedirect("ViewRoomDetails.jsp?msg=Successfully booked&type=success");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("ViewRoomDetailsList.jsp?msg=Booking+Failed&type=danger");
            }
            }


        }



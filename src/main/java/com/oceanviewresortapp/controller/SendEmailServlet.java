package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.util.EmailUtil;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));

        try (Connection conn = DB_Connection.getConnection()) {

            // Get reservation
            ReservationDAO reservationDAO = new ReservationDAO(conn);
            Reservation reservation = reservationDAO.getReservationById(reservationId);

            if (reservation == null) {
                response.getWriter().println("Reservation not found!");
                return;
            }

            // Get guest details
            GuestDAO guestDAO = new GuestDAO(conn);
            Guest guest = guestDAO.getGuestById(reservation.getGuestId());

            if (guest == null) {
                response.getWriter().println("Guest not found!");
                return;
            }

            String guestEmail = guest.getEmail(); // Use real email from DB

            // Path to the already generated PDF bill
            String pdfPath = "D:/OceanView_Bill_" + reservationId + ".pdf";

            // Send email
            EmailUtil.sendEmailWithAttachment(
                    "smtp.gmail.com",      // SMTP host
                    465,                   // SMTP port
                    "kidurshalini1026@gmail.com",// SMTP username
                    "gcpa jdlf wmmf uozk",   // SMTP password
                    "kidurshalini1026@gmail.com",// From email
                    guestEmail,            // To email
                    "Your Reservation Bill",
                    "Dear " + guest.getFirstName() + ",\n\nPlease find your reservation bill attached.\n\nThank you!",
                    pdfPath
            );

            response.getWriter().println("Email sent successfully to " + guestEmail);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
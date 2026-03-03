package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;
import com.oceanviewresortapp.util.BillGenerator;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;

@WebServlet("/PrintBillServlet")
public class PrintBillServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));

        try (Connection con = DB_Connection.getConnection()) {

            ReservationDAO reservationDAO = new ReservationDAO(con);
            RoomDetailsDAOImpl roomDAO = new RoomDetailsDAOImpl();

            // Get reservation
            Reservation reservation = reservationDAO.getReservationById(reservationId);

            if (reservation == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found");
                return;
            }

            // Get room details
            RoomDetails roomDetails =
                    roomDAO.getRoomDetailsById(reservation.getRoomId());

            // Get room price details
            RoomPriceDetails roomPrice =
                    roomDAO.getPriceByRoomId(reservation.getRoomId());

            if (roomDetails == null || roomPrice == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Room details not found");
                return;
            }

            // Generate PDF
            String pdfPath = BillGenerator.generateBill(
                    reservation,
                    roomDetails,
                    roomPrice
            );

            File file = new File(pdfPath);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition",
                    "attachment; filename=" + file.getName());
            response.setContentLengthLong(file.length());

            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {

                byte[] buffer = new byte[4096];
                int length;

                while ((length = in.read(buffer)) > 0) {
                    out.write(buffer, 0, length);
                }
            }

            file.delete(); // delete temporary file

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error generating bill.");
        }
    }
}
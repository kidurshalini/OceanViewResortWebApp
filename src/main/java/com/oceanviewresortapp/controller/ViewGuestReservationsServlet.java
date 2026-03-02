package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.model.GuestReservationView;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/ViewGuestReservations")
public class ViewGuestReservationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DB_Connection.getConnection()) {

            ReservationDAO dao = new ReservationDAO(conn);
            List<GuestReservationView> reservations = dao.getGuestReservations();
            System.out.println("Total reservations: " + reservations.size());
            request.setAttribute("reservations", reservations);
            request.getRequestDispatcher("ViewGuestReservations.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
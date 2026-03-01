package com.oceanviewresortapp.controller;



import com.oceanviewresortapp.DAO.ReservationDAO;

import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import java.sql.Connection;
import java.sql.ResultSet;

public class ViewGuestReservationsServlet {
    @WebServlet("/ViewGuestReservations")
    public class ViewGuestReservationServlet extends HttpServlet {

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            try (Connection conn = DB_Connection.getConnection()) {

                ReservationDAO dao = new ReservationDAO(conn);
                ResultSet rs = dao.getGuestReservations();

                request.setAttribute("rs", rs);
                request.getRequestDispatcher("ViewGuestReservations.jsp")
                        .forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        }
    }
}

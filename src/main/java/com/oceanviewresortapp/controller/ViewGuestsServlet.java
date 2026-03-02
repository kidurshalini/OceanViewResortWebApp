package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/ViewGuests")
public class ViewGuestsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DB_Connection.getConnection()) {

            GuestDAO dao = new GuestDAO(conn);
            List<Guest> guests = dao.getAllGuests();

            request.setAttribute("guests", guests);
            request.getRequestDispatcher("ViewGuestsDetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewGuestsDetails.jsp?msg=Error loading guests");
        }
    }
}
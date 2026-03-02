package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/GuestServlet")
public class GuestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DB_Connection.getConnection()) {
            GuestDAO dao = new GuestDAO(conn);

            if ("view".equals(action)) {
                int guestId = Integer.parseInt(request.getParameter("guestId"));
                Guest guest = dao.getGuestById(guestId);

                request.setAttribute("guest", guest);
                request.getRequestDispatcher("UpdateGuest.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewGuests?msg=Error loading guest");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DB_Connection.getConnection()) {

            Guest guest = new Guest();
            guest.setGuestId(Integer.parseInt(request.getParameter("guestId")));
            guest.setFirstName(request.getParameter("firstName"));
            guest.setLastName(request.getParameter("lastName"));
            guest.setEmail(request.getParameter("email"));
            guest.setContactNumber(request.getParameter("contactNumber"));
            guest.setGuestIdNo(request.getParameter("guestIdNo"));
            guest.setBirthOfDate(java.sql.Date.valueOf(request.getParameter("birthOfDate")));
            guest.setAddress(request.getParameter("address"));

            GuestDAO dao = new GuestDAO(conn);
            dao.updateGuest(guest);

            response.sendRedirect("ViewGuests?msg=Guest updated successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewGuests?msg=Update failed");
        }
    }
}
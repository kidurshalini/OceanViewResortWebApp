package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.util.DB_Connection;
import com.google.gson.Gson;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/api/guests/*")
public class GuestRestController extends HttpServlet {

    private final Gson gson = new Gson();

    // GET: /api/guests OR /api/guests/{id}
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");

        try (Connection conn = DB_Connection.getConnection()) {
            GuestDAO dao = new GuestDAO(conn);

            String pathInfo = request.getPathInfo();

            // GET ALL
            if (pathInfo == null || pathInfo.equals("/")) {
                List<Guest> guests = dao.getAllGuests();
                response.getWriter().write(gson.toJson(guests));
            }
            // GET BY ID
            else {
                int guestId = Integer.parseInt(pathInfo.substring(1));
                Guest guest = dao.getGuestById(guestId);

                if (guest == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("{\"message\":\"Guest not found\"}");
                } else {
                    response.getWriter().write(gson.toJson(guest));
                }
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error\"}");
        }
    }

    // PUT: /api/guests/{id}
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");

        try (Connection conn = DB_Connection.getConnection()) {
            GuestDAO dao = new GuestDAO(conn);

            String pathInfo = request.getPathInfo();
            int guestId = Integer.parseInt(pathInfo.substring(1));

            BufferedReader reader = request.getReader();
            Guest guest = gson.fromJson(reader, Guest.class);
            guest.setGuestId(guestId);

            boolean updated = dao.updateGuest(guest);

            if (updated) {
                response.getWriter().write("{\"message\":\"Guest updated successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\":\"Update failed\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error\"}");
        }
    }
}
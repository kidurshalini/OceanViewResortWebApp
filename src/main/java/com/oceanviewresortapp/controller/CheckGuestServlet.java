package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.model.Guest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/CheckGuestServlet")
public class CheckGuestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String contact = request.getParameter("contactNumber");

        GuestDAO guestDao = new GuestDAO();
        Guest guest = guestDao.getGuestByEmailOrContact(email, contact);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (guest != null) {
            // Manually create JSON string
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"guestId\":").append(guest.getGuestId()).append(",");
            json.append("\"firstName\":\"").append(escapeJson(guest.getFirstName())).append("\",");
            json.append("\"lastName\":\"").append(escapeJson(guest.getLastName())).append("\",");
            json.append("\"email\":\"").append(escapeJson(guest.getEmail())).append("\",");
            json.append("\"contactNumber\":\"").append(escapeJson(guest.getContactNumber())).append("\",");
            json.append("\"guestIdNo\":\"").append(escapeJson(guest.getGuestIdNo())).append("\",");
            json.append("\"birthOfDate\":\"").append(guest.getBirthOfDate()).append("\",");
            json.append("\"address\":\"").append(escapeJson(guest.getAddress())).append("\"");
            json.append("}");
            response.getWriter().write(json.toString());
        } else {
            response.getWriter().write("{}"); // Empty JSON if guest not found
        }
    }

    // Escape double quotes and backslashes for JSON safety
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
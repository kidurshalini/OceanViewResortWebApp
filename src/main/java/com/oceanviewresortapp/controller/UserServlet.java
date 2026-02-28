package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.UserDAOImpl;
import com.oceanviewresortapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        UserDAOImpl dao = new UserDAOImpl();

        try {
            if ("add".equalsIgnoreCase(action)) {
                // --- Add User ---
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                boolean isActive = request.getParameter("isActive") != null;
                String contact = request.getParameter("contact");
                String idnumber = request.getParameter("idnumber");

                User user = new User(fullName, email, password, role, isActive, contact, idnumber);
                dao.insert(user);
                response.sendRedirect("ViewUser.jsp?msg=User added successfully!");

            } else if ("update".equalsIgnoreCase(action)) {
                // --- Update User ---
                int userId = Integer.parseInt(request.getParameter("userId"));
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                boolean isActive = request.getParameter("isActive") != null;
                String contact = request.getParameter("contact");
                String idnumber = request.getParameter("idnumber");
                User user = new User(userId, fullName, email, password, role, isActive, contact, idnumber);
                dao.update(user);
                response.sendRedirect("ViewUser.jsp?msg=User updated successfully!");

            } else if ("delete".equalsIgnoreCase(action)) {
                // --- Delete User ---
                int userId = Integer.parseInt(request.getParameter("userId"));
                dao.delete(userId);
                response.sendRedirect("ViewUser.jsp?msg=User deleted successfully!");
            } else {
                response.sendRedirect("ViewUser.jsp?msg=Invalid action!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewUser.jsp?msg=Error: " + e.getMessage());
        }
    }


}
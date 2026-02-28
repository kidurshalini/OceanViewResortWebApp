package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.UserDAOImpl;
import com.oceanviewresortapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            UserDAOImpl dao = new UserDAOImpl();
            User user = dao.authenticateUser(email, password);

            if (user != null) {
                // store user info in session
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser", user);

                // redirect based on role
                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("Login.jsp?msg=Invalid email or password / inactive user");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp?msg=Login failed: " + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }

}
package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.util.DB_Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/testDB")
public class TestDBServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        try (Connection con = DB_Connection.getConnection()) {

            if (con != null && !con.isClosed()) {
                response.getWriter().println("<h3> Database connection successful!</h3>");
            } else {
                response.getWriter().println("<h3> Database connection failed!</h3>");
            }

        } catch (Exception e) {
            response.getWriter().println("<h3> Exception occurred!</h3>");
            e.printStackTrace(response.getWriter());
        }
    }
}
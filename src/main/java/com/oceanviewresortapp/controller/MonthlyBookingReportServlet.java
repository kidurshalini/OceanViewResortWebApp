package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/MonthlyBookingReportServlet")
public class MonthlyBookingReportServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
            Map<String, Integer> bookingMap = dao.getMonthlyBookingsByRoomType();

            request.setAttribute("bookingMap", bookingMap);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load booking report");
        }

        request.getRequestDispatcher("MonthlyBookingReport.jsp")
                .forward(request, response);
    }
}
package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.model.Guest;
import org.junit.jupiter.api.Test;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.*;

import java.sql.Connection;

import static org.mockito.Mockito.*;

public class GuestServletTest {

    @Test
    void testDoGet_ViewGuest() throws Exception {
        GuestServlet servlet = new GuestServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        RequestDispatcher dispatcher = mock(RequestDispatcher.class);

        when(request.getParameter("action")).thenReturn("view");
        when(request.getParameter("guestId")).thenReturn("1");
        when(request.getRequestDispatcher("UpdateGuest.jsp")).thenReturn(dispatcher);

        servlet.doGet(request, response);

        verify(request).setAttribute(eq("guest"), any(Guest.class));
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testDoPost_UpdateGuest_Success() throws Exception {
        GuestServlet servlet = new GuestServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("guestId")).thenReturn("1");
        when(request.getParameter("firstName")).thenReturn("Updated");
        when(request.getParameter("lastName")).thenReturn("Guest");
        when(request.getParameter("email")).thenReturn("updated@example.com");
        when(request.getParameter("contactNumber")).thenReturn("9876543210");
        when(request.getParameter("guestIdNo")).thenReturn("ID123");
        when(request.getParameter("birthOfDate")).thenReturn("1990-01-01");
        when(request.getParameter("address")).thenReturn("Updated Address");

        servlet.doPost(request, response);

        verify(response).sendRedirect("ViewGuests?msg=Guest updated successfully");
    }
}
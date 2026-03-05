package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.RoomDetailsDAOImpl;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.math.BigDecimal;

import static org.mockito.Mockito.*;

public class RoomDetailsServletTest {

    @Test
    void testDoPost_InsertRoom() throws Exception {
        RoomDetailsServlet servlet = new RoomDetailsServlet();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("action")).thenReturn(null);
        when(request.getParameter("roomType")).thenReturn("Deluxe");
        when(request.getParameter("roomNumber")).thenReturn("D103");
        when(request.getParameter("roomName")).thenReturn("Ocean View");
        when(request.getParameter("roomDescription")).thenReturn("Sea view room");
        when(request.getParameter("roomAvailabilityStatus")).thenReturn("Available");
        when(request.getParameter("roomCapacity")).thenReturn("2");
        when(request.getParameter("Currency")).thenReturn("USD");
        when(request.getParameter("PricePerNight")).thenReturn("120.00");

        doNothing().when(response).sendRedirect(anyString());

        servlet.doPost(request, response);

        verify(response).sendRedirect(contains("Room details inserted successfully"));
    }
}
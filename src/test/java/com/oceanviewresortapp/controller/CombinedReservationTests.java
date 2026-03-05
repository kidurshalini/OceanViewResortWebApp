package com.oceanviewresortapp.controller;
import static org.mockito.Mockito.*;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.controller.BookRoomServlet;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.model.GuestReservationView;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.RoomPriceDetails;
import com.oceanviewresortapp.util.DB_Connection;

import org.junit.jupiter.api.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class CombinedReservationTests {

    private Connection conn;
    private GuestDAO guestDAO;
    private ReservationDAO reservationDAO;

    @BeforeAll
    void setup() throws Exception {
        conn = DB_Connection.getConnection();
        guestDAO = new GuestDAO(conn);
        reservationDAO = new ReservationDAO(conn);
    }

    // ------------------- GuestDAO Tests (5) -------------------
    @Test
    void testSaveGuest() throws Exception {
        Guest guest = new Guest();
        guest.setFirstName("Test");
        guest.setLastName("User");
        guest.setEmail("testuser@example.com");
        guest.setContactNumber("1234567890");
        guest.setGuestIdNo("ID1234");
        guest.setBirthOfDate(Date.valueOf("1990-01-01"));
        guest.setAddress("123 Test St");
        int guestId = guestDAO.saveGuest(guest);
        assertTrue(guestId > 0);
    }

    @Test
    void testGetGuestByEmail() throws Exception {
        Guest guest = guestDAO.getGuestByEmail("testuser@example.com");
        assertNotNull(guest);
        assertEquals("Test", guest.getFirstName());
    }

    @Test
    void testGetGuestByContact() throws Exception {
        Guest guest = guestDAO.getGuestByContact("1234567890");
        assertNotNull(guest);
        assertEquals("User", guest.getLastName());
    }

    @Test
    void testUpdateGuest() throws Exception {
        Guest guest = guestDAO.getGuestByEmail("testuser@example.com");
        guest.setAddress("Updated Address");
        boolean updated = guestDAO.updateGuest(guest);
        assertTrue(updated);
    }

    @Test
    void testGetGuestById() throws Exception {
        Guest guest = guestDAO.getGuestByEmail("testuser@example.com");
        Guest byId = guestDAO.getGuestById(guest.getGuestId());
        assertNotNull(byId);
        assertEquals(guest.getEmail(), byId.getEmail());
    }

    // ------------------- ReservationDAO Tests (5) -------------------
    @Test
    void testSaveReservation() throws Exception {
        Reservation res = new Reservation();
        res.setGuestId(1); // Use valid guest ID
        res.setRoomId(1);  // Use valid room ID
        res.setCheckIn(LocalDateTime.now());
        res.setCheckOut(LocalDateTime.now().plusDays(2));
        res.setTotalNights(2);
        res.setTotalPrice(BigDecimal.valueOf(100));
        res.setServiceStatus("Pending");

        int resId = reservationDAO.saveReservation(res);
        assertTrue(resId > 0);
    }

    @Test
    void testGetGuestReservations() throws Exception {
        List<GuestReservationView> list = reservationDAO.getGuestReservations();
        assertNotNull(list);
        assertTrue(list.size() >= 0);
    }

    @Test
    void testGetReservationById() throws Exception {
        List<GuestReservationView> list = reservationDAO.getGuestReservations();
        if (!list.isEmpty()) {
            int resId = list.get(0).getReservationId();
            Reservation res = reservationDAO.getReservationById(resId);
            assertNotNull(res);
        }
    }

    @Test
    void testUpdateReservation() throws Exception {
        List<GuestReservationView> list = reservationDAO.getGuestReservations();
        if (!list.isEmpty()) {
            Reservation res = reservationDAO.getReservationById(list.get(0).getReservationId());
            res.setServiceStatus("Confirmed");
            reservationDAO.updateReservation(res);
            Reservation updated = reservationDAO.getReservationById(res.getReservationId());
            assertEquals("Confirmed", updated.getServiceStatus());
        }
    }

    @Test
    void testGetRoomPriceDetailsByRoomId() throws Exception {
        RoomPriceDetails price = reservationDAO.getRoomPriceDetailsByRoomId(1);
        assertNotNull(price);
        assertTrue(price.getPricePerNight().compareTo(BigDecimal.ZERO) > 0);
    }

    // ------------------- Servlet Tests (2) -------------------
    @Test
    void testDoGet_SearchGuestByEmail() throws Exception {
        BookRoomServlet servlet = new BookRoomServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("email")).thenReturn("testuser@example.com");
        when(request.getParameter("contactNumber")).thenReturn(null);

        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        when(response.getWriter()).thenReturn(pw);

        servlet.doGet(request, response);

        verify(request, atLeastOnce()).setAttribute(eq("guest"), any());
    }

    @Test
    void testDoPost_BookNewGuestReservation() throws Exception {
        BookRoomServlet servlet = new BookRoomServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("firstName")).thenReturn("Test");
        when(request.getParameter("lastName")).thenReturn("User");
        when(request.getParameter("email")).thenReturn("testuser2@example.com");
        when(request.getParameter("contactNumber")).thenReturn("9876543210");
        when(request.getParameter("guestIdNo")).thenReturn("ID5678");
        when(request.getParameter("birthOfDate")).thenReturn("1990-01-01");
        when(request.getParameter("address")).thenReturn("456 Test Ave");
        when(request.getParameter("roomId")).thenReturn("1");
        when(request.getParameter("checkIn")).thenReturn("2026-03-05");
        when(request.getParameter("checkOut")).thenReturn("2026-03-07");
        when(request.getParameter("totalNights")).thenReturn("2");
        when(request.getParameter("totalPrice")).thenReturn("150.00");
        when(request.getParameter("guestId")).thenReturn(null);

        servlet.doPost(request, response);

        verify(response).sendRedirect(contains("Successfully booked"));
    }
}
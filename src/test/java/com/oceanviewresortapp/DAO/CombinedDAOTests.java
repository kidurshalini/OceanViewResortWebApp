package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.DAO.GuestDAO;
import com.oceanviewresortapp.DAO.ReservationDAO;
import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.model.GuestReservationView;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.RoomPriceDetails;
import com.oceanviewresortapp.util.DB_Connection;

import org.junit.jupiter.api.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class CombinedDAOTests {

    private Connection conn;
    private GuestDAO guestDAO;
    private ReservationDAO reservationDAO;

    @BeforeAll
    void setup() throws Exception {
        conn = DB_Connection.getConnection();
        guestDAO = new GuestDAO(conn);
        reservationDAO = new ReservationDAO(conn);
    }


    @Test
    void testGetGuestById() throws Exception {
        Guest guest = guestDAO.getGuestByEmail("shantha@gmail.com");
        Guest byId = guestDAO.getGuestById(guest.getGuestId());
        assertNotNull(byId);
        assertEquals(guest.getEmail(), byId.getEmail());
    }

    @Test
    void testUpdateGuest() throws Exception {
        Guest guest = guestDAO.getGuestByEmail("shantha@gmail.com");
        guest.setAddress("Updated Address");
        boolean updated = guestDAO.updateGuest(guest);
        assertTrue(updated);
    }


    // ---------------- ReservationDAO Tests (6) ----------------
    @Test
    void testSaveReservation() throws Exception {
        // Make sure a guest and room exist
        Reservation res = new Reservation();
        res.setGuestId(24);
        res.setRoomId(38);
        res.setCheckIn(LocalDateTime.now());
        res.setCheckOut(LocalDateTime.now().plusDays(2));
        res.setTotalNights(2);
        res.setTotalPrice(BigDecimal.valueOf(200));
        res.setServiceStatus("Pending");

        int resId = reservationDAO.saveReservation(res);
        assertTrue(resId > 0);
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
    void testGetGuestReservations() throws Exception {
        List<GuestReservationView> list = reservationDAO.getGuestReservations();
        assertNotNull(list);
        assertTrue(list.size() >= 0);
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
    void testGetAllRooms() throws Exception {
        assertNotNull(reservationDAO.getAllRooms());
        assertTrue(reservationDAO.getAllRooms().size() >= 0);
    }

    @Test
    void testGetRoomPriceDetailsByRoomId() throws Exception {
        RoomPriceDetails price = reservationDAO.getRoomPriceDetailsByRoomId(38);
        assertNotNull(price);
        assertTrue(price.getPricePerNight().compareTo(BigDecimal.ZERO) > 0);
    }
}
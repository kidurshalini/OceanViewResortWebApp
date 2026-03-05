package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.Guest;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class GuestDAOTest {

    private static Connection conn;
    private GuestDAO guestDAO;

    @BeforeAll
    static void setupConnection() throws Exception {
        // Use your actual DB connection
        conn = com.oceanviewresortapp.util.DB_Connection.getConnection();
    }

    @BeforeEach
    void init() {
        guestDAO = new GuestDAO(conn);
    }

    @Test
    void testSaveGuest() throws Exception {
        Guest guest = new Guest();
        guest.setFirstName("Test");
        guest.setLastName("Guest");
        guest.setEmail("testguest1@example.com");
        guest.setContactNumber("1834567890");
        guest.setGuestIdNo("ID123");
        guest.setBirthOfDate(java.sql.Date.valueOf("1990-01-01"));
        guest.setAddress("123 Test Street");

        int id = guestDAO.saveGuest(guest);
        assertTrue(id > 0, "Guest ID should be greater than 0 after saving");
    }


    @Test
    void testGetGuestById_NotExists() throws Exception {
        Guest guest = guestDAO.getGuestById(9999); // Non-existing ID
        assertNull(guest, "Guest should be null for non-existing ID");
    }

    @Test
    void testGetAllGuests() throws Exception {
        List<Guest> guests = guestDAO.getAllGuests();
        assertNotNull(guests, "Guest list should not be null");
        assertTrue(guests.size() > 0, "There should be at least one guest");
    }

}
package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.Guest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {

    private Connection conn;

    public GuestDAO(Connection conn) {
        this.conn = conn;
    }

    public int saveGuest(Guest guest) throws SQLException {

        CallableStatement cs = conn.prepareCall("{call sp_InsertGuestDetails(?,?,?,?,?,?,?,?)}");

        cs.setString(1, guest.getFirstName());
        cs.setString(2, guest.getLastName());
        cs.setString(3, guest.getEmail());
        cs.setString(4, guest.getContactNumber());
        cs.setString(5, guest.getGuestIdNo());
        cs.setDate(6, new java.sql.Date(guest.getBirthOfDate().getTime()));
        cs.setString(7, guest.getAddress());
        cs.registerOutParameter(8, Types.INTEGER);
        cs.execute();

        return cs.getInt(8);
    }



    public Guest getGuestByEmail(String email) throws Exception {
        String sql = "SELECT * FROM GuestDetails WHERE Email = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return mapGuest(rs);
        }
        return null;
    }


    public Guest getGuestByContact(String contact) throws Exception {
        String sql = "SELECT * FROM GuestDetails WHERE ContactNumber = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, contact);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return mapGuest(rs);
        }
        return null;
    }


    private Guest mapGuest(ResultSet rs) throws Exception {
        Guest g = new Guest();
        g.setGuestId(rs.getInt("GuestId"));
        g.setFirstName(rs.getString("FirstName"));
        g.setLastName(rs.getString("LastName"));
        g.setEmail(rs.getString("Email"));
        g.setContactNumber(rs.getString("ContactNumber"));
        g.setGuestIdNo(rs.getString("GuestIdNo"));
        g.setBirthOfDate(rs.getDate("BirthOfDate"));
        g.setAddress(rs.getString("Address"));
        return g;
    }

    public boolean updateGuest(Guest guest) throws SQLException {
        CallableStatement cs = conn.prepareCall("{call sp_UpdateGuestDetails(?,?,?,?,?,?,?,?)}");
        cs.setInt(1, guest.getGuestId());
        cs.setString(2, guest.getFirstName());
        cs.setString(3, guest.getLastName());
        cs.setString(4, guest.getEmail());
        cs.setString(5, guest.getContactNumber());
        cs.setString(6, guest.getGuestIdNo());
        cs.setDate(7, new java.sql.Date(guest.getBirthOfDate().getTime()));
        cs.setString(8, guest.getAddress());
        return cs.executeUpdate() > 0;
    }

    // Get Guest by ID
    public Guest getGuestById(int guestId) throws Exception {
        CallableStatement cs = conn.prepareCall("{call sp_GetGuestById(?)}");
        cs.setInt(1, guestId);
        ResultSet rs = cs.executeQuery();
        if (rs.next()) {
            return mapGuest(rs);
        }
        return null;
    }

    // Get All Guests
    public List<Guest> getAllGuests() throws Exception {
        List<Guest> guests = new ArrayList<>();
        CallableStatement cs = conn.prepareCall("{call sp_GetAllGuests}");
        ResultSet rs = cs.executeQuery();
        while (rs.next()) {
            guests.add(mapGuest(rs));
        }
        return guests;
    }


}
package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.Guest;
import com.oceanviewresortapp.util.DB_Connection;

import java.sql.*;

public class GuestDAO {

    private Connection conn;


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

    public Guest getGuestByEmailOrContact(String email, String contactNumber) {
        Guest guest = null;
        String sql = "SELECT * FROM GuestDetails WHERE Email = ? OR ContactNumber = ?";
        try (Connection conn = DB_Connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, contactNumber);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                guest = new Guest();
                guest.setGuestId(rs.getInt("GuestId"));
                guest.setFirstName(rs.getString("FirstName"));
                guest.setLastName(rs.getString("LastName"));
                guest.setEmail(rs.getString("Email"));
                guest.setContactNumber(rs.getString("ContactNumber"));
                guest.setGuestIdNo(rs.getString("GuestIdNo"));
                guest.setBirthOfDate(rs.getDate("BirthOfDate"));
                guest.setAddress(rs.getString("Address"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return guest;
    }
}
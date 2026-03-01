package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.Guest;
import java.sql.*;

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
}
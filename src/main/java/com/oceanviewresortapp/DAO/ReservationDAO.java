package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.GuestReservationView;
import com.oceanviewresortapp.model.Reservation;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.util.DB_Connection;

import java.sql.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private Connection conn;

    public ReservationDAO(Connection conn) {
        this.conn = conn;
    }

    public int saveReservation(Reservation res) throws SQLException {
        CallableStatement cs = conn.prepareCall("{call sp_InsertReservation(?,?,?,?,?,?,?,?)}");
        cs.setInt(1, res.getGuestId());
        cs.setInt(2, res.getRoomId());
        cs.setTimestamp(3, Timestamp.valueOf(res.getCheckIn()));
        cs.setTimestamp(4, Timestamp.valueOf(res.getCheckOut()));
        cs.setInt(5, res.getTotalNights());
        cs.setBigDecimal(6, res.getTotalPrice());
        cs.setString(7, res.getServiceStatus());
        cs.registerOutParameter(8, Types.INTEGER); // ReservationId output
        cs.execute();
        return cs.getInt(8);
    }

    public List<GuestReservationView> getGuestReservations() throws SQLException {

        List<GuestReservationView> list = new ArrayList<>();
        Connection conn = DB_Connection.getConnection();

        CallableStatement cs = conn.prepareCall("{call sp_GetGuestReservations}");
        ResultSet rs = cs.executeQuery();

        while (rs.next()) {
            GuestReservationView v = new GuestReservationView();

            v.setReservationId(rs.getInt("ReservationId"));
            v.setFirstName(rs.getString("FirstName"));
            v.setLastName(rs.getString("LastName"));
            v.setEmail(rs.getString("Email"));
            v.setContactNumber(rs.getString("ContactNumber"));
            v.setRoomNumber(rs.getString("RoomNumber")); // ✅
            v.setCheckIn(rs.getTimestamp("CheckIn"));
            v.setCheckOut(rs.getTimestamp("CheckOut"));
            v.setTotalNights(rs.getInt("TotalNights"));
            v.setTotalPrice(rs.getBigDecimal("TotalPrice"));
            v.setServiceStatus(rs.getString("ServiceStatus"));

            list.add(v);
        }

        rs.close();
        cs.close();
        return list;
    }

    public Reservation getReservationById(int reservationId) throws SQLException {
        String sql = "SELECT * FROM Reservation WHERE ReservationId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, reservationId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Reservation res = new Reservation();
            res.setReservationId(rs.getInt("ReservationId"));
            res.setGuestId(rs.getInt("GuestId"));
            res.setRoomId(rs.getInt("RoomId"));
            res.setCheckIn(rs.getTimestamp("CheckIn").toLocalDateTime());
            res.setCheckOut(rs.getTimestamp("CheckOut").toLocalDateTime());
            res.setTotalNights(rs.getInt("TotalNights"));
            res.setTotalPrice(rs.getBigDecimal("TotalPrice"));
            res.setServiceStatus(rs.getString("ServiceStatus"));
            return res;
        }
        return null;
    }


    public List<RoomDetails> getAllRooms() throws SQLException {
        List<RoomDetails> list = new ArrayList<>();
        String sql = "SELECT RoomId, RoomName, RoomNumber FROM RoomDetails WHERE RoomAvailabilityStatus = 'Available'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            RoomDetails room = new RoomDetails();
            room.setRoomId(rs.getInt("RoomId"));
            room.setRoomName(rs.getString("RoomName"));
            room.setRoomNumber(rs.getString("RoomNumber"));
            list.add(room);
        }
        return list;
    }

    // Update reservation including room
    public void updateReservation(Reservation res) throws SQLException {
        CallableStatement cs = conn.prepareCall("{call sp_UpdateReservation(?,?,?,?,?,?,?)}");
        cs.setInt(1, res.getReservationId());
        cs.setTimestamp(2, Timestamp.valueOf(res.getCheckIn()));
        cs.setTimestamp(3, Timestamp.valueOf(res.getCheckOut()));
        cs.setInt(4, res.getTotalNights());
        cs.setBigDecimal(5, res.getTotalPrice());
        cs.setString(6, res.getServiceStatus());
        cs.setInt(7, res.getRoomId());
        cs.execute();
    }

}
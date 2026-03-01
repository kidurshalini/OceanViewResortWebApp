package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.Reservation;
import java.sql.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

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


}
package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;
import com.oceanviewresortapp.util.DB_Connection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Currency;
import java.util.List;

public class RoomDetailsDAOImpl implements RoomDetailsDAO {

    public void insert(RoomDetails room, RoomPriceDetails price) throws Exception {
        try (Connection con = DB_Connection.getConnection();
             CallableStatement cs = con.prepareCall("{call sp_InsertRoom(?, ?, ?, ?, ?, ?)}")) {
            CallableStatement cs1 = con.prepareCall("{call sp_InsertRoomPriceDetails(?, ?, ?)}");

            cs.setString(1, room.getRoomType());
            cs.setString(2, room.getRoomNumber());
            cs.setString(3, room.getRoomDescription());
            cs.setString(4, room.getRoomName());
            cs.setString(5, room.getRoomAvailabilityStatus());
            cs.setInt(6, room.getRoomCapacity());
            cs1.setInt(1, price.getRoomPriceDetailsId());
            cs1.setString(2, price.getCurrency());
            cs1.setInt(3, price.getPerNightPrice());


            cs.executeUpdate();
            cs1.executeUpdate();
            System.out.println("Room Details and price inserted successfully!");
        }
    }

    public List<RoomDetails> getAll() throws Exception {
        List<RoomDetails> list = new ArrayList<>();
        try (Connection con = DB_Connection.getConnection();
             CallableStatement cs = con.prepareCall("{call sp_GetAllRooms}");
             ResultSet rs = cs.executeQuery()) {

            while (rs.next()) {
                RoomDetails room = new RoomDetails(
                        rs.getString("RoomType"),
                        rs.getString("RoomNumber"),
                        rs.getString("RoomDescription"),
                        rs.getString("RoomName"),
                        rs.getString("RoomAvailabilityStatus"),
                        rs.getInt("RoomCapacity")
                );
                room.setRoomId(rs.getInt("RoomId"));
                list.add(room);
            }
        }
        return list;
    }

    @Override
    public RoomDetails getById(int id) throws Exception {
        return null;
    }

    public void update(RoomDetails room) throws Exception {
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_UpdateRoomDetails(?,?,?,?,?,?,?)}");

        cs.setInt(1, room.getRoomId());
        cs.setString(2, room.getRoomType());
        cs.setString(3, room.getRoomNumber());
        cs.setString(4, room.getRoomDescription());
        cs.setString(5, room.getRoomName());
        cs.setString(6, room.getRoomAvailabilityStatus());
        cs.setInt(7, room.getRoomCapacity());

        cs.executeUpdate();

        cs.close();
        con.close();
    }
    public void delete(int roomId) throws Exception {
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_DeleteRoom(?)}");
        cs.setInt(1, roomId);
        cs.execute();
        con.close();
    }
    public RoomDetails getRoomDetailsById(int roomId) throws Exception {
        Connection con = DB_Connection.getConnection();
        if (con == null) {
            throw new RuntimeException("DB Connection failed");
        }

        CallableStatement cs = con.prepareCall("{call sp_GetRoomDetailsById(?)}");
        cs.setInt(1, roomId);
        ResultSet rs = cs.executeQuery();
        RoomDetails room = new RoomDetails();
        if(rs.next()) {

            room.setRoomId(rs.getInt("RoomId"));
            room.setRoomType(rs.getString("RoomType"));
            room.setRoomNumber(rs.getString("RoomNumber"));
            room.setRoomDescription(rs.getString("RoomDescription"));
            room.setRoomName(rs.getString("RoomName"));
            room.setRoomAvailabilityStatus(rs.getString("RoomAvailabilityStatus"));
            room.setRoomCapacity(rs.getInt("RoomCapacity"));
        }

        con.close();
        return room;
    }
}
package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.util.DB_Connection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomDetailsDAOImpl {

    public void insert(RoomDetails room) throws Exception {
        try (Connection con = DB_Connection.getConnection();
             CallableStatement cs = con.prepareCall("{call sp_InsertRoom(?, ?, ?, ?, ?, ?)}")) {

            cs.setString(1, room.getRoomType());
            cs.setString(2, room.getRoomNumber());
            cs.setString(3, room.getRoomDescription());
            cs.setString(4, room.getRoomName());
            cs.setString(5, room.getRoomAvailabilityStatus());
            cs.setInt(6, room.getRoomCapacity());

            cs.executeUpdate();
            System.out.println("Room inserted successfully!");
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
}
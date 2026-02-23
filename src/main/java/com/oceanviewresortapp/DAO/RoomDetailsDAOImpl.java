package com.oceanviewresortapp.DAO;
import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.util.DB_Connection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDetailsDAOImpl implements RoomDetailsDAO {


    @Override
    public void insert(RoomDetails room) throws Exception {
        Connection con = DB_Connection.getConnection();

        if (con == null) {
            System.out.println("DB_Connection not successful!");

        }else{
            System.out.println("DB_Connection successful!");

        }
        // Call the updated stored procedure with 6 parameters
        CallableStatement cs = con.prepareCall("{call sp_InsertRoom(?, ?, ?, ?, ?, ?)}");

        cs.setString(1, room.getRoomType());
        cs.setString(2, room.getRoomNumber());
        cs.setString(3, room.getRoomDescription());
        cs.setString(4, room.getRoomName());
        cs.setString(5, room.getRoomAvailabilityStatus());
        cs.setInt(6, room.getRoomCapacity());

        cs.execute();
        cs.close();
        con.close();
    }

    @Override
    public List<RoomDetails> getAll() throws Exception {

        List<RoomDetails> list = new ArrayList<>();
        Connection con = DB_Connection.getConnection();

        CallableStatement cs = con.prepareCall("{call sp_GetAllRooms}");
        ResultSet rs = cs.executeQuery();

        while (rs.next()) {
            RoomDetails room = new RoomDetails();
            room.setRoomId(rs.getInt("RoomId"));
            room.setRoomType(rs.getString("RoomType"));
            room.setRoomNumber(rs.getString("RoomNumber"));

            list.add(room);
        }

        con.close();
        return list;
    }
}

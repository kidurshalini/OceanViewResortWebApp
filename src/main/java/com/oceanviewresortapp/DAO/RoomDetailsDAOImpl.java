package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;
import com.oceanviewresortapp.util.DB_Connection;
import java.util.Arrays;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Currency;
import java.util.List;

public class RoomDetailsDAOImpl implements RoomDetailsDAO {

    //insert room and price details
    public void insert(RoomDetails room, RoomPriceDetails price) throws Exception {
        // get connection
        try (Connection con = DB_Connection.getConnection()) {
            // disable auto-commit for transaction
            con.setAutoCommit(false);

            try (
                    CallableStatement csRoom = con.prepareCall("{call sp_InsertRoom(?, ?, ?, ?, ?, ?, ?)}");
                    CallableStatement csPrice = con.prepareCall("{call sp_InsertRoomPriceDetails(?, ?, ?)}")
            ) {

                // --- Insert RoomDetails ---
                csRoom.setString(1, room.getRoomType());
                csRoom.setString(2, room.getRoomNumber());
                csRoom.setString(3, room.getRoomDescription());
                csRoom.setString(4, room.getRoomName());
                csRoom.setString(5, room.getRoomAvailabilityStatus());
                csRoom.setInt(6, room.getRoomCapacity());
                csRoom.registerOutParameter(7, java.sql.Types.INTEGER); // output RoomDetailsId

                csRoom.executeUpdate();

                // get generated RoomDetailsId
                int roomDetailsId = csRoom.getInt(7);
                room.setRoomId(roomDetailsId);
                price.setRoomDetailsId(roomDetailsId);

                // --- Insert RoomPriceDetails ---
                csPrice.setInt(1, price.getRoomDetailsId());
                csPrice.setString(2, price.getCurrency());
                csPrice.setBigDecimal(3, price.getPerNightPrice());

                csPrice.executeUpdate();
                System.out.println("Inserting Room: " + room.getRoomType() + ", " + room.getRoomNumber());
                System.out.println("Inserting Price: " + price.getCurrency() + ", " + price.getPerNightPrice());
                System.out.println("RoomDetailsId = " + room.getRoomId());

                con.commit();
                System.out.println("Room and Price inserted successfully!");
            } catch (Exception e) {
                con.rollback();
                throw e;
            }
        }
    }

    public List<RoomDetails> getAll() throws Exception {
        List<RoomDetails> list = new ArrayList<>();
        try (Connection con = DB_Connection.getConnection();
             CallableStatement cs = con.prepareCall("{call sp_GetAllRooms}");
             CallableStatement cs1 = con.prepareCall("{call sp_GetAllRoomPrice}");
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
        try {
            con.setAutoCommit(false);

            // Update room
            CallableStatement csRoom = con.prepareCall("{call sp_UpdateRoomDetails(?,?,?,?,?,?,?)}");
            csRoom.setString(1, room.getRoomType());
            csRoom.setString(2, room.getRoomNumber());
            csRoom.setString(3, room.getRoomDescription());
            csRoom.setString(4, room.getRoomName());
            csRoom.setString(5, room.getRoomAvailabilityStatus());
            csRoom.setInt(6, room.getRoomCapacity());
            csRoom.setInt(7, room.getRoomId()); // for update

            csRoom.executeUpdate();


            con.commit();
            System.out.println("Room and Price updated successfully!");
        } catch (Exception e) {
            con.rollback();
            throw e;
        } finally {
            con.close();
        }
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
        CallableStatement cs = con.prepareCall("{call sp_GetRoomDetailsById(?)}");
        cs.setInt(1, roomId);

        ResultSet rs = cs.executeQuery();

        RoomDetails room = null;
        List<RoomPriceDetails> priceList = new ArrayList<>(); // list to hold all prices

        while (rs.next()) { // use while in case there are multiple price rows
            if (room == null) {
                // Set room details only once
                room = new RoomDetails();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomDescription(rs.getString("RoomDescription"));
                room.setRoomName(rs.getString("RoomName"));
                room.setRoomAvailabilityStatus(rs.getString("RoomAvailabilityStatus"));
                room.setRoomCapacity(rs.getInt("RoomCapacity"));
            }


        }


        rs.close();
        cs.close();
        con.close();

        return room;
    }
}
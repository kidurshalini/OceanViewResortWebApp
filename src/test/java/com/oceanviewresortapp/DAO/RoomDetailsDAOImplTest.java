package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.RoomDetails;
import com.oceanviewresortapp.model.RoomPriceDetails;
import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import static org.junit.jupiter.api.Assertions.*;

public class RoomDetailsDAOImplTest {

    @Test
    void testInsertRoomAndPrice() throws Exception {
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        RoomDetails room = new RoomDetails("Deluxe","D102","Sea view","Ocean Deluxe","Available",2);
        RoomPriceDetails price = new RoomPriceDetails("USD", new BigDecimal("150.00"));

        dao.insert(room, price);

        assertTrue(room.getRoomId() > 0, "Room ID should be generated");

        RoomPriceDetails fetchedPrice = dao.getPriceByRoomId(room.getRoomId());
        assertNotNull(fetchedPrice);
        assertEquals(price.getPricePerNight(), fetchedPrice.getPricePerNight());
    }

    @Test
    void testGetAllRooms() throws Exception {
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
        List<RoomDetails> rooms = dao.getAll();
        assertNotNull(rooms);
        rooms.forEach(r -> System.out.println(r.getRoomName() + " (" + r.getRoomType() + ")"));
    }



    @Test
    void testDeleteRoom() throws Exception {
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();

        // Insert test room first
        RoomDetails room = new RoomDetails("Test","T999","Test Room","DeleteMe","Available",1);
        RoomPriceDetails price = new RoomPriceDetails("USD", new BigDecimal("50"));
        dao.insert(room, price);

        dao.delete(room.getRoomId());
        RoomDetails deletedRoom = dao.getRoomDetailsById(room.getRoomId());
        assertNull(deletedRoom);
    }

    @Test
    void testGetMonthlyBookings() {
        RoomDetailsDAOImpl dao = new RoomDetailsDAOImpl();
        Map<String,Integer> map = dao.getMonthlyBookingsByRoomType();
        assertNotNull(map);
        map.forEach((type,count) -> System.out.println(type + " => " + count));
    }
}
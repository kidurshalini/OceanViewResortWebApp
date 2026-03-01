package com.oceanviewresortapp.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Reservation {
    private int ReservationId;
    private int GuestId;
    private int RoomId;

    private LocalDateTime CheckIn;
    private LocalDateTime CheckOut;
    private int TotalNights;
    private BigDecimal TotalPrice;
    private String ServiceStatus;
    private LocalDateTime CreatedOn;

    public Reservation (){
    }
   public Reservation(int ReservationId, int GuestId, int RoomId, LocalDateTime CheckIn, LocalDateTime CheckOut, int TotalNights,
                      BigDecimal TotalPrice, String ServiceStatus, LocalDateTime CreatedOn) {
        this.ReservationId = ReservationId;
        this.GuestId = GuestId;
        this.RoomId = RoomId;
        this.CheckIn = CheckIn;
        this.CheckOut = CheckOut;
        this.TotalNights = TotalNights;
        this.TotalPrice = TotalPrice;
        this.ServiceStatus = ServiceStatus;
        this.CreatedOn = CreatedOn;
   }

    public Reservation(int GuestId, int RoomId, LocalDateTime CheckIn, LocalDateTime CheckOut, int TotalNights,
                       BigDecimal TotalPrice, String ServiceStatus, LocalDateTime CreatedOn) {

        this.GuestId = GuestId;
        this.RoomId = RoomId;
        this.CheckIn = CheckIn;
        this.CheckOut = CheckOut;
        this.TotalNights = TotalNights;
        this.TotalPrice = TotalPrice;
        this.ServiceStatus = ServiceStatus;
        this.CreatedOn = CreatedOn;
    }

    public int getReservationId() {
        return ReservationId;
    }
    public void setReservationId(int reservationId) {
        ReservationId = reservationId;

    }
    public int getGuestId() {
        return GuestId;

    }
    public void setGuestId(int guestId) {
        GuestId = guestId;

    }
    public int getRoomId() {
        return RoomId;
    }
    public void setRoomId(int roomId) {
        RoomId = roomId;
    }
    public LocalDateTime getCheckIn() {
        return CheckIn;
    }
    public void setCheckIn(LocalDateTime checkIn) {
        CheckIn = checkIn;

    }
    public LocalDateTime getCheckOut() {
        return CheckOut;
    }
    public void setCheckOut(LocalDateTime checkOut) {
        CheckOut = checkOut;
    }
    public int getTotalNights() {
        return TotalNights;
    }
    public void setTotalNights(int totalNights) {
        TotalNights = totalNights;
    }
    public BigDecimal getTotalPrice() {
        return TotalPrice;
    }
    public void setTotalPrice(BigDecimal totalPrice) {
        TotalPrice = totalPrice;
    }
    public String getServiceStatus() {
        return ServiceStatus;
    }
    public void setServiceStatus(String serviceStatus) {
        ServiceStatus = serviceStatus;
    }
    public LocalDateTime getCreatedOn() {
        return CreatedOn;
    }
    public void setCreatedOn(LocalDateTime createdOn) {
        CreatedOn = createdOn;
    }

}

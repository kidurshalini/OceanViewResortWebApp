package com.oceanviewresortapp.model;

public class RoomPriceDetails {

    private int RoomPriceDetailsId;
    private int roomDetailsId;
    private String Currency;
    private int PerNightPrice;

//    default Constructor
    public RoomPriceDetails() {
    }

//    constructor with id
    public RoomPriceDetails(int RoomPriceDetailsId, int roomId, String Currency, int PerNightPrice) {
        this.RoomPriceDetailsId = RoomPriceDetailsId;
        this.roomDetailsId = roomId;
        this.Currency = Currency;
        this.PerNightPrice = PerNightPrice;

    }

    //   constructor without id
    public RoomPriceDetails(int roomDetailsId, String Currency, int PerNightPrice) {
        this.RoomPriceDetailsId = RoomPriceDetailsId;
        this.roomDetailsId = roomDetailsId;
        this.Currency = Currency;
        this.PerNightPrice = PerNightPrice;
    }

    //getters and setters
    public int getRoomPriceDetailsId() {
        return RoomPriceDetailsId;
    }

    public void setRoomPriceDetailsId(int RoomPriceDetailsId) {
        this.RoomPriceDetailsId = RoomPriceDetailsId;
    }

    public int getRoomDetailsId() {
        return roomDetailsId;
    }
    public void setRoomDetailsId(int roomDetailsId) {
        this.roomDetailsId = roomDetailsId;
    }
    public String getCurrency() {
        return Currency;
    }
    public void setCurrency(String Currency) {
        this.Currency = Currency;
    }
    public int getPerNightPrice() {
        return PerNightPrice;
    }
    public void setPerNightPrice(int PerNightPrice) {
        this.PerNightPrice = PerNightPrice;
    }



}

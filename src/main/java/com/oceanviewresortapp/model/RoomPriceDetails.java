package com.oceanviewresortapp.model;

import java.math.BigDecimal;

public class RoomPriceDetails {

    private int RoomPriceDetailsId;
    private int roomDetailsId;
    private String Currency;
    private BigDecimal PricePerNight;

//    default Constructor
    public RoomPriceDetails() {
    }

//    constructor with id
    public RoomPriceDetails(int RoomPriceDetailsId, int roomDetailsId, String Currency, BigDecimal PricePerNight) {
        this.RoomPriceDetailsId = RoomPriceDetailsId;
        this.roomDetailsId = roomDetailsId;
        this.Currency = Currency;
        this.PricePerNight = PricePerNight;

    }

    //   constructor without id
    public RoomPriceDetails(String Currency, BigDecimal PricePerNight) {
        this.Currency = Currency;
        this.PricePerNight = PricePerNight;
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
    public BigDecimal getPricePerNight() {
        return PricePerNight;
    }
    public void setPricePerNight(BigDecimal PricePerNight) {
        this.PricePerNight = PricePerNight;
    }




}

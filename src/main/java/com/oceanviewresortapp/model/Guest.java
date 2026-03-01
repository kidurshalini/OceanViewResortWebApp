package com.oceanviewresortapp.model;

import java.util.Date;

public class Guest {

    private int GuestId;
    private String FirstName;
    private String LastName;
    private String Email;
    private String ContactNumber;
    private String GuestIdNo;
    private Date BirthOfDate;
    private String Address;

    public Guest() {
    }

   public Guest(int GuestId, String FirstName, String LastName, String Email, String ContactNumber,
                String GuestIdNo, Date BirthOfDate, String Address) {
        this.GuestId = GuestId;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Email = Email;
        this.ContactNumber = ContactNumber;
        this.GuestIdNo = GuestIdNo;
        this.BirthOfDate = BirthOfDate;
        this.Address = Address;

   }
    public Guest(String FirstName, String LastName, String Email, String ContactNumber,
                 String GuestIdNo, Date BirthOfDate, String Address) {

        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Email = Email;
        this.ContactNumber = ContactNumber;
        this.GuestIdNo = GuestIdNo;
        this.BirthOfDate = BirthOfDate;
        this.Address = Address;
    }

    public int getGuestId() {
        return GuestId;
    }

    public void setGuestId(int GuestId) {
        this.GuestId = GuestId;
    }
    public String getFirstName() {
        return FirstName;
    }
    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }
    public String getLastName() {
        return LastName;
    }
    public void setLastName(String LastName) {
        this.LastName = LastName;
    }
    public String getEmail() {
        return Email;
    }
    public void setEmail(String Email) {
        this.Email = Email;
    }
    public String getContactNumber() {
        return ContactNumber;
    }
    public void setContactNumber(String ContactNumber) {
        this.ContactNumber = ContactNumber;
    }
    public String getGuestIdNo() {
        return GuestIdNo;
    }
    public void setGuestIdNo(String GuestIdNo) {
        this.GuestIdNo = GuestIdNo;
    }
    public Date getBirthOfDate() {
        return BirthOfDate;
    }
    public void setBirthOfDate(Date BirthOfDate) {
        this.BirthOfDate = BirthOfDate;
    }
    public String getAddress() {
        return Address;
    }
    public void setAddress(String Address) {
        this.Address = Address;
    }
}

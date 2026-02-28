package com.oceanviewresortapp.model;

public class User
{
    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private boolean isActive;
    private String Contact;
    private String IdNumber;
    //defult constractor
    public User() {
    }

    // constractor  with id
    public User(int userId, String fullName, String email, String password, String role,
                boolean isActive,String Contact,  String IdNumber) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.isActive = isActive;
        this.Contact = Contact;
        this.IdNumber = IdNumber;

    }

    // constractor  without id
    public User(String fullName, String email, String password, String role,
                boolean isActive,String Contact,  String IdNumber) {

        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.isActive = isActive;
        this.Contact = Contact;
        this.IdNumber = IdNumber;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    public boolean isIsActive() {
        return isActive;
    }
    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getContact() {
        return Contact;
    }
    public void setContact(String contact) {
        Contact = contact;
    }

    public String getIdNumber() {
        return IdNumber;
    }
    public void setIdNumber(String idNumber) {
        IdNumber = idNumber;
    }

}

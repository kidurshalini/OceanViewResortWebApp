package com.oceanviewresortapp.model;
import java.time.LocalDateTime;

public class RoomDetails {

        private int roomId;                       // RoomId in DB
        private String roomType;                  // RoomType
        private String roomNumber;                // RoomNumber
        private String roomDescription;           // RoomDescription
        private String roomName;                  // RoomName
        private String roomAvailabilityStatus;   // RoomAvailablityStatus
        private int roomCapacity;                 // RoomCapacity
        private LocalDateTime createdOn;          // CreatedOn
        private LocalDateTime modifiedOn;         // ModifiedOn

        // Default constructor
        public RoomDetails() {}

        // Constructor without ID (for creating new rooms)
        public RoomDetails(String roomType, String roomNumber, String roomDescription,
                           String roomName,String roomAvailabilityStatus, int roomCapacity) {
            this.roomType = roomType;
            this.roomNumber = roomNumber;
            this.roomDescription = roomDescription;
            this.roomName = roomName;
            this.roomAvailabilityStatus = roomAvailabilityStatus;
            this.roomCapacity = roomCapacity;
        }

        // Full constructor (with ID)
        public RoomDetails(int roomId, String roomType, String roomNumber, String roomDescription, String roomName,
                           String roomAvailabilityStatus, int roomCapacity, LocalDateTime createdOn, LocalDateTime modifiedOn) {
            this.roomId = roomId;
            this.roomType = roomType;
            this.roomNumber = roomNumber;
            this.roomDescription = roomDescription;
            this.roomName = roomName;
            this.roomAvailabilityStatus = roomAvailabilityStatus;
            this.roomCapacity = roomCapacity;
            this.createdOn = createdOn;
            this.modifiedOn = modifiedOn;
        }

        // Getters and Setters
        public int getRoomId() {
            return roomId;
        }

        public void setRoomId(int roomId) {
            this.roomId = roomId;
        }

        public String getRoomType() {
            return roomType;
        }

        public void setRoomType(String roomType) {
            this.roomType = roomType;
        }

        public String getRoomNumber() {
            return roomNumber;
        }

        public void setRoomNumber(String roomNumber) {
            this.roomNumber = roomNumber;
        }

        public String getRoomDescription() {
            return roomDescription;
        }

        public void setRoomDescription(String roomDescription) {
            this.roomDescription = roomDescription;
        }

        public String getRoomName() {
            return roomName;
        }

        public void setRoomName(String roomName) {
            this.roomName = roomName;
        }

        public String getRoomAvailabilityStatus() {
            return roomAvailabilityStatus;
        }

        public void setRoomAvailabilityStatus(String roomAvailabilityStatus) {
            this.roomAvailabilityStatus = roomAvailabilityStatus;
        }

        public int getRoomCapacity() {
            return roomCapacity;
        }

        public void setRoomCapacity(int roomCapacity) {
            this.roomCapacity = roomCapacity;
        }

        public LocalDateTime getCreatedOn() {
            return createdOn;
        }

        public void setCreatedOn(LocalDateTime createdOn) {
            this.createdOn = createdOn;
        }

        public LocalDateTime getModifiedOn() {
            return modifiedOn;
        }

        public void setModifiedOn(LocalDateTime modifiedOn) {
            this.modifiedOn = modifiedOn;
        }

    }


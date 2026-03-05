package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.User;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class UserDAOImplTest1 {

    private UserDAOImpl dao;

    @BeforeEach
    void init() {
        dao = new UserDAOImpl();
    }

    @Test
    void testValidateUser_Success() {
        assertTrue(dao.validateUser("admin@gmail.com", "Shan@2001"),
                "Valid admin credentials should return true");
    }

    @Test
    void testValidateUser_Failure_WrongPassword() {
        assertFalse(dao.validateUser("admin@gmail.com", "wrongPass"),
                "Invalid password should return false");
    }

    @Test
    void testValidateUser_Failure_WrongEmail() {
        assertFalse(dao.validateUser("user@gmail.com", "Shan@2001"),
                "Invalid email should return false");
    }

    @Test
    void testValidateUser_NullInput() {
        assertFalse(dao.validateUser(null, null),
                "Null email and password should return false");
    }


    @Test
    void testAuthenticateUser_Invalid() throws Exception {
        User user = dao.authenticateUser("wrong@gmail.com", "wrongPass");
        assertNull(user, "Invalid credentials should return null");
    }

    @Test
    void testGetAllUsers() throws Exception {
        List<User> users = dao.getAll();
        assertNotNull(users, "User list should not be null");
        assertTrue(users.size() >= 1, "There should be at least one user");
    }

    @Test
    void testGetUserById() throws Exception {
        User user = dao.getById(7);
        assertNotNull(user, "User with ID 1 should exist");
    }
}
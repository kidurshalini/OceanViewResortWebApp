package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.User;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class UserDAOImplTest {

    @Test
    void testValidateUser_Success() {
        UserDAOImpl dao = new UserDAOImpl();

        // Form requires alphanumeric + special character password
        boolean result = dao.validateUser("admin@gmail.com", "Shan@2001");

        assertTrue(result, "Valid admin credentials should return true");
    }

    @Test
    void testValidateUser_Failure_WrongPassword() {
        UserDAOImpl dao = new UserDAOImpl();

        boolean result = dao.validateUser("admin@gmail.com", "wrongPass!");

        assertFalse(result, "Invalid password should return false");
    }

    @Test
    void testValidateUser_Failure_WrongEmail() {
        UserDAOImpl dao = new UserDAOImpl();

        boolean result = dao.validateUser("user@gmail.com", "shan@2001");

        assertFalse(result, "Invalid email should return false");
    }

    @Test
    void testValidateUser_NullInput() {
        UserDAOImpl dao = new UserDAOImpl();

        boolean result = dao.validateUser(null, null);
        assertFalse(result, "Null email and password should return false");
    }

    @Test
    void testValidateUser_PartialNull() {
        UserDAOImpl dao = new UserDAOImpl();

        // Email is null
        boolean result1 = dao.validateUser(null, "shan@2001");
        assertFalse(result1, "Null email should return false");

        // Password is null
        boolean result2 = dao.validateUser("admin@gmail.com", null);
        assertFalse(result2, "Null password should return false");
    }



    @Test
    void testAuthenticateUser_ValidUser() throws Exception {
        UserDAOImpl dao = new UserDAOImpl();


        String email = "kidurshalini1026@gmail.com";
        String password = "jack@1996";

        User user = dao.authenticateUser(email, password);

        assertNotNull(user, "User should not be null for valid credentials");
        assertEquals("ADMIN", user.getRole(), "Role should be ADMIN");
    }

    @Test
    void testAuthenticateUser_InvalidUser() throws Exception {
        UserDAOImpl dao = new UserDAOImpl();

        String email = "wrong@gmail.com";
        String password = "wrongPass!";

        User user = dao.authenticateUser(email, password);

        assertNull(user, "Invalid user should return null");
    }

    @Test
    void testAuthenticateUser_NullInput() throws Exception {
        UserDAOImpl dao = new UserDAOImpl();

        User user = dao.authenticateUser(null, null);

        assertNull(user, "Null input should return null");
    }
}
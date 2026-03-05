package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.UserDAOImpl;
import com.oceanviewresortapp.model.User;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import javax.servlet.http.*;

import static org.mockito.Mockito.*;

public class LoginServletTest {

    @Test
    void testDoPost_InvalidLogin() throws Exception {

        LoginServlet servlet = new LoginServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("email")).thenReturn("wrong@gmail.com");
        when(request.getParameter("password")).thenReturn("wrong");

        servlet.doPost(request, response);

        verify(response).sendRedirect("Login.jsp?msg=Invalid email or password / inactive user");
    }
}
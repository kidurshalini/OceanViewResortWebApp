package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.DAO.UserDAOImpl;
import com.oceanviewresortapp.model.User;
import org.junit.jupiter.api.Test;

import javax.servlet.http.*;

import static org.mockito.Mockito.*;

public class UserServletTest {

    @Test
    void testDoPost_AddUser() throws Exception {
        UserServlet servlet = new UserServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("action")).thenReturn("add");
        when(request.getParameter("fullName")).thenReturn("John Doe");
        when(request.getParameter("email")).thenReturn("john@example.com");
        when(request.getParameter("password")).thenReturn("Test@123");
        when(request.getParameter("role")).thenReturn("USER");
        when(request.getParameter("isActive")).thenReturn("on");
        when(request.getParameter("countryCode")).thenReturn("+1");
        when(request.getParameter("contact")).thenReturn("9876543210");
        when(request.getParameter("idnumber")).thenReturn("ID001");

        servlet.doPost(request, response);

        verify(response).sendRedirect("ViewUser.jsp?msg=User added successfully!");
    }

    @Test
    void testDoPost_UpdateUser() throws Exception {
        UserServlet servlet = new UserServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("action")).thenReturn("update");
        when(request.getParameter("userId")).thenReturn("1");
        when(request.getParameter("fullName")).thenReturn("John Updated");
        when(request.getParameter("email")).thenReturn("john@example.com");
        when(request.getParameter("password")).thenReturn("Test@123");
        when(request.getParameter("role")).thenReturn("USER");
        when(request.getParameter("isActive")).thenReturn("on");
        when(request.getParameter("contact")).thenReturn("+19876543210");
        when(request.getParameter("idnumber")).thenReturn("ID001");

        servlet.doPost(request, response);

        verify(response).sendRedirect("ViewUser.jsp?msg=User updated successfully!");
    }

    @Test
    void testDoPost_DeleteUser() throws Exception {
        UserServlet servlet = new UserServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("action")).thenReturn("delete");
        when(request.getParameter("userId")).thenReturn("1");

        servlet.doPost(request, response);

        verify(response).sendRedirect("ViewUser.jsp?msg=User deleted successfully!");
    }

    @Test
    void testDoPost_InvalidAction() throws Exception {
        UserServlet servlet = new UserServlet();

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getParameter("action")).thenReturn("invalidAction");

        servlet.doPost(request, response);

        verify(response).sendRedirect("ViewUser.jsp?msg=Invalid action!");
    }
}
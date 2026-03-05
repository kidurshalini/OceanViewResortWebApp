package com.oceanviewresortapp.controller;

import com.oceanviewresortapp.controller.BookRoomServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestableBookRoomServlet extends BookRoomServlet {
    public void publicDoGet(HttpServletRequest req, HttpServletResponse res) throws Exception {
        super.doGet(req, res);
    }

    public void publicDoPost(HttpServletRequest req, HttpServletResponse res) throws Exception {
        super.doPost(req, res);
    }
}
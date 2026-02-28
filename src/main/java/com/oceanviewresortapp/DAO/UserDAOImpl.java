package com.oceanviewresortapp.DAO;

import com.oceanviewresortapp.model.User;
import com.oceanviewresortapp.util.DB_Connection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements GenericDAO<User> {

    @Override
    public void insert(User user) throws Exception {
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_InsertUser(?,?,?,?,?,?,?)}");

        cs.setString(1, user.getFullName());
        cs.setString(2, user.getEmail());
        cs.setString(3, user.getPassword());
        cs.setString(4, user.getRole());
        cs.setBoolean(5, user.isIsActive());
        cs.setString(6,user.getContact());
        cs.setString(7,user.getIdNumber());
        cs.execute();
        con.close();
    }

    @Override
    public void update(User user) throws Exception {
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_UpdateUser(?,?,?,?,?,?,?)}");

        cs.setInt(1, user.getUserId());
        cs.setString(2, user.getFullName());
        cs.setString(3, user.getEmail());
        cs.setString(4, user.getPassword());
        cs.setString(5, user.getRole());
        cs.setBoolean(6, user.isIsActive());
        cs.setString(7, user.getContact());
        cs.setString(8,user.getIdNumber());
        cs.execute();
        con.close();
    }

    @Override
    public void delete(int id) throws Exception {
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_DeleteUser(?)}");

        cs.setInt(1, id);
        cs.execute();
        con.close();
    }

    @Override
    public List<User> getAll() throws Exception {
        List<User> users = new ArrayList<>();
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_GetAllUsers()}");

        ResultSet rs = cs.executeQuery();

        while (rs.next()) {
            User user = new User(
                    rs.getInt("UserId"),
                    rs.getString("FullName"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("Role"),
                    rs.getBoolean("IsActive"),
                    rs.getString("contact"),
                    rs.getString("idNumber")
            );
            users.add(user);
        }
        con.close();
        return users;
    }

    @Override
    public User getById(int id) throws Exception {
        User user = null;
        Connection con = DB_Connection.getConnection();
        CallableStatement cs = con.prepareCall("{call sp_GetUserById(?)}");

        cs.setInt(1, id);
        ResultSet rs = cs.executeQuery();

        if (rs.next()) {
            user = new User(
                    rs.getInt("UserId"),
                    rs.getString("FullName"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("Role"),
                    rs.getBoolean("IsActive"),
                    rs.getString("contact"),
                    rs.getString("idNumber")
            );
        }
        con.close();
        return user;
    }
}
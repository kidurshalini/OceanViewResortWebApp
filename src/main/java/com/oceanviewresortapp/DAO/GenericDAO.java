package com.oceanviewresortapp.DAO;

import java.util.List;

public interface GenericDAO<T, U>{

    void insert(T obj, U obj1) throws Exception;

    void update(T obj) throws Exception;

    void delete(int id) throws Exception;

    List<T> getAll() throws Exception;

    T getById(int id) throws Exception;
}

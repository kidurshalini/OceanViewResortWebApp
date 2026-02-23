package com.oceanviewresortapp.DAO;

import java.util.List;

public interface GenericDAO<T>{

        void insert(T t) throws Exception;
    List<T> getAll() throws Exception;
}

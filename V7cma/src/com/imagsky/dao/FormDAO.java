package com.imagsky.dao;

import java.util.List;

import com.imagsky.exception.BaseDBException;

public abstract class FormDAO extends AbstractV7DAO {

	    public static FormDAO getInstance() {
	        return FormDAOImpl.getInstance();
	    }
}

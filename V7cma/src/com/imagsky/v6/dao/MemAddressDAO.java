package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;
import java.util.ArrayList;
import java.util.List;

public abstract class MemAddressDAO extends AbstractDbDAO{

	public static MemAddressDAO getInstance() {
		return MemAddressDAOImpl.getInstance();
	}
	
	public abstract List<Object> findListWithSample(Object obj) throws BaseDBException;

	public abstract List<Object> findListWithSample(Object obj, ArrayList orderByPair)
			throws BaseDBException;

}

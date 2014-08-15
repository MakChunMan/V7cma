package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.OrderSet;
import com.imagsky.v6.domain.SellItem;

public abstract class WithdrawnRequestDAO extends AbstractDbDAO{

	public static WithdrawnRequestDAO getInstance() {
		return WithdrawnRequestDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(OrderSet obj, ArrayList orderByPair) throws BaseDBException;
	
	public abstract List<Object> findListWithSample(OrderSet obj) throws BaseDBException;

}

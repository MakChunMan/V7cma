package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.OrderSet;
import com.imagsky.v6.domain.SellItem;

public abstract class OrderSetDAO extends AbstractDbDAO{

	public static OrderSetDAO getInstance() {
		return OrderSetDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(OrderSet obj, ArrayList orderByPair) throws BaseDBException;
	
	public abstract List<Object> findListWithSample(OrderSet obj) throws BaseDBException;
	
	public abstract List<Object> findListWithSampleWithoutFeedback(OrderSet obj, ArrayList orderByPair) throws BaseDBException;
	
}

package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.BulkOrderItem;
import java.util.List;

public abstract class BulkOrderDAO extends AbstractDbDAO{

	public static BulkOrderDAO getInstance() {
		return BulkOrderDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(BulkOrderItem obj) throws BaseDBException;
	
	public abstract List<Object> findAll(boolean onlineOnly, boolean refresh) throws BaseDBException;
	
	//public abstract boolean delete(Object obj, String sellitemId) throws BaseDBException;

	public abstract boolean updateCurrentQty(Object obj) throws BaseDBException ;

	//public abstract boolean updateItem(BulkOrder obj) throws BaseDBException;
}

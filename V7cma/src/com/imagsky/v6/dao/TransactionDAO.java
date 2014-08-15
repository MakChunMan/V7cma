package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Transaction;

public abstract class TransactionDAO extends AbstractDbDAO{

	public static TransactionDAO getInstance() {
		return TransactionDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(Transaction obj, ArrayList orderByPair) throws BaseDBException;
	
	public abstract List<Object> findListWithSample(Transaction obj) throws BaseDBException;
	
	public abstract List<Object> findListWithSample(Transaction obj, ArrayList orderByPair,
			boolean isLive) throws BaseDBException;

	public abstract List<Object> findListWithinDays(String ownerGuid, int numOfDaysBefore) throws BaseDBException;
}

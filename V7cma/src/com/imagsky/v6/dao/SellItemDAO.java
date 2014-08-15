package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.SellItem;

public abstract class SellItemDAO extends AbstractDbDAO{

	public static SellItemDAO getInstance() {
		return SellItemDAOImpl.getInstance();
	}

	public abstract List<Object>  findListWithSample(SellItem obj, ArrayList orderByPair) throws BaseDBException;
	
	public abstract List<Object> findListWithSample(SellItem obj) throws BaseDBException;
	
	public abstract int updatePriority(String[] guids) throws BaseDBException;

	public abstract List<Object> findListWithSample(SellItem obj, ArrayList orderByPair,
			boolean isLive) throws BaseDBException;

}

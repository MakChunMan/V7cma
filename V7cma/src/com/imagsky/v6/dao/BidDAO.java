package com.imagsky.v6.dao;
import java.util.ArrayList;
import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Bid;

public abstract class BidDAO extends AbstractDbDAO{

	public static BidDAO getInstance() {
		return BidDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(Bid obj) throws BaseDBException;

	public abstract List<Object> findListWithSample(Bid obj, ArrayList<?> orderByPair)throws BaseDBException;
        
                  public abstract Object checkAndCreate(Object obj) throws BaseDBException;
                  
}
        

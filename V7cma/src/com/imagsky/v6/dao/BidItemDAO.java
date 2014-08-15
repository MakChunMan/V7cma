package com.imagsky.v6.dao;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Bid;
import com.imagsky.v6.domain.BidItem;
import com.imagsky.v6.domain.Member;
import java.util.ArrayList;
import java.util.List;

public abstract class BidItemDAO extends AbstractDbDAO{

	public static BidItemDAO getInstance() {
		return BidItemDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(BidItem obj) throws BaseDBException;

	public abstract List<Object> findListWithSample(BidItem obj, ArrayList<?> orderByPair)throws BaseDBException;
        
                  public abstract List<Object> findOnlineBidItem() throws BaseDBException;
                  
                  public abstract List<Bid> findBidMemberListForLoserLastChangeNotify(int bidItemId, int offset) throws BaseDBException;
}

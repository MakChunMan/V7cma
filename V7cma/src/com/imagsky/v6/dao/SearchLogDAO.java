package com.imagsky.v6.dao;

import java.util.ArrayList;

import java.util.List;

import java.util.Map; 
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.SearchRecord;

public abstract class SearchLogDAO extends AbstractDbDAO{

	public static SearchLogDAO getInstance() {
		return SearchLogDAOImpl.getInstance();
	}


	public abstract List<Object> findListWithSample(SearchRecord obj) throws BaseDBException;

	public abstract List<Object> findListWithSample(SearchRecord obj, ArrayList<?> orderByPair)throws BaseDBException;
			
	//public abstract int	batchUpdateEnquiryStatus(int StatusFlg, Enquiry obj) throws BaseDBException;
	
	//public abstract int updatePriority(String[] guids) throws BaseDBException;

}

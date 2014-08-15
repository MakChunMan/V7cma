package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;

import java.util.Map; 
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Enquiry;
import com.imagsky.v6.domain.Member;

public abstract class EnquiryDAO extends AbstractDbDAO{

	public static EnquiryDAO getInstance() {
		return EnquiryDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(Enquiry obj) throws BaseDBException;

	public abstract List<Object> findListWithSample(Enquiry obj, ArrayList<?> orderByPair)throws BaseDBException;
			
	public abstract int	batchUpdateEnquiryStatus(int statusFlg, Member thisMember, Enquiry obj) throws BaseDBException;

	public abstract Enquiry[] getEnquiryContentByOwner(Member member) throws BaseDBException;
	
	//public abstract int updatePriority(String[] guids) throws BaseDBException;

}

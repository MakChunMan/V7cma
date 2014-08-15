package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;

import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.SellItem;

public abstract class MemberDAO extends AbstractDbDAO{

	public static MemberDAO getInstance() {
		return MemberDAOImpl.getInstance();
	}
	
	public abstract Member validURL(Member member) throws BaseDBException;

	public abstract List<Object> findListWithSample(Object obj) throws BaseDBException;

	public abstract List<Object> findListWithSample(Object obj, ArrayList orderByPair)
			throws BaseDBException;

	public abstract Member[] findNewShopWithProduct() throws BaseDBException;
}

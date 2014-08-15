package com.imagsky.v6.dao;

import java.util.List;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.SellItemCategory;

public abstract class SellItemCategoryDAO extends AbstractDbDAO{

	public static SellItemCategoryDAO getInstance() {
		return SellItemCategoryDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(SellItemCategory obj) throws BaseDBException;
	
	public abstract int updatePriority(String[] guids) throws BaseDBException;
	
	public abstract List<Object> findNodeListByCategoryList(List catList) throws BaseDBException;

	
}

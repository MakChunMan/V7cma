package com.imagsky.v6.dao;

import java.util.List;
import java.util.Map; 
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Node;
import com.imagsky.v6.domain.SearchRank;


public abstract class SearchDAO extends AbstractDbDAO{

	public static SearchDAO getInstance() {
		return SearchDAOImpl.getInstance();
	}

	//public abstract List<Object> findListWithSample(Article obj) throws BaseDBException;

	public abstract int keyWordSearchCount(String keyword, String lang) throws BaseDBException;
	
	public abstract SearchRank[] keyWordSearchSellItem(String keyword,String lang, String startRow, String rowPerPage) throws BaseDBException;

}

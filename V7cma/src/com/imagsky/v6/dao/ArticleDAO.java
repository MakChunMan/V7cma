package com.imagsky.v6.dao;

import java.util.List;
import java.util.Map; 
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Node;


public abstract class ArticleDAO extends AbstractDbDAO{

	public static ArticleDAO getInstance() {
		return ArticleDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(Article obj) throws BaseDBException;
	
	public abstract int updatePriority(String[] guids) throws BaseDBException;

	public abstract boolean updateExportInfo(Object obj) throws BaseDBException;
}

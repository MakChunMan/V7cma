package com.imagsky.v6.dao;

import com.imagsky.dao.AbstractV7DAO;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.Node;
import java.util.List;
import java.util.Map;

public abstract class NodeDAO extends AbstractV7DAO{

	public static NodeDAO getInstance() {
		return NodeDAOImpl.getInstance();
	}

	public abstract List<Object> findListWithSample(Node obj) throws BaseDBException;

	public abstract Map<String, Node> findNodeListWithSample(List<Object> contentList,
			String keyMode) throws BaseDBException;

}

package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.ColumnField;

public abstract class ContentTypeDAO  extends AbstractDbDAO{


		public static ContentTypeDAO getInstance() {
			return ContentTypeDAOImpl.getInstance();
		}
		
		public abstract ColumnField[] getColumnsByTableName(String tablename) throws BaseDBException;
		
}

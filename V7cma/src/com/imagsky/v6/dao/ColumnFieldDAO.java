package com.imagsky.v6.dao;

import java.util.*;


import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.domain.ColumnField;
import com.imagsky.v6.domain.ContentType;

public abstract class ColumnFieldDAO  extends AbstractDbDAO{


		public static ColumnFieldDAO getInstance() {
			return ColumnFieldDAOImpl.getInstance();
		}
		
		public abstract ColumnField[] getColumnsByTableName(String tablename) throws BaseDBException;

		public abstract List getColumnsByContentTypeGUID(String guid) throws BaseDBException;
		
		public abstract List<Object> findByContentTypeGuid(ContentType ct) throws BaseDBException;
}

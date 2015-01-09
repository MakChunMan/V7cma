package com.imagsky.v6.dao;


import java.util.List;
import java.sql.*;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.imagsky.exception.BaseDBException;
//import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.ColumnField;
import com.imagsky.v6.domain.ContentType;
import com.imagsky.v6.domain.SysObject;
//import com.imagsky.v6.domain.ContentType
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.resultProcessor.ColumnFieldByTableProcessor;
import com.imagsky.sqlframework.DatabaseQueryException;
import com.imagsky.sqlframework.DatabaseUpdateException;

public class ColumnFieldDAOImpl extends ColumnFieldDAO{	

	private static ColumnFieldDAOImpl columnFieldDAOImpl = new ColumnFieldDAOImpl();
	
	public static ColumnFieldDAO getInstance() {
		cmaLogger.debug("LOGGING = ColumnFieldDAO.getInstance ");
		return columnFieldDAOImpl;
	}

	@Override
	public ColumnField[] getColumnsByTableName(String tablename)
			throws BaseDBException {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM " + tablename;
		
        

		try{
			ColumnFieldByTableProcessor proc = ColumnFieldByTableProcessor.getInstance();
			ColumnField[] contentList = (ColumnField[]) APPDB_PROCESSOR(
					SystemConstants.DB_DS_PROPERTIES_NAME,
					SystemConstants.DB_DS_DATABASE_NAME).executeQuery(sql, null, proc);
			return contentList;
		} catch (DatabaseQueryException dqe){
			throwException("ContentTypeDAOImpl : getColumnsByTableName Failed " + dqe.getMessage(),
					sql + " - " ,dqe);
		}
		return null;
	}

	
	
	@Override
	protected void beanValidate(Object entityObj)
			throws BaseDBException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Object create(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<Object> findAll() throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findByContentTypeGuid(ContentType ct) throws BaseDBException{
		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT cf from ColumnField AS cf WHERE cf.feld_content_type_guid = :contentTypeGuid ORDER BY cf.feld_order_no");
		query.setParameter("contentTypeGuid", ct.getSys_guid());
		return query.getResultList();
	}
	
	@Override
	public List<Object> findAllByPage(String orderByField, int startRow,
			int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Object> getColumnsByContentTypeGUID(String guid)
			throws BaseDBException {
		// TODO Auto-generated method stub
		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT c from ColumnField AS c WHERE c.feld_content_type_guid = :contentTypeGuid ORDER BY  c.feld_order_no ASC");
		query.setParameter("contentTypeGuid", guid);
		
		return query.getResultList();
	}
	
	
}


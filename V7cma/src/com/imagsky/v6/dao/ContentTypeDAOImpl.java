package com.imagsky.v6.dao;


import java.util.ArrayList;
import java.util.Collection;

import java.util.Iterator;

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
import com.imagsky.v6.dao.*;

public class ContentTypeDAOImpl extends ContentTypeDAO{	

	private static ContentTypeDAOImpl contentTypeDAOImpl = new ContentTypeDAOImpl();
	
	public static ContentTypeDAO getInstance() {
		cmaLogger.debug("LOGGING = ContentTypeDAO.getInstance ");
		return contentTypeDAOImpl;
	}
	
	private static final String domainClassName = "com.imagsky.v6.cma.domain.ContentType";
	
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
		try {
			if( ! Class.forName ( domainClassName ).isInstance ( entityObj ) ){
				throw new BaseDBException("Using wrong DAO implementation: "+domainClassName + " with "+ entityObj.getClass().getName(),"");
			}
			Class.forName(domainClassName).cast(entityObj);
		} catch (ClassNotFoundException e) {
			throw new BaseDBException("ClassNotFound for "+ domainClassName , "", e);
			
		}
		
	}

	@Override
	public Object create(Object obj) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		em.persist(obj);
		em.getTransaction().commit();
		em.close();
		return obj;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int deleteAll(Object[] objs) throws BaseDBException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAll(String[] strs) throws BaseDBException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Object> findAll() throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT ct from ContentType AS ct");
		List list = query.getResultList();
		Iterator<ContentType> it = list.iterator();
		ContentType ct = null;
		Collection col = null;
		List<Object> al = new ArrayList();
		while (it.hasNext()){
			Object obj = it.next();
			ct = (ContentType)obj;
			cmaLogger.debug(ct.getCma_name() + " has " + ct.getFields().size() + " fields before add-on query");
			/*
			col = ColumnFieldDAO.getInstance().getColumnsByContentTypeGUID(ct.getSys_guid());
			cmaLogger.debug(ct.getCma_name() + " has " + col.size() + " fields");
			ct.setFields(ColumnFieldDAO.getInstance().getColumnsByContentTypeGUID(ct.getSys_guid()));
			*/
			al.add(ct);
		}
		em.close();
		return al;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow,
			int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		beanValidate(obj);
		ContentType ct = (ContentType)obj;
		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT ct from ContentType AS ct WHERE ct.sys_guid = :contentTypeGuid");
		query.setParameter("contentTypeGuid", ct.getSys_guid());
		return query.getSingleResult();
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}
	
	
}


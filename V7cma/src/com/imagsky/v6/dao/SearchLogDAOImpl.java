package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.v6.dao.SearchLogDAO;
import com.imagsky.v6.domain.SearchRecord;
import com.imagsky.v6.domain.SellItem;


public class SearchLogDAOImpl extends SearchLogDAO{
	
	private static SearchLogDAOImpl searchLogAOImpl = new SearchLogDAOImpl();
	
	public static SearchLogDAO getInstance() {
		cmaLogger.debug("LOGGING = SearchLogDAO.getInstance() ");
		return searchLogAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.SearchRecord";
			
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
		cmaLogger.debug("SearchLogDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		SearchRecord enq = (SearchRecord)obj;
		em.persist(enq);
		em.getTransaction().commit();
		update(enq);
		cmaLogger.debug("SearchLogDAOImpl.create: [END]");
		return enq;
	}

	@Override
	public List<Object> findAll() throws BaseDBException {
		// TODO Auto-generated method stub
		cmaLogger.debug("findAll not implemented");
		return null;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow,
			int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		cmaLogger.debug("findAllByPage not implemented");
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		/**
		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT mem from Member AS mem WHERE mem.mem_login_email = :loginemail");
		try{
			beanValidate(obj);
			Member mem = (Member)obj;
			query.setParameter("loginemail", mem.getMem_login_email());
			return query.getSingleResult();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
		***/
		cmaLogger.debug("findBySample not implemented");
		return null;
	}

	/***
	 * For Mark Delete & Hide only
	 */
	@Override
	public boolean update(Object obj) throws BaseDBException {
		/*
		beanValidate(obj);
		try{
			SearchLog SearchLog = (SearchLog)obj;
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			SearchLog tmpEnq = em.find(SearchLog.class, SearchLog.getId());
			if(tmpEnq.getParentid()== null)
				tmpEnq.setParentid(tmpEnq.getId());
			if(SearchLog.getDelete_flg()!=null)
				tmpEnq.setDelete_flg(SearchLog.getDelete_flg());
			if(SearchLog.getShow_flg()!=null)
				tmpEnq.setShow_flg(SearchLog.getShow_flg());
			//em.merge(tmpCat);
			em.getTransaction().commit();
		} catch (Exception e){
			throw new BaseDBException("SearchLog Exception: ","",e);
		}*/
		cmaLogger.debug("update not implemented");
		return true;
	}

	@Override
	public List<Object>  findListWithSample(SearchRecord obj, ArrayList orderByPair) throws BaseDBException{
		/*
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT enq from SearchLog AS enq WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			SearchLog enqObj = (SearchLog)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					SearchLog.getFields(enqObj),
					SearchLog.getWildFields()
					);
			
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "enq", JPAUtil.getOrderByString("enq",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}*/
		cmaLogger.debug("findListWithSample not implemented");
		return null;
	}
	
	@Override
	public List<Object> findListWithSample(SearchRecord obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}
}

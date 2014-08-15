package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.domain.Transaction;

public class TransactionDAOImpl extends TransactionDAO{
	
	private static TransactionDAOImpl sellItemDAOImpl = new TransactionDAOImpl();
	
	public static TransactionDAO getInstance() {
		cmaLogger.debug("LOGGING = TransactionDAO() ");
		return sellItemDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.Transaction";
	
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
		cmaLogger.debug("TransactionDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		Transaction txn = (Transaction)obj;
		em.persist(txn);
		em.getTransaction().commit();
		cmaLogger.debug("TransactionDAOImpl.create: [END]");
		return txn;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		/***
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Transaction prod = new Transaction();
		prod.setSys_guid(id);
		em.remove(em.merge(prod));
		em.getTransaction().commit();
		return true;
		****/
		return false; //NOT YET IMPLEYTMENT
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow,
			int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		return null;
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		/***
		beanValidate(obj);
		Transaction txn = (Transaction)obj;
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Transaction tmpTxn = em.find(Transaction.class, txn.getTxn_id());
		
		tmpTxn.setTxn_amount(txn.getTxn_amount());
		tmpTxn.setTxn_cr_dr(txn.getTxn_cr_dr());
		tmpTxn.set
		tmpProd.setProd_cate_guid(prod.getProd_cate_guid());
		tmpProd.setProd_desc(prod.getProd_desc());
		tmpProd.setProd_icon(prod.getProd_icon());
		tmpProd.setProd_image1(prod.getProd_image1());
		tmpProd.setProd_image2(prod.getProd_image2());
		tmpProd.setProd_image3(prod.getProd_image3());
		tmpProd.setProd_name(prod.getProd_name());
		tmpProd.setProd_price(prod.getProd_price());
		tmpProd.setProd_price2(prod.getProd_price2());
		tmpProd.setProd_price2_remarks(prod.getProd_price2_remarks());
		tmpProd.setProd_remarks(prod.getProd_remarks());
		tmpProd.setProd_last_enq_date(prod.getProd_last_enq_date());
		tmpProd.setSys_update_dt(new java.util.Date());
		if(prod.getSys_live_dt()!=null){
			tmpProd.setSys_live_dt(prod.getSys_live_dt());
		}
		if(prod.getSys_exp_dt()!=null){
			tmpProd.setSys_exp_dt(prod.getSys_exp_dt());
		}
		em.getTransaction().commit();
		return true;
		***/
		return false; //NOT yet implemented
	}

	@Override
	public List<Object> findListWithSample(Transaction obj, ArrayList orderByPair, boolean isLive)
	throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT txn from Transaction AS txn WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			Transaction enqObj = (Transaction)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					Transaction.getFields(enqObj),
					Transaction.getWildFields()
					);
			jpaUtil.setLiveContent(isLive);
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "txn", JPAUtil.getOrderByString("txn",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	public List<Object> findListWithSample(Transaction obj, ArrayList orderByPair)
			throws BaseDBException {
		return findListWithSample(obj,orderByPair, false);
	}
	
	@Override
	public List<Object> findListWithSample(Transaction obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}

	@Override
	public List<Object> findListWithinDays(String ownerGuid, int numOfDaysBefore)
			throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		java.util.Date currentDate = new java.util.Date();
		int defaultDayback = -14;
		
		if(numOfDaysBefore > 0){
			numOfDaysBefore = 0 - numOfDaysBefore;
		} else if(numOfDaysBefore ==0 ){
			numOfDaysBefore = defaultDayback;
		}
		
		java.util.Date inputDate = CommonUtil.dateAdd(currentDate, Calendar.DAY_OF_MONTH, numOfDaysBefore);
		cmaLogger.debug(CommonUtil.formatDate(inputDate));
		StringBuffer jpql_bf = new StringBuffer("SELECT txn from Transaction AS txn WHERE 1=1 and txn.txn_date >= :FLD0 and " +
				"txn.txn_owner = :FLD1 order by txn.txn_date ASC");
		
		try{
			Query query = em.createQuery(jpql_bf.toString());
			query.setParameter("FLD0", inputDate);
			query.setParameter("FLD1", ownerGuid);
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	
}

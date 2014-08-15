package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.domain.OrderSet;

public class OrderSetDAOImpl extends OrderSetDAO{
	
	private static OrderSetDAOImpl orderSetDAOImpl = new OrderSetDAOImpl();
	
	public static OrderSetDAO getInstance() {
		cmaLogger.debug("LOGGING = OrderSetDAO.getInstance() ");
		return orderSetDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.OrderSet";
	
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
		cmaLogger.debug("OrderSetDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		OrderSet prod = (OrderSet)obj;
		em.persist(prod);
		em.getTransaction().commit();
		cmaLogger.debug("OrderSetDAOImpl.create: [END]");
		return prod;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		OrderSet orderSet = new OrderSet();
		orderSet.setCode(id);
		em.remove(em.merge(orderSet));
		em.getTransaction().commit();
		return true;
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
		//Only feedback field can be updated
		beanValidate(obj);
		OrderSet orderSet = (OrderSet)obj;
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		OrderSet tmpOrderSet = em.find(OrderSet.class, orderSet.getId());
		tmpOrderSet.setFeedback_point(orderSet.getFeedback_point());
		tmpOrderSet.setFeedback_remarks(orderSet.getFeedback_remarks());
		if(orderSet.getOrder_status()!=null){
			tmpOrderSet.setOrder_status(orderSet.getOrder_status());
		}
		if(orderSet.getOrder_payment_date()!=null){
			tmpOrderSet.setOrder_payment_date(orderSet.getOrder_payment_date());
		}
                                    if(orderSet.isPaymentWarn()!=null){
                                                     tmpOrderSet.setPaymentWarn(orderSet.isPaymentWarn());
                                    }
                                    if(orderSet.getPendingBTPayment()!=null){
                                                    tmpOrderSet.setPendingBTPayment(orderSet.getPendingBTPayment());
                                    }
                                    em.merge(tmpOrderSet);
		//tmpOrderSet.set(new java.util.Date());
		em.getTransaction().commit();
		return true;
	}

	
	public List<Object> findListWithSample(OrderSet obj, ArrayList orderByPair)
			throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT os from OrderSet AS os WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			OrderSet enqObj = (OrderSet)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					OrderSet.getFields(enqObj),
					OrderSet.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "os", JPAUtil.getOrderByString("os",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	@Override
	/***
	 * Used by Profile Page: Show the unfeedback orderset of Buyer
	 * Exclude Bulk Order
	 */
	public List<Object> findListWithSampleWithoutFeedback(OrderSet obj, ArrayList orderByPair)
	throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT os from OrderSet AS os WHERE os.feedback_point is null ");

		try{
			beanValidate(obj);
			OrderSet enqObj = (OrderSet)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					OrderSet.getFields(enqObj),
					OrderSet.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "os", JPAUtil.getOrderByString("os",orderByPair));
			
			Iterator it = query.getResultList().iterator();
			ArrayList result = new ArrayList();
			
			String mainsiteGuid = PropertiesConstants.get(PropertiesConstants.mainSiteGUID);
			while(it.hasNext()){
				OrderSet aSO = (OrderSet)it.next();
				//cmaLogger.debug("Shop: aSO.getShop().getSys_guid() --- Mainsite"+ mainsiteGuid);
				if(!aSO.getShop().getSys_guid().equalsIgnoreCase(mainsiteGuid)){
					result.add(aSO);
				}
			}
			return result;
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	@Override
	public List<Object> findListWithSample(OrderSet obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}


}

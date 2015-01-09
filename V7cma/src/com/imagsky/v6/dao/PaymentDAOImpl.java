package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.domain.Payment;

public class PaymentDAOImpl extends PaymentDAO{
	
	private static PaymentDAOImpl PaymentDAOImpl = new PaymentDAOImpl();
	
	public static PaymentDAO getInstance() {
		cmaLogger.debug("LOGGING = PaymentDAO.getInstance() ");
		return PaymentDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.Payment";
	
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
		cmaLogger.debug("PaymentDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		Payment payment = (Payment)obj;
		em.persist(payment);
		em.getTransaction().commit();
		cmaLogger.debug("PaymentDAOImpl.create: [END]");
		return payment;
	}

	//2015-01-09 Remove Override : need further investigate
	/***
	@Override
	public boolean delete(String id) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Payment payment = new Payment();
		payment.setPay_id(new Integer(id));
		em.remove(em.merge(payment));
		em.getTransaction().commit();
		return true;
	}***/

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
		beanValidate(obj);
		Payment payment = (Payment)obj;
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Payment tmpPayment = em.find(Payment.class, payment.getPay_id());
		
		if(!CommonUtil.isNullOrEmpty(payment.getPay_bt_upload_file())){
			tmpPayment.setPay_bt_upload_file(payment.getPay_bt_upload_file());
		}
		if(!CommonUtil.isNullOrEmpty(payment.getPay_ref_num())){
			tmpPayment.setPay_ref_num(payment.getPay_ref_num());
		}
		if(!CommonUtil.isNullOrEmpty(payment.getPay_remarks())){
			tmpPayment.setPay_remarks(payment.getPay_remarks());
		}
		if(payment.getPay_confirm_date()!=null){
			tmpPayment.setPay_confirm_date(payment.getPay_confirm_date());
		}
		if(payment.getPay_proc_date()!=null){
			tmpPayment.setPay_proc_date(payment.getPay_proc_date());
		}
		if(payment.getPay_receive_date()!=null){
			tmpPayment.setPay_receive_date(payment.getPay_receive_date());
		}
		if(payment.getPay_status()!=null){
			tmpPayment.setPay_status(payment.getPay_status());
		}
		if(payment.getPay_gw_charge()!=null){
			tmpPayment.setPay_gw_charge(payment.getPay_gw_charge());
		}
		if(payment.getPay_remarks()!=null){
			tmpPayment.setPay_remarks(payment.getPay_remarks());
		}
		tmpPayment.setPay_last_update_date(new java.util.Date());
		em.getTransaction().commit();
		return true;
	}

	
	public List<Object> findListWithSample(Payment obj, ArrayList orderByPair)
			throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT os from Payment AS os WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			Payment enqObj = (Payment)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					Payment.getFields(enqObj),
					Payment.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "os", JPAUtil.getOrderByString("os",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	
	
	@Override
	public List<Object> findListWithSample(Payment obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}


}

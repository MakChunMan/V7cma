package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.MemAddress;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

public class MemAddressDAOImpl extends MemAddressDAO{
	
	private static MemAddressDAOImpl memberAddressDAOImpl = new MemAddressDAOImpl();
	
	public static MemAddressDAO getInstance() {
		cmaLogger.debug("LOGGING = MemAddressDAO.getInstance() ");
		return memberAddressDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.MemAddress";
	
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
		cmaLogger.debug("MemAddressDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
                                    em.getTransaction().begin();
		beanValidate(obj);
		MemAddress memAddr = (MemAddress)obj;
		em.persist(memAddr);
                                    em.getTransaction().commit();
		cmaLogger.debug("MemAddressDAOImpl.create: [END]");
		return obj;
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
	public List<Object> findListWithSample(Object obj, ArrayList orderByPair) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT memaddr from MemAddress AS memaddr WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			MemAddress enqObj = (MemAddress)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					MemAddress.getFields(enqObj),
					MemAddress.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "memaddr", JPAUtil.getOrderByString("memaddr",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}		

	@Override
	public List<Object> findListWithSample(Object obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		beanValidate(obj);
		MemAddress mem = (MemAddress)obj;
		EntityManager em = factory.createEntityManager();
		//this.txnBegin();
                                    em.getTransaction().begin();
		MemAddress tmpMem = em.find(MemAddress.class, mem.getId());
		if(!CommonUtil.isNullOrEmpty(mem.getAddr_line1())){
			tmpMem.setAddr_line1(mem.getAddr_line1());
		}
		if(!CommonUtil.isNullOrEmpty(mem.getAddr_line2())){
			tmpMem.setAddr_line2(mem.getAddr_line2());
		}
		if(!CommonUtil.isNullOrEmpty(mem.getAttention_name())){
			tmpMem.setAttention_name(mem.getAttention_name());
		}
		if(!CommonUtil.isNullOrEmpty(mem.getCountryplace())){
			tmpMem.setCountryplace(mem.getCountryplace());
		}
		if(!CommonUtil.isNullOrEmpty(mem.getRegion())){
			tmpMem.setRegion(mem.getRegion());
		}	
                                    if(mem.isIsdefault()!=null){
                                        tmpMem.setIsdefault(mem.isIsdefault());
                                    }
                                    em.merge(tmpMem);
                                    em.flush();
		em.getTransaction().commit();
		return true;
	}
	
	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

}

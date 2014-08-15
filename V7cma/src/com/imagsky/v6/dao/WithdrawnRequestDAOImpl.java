package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.domain.OrderSet;
import com.imagsky.v6.domain.WithdrawnRequest;

public class WithdrawnRequestDAOImpl extends WithdrawnRequestDAO{
	
	private static WithdrawnRequestDAOImpl withdrawnRequestDAOImpl = new WithdrawnRequestDAOImpl();
	
	public static WithdrawnRequestDAO getInstance() {
		cmaLogger.debug("LOGGING = WithdrawnRequestDAO.getInstance() ");
		return withdrawnRequestDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.WithdrawnRequest";
	
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
		cmaLogger.debug("WithdrawnRequestDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		WithdrawnRequest w = (WithdrawnRequest)obj;
		em.persist(w);
		em.getTransaction().commit();
		cmaLogger.debug("WithdrawnRequestDAOImpl.create: [END]");
		return w;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		/***
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		WithdrawnRequest orderSet = new WithdrawnRequest();
		orderSet.setCode(id);
		em.remove(em.merge(orderSet));
		em.getTransaction().commit();
		***/
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
		WithdrawnRequest wobj = (WithdrawnRequest)obj;
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		WithdrawnRequest tmpWithdrawnRequest = em.find(WithdrawnRequest.class, wobj.getReq_id());
		
		em.getTransaction().commit();
		return true;
	}

	
	public List<Object> findListWithSample(WithdrawnRequest obj, ArrayList orderByPair)
			throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT os from WithdrawnRequest AS os WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			WithdrawnRequest enqObj = (WithdrawnRequest)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					WithdrawnRequest.getFields(enqObj),
					WithdrawnRequest.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "os", JPAUtil.getOrderByString("os",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}

	@Override
	public List<Object> findListWithSample(OrderSet obj, ArrayList orderByPair)
			throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findListWithSample(OrderSet obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}
}

package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.imagsky.exception.BaseDBException;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.domain.*;
import com.imagsky.util.logger.*;

public class FormTypeDAOImpl extends FormTypeDAO{

	private static final String domainClassName = "com.imagsky.v6.cma.domain.FormFieldType";

	private static FormTypeDAOImpl formTypeDAOImpl = new FormTypeDAOImpl();
	
	public static FormTypeDAO getInstance() {
		cmaLogger.debug("LOGGING = FormTypeDAO.getInstance() ");
		return formTypeDAOImpl;
	}
	
	@Override
	public Object create(Object obj)  throws BaseDBException{
		beanValidate(obj);
		FormFieldType bean =  (FormFieldType)obj;
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		bean.setSys_guid(UUIDUtil.getNewUUID(bean.toString()));
		em.persist(bean);
		em.getTransaction().commit();
		em.close();
		return bean;
	}

	@Override
	public boolean delete(String id)  throws BaseDBException{
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Object obj)  throws BaseDBException{
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int deleteAll(Object[] objs)  throws BaseDBException{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAll(String[] strs)  throws BaseDBException{
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Object> findAll()  throws BaseDBException{
		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT f from FormFieldType AS f ORDER BY  f.sys_proirity ASC");
		return new ArrayList(query.getResultList());
	}
	
	@Override
	public Object findBySample(Object obj)  throws BaseDBException{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean update(Object obj)  throws BaseDBException{
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	protected void beanValidate(Object entityObj) throws BaseDBException {
		try {
			if( ! Class.forName ( domainClassName ).isInstance ( entityObj ) ){
				throw new BaseDBException("Using wrong DAO implementation: "+domainClassName + " with "+ entityObj.getClass().getName(),"");
			}
			Class.forName(domainClassName).cast(entityObj);
		} catch (ClassNotFoundException e) {
			throw new BaseDBException("ClassNotFound for "+ domainClassName , "", e);
			
		}
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> findAllByPage(String orderByField, int startRow,
			int chunksize) throws BaseDBException {

		EntityManager em = factory.createEntityManager();
		Query query = em.createQuery("SELECT f from FormFieldType AS f ORDER BY  f.sys_proirity ASC");
		return query.setFirstResult(startRow).setMaxResults(chunksize).getResultList();
	}

}

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
import com.imagsky.v6.domain.SellItem;

public class SellItemDAOImpl extends SellItemDAO{
	
	private static SellItemDAOImpl sellItemDAOImpl = new SellItemDAOImpl();
	
	public static SellItemDAO getInstance() {
		cmaLogger.debug("LOGGING = SelllItemDAO.getInstance() ");
		return sellItemDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.SellItem";
	
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
		cmaLogger.debug("SellItemDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		SellItem prod = (SellItem)obj;
		if(prod.getSys_guid()==null){
			prod.setSys_guid(UUIDUtil.getNewUUID("prod"+ new java.util.Date().toString()));
		}
		prod.setSys_master_lang_guid(prod.getSys_guid());
		em.persist(prod);
		em.getTransaction().commit();
		cmaLogger.debug("SellItemDAOImpl.create: [END]");
		return prod;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		SellItem prod = new SellItem();
		prod.setSys_guid(id);
		em.remove(em.merge(prod));
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
		beanValidate(obj);
		SellItem prod = (SellItem)obj;
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		SellItem tmpProd = em.find(SellItem.class, prod.getSys_guid());
		tmpProd.setProd_cate_guid(prod.getProd_cate_guid());
		tmpProd.setProd_desc(prod.getProd_desc());
		tmpProd.setProd_icon(prod.getProd_icon());
		tmpProd.setProd_image1(prod.getProd_image1());
		tmpProd.setProd_image2(prod.getProd_image2());
		tmpProd.setProd_image3(prod.getProd_image3());
		tmpProd.setProd_name(prod.getProd_name());
		tmpProd.setProd_price(prod.getProd_price());
		if(prod.getProd_price2()!=null){
			tmpProd.setProd_price2(prod.getProd_price2());
		}
		if(CommonUtil.isNullOrEmpty(tmpProd.getProd_price2_remarks())){
			tmpProd.setProd_remarks(prod.getProd_remarks());
		}
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
	}

	@Override
	public List<Object> findListWithSample(SellItem obj, ArrayList orderByPair, boolean isLive)
	throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT prod from SellItem AS prod WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			SellItem enqObj = (SellItem)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					SellItem.getFields(enqObj),
					SellItem.getWildFields()
					);
			jpaUtil.setLiveContent(isLive);
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "prod", JPAUtil.getOrderByString("prod",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	public List<Object> findListWithSample(SellItem obj, ArrayList orderByPair)
			throws BaseDBException {
		return findListWithSample(obj,orderByPair, false);
	}
	
	@Override
	public List<Object> findListWithSample(SellItem obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}

	@Override
	public int updatePriority(String[] guids) throws BaseDBException {
		SellItem tmpCat[] = new SellItem[guids.length];
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		for (int x =0; x < guids.length; x++){
			tmpCat[x] = em.find(SellItem.class, guids[x]);
			tmpCat[x].setSys_priority(x);
			cmaLogger.debug("Update "+ guids[x] + " : " + x);
		}
		em.getTransaction().commit();
		return guids.length;
	}
}

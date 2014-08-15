package com.imagsky.v6.dao;

import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.dao.SellItemCategoryDAO;
import com.imagsky.v6.domain.SellItem;
import com.imagsky.v6.domain.SellItemCategory;

public class SellItemCategoryDAOImpl extends SellItemCategoryDAO{
	
	private static SellItemCategoryDAOImpl sellItemCategoryDAOImpl = new SellItemCategoryDAOImpl();
	
	public static SellItemCategoryDAO getInstance() {
		cmaLogger.debug("LOGGING = SelllItemCategoryDAO.getInstance() ");
		return sellItemCategoryDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.SellItemCategory";
	
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
		cmaLogger.debug("SellItemCategoryDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		SellItemCategory cat = (SellItemCategory)obj;
		if(cat.getSys_guid()==null){
			cat.setSys_guid(UUIDUtil.getNewUUID("member"+ new java.util.Date().toString()));
			cat.setSys_master_lang_guid(cat.getSys_guid());
		}
		em.persist(cat);
		em.getTransaction().commit();
		cmaLogger.debug("SellItemCategoryDAOImpl.create: [END]");
		return cat;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		SellItemCategory cat = new SellItemCategory();
		cat.setSys_guid(id);
		em.remove(em.merge(cat));
		
		//Update All prod with this category as -1
		SellItemDAO dao = SellItemDAO.getInstance();
		SellItem enqObj = new SellItem();
		try{
			enqObj.setProd_cate_guid(id);
			List sellItemList = dao.findListWithSample(enqObj);
			cmaLogger.debug(sellItemList.size() + " sell item to be updated...");
			Iterator<?> it = sellItemList.iterator();
			int x =1;
			while(it.hasNext()){
				SellItem tmp = (SellItem)it.next();
				tmp.setProd_cate_guid("-1");
				dao.update(tmp);
				cmaLogger.debug(x++ + " updated");
			}
		} catch (Exception e){
			cmaLogger.error("Update child sellitem exception",e);
		}
		
		
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
		try{
			SellItemCategory cat = (SellItemCategory)obj;
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			SellItemCategory tmpCat = em.find(SellItemCategory.class, cat.getSys_guid());
			tmpCat.setCate_name(cat.getCate_name());
			tmpCat.setCate_lang(cat.getCate_lang());
			tmpCat.setCate_type(cat.getCate_type());
			tmpCat.setCate_item_count(cat.getCate_item_count());
			//em.merge(tmpCat);
			em.getTransaction().commit();
		} catch (Exception e){
			throw new BaseDBException("SellItemCategory Exception: ","",e);
		}
		return true;
	}

	@Override
	public List<Object> findListWithSample(SellItemCategory obj)
			throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT cat from SellItemCategory AS cat WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			SellItemCategory enqObj = (SellItemCategory)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					SellItemCategory.getFields(enqObj),
					SellItemCategory.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "cat"," order by cat.sys_priority");
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}

	@Override
	public int updatePriority(String[] guids) throws BaseDBException {
		SellItemCategory tmpCat[] = new SellItemCategory[guids.length];
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		for (int x =0; x < guids.length; x++){
			tmpCat[x] = em.find(SellItemCategory.class, guids[x]);
			tmpCat[x].setSys_priority(x);
			cmaLogger.debug("Update "+ guids[x] + " : " + x);
		}
		em.getTransaction().commit();
		return guids.length;
	}

	@Override
	public List<Object> findNodeListByCategoryList(List catList)
			throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}
}

package com.imagsky.v6.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.sqlframework.DatabaseQueryException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.EnquiryDAO;
import com.imagsky.v6.dao.resultProcessor.EnquiryProcessor;
import com.imagsky.v6.dao.resultProcessor.SearchRankCountProcessor;
import com.imagsky.v6.domain.Enquiry;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.SellItem;


public class EnquiryDAOImpl extends EnquiryDAO{
	
	private static EnquiryDAOImpl enquiryDAOImpl = new EnquiryDAOImpl();
	
	public static EnquiryDAO getInstance() {
		cmaLogger.debug("LOGGING = EnquiryDAO.getInstance() ");
		return enquiryDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.Enquiry";
			
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
		cmaLogger.debug("EnquiryDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		Enquiry enq = (Enquiry)obj;
		em.persist(enq);
		em.getTransaction().commit();
		update(enq);
		cmaLogger.debug("EnquiryDAOImpl.create: [END]");
		return enq;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		/*
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Enquiry enq = new Enquiry();
		enq.setId(new Integer(id));
		em.remove(em.merge(enq));
		em.getTransaction().commit();
		*/
		return false;
	}

	@Override
	public boolean delete(Object obj) throws BaseDBException {
		beanValidate(obj);
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Enquiry enq = (Enquiry)obj;
		//enq.setId(new Integer(id));
		em.remove(em.merge(enq));
		em.getTransaction().commit();
		return true;
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
		return null;
	}

	/***
	 * For Mark Delete & Hide only
	 */
	@Override
	public boolean update(Object obj) throws BaseDBException {
		beanValidate(obj);
		
		try{
			Enquiry enquiry = (Enquiry)obj;
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			Enquiry tmpEnq = em.find(Enquiry.class, enquiry.getId());
			if(tmpEnq.getParentid()== null)
				tmpEnq.setParentid(tmpEnq.getId());
			if(enquiry.getDelete_flg()!=null)
				tmpEnq.setDelete_flg(enquiry.getDelete_flg());
			if(enquiry.getShow_flg()!=null)
				tmpEnq.setShow_flg(enquiry.getShow_flg());
			if(enquiry.getDel_by_recipent()!=null)
				tmpEnq.setDel_by_recipent(enquiry.getDel_by_recipent());
			if(enquiry.getDel_by_sender()!=null)
				tmpEnq.setDel_by_sender(enquiry.getDel_by_sender());
			//em.merge(tmpCat);
			em.getTransaction().commit();
		} catch (Exception e){
			throw new BaseDBException("Enquiry Exception: ","",e);
		}
		
		return true;
	}

	/***
	 *  For Batch update Enquiry Status
	 */
	@Override
	public int	batchUpdateEnquiryStatus(int statusFlg, Member thisMember, Enquiry obj) throws BaseDBException{
	
		beanValidate(obj);
		
		StringBuffer jpql_bf =new StringBuffer("UPDATE Enquiry enq set ");
		Object[] param = new Object[2];
		if(statusFlg==Enquiry.SHOW_FLG){
			jpql_bf.append("show_flg = :FLD0");
			param[0] = "FLD0";
			param[1] = obj.getShow_flg();
		} else if(statusFlg==Enquiry.DEL_FLG){
			
			StringBuffer sql1 = new StringBuffer(jpql_bf.toString()+ " enq.del_by_sender = :FLD0 where enq.parentid = :FLD1 and enq.fr_member = :FLD2");
			StringBuffer sql2 = new StringBuffer(jpql_bf.toString()+ " enq.del_by_recipent = :FLD0 where enq.parentid = :FLD1 and enq.to_member = :FLD2");
			
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			Query query = em.createQuery(sql1.toString());
			query.setParameter("FLD0", true);
			query.setParameter("FLD1", obj.getParentid());
			query.setParameter("FLD2", thisMember);
			int result =  query.executeUpdate();
			
			Query query2 = em.createQuery(sql2.toString());
			query2.setParameter("FLD0", true);
			query2.setParameter("FLD1", obj.getParentid());
			query2.setParameter("FLD2", thisMember);
			int result2 = query2.executeUpdate();
			
			em.getTransaction().commit();
			return result + result2;
		} else {
			throw new BaseDBException("Enquiry Exception: Invalid StatusFlg = "+ statusFlg, null);
		}
		return -1;
	}
	
	@Override
	public List<Object>  findListWithSample(Enquiry obj, ArrayList orderByPair) throws BaseDBException{
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT enq from Enquiry AS enq WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			Enquiry enqObj = (Enquiry)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					Enquiry.getFields(enqObj),
					Enquiry.getWildFields()
					);
			
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "enq", JPAUtil.getOrderByString("enq",orderByPair));
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}
	
	@Override
	public List<Object> findListWithSample(Enquiry obj)
			throws BaseDBException {
		return findListWithSample(obj, null);
	}
	
	@Override
	public Enquiry[] getEnquiryContentByOwner(Member member) throws BaseDBException{
		String sql = 
			"SELECT sys_guid as contentid, PROD_LAST_ENQ_DATE as cdate, PROD_NAME as content from tb_item where PROD_OWNER = ? union " +
			"SELECT code as contentid, ORDER_CREATE_DATE as cdate, '' as content from tb_orderset where MEMBER_ID = ? or SHOP_ID = ? union "+ 
			"SELECT code as contentid, ORDER_CREATE_DATE as cdate, '' as content from tb_bobo_sellitem b, tb_orderset o , tb_bobo_order_hist bb where b.BOBO_SITM_CODE = bb.BOBO_CODE and bb.BOBO_HIST_ORDER_ID  = o.ID and " +
			"BOBO_OWNER = ?	order by cdate desc";
		
		try{
			EnquiryProcessor proc = EnquiryProcessor.getInstance();
			Enquiry[] countObj = (Enquiry[]) APPDB_PROCESSOR(
					SystemConstants.DB_DS_PROPERTIES_NAME,
					SystemConstants.DB_DS_DATABASE_NAME
					).executeQuery(sql.toString(), new Object[]{
						member.getSys_guid(),
						member.getSys_guid(),
						member.getSys_guid(),
						member.getSys_guid()
					}, proc);
			cmaLogger.debug("[ENQUIRY getEnquiryContentByOwner]" + countObj.length);
			return countObj;		
		} catch (DatabaseQueryException dqe){
			cmaLogger.error("[ENQUIRY]", dqe);
			throwException("EnquiryDAOImpl : getEnquiryContentByOwner Failed" + dqe.getMessage(),
					sql + " - " + member.getSys_guid() ,dqe);
			return null;
		} catch (Exception be){
			cmaLogger.error("[ENQUIRY]", be);
			throwException("EnquiryDAOImpl : getEnquiryContentByOwner: Failed" + be.getMessage(),
					sql + " - " + member.getSys_guid() ,be);
			return null;
		}
	}
}

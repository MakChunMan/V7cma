package com.imagsky.v6.dao;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.sqlframework.DatabaseQueryException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.ArticleDAO;
import com.imagsky.v6.domain.ColumnField;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.Node;

public class ArticleDAOImpl extends ArticleDAO{
	
	private static ArticleDAOImpl articleDAOImpl = new ArticleDAOImpl();
	
                  ArticleDAOImpl(){
                      super.domainClassName = ArticleDAOImpl.domainClassName;
                  }
                  
	public static ArticleDAO getInstance() {
		return articleDAOImpl;
	}

	private static final String domainClassName = "com.imagsky.v6.domain.Article";
	
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
		cmaLogger.debug("ArticleDAOImpl.create: [START]");
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		beanValidate(obj);
		Article article = (Article)obj;
		if(article.getSys_guid()==null){
			article.setSys_guid(UUIDUtil.getNewUUID("article"+ new java.util.Date().toString()));
			article.setSys_master_lang_guid(article.getSys_guid());
		}
		em.persist(article);
		em.getTransaction().commit();
		cmaLogger.debug("ArticleDAOImpl.create: [END]");
		return article;
	}

	@Override
	public boolean delete(String id) throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		Article article = new Article();
		article.setSys_guid(id);
		em.remove(em.merge(article));
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

	@Override
	public boolean updateExportInfo(Object obj) throws BaseDBException {
		beanValidate(obj);
		try{
			Article article = (Article)obj;
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			Article tmpArti = em.find(Article.class, article.getSys_guid());
			tmpArti.setArti_exp_date(article.getArti_exp_date());
			tmpArti.setArti_exp_file(article.getArti_exp_file());
			tmpArti.setSys_updator(article.getSys_updator());
			tmpArti.setSys_update_dt(article.getSys_update_dt());
			em.getTransaction().commit();
		} catch (Exception e){
			throw new BaseDBException("Article Exception: ","",e);
		}
		return true;
	}
	
	@Override
	public boolean update(Object obj) throws BaseDBException {
		beanValidate(obj);
		try{
			Article article = (Article)obj;
			EntityManager em = factory.createEntityManager();
			em.getTransaction().begin();
			Article tmpArti = em.find(Article.class, article.getSys_guid());
			tmpArti.setArti_content(article.getArti_content());
			tmpArti.setArti_lang(article.getArti_lang());
			tmpArti.setArti_isHighlightSection(article.isArti_isHighlightSection());
			tmpArti.setArti_isSubNav(article.isArti_isSubNav());
			tmpArti.setArti_isTopNav(article.isArti_isTopNav());
			tmpArti.setArti_name(article.getArti_name());
			tmpArti.setArti_parent_guid(article.getArti_parent_guid());
			
			tmpArti.setSys_cma_name(article.getArti_name() + "("+ article.getArti_lang()+")");
			tmpArti.setSys_is_live(article.isSys_is_live());
			tmpArti.setSys_is_node(article.isSys_is_node());
			tmpArti.setSys_is_published(article.isSys_is_published());
			tmpArti.setSys_updator(article.getSys_updator());
			tmpArti.setSys_update_dt(article.getSys_update_dt());
			
			//em.merge(tmpCat);
			em.getTransaction().commit();
		} catch (Exception e){
			throw new BaseDBException("Article Exception: ","",e);
		}
		return true;
	}

	@Override
	public List<Object> findListWithSample(Article obj)
			throws BaseDBException {
		EntityManager em = factory.createEntityManager();
		StringBuffer jpql_bf = new StringBuffer("SELECT arti from Article AS arti WHERE 1=1 ");
		
		try{
			beanValidate(obj);
			Article enqObj = (Article)obj;
			
			JPAUtil jpaUtil = new JPAUtil(
					Article.getFields(enqObj),
					Article.getWildFields()
					);
			
			Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "arti"," order by arti.sys_priority");
			return query.getResultList();
		} catch (NoResultException nre){
			cmaLogger.debug("Result not found");
			return null;
		}
	}

	@Override
	public int updatePriority(String[] guids) throws BaseDBException {
		Article tmpCat[] = new Article[guids.length];
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();
		for (int x =0; x < guids.length; x++){
			tmpCat[x] = em.find(Article.class, guids[x]);
			tmpCat[x].setSys_priority(x);
			cmaLogger.debug("Update "+ guids[x] + " : " + x);
		}
		em.getTransaction().commit();
		return guids.length;
	}

}

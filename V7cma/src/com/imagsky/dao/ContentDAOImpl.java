package com.imagsky.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.Article;
import java.util.List;
import javax.persistence.EntityManager;

/**
 *
 * @author jasonmak
 */
public class ContentDAOImpl extends ContentDAO {

    private static ContentDAOImpl contentDAOImpl = new ContentDAOImpl();
    protected static final String thisDomainClassName = "com.imagsky.v6.domain.Article";

    ContentDAOImpl() {
    	super.setDomainClassName(thisDomainClassName);
    }

    public static ContentDAO getInstance() {
        return contentDAOImpl;
    }

    @Override
    public Object CNT_update(Object obj) throws BaseDBException {
        Class thisContentClass = contentClassValidation(domainClassName);
        EntityManager em = factory.createEntityManager();

        beanValidate(obj);
        Article article = (Article) obj;

        try {
            em.getTransaction().begin();
            Article tmpCnti = em.find(Article.class, article.getSys_guid());

            if (!CommonUtil.isNullOrEmpty(article.getArti_name())) {
                tmpCnti.setArti_name(article.getArti_name());
            }
            tmpCnti.setArti_content(article.getArti_content());
            tmpCnti.setSys_update_dt(new java.util.Date());
            tmpCnti.setSys_updator(article.getSys_updator());
            tmpCnti.setSys_clfd_guid(article.getSys_clfd_guid());
            tmpCnti.setSys_is_live(article.isSys_is_live());
            tmpCnti.setSys_is_published(article.isSys_is_published());
            cmaLogger.debug("DAO is_published:"+ tmpCnti.isSys_is_published());
            tmpCnti.setSys_is_node(article.isSys_is_node());
            tmpCnti.setArti_isTopNav(article.isArti_isTopNav());
            tmpCnti.setArti_isSubNav(article.isArti_isSubNav());

            em.merge(tmpCnti);
            em.getTransaction().commit();
            article = em.find(Article.class, article.getSys_guid());
        } catch (Exception e) {
            cmaLogger.error("CNT_update Error: " + article.getArti_name(), e);
            return null;
        }
        return article;
    }

    @Override
    public List<Object> findAll() throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Object findBySample(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<Object> findAllByPage(String orderByField, int startRow, int chunksize) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Object create(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean update(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(String id) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int deleteAll(Object[] objs) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int deleteAll(String[] strs) throws BaseDBException {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}

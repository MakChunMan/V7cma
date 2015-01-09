package com.imagsky.v6.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.NoResultException;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.util.JPAUtil;
import com.imagsky.v6.domain.Bid;
import com.imagsky.v6.domain.BidItem;
import java.util.ArrayList;

//import com.imagsky.v6.domain.Article;
public class BidDAOImpl extends BidDAO {

    private static BidDAOImpl BidDAOImpl = new BidDAOImpl();

    public static BidDAO getInstance() {
        cmaLogger.debug("LOGGING = BidDAO() ");
        return BidDAOImpl;
    }
    private static final String domainClassName = "com.imagsky.v6.domain.Bid";

    @Override
    protected void beanValidate(Object entityObj)
            throws BaseDBException {
        try {
            if (!Class.forName(domainClassName).isInstance(entityObj)) {
                throw new BaseDBException("Using wrong DAO implementation: " + domainClassName + " with " + entityObj.getClass().getName(), "");
            }
            Class.forName(domainClassName).cast(entityObj);
        } catch (ClassNotFoundException e) {
            throw new BaseDBException("ClassNotFound for " + domainClassName, "", e);

        }
    }

    @Override
    public Object checkAndCreate(Object obj) throws BaseDBException {
        cmaLogger.debug("BidDAOImpl.checkAndCreate: [START]");
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT max(b.bid_price) from Bid AS b WHERE b.biditem_id = :BIDITEM_ID");
        Double maxBid_price = null;
        beanValidate(obj);
        Bid bid = null;
        try {
            bid = (Bid) obj;
            try {
                query.setParameter("BIDITEM_ID", bid.getBiditem_id());
                maxBid_price = (Double) query.getSingleResult();
            } catch (NoResultException nre) {
                maxBid_price = null;
            }
            if (maxBid_price == null || maxBid_price < bid.getBid_price()) {
                em.persist(bid); //Create Bid
                BidItem thisBid = em.find(BidItem.class, bid.getBiditem_id());
                thisBid.setBid_current_price(bid.getBid_price());
                if(bid.getMember()!=null){
                    thisBid.setBid_last_bidMember(bid.getMember());
                } else {
                    thisBid.setBid_last_bidMember(null);
                }
                thisBid.setBid_count(thisBid.getBid_count() + 1);
                em.merge(thisBid);
                em.getTransaction().commit();
            } else {
                em.getTransaction().rollback();
                cmaLogger.warn("BidDAOImpl.checkAndCreate - new price incorrect: [ROLLBACK]");
                return null;
            }
        } catch (Exception e) {
            cmaLogger.error("BidDAOImpl.checkAndCreate - exception: [ROLLBACK]", e);
            em.getTransaction().rollback();
            return null;
        }
        cmaLogger.debug("BidDAOImpl.checkAndCreate: [END]");
        return bid;
    }

    @Override
    public Object create(Object obj) throws BaseDBException {
        cmaLogger.debug("BidDAOImpl.create: [START]");
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        beanValidate(obj);
        Bid bid = (Bid) obj;
        em.persist(bid);
        em.getTransaction().commit();
        cmaLogger.debug("BidDAOImpl.create: [END]");
        return bid;
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
         * EntityManager em = factory.createEntityManager(); Query query =
         * em.createQuery("SELECT mem from Member AS mem WHERE
         * mem.mem_login_email = :loginemail"); try{ beanValidate(obj); Member
         * mem = (Member)obj; query.setParameter("loginemail",
         * mem.getMem_login_email()); return query.getSingleResult(); } catch
         * (NoResultException nre){ cmaLogger.debug("Result not found"); return
         * null; }
		**
         */
        return null;
    }

    @Override
    public boolean update(Object obj) throws BaseDBException {
        /**
         * *
         * beanValidate(obj); try{ Article article = (Article)obj; EntityManager
         * em = factory.createEntityManager(); em.getTransaction().begin();
         * Article tmpArti = em.find(Article.class, article.getSys_guid());
         * tmpArti.setArti_content(article.getArti_content());
         * tmpArti.setArti_lang(article.getArti_lang());
         * tmpArti.setArti_isHighlightSection(article.isArti_isHighlightSection());
         * tmpArti.setArti_isSubNav(article.isArti_isSubNav());
         * tmpArti.setArti_isTopNav(article.isArti_isTopNav());
         * tmpArti.setArti_name(article.getArti_name());
         * tmpArti.setArti_parent_guid(article.getArti_parent_guid());
         *
         * tmpArti.setSys_cma_name(article.getArti_name() + "("+
         * article.getArti_lang()+")");
         * tmpArti.setSys_is_live(article.isSys_is_live());
         * tmpArti.setSys_is_node(article.isSys_is_node());
         * tmpArti.setSys_is_published(article.isSys_is_published());
         * tmpArti.setSys_updator(article.getSys_updator());
         * tmpArti.setSys_update_dt(article.getSys_update_dt());
         *
         *
         *
         * //em.merge(tmpCat); em.getTransaction().commit(); } catch (Exception
         * e){ throw new BaseDBException("Article Exception: ","",e); }
		**
         */
        return false;
    }

    @Override
    public List<Object> findListWithSample(Bid obj)
            throws BaseDBException {
        return findListWithSample(obj, null);
    }

    @Override
    public List<Object> findListWithSample(Bid obj, ArrayList<?> orderByPair) throws BaseDBException {
        EntityManager em = factory.createEntityManager();
        StringBuffer jpql_bf = new StringBuffer("SELECT b from Bid AS b WHERE 1=1 ");
        try {
            beanValidate(obj);
            Bid enqObj = (Bid) obj;

            JPAUtil jpaUtil = new JPAUtil(
                    Bid.getFields(enqObj),
                    Bid.getWildFields());
            Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "b", JPAUtil.getOrderByString("b", orderByPair));
            return query.getResultList();
        } catch (NoResultException nre) {
            cmaLogger.debug("Result not found");
            return null;
        }
    }
}

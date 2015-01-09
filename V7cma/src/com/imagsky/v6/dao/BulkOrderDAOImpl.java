/******
 * 2013-10-02 Allow BO Edit date
 */
package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.PropertiesUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.BulkOrderItem;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

public class BulkOrderDAOImpl extends BulkOrderDAO {

    private static BulkOrderDAOImpl BulkOrderDAOImpl = new BulkOrderDAOImpl();

    public static BulkOrderDAO getInstance() {
        cmaLogger.debug("LOGGING = BulkOrderDAO.getInstance() ");
        return BulkOrderDAOImpl;
    }
    private static final String domainClassName = "com.imagsky.v6.domain.BulkOrderItem";

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
    public Object create(Object obj) throws BaseDBException {
        cmaLogger.debug("BulkOrderDAOImpl.create: [START]");
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        beanValidate(obj);
        BulkOrderItem BulkOrder = (BulkOrderItem) obj;
        em.persist(BulkOrder);
        em.getTransaction().commit();
        cmaLogger.debug("BulkOrderDAOImpl.create: [END]");
        return BulkOrder;
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
         * null; } *
         */
        return null;
    }

    /**
     * ***
     * Update Current Qty ONLY **
     */
    @Override
    public boolean updateCurrentQty(Object obj) throws BaseDBException {
        beanValidate(obj);

        try {
            BulkOrderItem bulkOrder = (BulkOrderItem) obj;
            EntityManager em = factory.createEntityManager();
            em.getTransaction().begin();
            BulkOrderItem tmpBO = em.find(BulkOrderItem.class, bulkOrder.getId());
            tmpBO.setBoiCurrentQty(bulkOrder.getBoiCurrentQty());
            //em.merge(tmpCat);
            em.getTransaction().commit();
            PropertiesUtil.loadBulkOrder("zh");
        } catch (Exception e) {
            throw new BaseDBException("BulkOrder Exception: ", "", e);
        }
        return true;
    }

    /**
     * *
     * Admin use : Update Name, Description and Status only
     */
    @Override
    public boolean update(Object obj) throws BaseDBException {
        beanValidate(obj);

        try {
            BulkOrderItem bulkOrder = (BulkOrderItem) obj;
            EntityManager em = factory.createEntityManager();
            em.getTransaction().begin();
            BulkOrderItem tmpBO = em.find(BulkOrderItem.class, bulkOrder.getId());
            //tmpBO.setBo_current_qty(bulkOrder.getBo_current_qty());
            if (bulkOrder.getBoiName() != null) {
                tmpBO.setBoiName(bulkOrder.getBoiName());
            }
            if (bulkOrder.getBoiDescription() != null) {
                tmpBO.setBoiDescription(bulkOrder.getBoiDescription());
            }
            if (bulkOrder.getBoiStatus() != null) {
                tmpBO.setBoiStatus(bulkOrder.getBoiStatus());
            }
            if(bulkOrder.getBoiCost()!=null){
                tmpBO.setBoiCost(bulkOrder.getBoiCost());
            }
            if(bulkOrder.getBoiClosingQty()!=null){
                tmpBO.setBoiClosingQty(bulkOrder.getBoiClosingQty());
            }
            if(bulkOrder.getBoiPrice1()!=null){
                tmpBO.setBoiPrice1(bulkOrder.getBoiPrice1());
            }
            if(bulkOrder.getBoiPrice2()!=null){
                tmpBO.setBoiPrice2(bulkOrder.getBoiPrice2());
            }
            if(bulkOrder.getBoiPrice1Description()!=null){
                tmpBO.setBoiPrice1Description(bulkOrder.getBoiPrice1Description());
            }
            if(bulkOrder.getBoiPrice2Description()!=null){
                tmpBO.setBoiPrice2Description(bulkOrder.getBoiPrice2Description());
            }            
            if(bulkOrder.getBoiPrice1Stock()!=null){
                tmpBO.setBoiPrice1Stock(bulkOrder.getBoiPrice1Stock());
            }
            if(bulkOrder.getBoiPrice2Stock()!=null){
                tmpBO.setBoiPrice2Stock(bulkOrder.getBoiPrice2Stock());
            }
            if(bulkOrder.getBoiStatus()!=null){
                tmpBO.setBoiStatus(bulkOrder.getBoiStatus());//I:init, A:Active, F:Finished,D: Deleted: Not shown in edit List
            }
            if(bulkOrder.getBoiStartQty()!=null){
                tmpBO.setBoiStartQty(bulkOrder.getBoiStartQty());
            }
            if(bulkOrder.getBoiCurrentQty()!=null){
                tmpBO.setBoiCurrentQty(bulkOrder.getBoiCurrentQty());
            }
            if(bulkOrder.getBoiSellPrice()!=null){
                tmpBO.setBoiSellPrice(bulkOrder.getBoiSellPrice());
            }            
            if(bulkOrder.getBoiCurrentQty()!=null){
                tmpBO.setBoiCurrentQty(bulkOrder.getBoiCurrentQty());
            }                        
            if(bulkOrder.getBoiOption1Name()!=null){
                tmpBO.setBoiOption1Name(bulkOrder.getBoiOption1Name());
            }
            if(bulkOrder.getBoiOption1()!=null){
                tmpBO.setBoiOption1(bulkOrder.getBoiOption1());
            }            
            if(bulkOrder.getBoiOption2Name()!=null){
                tmpBO.setBoiOption2Name(bulkOrder.getBoiOption2Name());
            }
            if(bulkOrder.getBoiOption2()!=null){
                tmpBO.setBoiOption2(bulkOrder.getBoiOption2());
            }            
            if(bulkOrder.getBoiOption3Name()!=null){
                tmpBO.setBoiOption3Name(bulkOrder.getBoiOption3Name());
            }
            if(bulkOrder.getBoiOption3()!=null){
                tmpBO.setBoiOption3(bulkOrder.getBoiOption3());
            }                        
            //2013-10-02 Allow BO Edit Date when No Active
            if(bulkOrder.getBoiStartDate()!=null){
            	tmpBO.setBoiStartDate(bulkOrder.getBoiStartDate());
            }
            if(bulkOrder.getBoiEndDate()!=null){
            	tmpBO.setBoiEndDate(bulkOrder.getBoiEndDate());
            } //End 2013-10-02
            
            //2013-10-16 Update Collection information
            if(bulkOrder.getBoiCollectionStartDate()!=null){
            	tmpBO.setBoiCollectionStartDate(bulkOrder.getBoiCollectionStartDate());
            }
            if(bulkOrder.getBoiCollectionEndDate()!=null){
            	tmpBO.setBoiCollectionEndDate(bulkOrder.getBoiCollectionEndDate());
            }
            if(bulkOrder.getBoiCollectionRemarks()!=null){
            	tmpBO.setBoiCollectionRemarks(bulkOrder.getBoiCollectionRemarks());
            }
            
            //em.merge(tmpCat);
            em.getTransaction().commit();
            PropertiesUtil.loadBulkOrder("zh");
            }   catch (Exception e) {
            throw new BaseDBException("BulkOrder Exception: ", "", e);
        }
        return true;
    }

    /**
     * *
     * Admin use
     */
    /**
     * ****
     * @Override public boolean updateItem(BulkOrder obj) throws BaseDBException
     * { beanValidate(obj);
     *
     * try { BulkOrder bulkOrder = (BulkOrder) obj; EntityManager em =
     * factory.createEntityManager(); em.getTransaction().begin(); BulkOrder
     * tmpBO = em.find(BulkOrder.class, bulkOrder.getId());
     *
     * Iterator<SellItem> it = obj.getSellItems().iterator(); SellItem tmpObj;
     * Collection<SellItem> newCollection = new ArrayList<SellItem>(); while
     * (it.hasNext()) { tmpObj = (SellItem) it.next(); if
     * (!BulkOrder.isProductInBulkOrder(tmpBO, tmpObj.getSys_guid())) {
     * newCollection.add(tmpObj); } } HashSet<SellItem> aHashSet = new
     * HashSet<SellItem>(newCollection); aHashSet.addAll(tmpBO.getSellItems());
     *
     * //cmaLogger.debug("HashSet"+ aHashSet.size());
     *
     * tmpBO.setSellItems(aHashSet); em.getTransaction().commit();
     * PropertiesUtil.loadBulkOrder("zh"); } catch (Exception e) { throw new
     * BaseDBException("BulkOrder Exception: ", "", e); } return true; }
    ****
     */
    @Override
    public List<Object> findListWithSample(BulkOrderItem obj)
            throws BaseDBException {
        EntityManager em = factory.createEntityManager();
        //StringBuffer jpql_bf = new StringBuffer("SELECT boi from BulkOrderItem AS boi WHERE boi.boiStatus != 'D' ");
        StringBuffer jpql_bf = new StringBuffer("SELECT boi from BulkOrderItem AS boi WHERE boi.boiStatus <> 'D' ");

        try {
            beanValidate(obj);
            BulkOrderItem enqObj = (BulkOrderItem) obj;

            JPAUtil jpaUtil = new JPAUtil(
                    BulkOrderItem.getFields(enqObj),
                    BulkOrderItem.getWildFields());

            Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "boi", " order by boi.boiEndDate DESC");
            List al = query.getResultList();
            cmaLogger.debug(query.toString());
            cmaLogger.debug("Query result size:=" + al.size());
            return query.getResultList();
        } catch (NoResultException nre) {
            cmaLogger.debug("Result not found");
            return null;
        }
    }

    @Override
    public List<Object> findAll(boolean onlineOnly, boolean refresh)
            throws BaseDBException {
        EntityManager em = factory.createEntityManager();
        StringBuffer jpql_bf = new StringBuffer("SELECT bo from BulkOrderItem AS bo WHERE 1=1 ");

        try {

            if (onlineOnly) {
                jpql_bf.append(" and bo.boiStartDate < :start AND bo.boiEndDate > :end ");
            }
            BulkOrderItem enqObj = new BulkOrderItem();
            JPAUtil jpaUtil = new JPAUtil(
                    BulkOrderItem.getFields(enqObj),
                    BulkOrderItem.getWildFields());

            Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "bo", " order by bo.boiStartDate desc");
            if (onlineOnly) {
                Date now = new Date();
                query.setParameter("start", now).setParameter("end", now);
            }
            if (refresh) {
                query.setHint("javax.persistence.cache.storeMode", "REFRESH");
            }
            return query.getResultList();
        } catch (NoResultException nre) {
            cmaLogger.debug("Result not found");
            return null;
        }
    }
}

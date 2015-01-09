/*****************
 *  2013-09-17 V7 enhancement - thisDomainClassName
 * 
 */
package com.imagsky.v6.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Node;
import com.imagsky.v6.domain.SysObject;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

public class NodeDAOImpl extends NodeDAO {

    private static NodeDAOImpl nodeDAOImpl = new NodeDAOImpl();

    public static NodeDAO getInstance() {
        return nodeDAOImpl;
    }
    
    private static final String thisDomainClassName = "com.imagsky.v6.domain.Node";

    NodeDAOImpl() {
    	super.setDomainClassName(thisDomainClassName);
        //super.domainClassName = NodeDAOImpl.domainClassName;
    }

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
    public Object CNT_update(Object obj) throws BaseDBException {
        Class thisContentClass = contentClassValidation(domainClassName);
        EntityManager em = factory.createEntityManager();

        beanValidate(obj);
        Node tmp = (Node) obj;

        try {
            em.getTransaction().begin();
            Node tmpCnti = em.find(Node.class, tmp.getSys_guid());

            if (!CommonUtil.isNullOrEmpty(tmp.getNod_url())) {
                tmpCnti.setNod_url(tmp.getNod_url());
            }
            tmpCnti.setNod_bannerurl(tmp.getNod_bannerurl());
            tmpCnti.setNod_cacheurl(tmp.getNod_cacheurl());
            if (!CommonUtil.isNullOrEmpty(tmp.getNod_contentGuid())) {
                tmpCnti.setNod_contentGuid(tmp.getNod_contentGuid());
            }
            tmpCnti.setNod_description(tmp.getNod_description());
            tmpCnti.setNod_keyword(tmp.getNod_keyword());
            if (!CommonUtil.isNullOrEmpty(tmp.getNod_owner())) {
                tmpCnti.setNod_owner(tmp.getNod_owner());
            }
            tmpCnti.setSys_update_dt(new java.util.Date());
            tmpCnti.setSys_updator(tmp.getSys_updator());

            em.merge(tmpCnti);
            em.getTransaction().commit();
            tmp = em.find(Node.class, tmpCnti.getSys_guid());
        } catch (Exception e) {
            cmaLogger.error("CNT_update Error: " + tmp.getNod_url(), e);
            return null;
        }
        return tmp;
    }

    @Override
    public Object create(Object obj) throws BaseDBException {
        cmaLogger.debug("NodeDAOImpl.create: [START]");
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        beanValidate(obj);
        Node node = (Node) obj;
        if (node.getSys_guid() == null) {
            node.setSys_guid(UUIDUtil.getNewUUID("node" + new java.util.Date().toString()));
            node.setSys_master_lang_guid(node.getSys_guid());
        }
        node.setSys_create_dt(new java.util.Date());
        node.setSys_update_dt(new java.util.Date());
        node.setSys_is_live(true);
        node.setSys_is_node(true);
        node.setSys_is_published(true);
        em.persist(node);
        em.getTransaction().commit();
        cmaLogger.debug("NodeDAOImpl.create: [END]");
        return node;
    }

    //TODO: Need further check 20140109
    /***
    @Override
    public boolean delete(Object obj) throws BaseDBException {
        beanValidate(obj);
        List al = findListWithSample((Node) obj);
        if (al == null) {
            return false;
        } else {
            for (int x = 0; x < al.size(); x++) {
                delete(((Node) al.get(x)).getSys_guid());
            }
            return true;
        }
    }***/

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

    @Override
    public boolean update(Object obj) throws BaseDBException {
        beanValidate(obj);

        try {
            Node node = (Node) obj;
            EntityManager em = factory.createEntityManager();
            em.getTransaction().begin();
            Node tmpNode = em.find(Node.class, node.getSys_guid());
            if (!CommonUtil.isNullOrEmpty(node.getNod_bannerurl())) {
                tmpNode.setNod_bannerurl(node.getNod_bannerurl());
            }

            if (!CommonUtil.isNullOrEmpty(node.getNod_url())) {
                tmpNode.setNod_url(node.getNod_url());
            }

            if (!CommonUtil.isNullOrEmpty(node.getNod_keyword())) {
                tmpNode.setNod_keyword(node.getNod_keyword());
            }

            if (!CommonUtil.isNullOrEmpty(node.getNod_description())) {
                tmpNode.setNod_description(node.getNod_description());
            }
            //20110907 Cache URL Update
            if (!CommonUtil.isNullOrEmpty(node.getNod_cacheurl())) {
                tmpNode.setNod_cacheurl(node.getNod_cacheurl());
            }
            tmpNode.setSys_update_dt(new java.util.Date());
            //em.merge(tmpCat);
            em.getTransaction().commit();
        } catch (Exception e) {
            throw new BaseDBException("Node Exception: ", "", e);
        }

        return true;
    }

    @Override
    public List<Object> findListWithSample(Node obj)
            throws BaseDBException {
        EntityManager em = factory.createEntityManager();
        StringBuffer jpql_bf = new StringBuffer("SELECT n from Node AS n WHERE 1=1 ");

        try {
            beanValidate(obj);
            Node enqObj = (Node) obj;

            JPAUtil jpaUtil = new JPAUtil(
                    Node.getFields(enqObj),
                    Node.getWildFields());

            Query query = jpaUtil.getQuery(em, jpql_bf.toString(), "n", " order by n.sys_priority");
            return query.getResultList();
        } catch (NoResultException nre) {
            cmaLogger.debug("Result not found");
            return null;
        }
    }

    @Override
    public Map<String, Node> findNodeListWithSample(List<Object> contentList, String keyMode)
            throws BaseDBException {

        SysObject tmpObj = null;
        StringBuffer inList = new StringBuffer();

        EntityManager em = factory.createEntityManager();

        if (contentList == null) {
            return null;
        }
        if (contentList.size() == 0) {
            return null;
        }

        Iterator it_a = contentList.iterator();
        while (it_a.hasNext()) {
            tmpObj = (SysObject) it_a.next();
            if (!CommonUtil.isNullOrEmpty(inList.toString())) {
                inList.append(",");
            }
            inList.append("'" + tmpObj.getSys_guid() + "'");
        }

        //For JPA in clause empty list handling
        //if(inList.size()==0)
        //	inList.add("");

        //inList.add("'A'");inList.add("'E'");
        HashMap<String, Node> aMap = new HashMap<String, Node>();
        try {
            Query query = em.createQuery("select n from Node n where n.nod_contentGuid in (" + inList.toString() + ")");
            List<?> resultNodeList = query.getResultList();
            Iterator<Node> it = (Iterator<Node>) resultNodeList.iterator();

            Node a;
            while (it.hasNext()) {
                a = new Node();
                a = (Node) it.next();
                if (keyMode.equalsIgnoreCase(SystemConstants.NODMAP_KEY_C_GUID)) {
                    aMap.put(a.getNod_contentGuid(), a);
                } else if (keyMode.equalsIgnoreCase(SystemConstants.NODMAP_KEY_N_URL)) {
                    aMap.put(a.getNod_url(), a);
                }
            }
            return aMap;
        } catch (NoResultException nre) {
            cmaLogger.debug("Result not found");
            return null;
        }
    }
}

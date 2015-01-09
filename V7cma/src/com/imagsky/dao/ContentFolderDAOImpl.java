/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.dao;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v7.domain.ContentFolder;
import java.util.List;
import javax.persistence.EntityManager;

/**
 * @author jasonmak
 */
public class ContentFolderDAOImpl extends ContentFolderDAO {

    private static ContentFolderDAOImpl contentFolderDAOImpl = new ContentFolderDAOImpl();
    protected static final String thisDomainClassName = "com.imagsky.v7.domain.ContentFolder";

    ContentFolderDAOImpl() {
    	super.setDomainClassName(thisDomainClassName);
    }

    public static ContentFolderDAO getInstance() {
        return contentFolderDAOImpl;
    }

    @Override
    public Object CNT_update(Object obj) throws BaseDBException {
        Class thisContentClass = contentClassValidation(domainClassName);
        EntityManager em = factory.createEntityManager();

        beanValidate(obj);
        ContentFolder cf = (ContentFolder) obj;

        try {
            em.getTransaction().begin();
            ContentFolder tmpCnti = em.find(ContentFolder.class, cf.getSys_guid());

            if (!CommonUtil.isNullOrEmpty(cf.getCF_NAME())) {
                tmpCnti.setCF_NAME(cf.getCF_NAME());
            }
            tmpCnti.setCF_DESC(cf.getCF_DESC());
            tmpCnti.setSys_update_dt(new java.util.Date());
            tmpCnti.setSys_updator(cf.getSys_updator());
            em.merge(tmpCnti);
            em.getTransaction().commit();
            cf = em.find(ContentFolder.class, cf.getSys_guid());
        } catch (Exception e) {
            cmaLogger.error("CNT_update Error: " + cf.getCF_NAME(), e);
            return null;
        }
        return cf;
    }

    @Override
    public List<Object> findAll() throws BaseDBException {
        throw new UnsupportedOperationException("To be remove. V6 methods woyld not be used for V7.");
    }

    @Override
    public Object findBySample(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("To be remove. V6 methods woyld not be used for V7.");
    }

    @Override
    public List<Object> findAllByPage(String orderByField, int startRow, int chunksize) throws BaseDBException {
        throw new UnsupportedOperationException("To be remove. V6 methods woyld not be used for V7.");
    }

    @Override
    public Object create(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("To be remove. V6 methods woyld not be used for V7.");
    }

    @Override
    public boolean update(Object obj) throws BaseDBException {
        throw new UnsupportedOperationException("To be remove. V6 methods woyld not be used for V7.");
    }
}

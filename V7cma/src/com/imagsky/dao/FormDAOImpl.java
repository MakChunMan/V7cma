package com.imagsky.dao;

import java.util.HashSet;
import java.util.List;







import javax.persistence.EntityManager;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v8.domain.AppImage;
import com.imagsky.v8.domain.FormField;
import com.imagsky.v8.domain.ModAboutPage;
import com.imagsky.v8.domain.ModForm;

public class FormDAOImpl extends FormDAO {


    private static FormDAOImpl impl = new FormDAOImpl();
    protected static final String thisDomainClassName = "com.imagsky.v8.domain.ModForm";
    
    FormDAOImpl() {
    	super.setDomainClassName(thisDomainClassName);
    }

    public static FormDAO getInstance() {
        return impl;
    }
	@Override
	public Object CNT_update(Object obj) throws BaseDBException {
		Class thisContentClass = contentClassValidation(domainClassName);
        EntityManager em = factory.createEntityManager();

        beanValidate(obj);
        ModForm module = (ModForm) obj;
        FormFieldDAO subdao = FormFieldDAO.getInstance();
        
        try {
            em.getTransaction().begin();
            ModForm tmpModule = em.find(ModForm.class, module.getSys_guid());
            if (!CommonUtil.isNullOrEmpty(module.getForm_name())) {
            	tmpModule.setForm_name(module.getForm_name());
            }
            tmpModule.setForm_fields(module.getForm_fields());
            HashSet<FormField> aSet = new HashSet<FormField>();
            for(FormField thisFormField: module.getForm_fields()){
            	thisFormField.setForm(tmpModule);
	            if(thisFormField.getSys_guid()==null){
	            	//Create
	            	//cmaLogger.debug("Create form field");
	            	aSet.add((FormField)subdao.CNT_create(thisFormField));
	            } else { 
	            	//Update
	            	//cmaLogger.debug("Update form field");
	            	aSet.add((FormField)subdao.CNT_update(thisFormField));
	            }
            }
            
            
            
            tmpModule.setSys_update_dt(new java.util.Date());
            tmpModule.setSys_updator(module.getSys_updator());
            tmpModule.setSys_clfd_guid(module.getSys_clfd_guid());
            tmpModule.setSys_is_live(module.isSys_is_live());
            tmpModule.setSys_is_published(module.isSys_is_published());
            tmpModule.setSys_is_node(module.isSys_is_node());
            
            em.merge(tmpModule);
            em.getTransaction().commit();
            module = em.find(ModForm.class, module.getForm_name());
        } catch (Exception e) {
            cmaLogger.error("CNT_update Error: " + module.getForm_name(), e);
            return null;
        }
        return module;
	}

	@Override
	public List<Object> findAll() throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object findBySample(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findAllByPage(String orderByField, int startRow, int chunksize) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object create(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean update(Object obj) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
	}
}

package com.imagsky.dao;

import java.util.List;


import javax.persistence.EntityManager;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v8.domain.AppImage;
import com.imagsky.v8.domain.ModAboutPage;

public class ModAboutPageDAOImpl extends ModAboutPageDAO {

    private static ModAboutPageDAOImpl modAboutPageDAOImpl = new ModAboutPageDAOImpl();
    protected static final String thisDomainClassName = "com.imagsky.v8.domain.ModAboutPage";
    
    ModAboutPageDAOImpl() {
    	super.setDomainClassName(thisDomainClassName);
    }

    public static ModAboutPageDAOImpl getInstance() {
        return modAboutPageDAOImpl;
    }
    
	@Override
	public Object CNT_update(Object obj) throws BaseDBException {
		Class thisContentClass = contentClassValidation(domainClassName);
        EntityManager em = factory.createEntityManager();

        beanValidate(obj);
        ModAboutPage module = (ModAboutPage) obj;
        AppImageDAO subdao = AppImageDAO.getInstance();
        
        try {
            em.getTransaction().begin();
            ModAboutPage tmpModule = em.find(ModAboutPage.class, module.getSys_guid());
            AppImage tmpAppImage = em.find(AppImage.class, tmpModule.getPageImage().getSys_guid());
            //Update AppImage
            if(tmpModule.getPageImage()!=null && tmpAppImage!=null){
            	tmpAppImage.setImageUrl(module.getPageImage().getImageUrl());
            	subdao.CNT_update(tmpAppImage);
            }
            
            if (!CommonUtil.isNullOrEmpty(module.getPageTitle())) {
            	tmpModule.setPageTitle(module.getPageTitle());
            }
            tmpModule.setPageAbout(module.getPageAbout());
            tmpModule.setPageAddress(module.getPageAddress());
            tmpModule.setPageDescription(module.getPageDescription());
            tmpModule.setPageEmail(module.getPageEmail());
            tmpModule.setPageFacebookLink(module.getPageFacebookLink());

            cmaLogger.debug("tmpModule:"+ tmpModule.getPageImage());
            cmaLogger.debug("module:"+module.getPageImage());
            
        	
            if(tmpModule.getPageImage()==null && module.getPageImage()!=null){
            	//Create
            	tmpModule.setPageImage((AppImage)subdao.CNT_create(module.getPageImage()));
            } else if(tmpModule.getPageImage()!=null && module.getPageImage()!=null) { 
            	//Update
            	/****
            	AppImage tmpAppImage = em.find(AppImage.class, tmpModule.getPageImage().getSys_guid());
            	tmpAppImage.setImageUrl(module.getPageImage().getImageUrl());
            	cmaLogger.debug("guid:"+ tmpAppImage.getSys_guid());
            	subdao.CNT_update(tmpAppImage);
            	****/
            	//tmpModule.setPageImage((AppImage)subdao.CNT_update(tmpAppImage));
            } else { 
            	//Remove
            	subdao.CNT_delete(tmpModule.getPageImage());
            	tmpModule.setPageImage(null);
            }
            
            tmpModule.setSys_update_dt(new java.util.Date());
            tmpModule.setSys_updator(module.getSys_updator());
            tmpModule.setSys_clfd_guid(module.getSys_clfd_guid());
            tmpModule.setSys_is_live(module.isSys_is_live());
            tmpModule.setSys_is_published(module.isSys_is_published());
            tmpModule.setSys_is_node(module.isSys_is_node());
            
            em.merge(module);
            em.getTransaction().commit();
            module = em.find(ModAboutPage.class, module.getPageTitle());
        } catch (Exception e) {
            cmaLogger.error("CNT_update Error: " + module.getPageTitle(), e);
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

	@Override
	public boolean delete(String id) throws BaseDBException {
		// TODO Auto-generated method stub
		return false;
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

}


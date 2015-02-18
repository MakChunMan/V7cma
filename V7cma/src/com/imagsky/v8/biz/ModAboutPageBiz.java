package com.imagsky.v8.biz;

import java.util.List;

import java.util.Map;







import com.imagsky.dao.AppImageDAO;
import com.imagsky.dao.FormDAO;
import com.imagsky.dao.ModAboutPageDAO;
import com.imagsky.exception.BaseDBException;
import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v8.domain.AppImage;
import com.imagsky.v8.domain.ModAboutPage;
import com.imagsky.v8.domain.ModForm;
import com.imagsky.v8.domain.Module;

public class ModAboutPageBiz extends BaseModuleBiz {

	private Module returnModule;
	
	@Override
	public Module execute(ModuleBiz biz, String actionCode, Map paramMap)
			throws BaseException {

			this.thisParamMap = paramMap;
			//Assign Class Type
			assignClass(ModAboutPage.class);
			//Dispatch Action
			if(ModuleBiz.ACTION_CODE.CREATE.name().equalsIgnoreCase(actionCode)){
				returnModule = doCreate();
			} else if(ModuleBiz.ACTION_CODE.UPDATE.name().equalsIgnoreCase(actionCode)){
				returnModule = doUpdate();
			} else if(ModuleBiz.ACTION_CODE.DELETE.name().equalsIgnoreCase(actionCode)){
				returnModule = doDelete();
			} else  if(ModuleBiz.ACTION_CODE.FIND.name().equalsIgnoreCase(actionCode)){
				returnModule = doFind();
			}
			return returnModule;
	}


	private Module doUpdate() {
		ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
		AppImageDAO adao = AppImageDAO.getInstance();
		
		ModAboutPage enqObj = new ModAboutPage();
		
		AppImage thisAppImage = null;
		
        if (!CommonUtil.isNullOrEmpty(this.getParamToString("MODGUID"))) {
        	enqObj.setSys_guid(this.getParamToString("MODGUID"));
        }
        try{
	        enqObj.setPageTitle(this.getParamToString("edit-abt-title"));
	        enqObj.setPageAbout(this.getParamToString("edit-abt-about"));
	        enqObj.setPageAddress(this.getParamToString("edit-abt-address"));
	        enqObj.setPageDescription(this.getParamToString("edit-abt-desc"));
	        enqObj.setPageEmail(this.getParamToString("edit-abt-email"));
	        enqObj.setPageFacebookLink(this.getParamToString("edit-abt-fb"));
	
	        //Common field
	        if(!CommonUtil.isNullOrEmpty(this.getParamToString("mod_bg_response"))){
	        	thisAppImage = new AppImage(this.thisApp, this.getParamToString("mod_bg_response"));
	        	List alist =  adao.CNT_findListWithSample(thisAppImage);
	        	if(CommonUtil.isNullOrEmpty(alist)){
	        		enqObj.setModBackground(thisAppImage);
	        	} else {
	        		thisAppImage = (AppImage)alist.get(0);
	        		thisAppImage.setImageUrl(this.getParamToString("mod_bg_response"));
	        		enqObj.setModBackground(thisAppImage);
	        	}
	        } else {
	        	enqObj.setModBackground(null);
	        }
	        
	        cmaLogger.debug("mod_icon_response: "+this.getParamToString("mod_icon_response"));
	        if(!CommonUtil.isNullOrEmpty(this.getParamToString("mod_icon_response"))){
	        	thisAppImage = new AppImage(this.thisApp, this.getParamToString("mod_icon_response"));
	        	List alist =  adao.CNT_findListWithSample(thisAppImage);
	        	if(CommonUtil.isNullOrEmpty(alist)){
	        		cmaLogger.debug("mod_icon_response: Not found");
	        		enqObj.setModIcon(thisAppImage);
	        	} else {
	        		cmaLogger.debug("mod_icon_response: Found");
	        		thisAppImage = (AppImage)alist.get(0);
	        		thisAppImage.setImageUrl(this.getParamToString("mod_icon_response"));
	        		enqObj.setModIcon(thisAppImage);
	        	}
	        }else {
	        	enqObj.setModIcon(null);
	        }
	        //End of Common field
	        
	        cmaLogger.debug("abt_image_response: "+this.getParamToString("abt_image_response"));
	        if(!CommonUtil.isNullOrEmpty(this.getParamToString("abt_image_response"))){
	        	cmaLogger.debug("thisApp:" + this.thisApp);
	        	thisAppImage = new AppImage(this.thisApp, this.getParamToString("abt_image_response"));
	        	List alist =  adao.CNT_findListWithSample(thisAppImage);
	        	if(CommonUtil.isNullOrEmpty(alist)){
	        		cmaLogger.debug("empty List");
	        		enqObj.setPageImage(thisAppImage);
	        	} else {
	        		cmaLogger.debug("not empty List");
	        		//(AppImage)subdao.CNT_update(tmpAppImage));
	        		thisAppImage = (AppImage)alist.get(0);
	        		thisAppImage.setImageUrl(this.getParamToString("edit-abt-image"));
	        		enqObj.setPageImage(thisAppImage);
	        	}
	        } else {
	        	enqObj.setPageImage(null);
	        }
	        
	        enqObj.setSys_update_dt(new java.util.Date());
	        enqObj.setSys_updator(this.getParamToString("updator"));
	        //enqObj.setSys_clfd_guid(module.getSys_clfd_guid());
	        enqObj.setSys_is_live(Boolean.TRUE);
	        enqObj.setSys_is_published(Boolean.TRUE);
	        enqObj.setSys_is_node(Boolean.FALSE);
	        enqObj = (ModAboutPage)mdao.CNT_update(enqObj);		
        } catch (BaseDBException e) {
			cmaLogger.error("ModAboutPageBiz.doUpdate()", e);
		}
        return enqObj;
	}


	private Module doFind() {
		ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
		ModAboutPage enqObj = new ModAboutPage();
		try{
			enqObj.setSys_guid((String)thisParamMap.get("guid"));
			List aList = mdao.CNT_findListWithSample(enqObj);
			if(aList==null || aList.size()==0){
				cmaLogger.debug(aList.toString());
				return null;
			}
			enqObj = (ModAboutPage) aList.get(0);
			//ModAboutPageForJson jsonObj = new ModAboutPageForJson(enqObj);
			//cmaLogger.debug(jsonObj.getJsonString());
		} catch (BaseDBException e) {
			cmaLogger.error("ModAboutPageBiz.doFind()", e);
		}
		return enqObj;
	}


	private Module doCreate(){
		ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
		ModAboutPage newMod = new ModAboutPage();
		try {
			newMod.setModDisplayOrder((Integer)thisParamMap.get("idx"));
			newMod.setPageTitle("A new "+ Module.ModuleTypes.ModAboutPage.name());
			newMod.setPageAbout("");
			newMod.setPageAddress("");
			newMod.setPageDescription("");
			newMod.setPageFacebookLink("");
			newMod.setPageImage(null);
			newMod.setPageEmail("");
			newMod.setPageFacebookLink("");
			newMod = (ModAboutPage)mdao.CNT_create(newMod);
		} catch (BaseDBException e) {
			cmaLogger.error("ModAboutPageBiz.doCreate()", e);
		}
		return newMod;
	}
	
	private Module doDelete(){
		ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
		ModAboutPage newMod = new ModAboutPage();
		try {
			newMod.setSys_guid((String)thisParamMap.get("guid"));
			mdao.CNT_delete(newMod);
		} catch (BaseDBException e) {
			cmaLogger.error("ModAboutPageBiz.doDelete()", e);
		}
		return newMod;
	}
}

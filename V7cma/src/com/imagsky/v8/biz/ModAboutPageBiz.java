package com.imagsky.v8.biz;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.dao.AppDAO;
import com.imagsky.dao.ModAboutPageDAO;
import com.imagsky.exception.BaseDBException;
import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.Member;
import com.imagsky.v7.biz.V7AbstractBiz;
import com.imagsky.v8.domain.ModAboutPage;
import com.imagsky.v8.domain.Module;

public class ModAboutPageBiz extends BaseModuleBiz {

	private ModuleBiz callerBiz;
	private Module returnModule;
	
	@Override
	public Module execute(ModuleBiz biz, String actionCode, Map paramMap)
			throws BaseException {

			//
			this.callerBiz = biz;
			this.thisParamMap = paramMap;
			//Assign Class Type
			assignClass(ModAboutPage.class);
			//Dispatch Action
			if(ModuleBiz.ACTION_CODE.CREATE.name().equalsIgnoreCase(actionCode)){
				returnModule = doCreate();
			} else if(ModuleBiz.ACTION_CODE.UPDATE.name().equalsIgnoreCase(actionCode)){
				returnModule = doUpdate();
			} else if(ModuleBiz.ACTION_CODE.DELETE.name().equalsIgnoreCase(actionCode)){
				
			} else  if(ModuleBiz.ACTION_CODE.FIND.name().equalsIgnoreCase(actionCode)){
				returnModule = doFind();
			}
			return returnModule;
	}


	private Module doUpdate() {
		ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
		ModAboutPage enqObj = new ModAboutPage();
		
        if (!CommonUtil.isNullOrEmpty((String)this.thisParamMap.get("MODGUID"))) {
        	enqObj.setSys_guid((String)this.thisParamMap.get("MODGUID"));
        }
        enqObj.setPageTitle((String)this.thisParamMap.get("edit-abt-title"));
        enqObj.setPageAbout((String)this.thisParamMap.get("edit-abt-about"));
        enqObj.setPageAddress((String)this.thisParamMap.get("edit-abt-address"));
        enqObj.setPageDescription((String)this.thisParamMap.get("edit-abt-desc"));
        enqObj.setPageEmail((String)this.thisParamMap.get("edit-abt-email"));
        enqObj.setPageFacebookLink((String)this.thisParamMap.get("edit-abt-fb"));

        enqObj.setSys_update_dt(new java.util.Date());
        enqObj.setSys_updator(module.getSys_updator());
        enqObj.setSys_clfd_guid(module.getSys_clfd_guid());
        enqObj.setSys_is_live(Boolean.TRUE);
        enqObj.setSys_is_published(Boolean.TRUE);
        enqObj.setSys_is_node(Boolean.FALSE);
        
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
}

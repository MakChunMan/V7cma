package com.imagsky.v8.biz;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.dao.AppDAO;
import com.imagsky.dao.ModAboutPageDAO;
import com.imagsky.exception.BaseDBException;
import com.imagsky.exception.BaseException;
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
				
			} else if(ModuleBiz.ACTION_CODE.DELETE.name().equalsIgnoreCase(actionCode)){
				
			}
			return returnModule;
	}


	private Module doCreate(){
		ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
		ModAboutPage newMod = new ModAboutPage();
		try {
			newMod.setModDisplayOrder((Integer)thisParamMap.get("idx"));
			newMod.setPageTitle("A new "+ Module.ModuleTypes.ModAboutPage.name());
			newMod = (ModAboutPage)mdao.CNT_create(newMod);
		} catch (BaseDBException e) {
			cmaLogger.error("ModAboutPageBiz.doCreate()", e);
		}
		return newMod;
	}
}

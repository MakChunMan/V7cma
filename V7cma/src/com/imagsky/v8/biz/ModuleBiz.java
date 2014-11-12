package com.imagsky.v8.biz;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.dao.AppDAO;
import com.imagsky.dao.ModAboutPageDAO;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.Member;
import com.imagsky.v7.biz.V7AbstractBiz;
import com.imagsky.v8.domain.App;
import com.imagsky.v8.domain.ModAboutPage;
import com.imagsky.v8.domain.Module;

public class ModuleBiz  extends V7AbstractBiz {

	protected ModuleBiz(Member thisMember, HttpServletRequest req) {
		super(thisMember, req);
	}
	
	private static ModuleBiz instance = null;
	
	public static ModuleBiz getInstance(Member thisMember, HttpServletRequest req) {
	      if(instance == null) {
	         instance = new ModuleBiz(thisMember, req);
	      } else {
	    	instance.reset(thisMember, req);  
	      }
	      return instance;
	}

	public Module createModule(int idx, App thisApp, String moduleTypeName){
		Module returnModule = null;
		try{
			if(Module.ModuleTypes.ModAboutPage.name().equalsIgnoreCase(moduleTypeName)){
				AppDAO dao = AppDAO.getInstance();
				ModAboutPage newMod = new ModAboutPage();
				//newMod.setModOwnerApp(super.getThisWorkingApp());
				newMod.setModDisplayOrder(idx);
				newMod.setPageTitle("A new "+ Module.ModuleTypes.ModAboutPage.name());
				//newMod = (ModAboutPage)dao.CNT_create(newMod);

				//Create Child
				ModAboutPageDAO mdao = ModAboutPageDAO.getInstance();
				newMod = (ModAboutPage)mdao.CNT_create(newMod);
				//Add association
				Set<Module> aSet = new HashSet<Module>(thisApp.getModules());
				aSet.add(newMod);

				thisApp.setModules(aSet);
				dao.CNT_update(thisApp);
				returnModule = newMod;
			} else {}
		} catch (Exception e){
			cmaLogger.error("ModuleBiz exception:", e);
		}
		return returnModule;
	}
}

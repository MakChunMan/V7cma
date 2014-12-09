package com.imagsky.v8.biz;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.dao.AppDAO;
import com.imagsky.dao.ModAboutPageDAO;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.servlet.handler.HandlerFactory;
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

	public enum ACTION_CODE { CREATE, UPDATE, DELETE };
	
	public Module createModule(int idx, App thisApp, String moduleTypeName){
		Module returnModule = null;
		BaseModuleBiz moduleBiz;
		try{
				AppDAO dao = AppDAO.getInstance();
				Map aParamMap = new HashMap();
				aParamMap.put("idx", new Integer(idx));
				//Create Child
				moduleBiz = ModuleBizFactory.createBusiness(moduleTypeName);
				returnModule = moduleBiz.execute(this, ACTION_CODE.CREATE.name(), aParamMap);
				//Add association
				Set<Module> aSet = new HashSet<Module>(thisApp.getModules());
				aSet.add(returnModule);
				thisApp.setModules(aSet);
				dao.CNT_update(thisApp);
		} catch (Exception e){
			cmaLogger.error("ModuleBiz exception:", e);
		}
		return returnModule;
	}
}

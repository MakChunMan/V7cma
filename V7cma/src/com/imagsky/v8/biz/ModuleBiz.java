package com.imagsky.v8.biz;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.dao.AppDAO;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.domain.Member;
import com.imagsky.v7.biz.V7AbstractBiz;
import com.imagsky.v8.domain.App;
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

	public enum ACTION_CODE { CREATE, UPDATE, DELETE, FIND };
	
	public Module createModule(int idx, App thisApp, String moduleTypeName){
		Module returnModule = null;
		BaseModuleBiz moduleBiz;
		try{
				AppDAO dao = AppDAO.getInstance();
				Map aParamMap = new HashMap();
				aParamMap.put("idx", new Integer(idx));
				//Create Child
				moduleBiz = ModuleBizFactory.createBusiness(moduleTypeName);
				moduleBiz.setApp(this.getThisWorkingApp());
				
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
	
	public Module getModule(String moduleTypeName, String guid){
		Module returnModule = null;
		BaseModuleBiz moduleBiz;
		try{
				Map aParamMap = new HashMap();
				aParamMap.put("guid", guid);
				//Find Child by guid
				moduleBiz = ModuleBizFactory.createBusiness(moduleTypeName);
				moduleBiz.setApp(this.getThisWorkingApp());
				returnModule = moduleBiz.execute(this, ACTION_CODE.FIND.name(), aParamMap);
		} catch (Exception e){
			cmaLogger.error("ModuleBiz exception:", e);
		}
		return returnModule;
	}

	
	public Module updateModule(String moduleTypeName, String moduleGuid){
		Module returnModule = null;
		BaseModuleBiz moduleBiz;
		Module thisModule;
		try{
			Map aParamMap = new HashMap();
			aParamMap.put("guid", moduleGuid);
			aParamMap.put("updator", owner.getSys_guid()); //thismember
			aParamMap.putAll(paramMap);
			moduleBiz = ModuleBizFactory.createBusiness(moduleTypeName);
			moduleBiz.setApp(this.getThisWorkingApp());
			returnModule = moduleBiz.execute(this, ACTION_CODE.UPDATE.name(), aParamMap);
		} catch (Exception e){
			this.addErrorMsg("ModuleBiz update exception: "+ this.getAllParamToString());
			cmaLogger.error("ModuleBiz exception:", e);
		}
		return returnModule;
	}
	
	public void deleteModule(App thisApp, String moduleTypeName, String moduleGuid){
		BaseModuleBiz moduleBiz;
		AppDAO dao = AppDAO.getInstance();
		try{
			Map aParamMap = new HashMap();
			aParamMap.put("guid", moduleGuid);
			aParamMap.putAll(paramMap);
			moduleBiz = ModuleBizFactory.createBusiness(moduleTypeName);
			moduleBiz.setApp(this.getThisWorkingApp());
			moduleBiz.execute(this, ACTION_CODE.DELETE.name(), aParamMap);
			//Delete from set
			Set<Module> aSet = new HashSet<Module>(thisApp.getModules());
			Set<Module> resultSet = new HashSet<Module>(thisApp.getModules());
			for(Module thisModule : aSet){
				if(thisModule.getSys_guid().equalsIgnoreCase(moduleGuid)){
					resultSet.remove(thisModule);
				}
			}
			thisApp.setModules(resultSet);
			dao.CNT_update(thisApp);
		} catch (Exception e){
			this.addErrorMsg("ModuleBiz delete exception: "+ this.getAllParamToString());
			cmaLogger.error("ModuleBiz exception:", e);
		}
		return;
	}
}

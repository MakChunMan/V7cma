package com.imagsky.v8.biz;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.dao.AppDAO;
import com.imagsky.dao.ContentFolderDAO;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v7.biz.V7AbstractBiz;
import com.imagsky.v7.domain.ContentFolder;
import com.imagsky.v8.domain.App;

public class AppBiz extends V7AbstractBiz {

	protected AppBiz(Member thisMember, HttpServletRequest req){
		super(thisMember, req);
	}
	
	private static AppBiz instance = null;
	
	public static AppBiz getInstance(Member thisMember, HttpServletRequest req) {
	      if(instance == null) {
	         instance = new AppBiz(thisMember, req);
	      } else {
	    	instance.reset(thisMember, req);  
	      }
	      return instance;
	}
	
	//#1. Load apps for a member
	public List<App> listApp(){
		List<App> aList =  new ArrayList<App>();
		aList.addAll(this.getOwner().getApps());
        return aList;
	}
	
	//#2. Create apps for member
	public App addApp(){
		App newApp = new App();
		newApp.setAPP_NAME(this.getParam("app-name")[0]);
		newApp.setAPP_TYPE(Integer.parseInt(this.getParam("app-type")[0]));
		newApp.setAPP_CREATOR(getOwner());
		newApp.setAPP_STATUS("");
		newApp.setAPP_DESC("");
		
		AppDAO aDao = AppDAO.getInstance();
		MemberDAO mDao = MemberDAO.getInstance();
		try{
			aDao.CNT_create(newApp);
			Set<App> aSet = this.getOwner().getApps();
			if(aSet == null){
				aSet = new HashSet<App>();
			}
			aSet.add(newApp);
			this.getOwner().setApps(aSet);
			mDao.update(this.getOwner());
		} catch (Exception e){
			cmaLogger.error("Error AppDAO", e);
		}
		
		return newApp;
	}
	//#3. Change creator // allow creator delete only
	//#4. Delete apps
	//#5. Change apps name or description
	public App update() {
        AppDAO dao = AppDAO.getInstance();
        App app = new App();

        if (this.getParam("edit_guid") == null) {
            this.addErrorMsg("App does not existed... ");
            return null;
        }
        if (this.getParam("edit-app-name") == null) {
            this.addErrorMsg("Nothing needs to be updated... ");
            return null;
        }
        if (this.getParam("edit-app-desc") == null) {
            this.addErrorMsg("Nothing needs to be updated... ");
            return null;
        }
        try {
        	//cmaLogger.debug(this.getParam("edit_guid")[0]+"/"+this.getParam("edit-app-name")[0] + "/"+ this.getParam("edit-app-desc")[0] );
=======
	      }
	      return instance;
	}
	
	//#1. Load apps for a member
	public List<App> listApp(){
		List<App> aList =  new ArrayList<App>();
		aList.addAll(this.getOwner().getApps());
        return aList;
	}
	
	//#2. Create apps for member
	public App addApp(){
		App newApp = new App();
		newApp.setAPP_NAME(this.getParam("APP_NAME")[0]);
		newApp.setAPP_DESC(this.getParam("APP_DESC")[0]);
		newApp.setAPP_CREATOR(getOwner());
		
		AppDAO aDao = AppDAO.getInstance();
		try{
			aDao.CNT_create(newApp);
		} catch (Exception e){
			cmaLogger.error("Error AppDAO", e);
		}
		
		return newApp;
	}
	//#3. Change creator // allow creator delete only
	//#4. Delete apps
	//#5. Change apps name or description
	public App update() {
        AppDAO dao = AppDAO.getInstance();
        App app = new App();

        if (this.getParam("edit_guid") == null) {
            this.addErrorMsg("App does not existed... ");
            return null;
        }
        if (this.getParam("edit-app-name") == null) {
            this.addErrorMsg("Nothing needs to be updated... ");
            return null;
        }
        if (this.getParam("edit-app-desc") == null) {
            this.addErrorMsg("Nothing needs to be updated... ");
            return null;
        }
        try {
>>>>>>> branch 'master' of https://github.com/MakChunMan/V7cma.git
        	app.setSys_guid(this.getParam("edit_guid")[0]);
        	app.setAPP_NAME(this.getParam("edit-app-name")[0]);
        	app.setAPP_DESC(this.getParam("edit-app-desc")[0]);
            app.setAPP_TYPE(Integer.parseInt(this.getParam("edit-app-type")[0]));
            app = (App) dao.CNT_update(app);
            return app;
        } catch (Exception e) {
            this.addErrorMsg("AppBiz.update() Exception: " + this.getParam("edit_guid")[0]);
            cmaLogger.error("AppBiz.update() Exception", e);
            return null;
        }
    }
	
	
	public App testAddApp(){
		App newApp = new App();
		newApp.setAPP_NAME("Test."+ new java.util.Date());
		newApp.setAPP_DESC("Desc."+ new java.util.Date());
		newApp.setAPP_CREATOR(getOwner());
		newApp.setAPP_STATUS("");
		newApp.setAPP_TYPE(0);
		AppDAO aDao = AppDAO.getInstance();
		MemberDAO mDao = MemberDAO.getInstance();
				
		try{
			aDao.CNT_create(newApp);
			Set<App> aSet = this.getOwner().getApps();
			if(aSet == null){
				aSet = new HashSet<App>();
			}
			aSet.add(newApp);
			this.getOwner().setApps(aSet);
			mDao.update(this.getOwner());
		} catch (Exception e){
			cmaLogger.error("Error AppDAO", e);
		}
		
		return newApp;
	}
}

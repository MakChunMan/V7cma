/*****
 * 20150319 Add Color Theme Field
 */
package com.imagsky.v8.biz;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.dao.AppDAO;
import com.imagsky.dao.ContentFolderDAO;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v7.biz.V7AbstractBiz;
import com.imagsky.v7.domain.ContentFolder;
import com.imagsky.v8.domain.App;
import com.imagsky.v8.domain.Module;


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
        	app.setSys_guid(this.getParam("edit_guid")[0]);
        	app.setAPP_NAME(this.getParam("edit-app-name")[0]);
        	app.setAPP_DESC(this.getParam("edit-app-desc")[0]);
            app.setAPP_TYPE(Integer.parseInt(this.getParam("edit-app-type")[0]));
            app.setAPP_COLOR_THEME(Integer.parseInt(this.getParamToString("edit-app-colortheme")));
            app.setSys_updator(owner.getSys_guid());
            
            app = (App) dao.CNT_update(app);
            return app;
        } catch (Exception e) {
            this.addErrorMsg("AppBiz.update() Exception: " + this.getParam("edit_guid")[0]);
            cmaLogger.error("AppBiz.update() Exception", e);
            return null;
        }
    }
	
	//#6 Reload App
	public App reloadApp(App oldApp){
		AppDAO dao = AppDAO.getInstance();
		App enqObj = new App();
		enqObj.setSys_guid(oldApp.getSys_guid());
		enqObj.setAPP_TYPE(oldApp.getAPP_TYPE());
		List aList;
		try {
			aList = dao.CNT_findListWithSample(enqObj);
			if(CommonUtil.isNullOrEmpty(aList)){
				cmaLogger.error("Cannot find app:"+ oldApp.getSys_guid());
			}
			return (App)(aList.get(0));
		} catch (BaseDBException e) {
			// TODO Auto-generated catch block
			cmaLogger.error("reloadApp error:" + oldApp.getSys_guid(), e );
			return null;
		}
	}
}

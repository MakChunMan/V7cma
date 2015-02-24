package com.imagsky.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.common.SiteResponse;
import com.imagsky.constants.V7JspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.domain.Member;
import com.imagsky.v8.domain.App;

public class V8Util {

	public static SiteResponse v8CheckLogin(SiteResponse siteR, HttpServletRequest request){
		if(!V6Util.isLogined(request)){
			siteR.setTargetJSP(V7JspMapping.LOGIN_PHP);
		}
		return siteR;
	}
	
	/****
	 * After image upload to tmp folder, when the user press save in the module edit page, image file will be moved to the 
	 * user own folder
	 * @param member
	 * @param filename
	 * @return
	 */
	public static boolean imageUploadFileMove(App app, String filename){
		if(app==null)
			return false;
		if(CommonUtil.isNullOrEmpty(filename))
			return false;
		File afile =new File(PropertiesConstants.get(PropertiesConstants.v81_uploadDirectory)+"tmp/"+filename);
		if(!afile.exists())
			return false;
		new File(PropertiesConstants.get(PropertiesConstants.v81_uploadDirectory)+ app.getSys_guid() + "/").mkdir(); //Nothing happen if already exists
		return afile.renameTo(new File(PropertiesConstants.get(PropertiesConstants.v81_uploadDirectory)+ app.getSys_guid() + "/"+filename));
	}
	
	public static boolean imageFileDelete(App app, String filename){
		if(app==null)
			return false;
		if(CommonUtil.isNullOrEmpty(filename))
			return false;
		File afile =new File(PropertiesConstants.get(PropertiesConstants.v81_uploadDirectory) + app.getSys_guid() +"/"+filename);
		return afile.delete();
	}
}

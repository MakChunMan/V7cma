package com.imagsky.v6.cma.constants;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.Iterator;


import com.imagsky.util.MessageUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.dao.ContentTypeDAO;
import com.imagsky.v6.domain.*;

public class ContentTypeConstants {

	private static Map<String, ContentType> ContentTypeMap;
	public static final String FieldType_CT = "FormFieldType";
	public static final String Folder_CT = "ContentFolder";
	public static final String SellItemCategory_CT = "SellItemCategory";
	
	public static void init(){
		if(ContentTypeConstants.ContentTypeMap==null){
			ContentTypeDAO dao = ContentTypeDAO.getInstance();
			
			ContentTypeMap = new HashMap<String, ContentType>();
			try{
				List<?> list = dao.findAll();
				Iterator<?> it = list.iterator();
				String ctName = null;
				ContentType ct = null;
				Object obj = null;
				while (it.hasNext()){
					obj = it.next();
					cmaLogger.debug(obj.toString() + obj.getClass().getName());
					ct = (ContentType)obj;
					ctName = ct.getCma_name();
					ContentTypeMap.put(ctName, ct);
					cmaLogger.debug("ContentTypeConstants.init() : "+ ctName + " is added.");
				}
			} catch (ClassCastException cce){
				
			} catch (Exception e){
				cmaLogger.error("ContentTypeConstants.init() Exception" , e);
			}
		}
	}
	
	public static Map<String, ContentType> getMap(){
		if(ContentTypeMap==null){
			init();
		}
		return ContentTypeMap;
	}
	
	public static ContentType getCT(String contentTypeName){
		return (ContentType)getMap().get(contentTypeName);
	}
	
	public static ContentType getCTByGUID(String contentTypeGuid){
		Iterator it = ContentTypeMap.keySet().iterator();
		String key = null;
		ContentType ct = null;
		while(it.hasNext()){
			key = (String)it.next();
			ct = (ContentType)getMap().get(key);
			if(ct.getSys_guid().equalsIgnoreCase(contentTypeGuid)){
				return ct;
			}
		}
		return null;
	}
}

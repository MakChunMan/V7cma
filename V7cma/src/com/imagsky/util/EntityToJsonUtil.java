/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.util;

import java.util.*;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

/**
 *
 * @author jasonmak
 */
public class EntityToJsonUtil {

    /***
    public static void main(String[] arg) {
        ContentFolder cf = new ContentFolder();
        cf.setClfd_full_path("PATH 123://:asdas");
        cf.setClfd_name("NAME NAME");
        cf.setClfd_parent_guid("asuiydpausdy");
        cf.setSys_clfd_guid("jasjjjj");
        cf.setSys_exp_dt(new java.util.Date());
        cf.setSys_is_node(Boolean.TRUE);
        ArrayList al = new ArrayList();
        al.add(cf);
        System.out.println(EntityToJsonUtil.toJsonString(al));
        //System.out.println(toJsonString(cf));
    }***/

	/***** For other json return page ****/
	public static String toSimpleJsonString(ArrayList<String[]> obj){
		Map<String, Object> amap = new HashMap<String, Object>();
		for (String[] aArray : obj){
			amap.put(aArray[0], aArray[1]);
		}
		net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
        return jsonObjectMary.toString();
	}
	
	public static String toSimpleJsonStringFromMultipleMap(ArrayList<HashMap<String, String>> obj){
		Map<String, Object> amap = new HashMap<String, Object>();
		amap.put("Options", obj);
		net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
        return jsonObjectMary.toString();
	}

	/*********** FOR CMA below **************/
	
    public static String toJsonStringError(String message, String lang) {
            Map<String, Object> amap = new HashMap<String, Object>();
            amap.put("Result", "ERROR");
            amap.put("Message", message);
            net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
            return jsonObjectMary.toString();
    }

    public static String toJsonString(ArrayList obj, Throwable th) {
        if (th == null) {
            return toJsonString(obj, obj.size());
        } else {
            Map<String, Object> amap = new HashMap<String, Object>();
            amap.put("Result", "ERROR");
            amap.put("Message", th.getMessage());
            net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
            return jsonObjectMary.toString();
        }
    }

    public static String toJsonStringForOptions(ArrayList list){
                Map<String, Object> amap = new HashMap<String, Object>();
                amap.put("Result", "OK");
                amap.put("Options", list);
                net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
                return jsonObjectMary.toString();
    }

    public static String toJsonString(ArrayList obj, int totalRecordCount) {
        Map<String, Object> amap = new HashMap<String, Object>();
        amap.put("Result", "OK");
        amap.put("Records", obj);
        amap.put("TotalRecordCount", totalRecordCount);
        net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
        return jsonObjectMary.toString();
    }

        public static String toJsonString(ArrayList obj) {
        Map<String, Object> amap = new HashMap<String, Object>();
        amap.put("Result", "OK");
        amap.put("Records", obj);
        net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
        return jsonObjectMary.toString();
    }

    public static String toJsonStringAfterCreate(Object obj){
        Map<String, Object> amap = new HashMap<String, Object>();
        amap.put("Result", "OK");
        amap.put("Record", obj);
        net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
        return jsonObjectMary.toString();
    }

    public static String toJsonString(String message, String value){
        Map<String, Object> amap = new HashMap<String, Object>();
        amap.put(message, value);
        net.sf.json.JSONObject jsonObjectMary = JSONObject.fromObject(amap, getJsonConfig());
        return jsonObjectMary.toString();
    }
    private static JsonConfig jsonConfigToJSON = null;

    private static JsonConfig getJsonConfig() {
        if (jsonConfigToJSON == null) {
            jsonConfigToJSON = new JsonConfig();
            //Date Processor
            jsonConfigToJSON.registerJsonValueProcessor(java.util.Date.class, new JsonValueProcessor() {
                @Override
                public Object processObjectValue(String key, Object value, JsonConfig jsonConfig) {
                    return process(value, jsonConfig);
                }
                @Override
                public Object processArrayValue(Object value, JsonConfig jsonConfig) {
                    return process(value, jsonConfig);
                }
                private Object process(Object value, JsonConfig jsonConfig) {
                    if (value == null) {
                        return "";
                    }
                    // For Unix Time
                    return "/Date("+ ((Date) value).getTime()  + "/";
                    //return ;
                }
            });
     }
        return jsonConfigToJSON;
    }
}

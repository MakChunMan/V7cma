package com.imagsky.util;

import java.util.TreeMap;

import com.imagsky.util.logger.cmaLogger;

public class URLCache {

	private static TreeMap<String, String> cache;
	
	public static void add(String url, String cacheUrl){
		if(cache==null){
			cache = new TreeMap<String,String>();
		}
		if(CommonUtil.isNullOrEmpty(url) || CommonUtil.isNullOrEmpty(cacheUrl)){
			cmaLogger.warn("URLCache Warning: Cache URL or Node URL is null..");
		} else {
			//long strt = ObjectSizer.getObjectSize(cache);
			cache.put(url, cacheUrl);
			cmaLogger.debug("URLCache Cache Size: " + cache.size() );
		}
	}
	
	public static String get(String nodeUrl){
		if(cache==null){
			cache = new TreeMap<String,String>();
		} 
		if(CommonUtil.isNullOrEmpty(nodeUrl))
			return null;
		
		return (String)cache.get(nodeUrl);
	}
}

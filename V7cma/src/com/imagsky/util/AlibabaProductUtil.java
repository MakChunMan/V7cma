package com.imagsky.util;

import java.io.File;
import java.util.*;

public class AlibabaProductUtil {
	
	private String basicInfo;
	private ArrayList<String> imageURL;
	
	public AlibabaProductUtil(String url, String proxy){
		try{
			Map<String,String> paramMap = new HashMap<String,String>();
			paramMap.put("target",url);
			String productPage = HttpClientUtil.httpRequestSubmit(proxy , paramMap, "GB2312");
			System.out.println("Page size:"+ productPage.length());
			//TEST for taobao
			StringBuilder sb1 = new StringBuilder(productPage);
			//sb1.delete(0,sb1.indexOf("DivItemDesc"));
			//System.out.println(productPage);
			StringBuilder sb = new StringBuilder(productPage);
			sb.delete(0, sb.indexOf("form id=\"applyPartnerForm\""))
				.delete(sb.indexOf("</form>"),sb.length()-1);
			basicInfo = sb.toString();
			StringBuilder sb2 = new StringBuilder(productPage);
			sb2.delete(0, sb2.indexOf(" <div class=\"de-description-detail fd-editor\" id=\"de-description-detail\" >"));
			sb2.delete(sb2.indexOf("<div id=\"mod-detail-wholesale\""), sb2.length()-1);
			System.out.println(sb2.toString());
			String[] imageArray = sb2.toString().split("src");
			imageURL = new ArrayList<String>();
			for(String tmp : imageArray){
				if(tmp.indexOf(".jpg")>=0){
					imageURL.add(tmp.substring(0,tmp.indexOf(".jpg")+4).replaceAll("=\"http:","http:"));
				}
			}
			//System.out.println("Image URL size:" + imageURL.size());
		} catch (Exception e){
			System.err.println("Prouct Detail Page error: "+ e.getMessage());
		}
	}

	public String getBasicInfo() {
		return basicInfo;
	}

	public void setBasicInfo(String basicInfo) {
		this.basicInfo = basicInfo;
	}

	public ArrayList<String> getImageURL() {
		return imageURL;
	}

	public void setImageURL(ArrayList<String> imageURL) {
		this.imageURL = imageURL;
	}
	
	public static boolean saveImage(String prod_code, String basepath, ArrayList<String> saveURL){
		String folderpath = basepath+ "/"+ prod_code;
		File path = new File(folderpath);
		if(!path.exists()){
			path.mkdir();
		}
		int x = 1;
		for(String a : saveURL.toArray(new String[saveURL.size()])){
			//System.out.println(x+"...");
			try{
				HttpClientUtil.httpDownloadImage(a, folderpath  + "/"+ prod_code + (x++) + ".jpg");
				//System.out.println("...done");
			} catch (Exception e){
				System.out.print("Download "+ a + " failed" + e.getMessage());
			}
			
		}
		return true;
	}
}

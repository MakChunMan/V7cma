package com.imagsky.util;

import com.imagsky.v6.domain.*;
import com.imagsky.v6.dao.SellItemDAO;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.util.logger.*;
import com.imagsky.v6.cma.constants.*;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

public class ClearFileUtil {

	public static final String SELLITEM_IMG = "SELLITEM";
	public static final String BANNER_IMG = "BNR";
	public static final String ALL = "ALL";
	
	public static boolean clearFile(Member member, String fileType){
		if(member==null){
			cmaLogger.info("[ClearFileUtil] Member is null...");
			return true;
		}
		
		cmaLogger.debug("[START clearFile] "+ member.getMem_login_email());
		boolean result = true;
		if(fileType.equalsIgnoreCase(SELLITEM_IMG) || fileType.equalsIgnoreCase(ALL)){
			cmaLogger.debug("do clearSellItemImage" + fileType);
			clearSellItemImage(member);
		}
		if(fileType.equalsIgnoreCase(BANNER_IMG) || fileType.equalsIgnoreCase(ALL)){
			cmaLogger.debug("do clearBannerImage" + fileType);
			clearBannerImage(member);
		}
		cmaLogger.debug("[END clearFile] "+ member.getMem_login_email());
		return result;
	}
	
	public static boolean clearPublicFile(){
		cmaLogger.info("[ClearFileUtil] Clear File in public folder STARTED...");
		String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadDirectory);
		FilenameFilter imageFilter = new FilenameFilter() {
		    public boolean accept(File dir, String name) {
		    	if(name.startsWith(".")){
		    		return false;
		    	} else if(name.startsWith("thm_") || name.startsWith("raw_") || name.startsWith("dtl_") || name.startsWith("bnr")){
		    		return true;
		    	}
		        return false;
		    }
		};
		File uploadDirectory = new File(userImagePath);
		File[] children = uploadDirectory.listFiles(imageFilter);
                                    try{
		for(File x : children){
			 java.util.Date now = new java.util.Date();
			 java.util.Date comparedDate = CommonUtil.dateAdd(new java.util.Date(x.lastModified()), Calendar.DAY_OF_MONTH, 2);
			 if(comparedDate.getTime()< now.getTime()){
				 try{
					 cmaLogger.debug("[ClearFileUtil] Image deleted: "+ x.getCanonicalPath() + x.getName());
					 x.delete();
				 }catch (Exception e){
					 cmaLogger.error("Delete error:",e);
				 }
			 }
		}
                                    } catch (Exception e){
                                        cmaLogger.error("[ClearFileUtil] Exception:",e);
                                        
                                    }
		cmaLogger.info("[ClearFileUtil] Clear File in public folder COMPLETED");
		return true;
	}
	private static boolean clearSellItemImage(Member member){
			String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ "/"+
				member.getSys_guid() +"/";
			SellItemDAO sdao = SellItemDAO.getInstance();
			SellItem sellItemEnq = new SellItem();
			try{
				sellItemEnq.setProd_owner(member.getSys_guid());
				List aList = sdao.findListWithSample(sellItemEnq);
				Iterator it = aList.iterator();
				ArrayList<String> imagesUsing = new ArrayList<String>();
				while(it.hasNext()){
					SellItem tmp = (SellItem)it.next();
					if(!CommonUtil.isNullOrEmpty(tmp.getProd_image1())){
						imagesUsing.add(tmp.getProd_image1());
					}
					if(!CommonUtil.isNullOrEmpty(tmp.getProd_image2())){
						imagesUsing.add(tmp.getProd_image2());
					}
					if(!CommonUtil.isNullOrEmpty(tmp.getProd_image3())){
						imagesUsing.add(tmp.getProd_image3());
					}
				}
				it = imagesUsing.iterator();
				while(it.hasNext()){
					cmaLogger.debug("Image using: "+ (String)it.next());
				}
				
				File uploadDirectory = new File(userImagePath);
				cmaLogger.debug("userImagePath: "+ userImagePath);
				FilenameFilter sellItemFilter = new FilenameFilter() {
				    public boolean accept(File dir, String name) {
				    	if(name.startsWith(".")){
				    		return false;
				    	} else if(name.startsWith("thm_") || name.startsWith("raw_")){
				    		return true;
				    	}
				        return false;
				    }
				};
				
				File[] children = uploadDirectory.listFiles(sellItemFilter);
				if(children !=null){
					for (int x= 0; x< children.length; x++){
						
						if(!imagesUsing.contains(children[x].getName().replaceFirst("thm_", "").replaceFirst("raw_", "").replaceFirst("dtl", ""))){
							if(	children[x].delete()){
								cmaLogger.debug("[ClearFileUtil] Image deleted: "+ children[x].getCanonicalPath() + children[x].getName());
							} else {
								cmaLogger.debug("[ClearFileUtil] Image delete failed: "+ children[x].getCanonicalPath() + children[x].getName());
							}
							
						}
					}
				}

			}catch (Exception e){
				cmaLogger.error("ClearFileUtil.clearSellItemImage Exception: ", e);
			}
			
			return false;
	}
	
	private static boolean clearBannerImage(Member member){
		
		String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadDirectory)+ "/"+
		member.getSys_guid() +"/";
		NodeDAO ndao = NodeDAO.getInstance();
		Node nodeEnq = new Node();
		
	try{
		nodeEnq.setNod_owner(member.getSys_guid());
		List aList = ndao.findListWithSample(nodeEnq);
		
		Iterator it = aList.iterator();
		ArrayList<String> imagesUsing = new ArrayList<String>();
		
		while(it.hasNext()){
			Node tmp = (Node)it.next();
			if(!CommonUtil.isNullOrEmpty(tmp.getNod_bannerurl())){
				imagesUsing.add(CommonUtil.stringTokenize(tmp.getNod_bannerurl(),"/")[1]);
			}
		}
		
		if(!CommonUtil.isNullOrEmpty(member.getMem_shopbanner())){
			imagesUsing.add(CommonUtil.stringTokenize(member.getMem_shopbanner(),"/")[1]);
		}
		
		it = imagesUsing.iterator();
		while(it.hasNext()){
			cmaLogger.debug("Image using: "+ (String)it.next());
		}
		
		
		File uploadDirectory = new File(userImagePath);
		FilenameFilter bannerFilter = new FilenameFilter() {
		    public boolean accept(File dir, String name) {
		    	if(name.startsWith(".")){
		    		return false;
		    	} else if(name.startsWith("bnr_")){
		    		return true;
		    	}
		        return false;
		    }
		};
		
		File[] children = uploadDirectory.listFiles(bannerFilter);
		if(children!=null){
			for (int x= 0; x< children.length; x++){
				if(!imagesUsing.contains(children[x].getName())){
					if(	children[x].delete()){
						cmaLogger.debug("[ClearFileUtil] Image deleted: "+ children[x].getCanonicalPath());
					} else {
						cmaLogger.debug("[ClearFileUtil] Image delete failed: "+ children[x].getCanonicalPath());
					}
					
				}
			}
		}
	}catch (Exception e){
		cmaLogger.error("ClearFileUtil.clearBannerImage Exception: ", e);
	}
	
	return false;
	}
	
	
}

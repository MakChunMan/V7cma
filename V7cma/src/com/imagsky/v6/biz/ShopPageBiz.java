package com.imagsky.v6.biz;

import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.PropertiesUtil;
import com.imagsky.util.V6Util;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.ArticleDAO;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.SellItemDAO;
import com.imagsky.v6.domain.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ShopPageBiz {

	private static ShopPageBiz instance = null;
	
	protected ShopPageBiz() {
	  // Exists only to defeat instantiation.
	   }
	public static ShopPageBiz getInstance() {
	      if(instance == null) {
	         instance = new ShopPageBiz();
	      }
	      return instance;
	}
	   
	public Map getPublicHomeContent(Member thisShop){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		SellItemDAO cDAO = SellItemDAO.getInstance();
		SellItem enqObj = new SellItem();
		
		cmaLogger.debug("ShopPageBiz - getPublicHomeContent [START] : ");
		enqObj.setProd_lang("zh");
		enqObj.setSys_is_live(true);
		enqObj.setSys_is_published(true);
		enqObj.setProd_owner(thisShop.getSys_guid());
		
		
			ArrayList orderByList = new ArrayList();
			orderByList.add(new String[]{SysObject.orderByCreateDate, SystemConstants.DB_DESC});
			orderByList.add(new String[]{SysObject.orderBySysPriority, SystemConstants.DB_ASC});
			
			//Product
			try {
				List prodList = cDAO.findListWithSample(enqObj, orderByList);
				if(prodList==null){
					cmaLogger.debug("- Return Product List is null");
				} else {
					cmaLogger.debug("- Return Product List size: "+ prodList.size());
					if(prodList.size()>0){
						ArrayList newList = new ArrayList();
						for (int x =0; x< 3; x++){
							if(prodList.size()>x){
								newList.add(prodList.get(x));
							}
						}
						if(newList.size()>0){
							returnMap.put(SystemConstants.PUB_HOME_NEWLIST, newList);
						}
						
						if(prodList.size()>3){
							int idx = new Double(Math.floor(Math.random()*(prodList.size()-3))).intValue();
							returnMap.put(SystemConstants.PUB_HOME_HOT, prodList.get(idx+3));
						}
						returnMap.put(SystemConstants.REQ_ATTR_OBJ_LIST, prodList);
					}
				}
			} catch (BaseDBException e) {
				cmaLogger.error("ShopPageBiz - getPublicHomeContent [Exception] : ", e);
			}

			//Article
			//cmaLogger.debug("Homepage Article: "+ thisShop.getMem_shop_hp_arti());
			if(!CommonUtil.isNullOrEmpty(thisShop.getMem_shop_hp_arti())){
				Article homepageArti = new Article();
				ArticleDAO aDAO = ArticleDAO.getInstance();
				homepageArti.setSys_guid(thisShop.getMem_shop_hp_arti());
				homepageArti.setArti_owner(thisShop.getSys_guid());;
				try{
					homepageArti = (Article) aDAO.findListWithSample(homepageArti).get(0);
					returnMap.put("HP_ARTI", homepageArti);
				} catch (BaseDBException e) {
					cmaLogger.error("ShopPageBiz - getPublicHomeContent [Exception] : ", e);
				}
			}
			cmaLogger.debug("ShopPageBiz - getPublicHomeContent [END]");
			return returnMap;
	}

	public Map getMainsiteHomeContent(){
		Map aMap = new HashMap<String, Object>();
		
		//Bulk Order
		ArrayList<BulkOrderItem> bo = PropertiesUtil.getBulkOrderList();
		if(V6Util.isBulkOrderModuleOn() && bo!=null){
			aMap.put(SystemConstants.PUB_HOME_BO, bo);
		}
		
		//New Shop Register
		/*** 2013-10-03 Disabled 
		MemberDAO mDAO = MemberDAO.getInstance();
		try{
			Member[] newShopList = mDAO.findNewShopWithProduct();
			aMap.put(SystemConstants.PUB_HOME_NEWSHOP, newShopList);
		} catch(Exception e ){
			cmaLogger.error("ShopPageBiz: getNewShopList Error ", e);
		}****/
		return aMap;
	}
}

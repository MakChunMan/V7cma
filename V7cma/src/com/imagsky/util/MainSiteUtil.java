/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.util;

import com.imagsky.v6.domain.SellItemCategory;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.dao.SellItemCategoryDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Node;
import com.imagsky.v6.domain.SellItem;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;


/**
 *
 * @author jasonmak
 */
public class MainSiteUtil {

    private static SellItemCategory[] onLineCategory;
    
    private static Member mainSite;
    
    public static Member getMainSiteObject(boolean clearCache){
        if(clearCache || mainSite==null){
            MemberDAO mDAO = MemberDAO.getInstance();
            Member enqObj = new Member();
            try{
                enqObj.setSys_guid(PropertiesConstants.get(PropertiesConstants.mainSiteGUID));
                List aList = mDAO.findListWithSample(enqObj);
                if(CommonUtil.isNullOrEmpty(aList)){
                    return null;
                } else {
                    mainSite = (Member)aList.get(0);
                }
            } catch (Exception e){
                cmaLogger.error("MAINSiteUtil.getMainSiteObject Error: ", e);
                return null;
            }
        }
        return mainSite;
    }
     /*****
     * 
     * @return Object Array of <Content with URL>
     */
    public static SellItemCategory[] getOnLineCategory(boolean clearCache){
        if(clearCache || onLineCategory==null){
            cmaLogger.info("MainSiteUtil.onLineCategory is loading from DB.");
            SellItemCategoryDAO cDAO = SellItemCategoryDAO.getInstance();
            SellItemCategory enqObj = new SellItemCategory();
            try{
                enqObj.setCate_owner(PropertiesConstants.get(PropertiesConstants.mainSiteGUID));
                enqObj.setSys_is_live(Boolean.TRUE);
                List aList = cDAO.findListWithSample(enqObj);
                NodeDAO nDAO = NodeDAO.getInstance();
                Node tmpNode = null;
                SellItemCategory aCat = null;
                
                
                ArrayList returnList = new ArrayList();
                if(aList!=null){
                    Map contentGuidNodeMapping  = nDAO.findNodeListWithSample(aList, SystemConstants.NODMAP_KEY_C_GUID);
                    Iterator it = aList.iterator();
                    int x= 0;
                    while(it.hasNext()){
                        aCat = (SellItemCategory)it.next();
                        aCat.setCate_url(((Node)contentGuidNodeMapping.get(aCat.getSys_guid())).getNod_url());
                        returnList.add(aCat);
                    }
                    cmaLogger.info("MainSiteUtil.onLineCategory loaded from DB (Size = " + returnList.size()  + ")");
                    onLineCategory = (SellItemCategory[])returnList.toArray(new SellItemCategory[returnList.size()]);
                }
            } catch (Exception e){
                cmaLogger.error("MAINSiteUtil.getOnLineCategory Error: ", e);
                return null;
            }
        }
        return onLineCategory;
    }
    
    /*****
     * 
     * @return SellItemCategory Array of <Content, URL>
     */
    public static SellItemCategory[] getOnLineCategory(){
        return getOnLineCategory(false);
    }
}

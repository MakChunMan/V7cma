/*******************
 *  2013-09-19 Initial - Move logic from PUBLIC_Handler to Business Class
 * 
 *******************
 * 
 * Usage Example:
 * 	//New Business Class
 * 				PubBulkOrderCartBiz aBiz = new PubBulkOrderCartBiz(thisMember, request);
		//Proceed Remove BO Item from Cart Operation
					SiteResponse thisResp = aBiz.removeItemFromBulkOrderCart();
		//Assign return attribute to request by request.setAttribute
					aBiz.setAttribute(request);
		//Proceed Error Msg if necessary
					aBiz.getErrMsgList()
		return thisResp;
 * 
 * 
 * 
 */
package com.imagsky.v7.biz;

import javax.servlet.http.HttpServletRequest;

import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.EntityToJsonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.OrderItem;
import com.imagsky.v6.domain.OrderSet;

public class PubBulkOrderCartBiz extends V7AbstractBiz{

    public PubBulkOrderCartBiz(Member thisMember, HttpServletRequest req){
    	super(thisMember, req);
    }
    
    public PubBulkOrderCartBiz(Member thisMember){
        super(thisMember);
    }

    public SiteResponse removeItemFromBulkOrderCart(OrderSet boCart){
    	SiteResponse thisResp = new SiteResponse();
    	String removeItemGuid = getParamToString("guid");
    	
    	if(boCart==null){
    		thisResp.addErrorMsg(new SiteErrorMessage("BOCART_MGMT_NO_CART"));
    	} else if(CommonUtil.isNullOrEmpty(removeItemGuid)){
    		thisResp.addErrorMsg(new SiteErrorMessage("BOCART_MGMT_NO_DEL_GUID"));
    	}
    	for(OrderItem item : boCart.getOrderItems()){
    		if(item.getContentGuid().equalsIgnoreCase(removeItemGuid))
    			boCart.removeOrderItem(item);
    	}
    	addReturnAttribute(SystemConstants.PUB_CART, boCart); 
    	return thisResp;
    }
    

    /****
     * It is used to check if the page item is already existed in the BOCart by ajax
     * @param boCart
     * @return
     */
    public SiteResponse checkIfBOItemExistInCart(OrderSet boCart){
    	SiteResponse thisResp = new SiteResponse();
    	String pageGuid = getParamToString("guid");
    	if(boCart==null){
    		thisResp.addErrorMsg(new SiteErrorMessage("BOCART_MGMT_NO_CART"));
    		addReturnAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("NOTEXIST",""));
			cmaLogger.debug("Add NOTEXIST to JsonData");
    	} else {
    		for(OrderItem item : boCart.getOrderItems()){
        		if(item.getContentGuid().equalsIgnoreCase(pageGuid)){
        			if(!CommonUtil.isNullOrEmpty(item.getOptionsJsonString())){
        				addReturnAttribute(SystemConstants.REQ_ATTR_JSONDATA, item.getOptionsJsonString());
        				cmaLogger.debug("Add JsonData");
        			}
        		}
        	}
    		//Not exist
    		if(getReturnAttribute(SystemConstants.REQ_ATTR_JSONDATA)==null){
    			addReturnAttribute(SystemConstants.REQ_ATTR_JSONDATA, EntityToJsonUtil.toJsonStringError("NOTEXIST",""));
    			cmaLogger.debug("Add NOTEXIST to JsonData");
    		}
    	}
    	return thisResp;
    }
}

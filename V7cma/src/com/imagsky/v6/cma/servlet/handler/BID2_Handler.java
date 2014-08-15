/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseException;
import com.imagsky.util.BidUtil;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.BidDAO;
import com.imagsky.v6.dao.BidItemDAO;
import com.imagsky.v6.domain.Bid;
import com.imagsky.v6.domain.BidItem;
import com.imagsky.v6.domain.Member;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jasonmak
 */
public class BID2_Handler extends BaseHandler {

    protected static final String CLASS_NAME = "BID2_Handler.java";

    private Member thisMember = null;
    private String thisLang = null;
    private String action = null;
    
    @Override
    public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) throws BaseException {
    
                SiteResponse thisResp = super.createResponse();
                cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);		
                action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
                cmaLogger.debug("Action = "+ action);
                
                thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
                thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
                
                String[] urlToken = (String[])request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN);
                String thisAction = null; //FOR url pattern
                String biid = null; //FOR url pattern
                if(urlToken!=null && urlToken.length>=3){
                    //[0] = appcode, [1] = details, [2] = biid
                    thisAction = urlToken[1].toLowerCase();
                    biid = urlToken[2].toLowerCase();
                } else {
                    thisAction = action;
                    biid = request.getParameter("biid");
                }
                
                
                boolean isAjax = thisAction.endsWith("_AJ");
                if(thisAction.equalsIgnoreCase("MAIN")){
                    thisResp = showMain(request, response, isAjax);
                } else if(thisAction.equalsIgnoreCase("details")){
                    thisResp = showDetails(request, response, biid, isAjax);
                } else if(thisAction.equalsIgnoreCase("newbid") || thisAction.equalsIgnoreCase("newbid_AJ")){
                    thisResp = addNewBid(request, response, isAjax);
                } else if(thisAction.equalsIgnoreCase("hist_AJ")){
                    thisResp = showHist(request, response, isAjax);                    
                } else {
                    thisResp = showBidLogin(request, response);
                }
                return thisResp;
    }

    private SiteResponse showBidLogin(HttpServletRequest request, HttpServletResponse response) {
            SiteResponse thisResp = super.createResponse();
            thisResp.setTargetJSP(CMAJspMapping.PUB_BID2_LOGIN);
            return thisResp;
        
    }

    private SiteResponse doNothing(HttpServletRequest request, HttpServletResponse response, boolean ajax) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    private SiteResponse showMain(HttpServletRequest request, HttpServletResponse response, boolean ajax) {
        SiteResponse thisResp = super.createResponse();
        
        //TODO: Uncomment it when deploy to PRODUCTION
        //if(!FacebookUtil.isFBLogined(request)) return showBidLogin(request, response);
        
        BidItemDAO bDAO = BidItemDAO.getInstance();
        try{
            List bidItemList = bDAO.findOnlineBidItem();
            request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, bidItemList);
        } catch (Exception e){
            cmaLogger.error("BID2 getBidList :",request,e);
        }
        if(ajax){
            thisResp.setTargetJSP(CMAJspMapping.PUB_BID2_MAIN_AJ);
        } else {
            thisResp.setTargetJSP(CMAJspMapping.PUB_BID2_MAIN);
        }
        return thisResp;
    }

    private SiteResponse addNewBid(HttpServletRequest request, HttpServletResponse response, boolean ajax) {
        SiteResponse thisResp = super.createResponse();
        
        //TODO: Uncomment it when deploy to PRODUCTION
        //if(!FacebookUtil.isFBLogined(request)) return showBidLogin(request, response);
        
        Bid newBid = new Bid();
        String bidid = CommonUtil.null2Empty(request.getParameter("fr_biditem_id"));
        String bidvalue = CommonUtil.null2Empty(request.getParameter("fr_biditem_value"));
        
        if(CommonUtil.isNullOrEmpty(bidid)){
            thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_EMPTY_ID"));
        }
        if(CommonUtil.isNullOrEmpty(bidvalue)){
            thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_EMPTY_VALUE"));
        }
        if(!CommonUtil.isValidNumber(bidvalue)){
            thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_INVALID_VALUE"));
        }
        if(thisResp.hasError()){
            SiteResponse returnResp = showMain(request, response, ajax);
            returnResp.addErrorMsg(thisResp.getErrorMsgList());
            return returnResp;
        }
        
        Double dbidvalue = new Double(bidvalue);
        BidDAO bDAO = BidDAO.getInstance();
        BidItemDAO biDAO = BidItemDAO.getInstance();
        try{
            BidItem enqbi = new BidItem();
            enqbi.setId(new Integer(bidid));
            List biList = biDAO.findListWithSample(enqbi);
            if(biList==null || biList.isEmpty()){
                cmaLogger.error("BID Create new Bid Error (ID "+ bidid + " not found in BidItem Table: ", request);
                thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_INVALID_ID"));
            } else {
                enqbi = (BidItem)biList.get(0);
                if(enqbi.getBid_end_date()!=null && enqbi.getBid_end_date().before(new java.util.Date())){
                    cmaLogger.error("BID Create Error (Bid Item Expired - ID: " + bidid+")", request);
                    thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_EXPIRED"));
                }
                if(enqbi.getBid_start_date()!=null && enqbi.getBid_start_date().after(new java.util.Date())){
                    cmaLogger.error("BID Create Error (Bid Item Not Ready for Auction - ID: " + bidid+")", request);
                    thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_NOT_YET_START"));
                }
                if(enqbi.getBid_current_price()>=dbidvalue){
                    cmaLogger.error("Current Price: "+ enqbi.getBid_current_price());
                    cmaLogger.error("New Bid Price: "+ dbidvalue);
                    cmaLogger.error("BID Create Error (Try higher Bid Value) - ID: " + bidid + ")", request);
                    thisResp.addErrorMsg(new SiteErrorMessage("BID_NEW_TRY_HIGHER"));
                }
                if(!thisResp.hasError()){
                    Bid anewBid = new Bid();
                    anewBid.setBid_price(dbidvalue);
                    anewBid.setBiditem_id(new Integer(bidid));
                    anewBid.setLast_update_date(new java.util.Date());
                    anewBid.setMember(thisMember);
                    if(bDAO.checkAndCreate(anewBid)==null){
                        throw new Exception ("Create new bid failed:");
                    } else {
                        BidItem newbi = new BidItem();
                        newbi.setId(enqbi.getId());
                        biList = biDAO.findListWithSample(newbi);
                        if(!BidUtil.checkAndMailPreviousBidder((BidItem)biList.get(0), thisLang, request )){
                            cmaLogger.error("[BID EMAIL] Send Fail: Something wrong", request);
                        };
                        request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
					"BID_NEW_SUCCEED"));
                    }
                } 
            }
            
        } catch(Exception e){
            cmaLogger.error("BID Create new Bid Error : ", request, e);
        }
            SiteResponse returnResp = showMain(request, response, ajax);
            returnResp.addErrorMsg(thisResp.getErrorMsgList());
            return returnResp;
    }

    private SiteResponse showHist(HttpServletRequest request, HttpServletResponse response, boolean ajax) {
            SiteResponse thisResp = super.createResponse();
            
            String bidItemId = CommonUtil.null2Empty(request.getParameter("biid"));
            try{
                if(!CommonUtil.isNullOrEmpty(bidItemId)){
                    BidDAO dao = BidDAO.getInstance();
                    Bid abid = new Bid();
                    abid.setBiditem_id(new Integer(bidItemId));
                    ArrayList paramList = new ArrayList();
                    paramList.add(new String[]{"last_update_date", "desc"});
                    List aList = dao.findListWithSample(abid,paramList);
                    request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, aList);
                }
            } catch (Exception e){
                cmaLogger.error("[BID_HIST] Error", request, e);
            }
            thisResp.setTargetJSP(CMAJspMapping.PUB_BID2_HIST_AJ);
            return thisResp;
    }

    private SiteResponse showDetails(HttpServletRequest request, HttpServletResponse response, String biid, boolean ajax) {
        SiteResponse thisResp = super.createResponse();
        
        String bidItemId = biid;
        try{
            if(!CommonUtil.isNullOrEmpty(bidItemId)){
                BidItem bidItem = new BidItem();
                bidItem.setId(new Integer(bidItemId));
                BidItemDAO bDAO = BidItemDAO.getInstance();
                List result = bDAO.findListWithSample(bidItem);
                if(result == null || result.isEmpty()){
                    cmaLogger.error("[BID_DETAILS] Error Invalid BidItem ID: "+ bidItemId,request);
                } else {
                    request.setAttribute(SystemConstants.REQ_ATTR_OBJ, result.get(0));
                }
            }
            } catch (Exception e)        {
                cmaLogger.error("[BID_DETAILS] Error", request, e);
            }
        thisResp.setTargetJSP(CMAJspMapping.PUB_BID2_DETAILS);
            return thisResp;
    }
    
}

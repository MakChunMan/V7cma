package com.imagsky.v6.cma.servlet.handler;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.imagsky.v6.dao.BidItemDAO;
import com.imagsky.v6.domain.BidItem;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.SellItem;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.util.logger.*;
import com.imagsky.util.CommonUtil;
import com.imagsky.v6.dao.SellItemDAO;
import java.util.*;

	
/****
 * BID_Handler is used by admin to maintanenace the BID Item
 * @author jasonmak
 */	
public class BID_Handler  extends BaseHandler {

	public static final String SHOW_ASSIGN = "assign";
                  public static final String DO_SAVE = "save";
                  public static final String DO_CREATE = "new";
                  public static final String DO_SAVE_UPDATE = "su";
	protected static final String CLASS_NAME = "BID_Handler.java";
	
	private Member thisMember = null;
	private String thisLang = null;
	
	private String action = null;
	
	/* (non-Javadoc)
	 * @see com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);		
		
		action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
		
		cmaLogger.debug("Action = "+ action);
		thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
		thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		boolean isAjax = action.endsWith("_AJ");
		if(action.equalsIgnoreCase(SHOW_ASSIGN)){
                                        thisResp = showAssign(request, response, false);
                                    } else if(action.equalsIgnoreCase(DO_SAVE)){
                                        thisResp = doSave(request, response);
                                    } else if(action.equalsIgnoreCase(DO_CREATE)){
                                        thisResp = doCreate(request, response);                                        
                                    } else if(action.equalsIgnoreCase(DO_SAVE_UPDATE)){
                                        thisResp = doSaveUpdate(request, response);                                                                                
                                    } else {
                                        thisResp = showAssign(request, response, false);
                                    }
                                    cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
                }
		
     
                
                private SiteResponse showAssign(HttpServletRequest request, HttpServletResponse response, boolean isAjax) {
                        SiteResponse thisResp = super.createResponse();
                        BidItem bidObj = new BidItem();
                        SellItem sellObj = new SellItem();
                        try{
                            BidItemDAO bDAO = BidItemDAO.getInstance();
                            List bidItemList = bDAO.findListWithSample(new BidItem());
                            Map<String, BidItem> existingBidItemList = new HashMap<String, BidItem>();
                            request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, bidItemList);
                            
                            sellObj.setProd_owner(thisMember.getSys_guid());
                            SellItemDAO sDAO = SellItemDAO.getInstance();
                            List sellItems = sDAO.findListWithSample(sellObj);
                            if(sellItems!=null && sellItems.size()>0){
                                Iterator it = sellItems.iterator();
                                SellItem tmp = null;
                                StringBuffer sb = new StringBuffer();
                                while(it.hasNext()){
                                    tmp = (SellItem)it.next();
                                    sb.append("<option value=\""+tmp.getSys_guid()+"\">"+ tmp.getProd_name()+"</option>");
                                }
                                request.setAttribute("OPTION_LIST", sb.toString());
                            }
                        } catch (Exception e){
                            cmaLogger.error("BID showAssign error: ", request,e);
                        }
                        if(!isAjax){
                            thisResp.setTargetJSP(CMAJspMapping.JSP_BID);
                        } else {
                            thisResp.setTargetJSP(CMAJspMapping.JSP_BID_AJ);
                        }
                        return thisResp;
                }

                private SiteResponse doCreate(HttpServletRequest request, HttpServletResponse response) {
                    SiteResponse thisResp = super.createResponse();
                    SellItem enqObj = new SellItem();
                    BidItem bidObj = new BidItem();
                    
                    String guid = CommonUtil.null2Empty(request.getParameter("guid"));
                    if(CommonUtil.isNullOrEmpty(guid)){
                        thisResp.addErrorMsg(new SiteErrorMessage("BID_INVALID_SELLITEM_GUID"));
                    }
                    if(!CommonUtil.isValidNumber(request.getParameter("cost"))){
                        thisResp.addErrorMsg(new SiteErrorMessage("BID_INVALID_COST"));
                    }
                    if(!thisResp.hasError()){
                        try{
                            SellItemDAO sDAO = SellItemDAO.getInstance();
                            enqObj.setSys_guid(guid);
                            List aList = sDAO.findListWithSample(enqObj);
                            if(aList==null || aList.size()<=0){
                                cmaLogger.error("BID Invalid SellItem GUID: "+ guid, request);
                                thisResp.addErrorMsg(new SiteErrorMessage("BID_INVALID_SELLITEM_GUID"));
                            } else{
                                bidObj.setSellitem((SellItem)aList.get(0));
                                bidObj.setBid_call_price(request.getParameter("cost")==null?-1:new Double(request.getParameter("cost")));
                                bidObj.setBid_start_price(new Double(1));
                                bidObj.setBid_current_price(new Double(1));
                                bidObj.setBid_start_date(new java.util.Date());
                                bidObj.setBid_delivery(BidItem.BidDelivery.NA);
                                bidObj.setBid_status(BidItem.BidStatus.INIT);
                                bidObj.setBid_count(0);
                                bidObj.setIsSentLastChanceNotify(Boolean.FALSE);
                                BidItemDAO bdao = BidItemDAO.getInstance();
                                bdao.create(bidObj);
                                request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, "SAVE DONE");
                            }
                        } catch(Exception e){
                            cmaLogger.error("BID Item Create Exception : "+ guid, request,e);
                            thisResp.addErrorMsg(new SiteErrorMessage("BID_CREATE_EXCEPTION"));
                        }
                    }
                    SiteResponse listResp = showAssign(request, response, true);
                    listResp.addErrorMsg(thisResp.getErrorMsgList());
                    return listResp;
                }
                
                private SiteResponse doSave(HttpServletRequest request, HttpServletResponse response) {
                    throw new UnsupportedOperationException("Not yet implemented");
                }

                private SiteResponse doSaveUpdate(HttpServletRequest request, HttpServletResponse response) {
                    SiteResponse thisResp = super.createResponse();
                    
                    String[] editIds = request.getParameterValues("assign_guid");
                    if(editIds==null || editIds.length==0){
                        thisResp.addErrorMsg(new SiteErrorMessage("BID_NO_GUID_FOR_EDIT"));
                    } 
                    BidItemDAO bDAO = BidItemDAO.getInstance();
                    BidItem thisObj = null;
                    boolean hasErrorForThisGuid = false;
                    boolean result = false;
                    int y = 0;
                    for(int x =0 ; x<editIds.length; x++){
                        hasErrorForThisGuid = false;
                        ArrayList tmpParam = null;
                        if(!CommonUtil.isValidNumber(request.getParameter("cost_"+editIds[x]))){
                            tmpParam = new ArrayList();
                            tmpParam.add(editIds[x]);
                            thisResp.addErrorMsg(new SiteErrorMessage("BID_INVALID_COST", tmpParam));
                            hasErrorForThisGuid = true;
                        }
                        if(CommonUtil.isValidDate(request.getParameter("startdate_"+editIds[x]))==null){
                            tmpParam = new ArrayList();
                            tmpParam.add(editIds[x]);
                            thisResp.addErrorMsg(new SiteErrorMessage("BID_INVALID_START", tmpParam));
                            hasErrorForThisGuid = true;
                        }
                        if(CommonUtil.isValidDate(request.getParameter("enddate_"+editIds[x]))==null){
                            tmpParam = new ArrayList();
                            tmpParam.add(editIds[x]);
                            thisResp.addErrorMsg(new SiteErrorMessage("BID_INVALID_END", tmpParam));
                            hasErrorForThisGuid = true;
                        }
                        
                        if(!hasErrorForThisGuid){
                            thisObj = new BidItem();
                            thisObj.setId(new Integer(editIds[x]));
                            thisObj.setBid_call_price(new Double(request.getParameter("cost_"+editIds[x])));
                            thisObj.setBid_start_date(CommonUtil.isValidDate(request.getParameter("startdate_"+editIds[x])));
                            java.util.Date end_date = CommonUtil.isValidDate(request.getParameter("enddate_"+editIds[x]));
                            GregorianCalendar calendar = new GregorianCalendar();  
                            calendar.clear();  
                            calendar.setTime( end_date); 
                            calendar.set(Calendar.HOUR_OF_DAY ,23); //TODO: HARDCODE
                            thisObj.setBid_end_date(calendar.getTime());
                            thisObj.setBid_status(BidItem.BidStatus.valueOf(request.getParameter("status_"+editIds[x])));
                            try{
                                result = bDAO.update(thisObj);
                            } catch (Exception e){
                                cmaLogger.error("BidItem Update Exception :",e);
                                result = false;
                            }
                            if(!result){
                                tmpParam = new ArrayList();
                                tmpParam.add(editIds[x]);
                                thisResp.addErrorMsg(new SiteErrorMessage("BID_UPDATE_ERROR", tmpParam));
                            } else {
                                 y++;
                            }
                        }
                    }
                     SiteResponse listResp = showAssign(request, response, true);
                    listResp.addErrorMsg(thisResp.getErrorMsgList());
                    return listResp;
                }

}



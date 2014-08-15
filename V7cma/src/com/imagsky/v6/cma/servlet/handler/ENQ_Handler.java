package com.imagsky.v6.cma.servlet.handler;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.v6.dao.EnquiryDAO;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.SellItemDAO;
import com.imagsky.v6.domain.Enquiry;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.SellItem;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.util.logger.*;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MailUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;

public class ENQ_Handler  extends BaseHandler {

	public static final String DO_ENQ_LIST = "LIST";
	public static final String DO_ENQ_LIST_AJ = "LISTAJ";
	public static final String DO_ENQ_REPLY = "REPLY";
	public static final String DO_ENQ_REPLY_AJ = "REPLYAJ";
	public static final String DO_ENQ_UPDATE = "UPD"; 
	public static final String DO_ENQ_REPLY_SAVE = "REPLY_SAVE";
		
	protected static final String CLASS_NAME = "ENQ_Handler.java";
	
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
		
		//TODO: Login check in mainServlet
		thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
		thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		
		if(action.equalsIgnoreCase(DO_ENQ_LIST)){
			thisResp = doList(request, response, false);
		} else if(action.equalsIgnoreCase(DO_ENQ_LIST_AJ)){
			thisResp = doList(request, response, true);
		} else if(action.equalsIgnoreCase(DO_ENQ_REPLY_AJ) ||
				action.equalsIgnoreCase(DO_ENQ_REPLY)){
			thisResp = doReply(request, response);
		} else if(action.equalsIgnoreCase(DO_ENQ_UPDATE)){
			thisResp = updateMessage(request, response);
		} else if(action.equalsIgnoreCase(DO_ENQ_REPLY_SAVE)){
			thisResp = doReplySave(request, response);
		} else {
			thisResp = doList(request, response, false); //Default
		}
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}
	
	private SiteResponse doReplySave(HttpServletRequest request,
			HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		
		EnquiryDAO dao = EnquiryDAO.getInstance();
		Enquiry enq = new Enquiry();
		
		SellItemDAO pdao = SellItemDAO.getInstance();
		SellItem sellitem = new SellItem();
		
		//MemberDAO mdao = MemberDAO.getInstance();
		//Member shop = new Member();
		
		
		String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		
		//Validation
		if(CommonUtil.isNullOrEmpty(request.getParameter("ENQ_CONTENT"))){
			thisResp.addErrorMsg(new SiteErrorMessage("ENQ_MISSING_CONTENT"));}
		
		if(CommonUtil.isNullOrEmpty(request.getParameter("mid"))){
			thisResp.addErrorMsg(new SiteErrorMessage("ENQ_MISSING_ID"));}
		
		if(!thisResp.hasError()){
			try{
				enq.setId(new Integer(request.getParameter("mid")));
				enq.setTo_member(thisMember);
				List r1 = dao.findListWithSample(enq);
				if(r1==null || r1.size()<=0){
					thisResp.addErrorMsg(new SiteErrorMessage("ENQ_INVALID_ACCCESS"));
					throw new BaseDBException("Invalid Access: " + thisMember.getMem_login_email(),"");
				}
				enq = (Enquiry)r1.get(0);
				Enquiry newEnq = new Enquiry();
				newEnq.setContentid(enq.getContentid());
				newEnq.setFr_member(thisMember);
				newEnq.setTo_member(enq.getFr_member());
				newEnq.setDelete_flg(false);
				newEnq.setMessage_type("O");
				newEnq.setMessageContent(CommonUtil.escape(request.getParameter("ENQ_CONTENT")));
				newEnq.setShow_flg(CommonUtil.null2Empty(request.getParameter("ENQ_MSG_MODE")).equalsIgnoreCase("PUBLIC"));
				newEnq.setParentid(enq.getParentid());
				newEnq.setRead_flg(false);
				newEnq.setCreate_date(new java.util.Date());
				newEnq.setDel_by_recipent(false);
				newEnq.setDel_by_sender(false);
				newEnq = (Enquiry)dao.create(newEnq);
				
				//Update Last Enquiry update Date to SellItem
				boolean isOrder = (newEnq.getContentid().length()!= 32); 
				if(!isOrder){
					sellitem.setSys_guid(newEnq.getContentid());
					sellitem = (SellItem)(pdao.findListWithSample(sellitem).get(0));
					sellitem.setProd_last_enq_date(new java.util.Date());
					pdao.update(sellitem);
				}
				
				/****Email to recipient***/
				MailUtil mailer = new MailUtil();
				mailer.setToAddress(newEnq.getTo_member().getMem_login_email());
				//Subject
				ArrayList<String> aParam = new ArrayList<String>();
				if(isOrder){
					aParam.add(MessageUtil.getV6Message(lang, "TXT_ORDER_NO")+ " " + newEnq.getContentid());
				} else {
					aParam.add(sellitem.getProd_name());
				}
				mailer.setSubject(MessageUtil.getV6Message(lang, "EMAIL_ENQ_GEN_SUBJ", aParam));
				//Content
				aParam = new ArrayList<String>();
				aParam.add(newEnq.getTo_member().getNickName());
				if(isOrder){
					aParam.add(MessageUtil.getV6Message(lang, "TXT_ORDER_NO")+ " " + newEnq.getContentid());
				} else {
					aParam.add(sellitem.getProd_name());
				}
				aParam.add(newEnq.getFr_member().getNickName());
				aParam.add(newEnq.getMessageContent());
				//URL
				String url = SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost)+ request.getAttribute("contextPath")+"/do/ENQ?action=REPLY&mid="+ newEnq.getId();
				aParam.add("<a href=\""+url+"\" target=\"_blank\">"+ MessageUtil.getV6Message(lang, "COUT_REPLY_URL") + "</a>");
				mailer.setContent(MessageUtil.getV6Message(lang, "EMAIL_ENQ_GEN", aParam));
				if (!mailer.send()){
					cmaLogger.error("[ENQUIRY REPLY] FAIL - From :" + newEnq.getFr_member().getMem_login_email() +",　To: "+ newEnq.getTo_member().getMem_login_email());
				} else {
					cmaLogger.info("[ENQUIRY REPLY] DONE - From :" + newEnq.getFr_member().getMem_login_email() +",　To: "+ newEnq.getTo_member().getMem_login_email());
				}
			} catch  (BaseDBException e) {
				cmaLogger.error("[ENQUIRY REPLY] Exception:", request, e);
			}
		}
		
		SiteResponse l = doList(request, response, true);
		if(thisResp.hasError()){
			l.addErrorMsg(thisResp.getErrorMsgList());
		} else {
			request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
			"ENQ_REPLY_DONE"));
		}
		return l;		
	}

	/***
	 * Display Reply input form 
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doReply(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		EnquiryDAO dao = EnquiryDAO.getInstance();
		SellItemDAO sDao = SellItemDAO.getInstance();
		
		boolean isAjax = action.indexOf("AJ")>0;
		
		String messageId = request.getParameter("mid");
		Enquiry enq = new Enquiry();
		enq.setId(new Integer(messageId));
		try{
			List enqList = dao.findListWithSample(enq);
			if(enqList!=null && enqList.size()>0){
				enq = (Enquiry)enqList.get(0);
				if(!enq.getFr_member().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email()) &&
						!enq.getTo_member().getMem_login_email().equalsIgnoreCase(thisMember.getMem_login_email())
						){
					//INVALID ACCESS
					cmaLogger.error("[REPLY MESSAGE ERROR] Invalid Access (MID =  "+ messageId+ "): "+ thisMember.getMem_login_email(), request);
					thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
					SiteResponse listResp = doList(request, response, isAjax);
					listResp.addErrorMsg(thisResp.getErrorMsgList());
					return listResp;
				} else {
					Enquiry enqByParent = new Enquiry();
					enqByParent.setParentid(enq.getParentid());
					ArrayList<String[]> enqOrderBy = new ArrayList<String[]>();
					enqOrderBy.add(new String[]{"create_date","asc"});
					
					if(enq.getContentid().length()<32){
						//ORDER Enquiry
					} else {
						SellItem sellItem = new SellItem();
						sellItem.setSys_guid(enq.getContentid());
						List sellItemList = sDao.findListWithSample(sellItem);
						if(sellItemList!=null && sellItemList.size()>0){
							request.setAttribute("SELLITEM", sellItemList.get(0));
						}
					}
					
					List sameParentList = dao.findListWithSample(enqByParent, enqOrderBy);
					
					request.setAttribute("WHOLEQUESTION", sameParentList);
					request.setAttribute("REP_QUESTION", enq);
					if(isAjax)
						thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_REPLY_AJ);
					else 
						thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_LIST);
				}
			} else {
				cmaLogger.error("[REPLY MESSAGE ERROR] Message ID not found: "+ messageId, request);
				thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
				SiteResponse listResp = doList(request, response, isAjax);
				listResp.addErrorMsg(thisResp.getErrorMsgList());
				return listResp;
			}
		}catch (Exception e){
			cmaLogger.error("[REPLY MESSAGE ERROR]", request, e);
			thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			SiteResponse listResp = doList(request, response, isAjax);
			listResp.addErrorMsg(thisResp.getErrorMsgList());
			return listResp;
		}
		return thisResp;
	}

	private SiteResponse updateMessage(HttpServletRequest request,
			HttpServletResponse response) {
		
		SiteResponse thisResp = super.createResponse();
		
		EnquiryDAO dao = EnquiryDAO.getInstance();
		
		boolean successResult = false;
		try{
			//'<%=request.getAttribute("contextPath") %>/do/PROFILE?action=MSG_UPDATE&mid=' + $(this).attr("id") + "&mode="+ $(this).val();
			Enquiry enq = new Enquiry();
			SellItem sellItem = new SellItem();
			enq.setId(new Integer(request.getParameter("mid")));
			List enqList = dao.findListWithSample(enq);
		
			//Check sell item owner
			if(enqList==null || enqList.size()<=0){
				cmaLogger.error("[UPDATE MESSAGE] Invalid mid: "+ enq.getId(), request);
				thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			} else if(enqList.get(0)==null){
				cmaLogger.error("[UPDATE MESSAGE] Invalid mid: "+ enq.getId(), request);
				thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			} else {
				enq = (Enquiry)enqList.get(0);

				//DEBUG
				cmaLogger.debug("Enq ID: "+ enq.getId());
				if(!thisResp.hasError()){
					//START HIDE or DEL one
					if(request.getParameter("mode").indexOf("ALL")<0){
						if(request.getParameter("mode").indexOf("HIDE")>=0){
							enq.setShow_flg(false);
						} else if(request.getParameter("mode").indexOf("DEL")>=0){
							//enq.setDelete_flg(true);
							enq.setDelete(thisMember);
						}
						if (dao.update(enq)){
							cmaLogger.debug("[UPDATE MESSAGE] 1 message is updated by "+ thisMember.getMem_login_email(), request);
							successResult = true;
						} else 
							cmaLogger.error("[UPDATE MESSAGE ERROR] 0 message is updated by "+ thisMember.getMem_login_email(), request);
					//END START HIDE or DEL one						
					} else {
					//START HIDE or DEL all
						Integer parentid = enq.getId();
						int statusFlg = -1;
						if(request.getParameter("mode").indexOf("HIDE")>=0){
							//HIDE
							enq.setShow_flg(false);
							dao.update(enq);
							enq = new Enquiry();
							enq.setParentid(parentid);
							enq.setShow_flg(false);
							statusFlg = Enquiry.SHOW_FLG;
							int result = dao.batchUpdateEnquiryStatus(statusFlg, thisMember, enq);
							cmaLogger.debug("[UPDATE MESSAGE] "+ result + " message is updated by "+ thisMember.getMem_login_email(), request);
							successResult = true;
						} else if(request.getParameter("mode").indexOf("DEL")>=0){
							//DEL
							//enq.setDelete_flg(false);
							enq.setDelete(thisMember);
							dao.update(enq);
							enq = new Enquiry();
							enq.setParentid(parentid);
							//enq.setDelete(thisMember); //Comment this: Batch delete depends on the statusFlg(nextline) not the "delete attribute()");
							statusFlg = Enquiry.DEL_FLG;
							int result = dao.batchUpdateEnquiryStatus(statusFlg, thisMember, enq);
							cmaLogger.debug("[UPDATE MESSAGE] "+ result + " message is updated by "+ thisMember.getMem_login_email(), request);
							successResult = true;
						} else {
							cmaLogger.error("[UPDATE MESSAGE ERROR] Invalid MODE = "+ request.getParameter("mode"), request);
						}
					//END HIDE or DEL ALL
					}
				}
			}
			if(successResult){
				request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
				"MSG_UPDATE_DONE"));
			}
			SiteResponse listResp = listMessage(request, response);
			listResp.addErrorMsg(thisResp.getErrorMsgList());
			return listResp;
		} catch (Exception e){
			cmaLogger.error("[UPDATE MESSAGE ERROR]", request, e);
			thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			SiteResponse listResp = listMessage(request, response);
			listResp.addErrorMsg(thisResp.getErrorMsgList());
			return listResp;
		}
	}

	private SiteResponse doList(HttpServletRequest request,
			HttpServletResponse response, boolean isAjax){
		
		SiteResponse thisResp = listMessage(request, response);
		if(request.getParameter("new")==null){
			if(!isAjax){
				thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_LIST);
			} else {
				thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_LIST_AJ);
			}
		} else {
			if(!isAjax){
				thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_LIST2);
			} else {
				thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_LIST_AJ2);
			}
		}
		return thisResp;
	}
	
	private SiteResponse listMessage(HttpServletRequest request,
			HttpServletResponse response) {
		
		SiteResponse thisResp = super.createResponse();
		
		EnquiryDAO dao = EnquiryDAO.getInstance();
		//SellItemDAO sDao = SellItemDAO.getInstance();
		
		//SellItem s_enq = new SellItem();
		Enquiry enq = new Enquiry();
		try{
			//ArrayList<String[]> sellItemOrderBy = new ArrayList<String[]>();
			//sellItemOrderBy.add(new String[]{"prod_last_enq_date","desc"});
			
			Enquiry[] listEnquiry = dao.getEnquiryContentByOwner(thisMember);
			Enquiry dummy;
			//List sellItemList = sDao.findListWithSample(s_enq, sellItemOrderBy);
			
			ArrayList<String[]> enqOrderBy = new ArrayList<String[]>();
			enqOrderBy.add(new String[]{"parentid","desc"});
			enqOrderBy.add(new String[]{"create_date","asc"});
			
			ArrayList<List> enqFullList = new ArrayList<List>();
			ArrayList<Enquiry> itemFullList = new ArrayList<Enquiry>();
			for(int x =0; x < listEnquiry.length; x++){
				dummy = listEnquiry[x];
				enq.setContentid(dummy.getContentid());
				enq.setDelete_flg(false);
				enq.setMessage_type("O");
				List aList = dao.findListWithSample(enq,enqOrderBy);
				if(aList!=null && aList.size()>0){
					enqFullList.add(aList);
					itemFullList.add(dummy);
				}
			}
			request.setAttribute("ENQUIRY_LIST", enqFullList);
			request.setAttribute("ITEM_LIST", itemFullList);
			thisResp.setTargetJSP(CMAJspMapping.JSP_MSG_LIST);
		} catch (BaseDBException e) {
			thisResp.addErrorMsg(new SiteErrorMessage("ENQUIRY_ERROR"));
			//cmaLogger.error("PUBLIC_Handler.doListEnquiry Exception: Product Not Found ("+contentGuid+")", request);
		}
		return thisResp;
	}

}



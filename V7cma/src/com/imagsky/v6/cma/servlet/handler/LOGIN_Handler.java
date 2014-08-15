/***
 * 2014-08-14 Remove Shop URL in register form
 */
package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;

import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.ClearFileUtil;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MailUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.utility.Base64;
import com.imagsky.utility.MD5Utility;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Service;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




public class LOGIN_Handler  extends BaseHandler {

	//Save Registration
	public static final String DO_REG = "REG";
	public static final String SHOW_REG = "REGFORM";
	
	//Ajax Reg
	public static final String DO_AJAX_REG="AJ_REG";
	public static final String DO_AJAX_LOGIN="AJ_LOGIN";
	
	//Perform Login
	public static final String DO_LOGIN = "LOGIN";
	public static final String DO_FBLOGIN = "FBLOGIN"; //Always AJAX
	
	//Logout
	public static final String DO_LOGOUT = "LOGOUT";
	
	//ACTIVATE - Back from Register Email
	public static final String ACTI = "ACTIVATE"; 
	
	//FORGET PASSWORD
	public static final String DO_FORGET_PWD = "FPWD";
	public static final String DO_FORGET_PWD_RESET = "FPWD_RESET";
	
	protected static final String CLASS_NAME = "LOGIN_Handler.java";
	
	/* (non-Javadoc)
	 * @see com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);		
		
		String action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
		
		cmaLogger.debug("Action = "+ action);
		
		if(action.equalsIgnoreCase(DO_REG) || 
				action.equalsIgnoreCase(DO_AJAX_REG)){
			thisResp = doRegister(request, response);
		} else if(action.equalsIgnoreCase(DO_LOGIN) || action.equalsIgnoreCase(DO_AJAX_LOGIN)){
			thisResp = doLogin(request, response);
		} else if(action.equalsIgnoreCase(DO_FBLOGIN)){
			thisResp = doFacebookLogin(request, response);			
		} else if(action.equalsIgnoreCase(DO_LOGOUT)){
			thisResp = doLogout(request, response);
		} else if(action.equalsIgnoreCase(SHOW_REG)){
			thisResp.setTargetJSP(CMAJspMapping.JSP_REGISTER_FORM);
		} else if(action.equalsIgnoreCase(ACTI)){			
			thisResp = doActivate(request, response);
		} else if(action.equalsIgnoreCase(DO_FORGET_PWD)){
			thisResp = doForgetPwd(request, response);
		} else if(action.equalsIgnoreCase(DO_FORGET_PWD_RESET)){
			thisResp = doResetPwd(request, response);			
		} else {
			//Retain redirectURL
			if(!CommonUtil.isNullOrEmpty(request.getParameter("redirectURL"))){
				request.setAttribute("redirectURL",request.getParameter("redirectURL"));
			}
			thisResp.setTargetJSP(CMAJspMapping.JSP_LOGIN);
		}
		cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
		return thisResp;
	}
	
	
	private SiteResponse doFacebookLogin(HttpServletRequest request,
			HttpServletResponse response) {
		
		SiteResponse thisResp = super.createResponse();
		String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		Member returnMember= null;
		
		boolean isValidFbCallBack = true;
		
		//Start Validation (Client Information)
		if(CommonUtil.isNullOrEmpty(request.getParameter("fb_accesstoken"))){
			isValidFbCallBack = false;
			cmaLogger.error("[FB LOGIN] Error: Access Token is missing", request);
		} else if (CommonUtil.isNullOrEmpty(request.getParameter("fb_id"))){
			isValidFbCallBack = false;
			cmaLogger.error("[FB LOGIN] Error: Facebook ID is missing", request);
		} else if(CommonUtil.isNullOrEmpty(request.getParameter("fb_email"))){
			isValidFbCallBack = false;
			cmaLogger.error("[FB LOGIN] Error: Facebook Email is missing", request);
		}
		
		//Start Validation (Server Information)
		if(isValidFbCallBack){
			Member member = new Member();
			member.setFb_id(request.getParameter("fb_id"));
			member.setMem_firstname(CommonUtil.null2Empty(request.getParameter("fb_firstname")));
			member.setMem_lastname(CommonUtil.null2Empty(request.getParameter("fb_lastname")));
			member.setMem_display_name(CommonUtil.null2Empty(request.getParameter("fb_name")));
			member.setMem_login_email(CommonUtil.null2Empty(request.getParameter("fb_email")));
			
			String fb_link = CommonUtil.null2Empty(request.getParameter("fb_profile_url")).replaceAll("http://www.facebook.com/", "");
			if(fb_link.indexOf(".do")>=0 ){
				fb_link = fb_link.replaceAll(".","_");
			}
			member.setMem_shopurl(fb_link);
			
			MemberBiz biz = MemberBiz.getInstance();
			try{
				returnMember = biz.getFBMemberLogin(member);
			} catch (Exception e){
				cmaLogger.error("[FB LOGIN] Error: biz.getFBMemberLogin ", request, e);
			}
		}
		
		//LOGIN
		if(isValidFbCallBack && returnMember!=null){
			//Update lastloginDate
			MemberDAO dao = MemberDAO.getInstance();
			returnMember.setMem_lastlogindate(new java.util.Date());
			try{
				dao.update(returnMember);
			} catch(Exception e){
				cmaLogger.error("[FB LOGIN] Error: Update LastLoginDate ", request, e);
			}
			//Store in session
			ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
				//Store fb access token
				String accessToken = request.getParameter("fb_accesstoken");
				accessToken = CommonUtil.stringTokenize(accessToken.substring(accessToken.indexOf("access_token")), "&")[0];
				accessToken = CommonUtil.stringTokenize(accessToken, "=")[1];
			session.setFbAccessToken(accessToken);
			session.setLogined(true);
			session.setUser(returnMember);
                                                      MemberBiz biz = MemberBiz.getInstance();
                                                      try{
                                                      if(!biz.hasInputAddress(returnMember)){
                                                          request.getSession().setAttribute(SystemConstants.REQ_ATTR_REMINDER, "MSG_INPUT_ADDRESS");
                                                      }
                                                      } catch (Exception e){
                                                          	cmaLogger.error("[FB LOGIN] Error: Get Member Delivery Addresss ", request, e);
                                                      }
			request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);
			thisResp.setTargetJSP(CMAJspMapping.JSP_FB_LOGIN);
		}

		return thisResp;
	}


	/***
	 * Display Pwd Reset Form / Reset Password
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doResetPwd(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
		
		request.setAttribute("mode","reset");
		
		if(request.getParameter("s")!=null && request.getParameter("code")!=null){
			request.getSession().setAttribute("email", Base64.decode(request.getParameter("s")));
			request.getSession().setAttribute("code", request.getParameter("code"));
			thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
		} else if(request.getSession().getAttribute("email")!=null && request.getParameter("LOGIN_EMAIL")!=null){
			if(CommonUtil.isNullOrEmpty(request.getParameter("LOGIN_EMAIL"))){
				thisResp.addErrorMsg(new SiteErrorMessage("REG_ID_EMPTY"));
			} else if (
					!((String)request.getSession().getAttribute("email")).equalsIgnoreCase(request.getParameter("LOGIN_EMAIL"))){
				thisResp.addErrorMsg(new SiteErrorMessage("FPWD_CODE_ERROR"));
			} else if(CommonUtil.isNullOrEmpty((String)request.getSession().getAttribute("code"))){
				thisResp.addErrorMsg(new SiteErrorMessage("FPWD_CODE_ERROR"));
			}
			if(CommonUtil.isNullOrEmpty(request.getParameter("LOGIN_NEW_PWD"))){
				thisResp.addErrorMsg(new SiteErrorMessage("PROF_NEW_PWD_EMPTY"));
			} else if(CommonUtil.isNullOrEmpty(request.getParameter("LOGIN_NEW_PWD2")) ||
					!request.getParameter("LOGIN_NEW_PWD").equalsIgnoreCase(request.getParameter("LOGIN_NEW_PWD2"))){
				thisResp.addErrorMsg(new SiteErrorMessage("PROF_NEW_PWD_NOT_MATCH"));
			} else if(request.getParameter("LOGIN_NEW_PWD").length()<6){
				thisResp.addErrorMsg(new SiteErrorMessage("PROF_NEW_PWD_TOO_SHORT"));
			}
			
			if(thisResp.hasError()){
				cmaLogger.error("[FORGET_PWD] Password Reset Error: " + request.getRemoteAddr() + " MEMBER EMAIL:"+ request.getParameter("LOGIN_EMAIL"), request);
				for(Object msg : thisResp.getErrorMsgList()){
					cmaLogger.error("[FORGET_PWD] Error reason:  " + request.getRemoteAddr() + ((SiteErrorMessage)msg).getMsgCode() );
				}
				thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
			}
			else {
				String email = request.getParameter("LOGIN_EMAIL");
				MemberDAO mdao = MemberDAO.getInstance();
				Member enqMember = new Member();
				
				try{
					enqMember.setMem_login_email(email);
					List<?> aList = mdao.findListWithSample(enqMember);
					if(aList==null || aList.size()<=0){
						cmaLogger.error("[FORGET_PWD] Reset Not found User: " + request.getRemoteAddr() + " MEMBER EMAIL:"+ request.getParameter("LOGIN_EMAIL"), request);
						thisResp.addErrorMsg(new SiteErrorMessage("FPWD_NO_USER"));
						thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
						request.removeAttribute("mode");
						request.getSession().removeAttribute("email");
						request.getSession().removeAttribute("code");
					} else {
						enqMember = (Member)aList.get(0);
						if(!enqMember.getMem_passwd().substring(0,10).equalsIgnoreCase((String)(request.getSession().getAttribute("code")))){
							cmaLogger.error("[FORGET_PWD] Reset code Error: " + request.getRemoteAddr() + " Session Code:"+ request.getSession().getAttribute("code"), request);
							thisResp.addErrorMsg(new SiteErrorMessage("FPWD_CODE_ERROR"));
							thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
							request.removeAttribute("mode");
							request.getSession().removeAttribute("email");
							request.getSession().removeAttribute("code");
						} else {
							enqMember.setMem_passwd(MD5Utility.MD5(request.getParameter("LOGIN_NEW_PWD")));
							if(mdao.update(enqMember)){
								request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG,MessageUtil.getV6Message(lang, "FPWD_RESET_DONE"));
								thisResp.setTargetJSP(CMAJspMapping.JSP_LOGIN);
								//Redirect to Login Page after reset password
							}
						}
					}
					
				} catch (Exception e){
					cmaLogger.error("Reset Password ERROR", request, e);
					thisResp.addErrorMsg(new SiteErrorMessage("FPWD_CODE_ERROR"));
					request.removeAttribute("mode");
					request.getSession().removeAttribute("email");
					request.getSession().removeAttribute("code");
					thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
				}
			}
		}
		if(CommonUtil.isNullOrEmpty(thisResp.getTargetJSP())){
			request.removeAttribute("mode");
			request.getSession().removeAttribute("email");
			request.getSession().removeAttribute("code");
			thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
		}
		return thisResp;
	}



	/***
	 * Forget Pwd Init Page / FPWD email sending
	 * @param request
	 * @param response
	 * @return
	 */
	private SiteResponse doForgetPwd(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		
		//Clear Prev Forget Pwd Request
		request.getSession().removeAttribute("email");
		request.getSession().removeAttribute("code");
		request.removeAttribute("mode");
		
		if(CommonUtil.null2Empty(request.getParameter("sid")).equalsIgnoreCase(request.getSession().getId())){
			ArrayList<String> emailParam = new ArrayList<String>();
			String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
			try{
				MemberDAO dao = MemberDAO.getInstance();
				Member fpwdMember = new Member();
				fpwdMember.setMem_login_email(request.getParameter("LOGIN_EMAIL"));
				List<?> fpwdMemberList = dao.findListWithSample(fpwdMember);
				if(fpwdMemberList ==null || fpwdMemberList.size()==0){
					cmaLogger.error("[FORGET_PWD] Not found User: " + request.getRemoteAddr() + " MEMBER EMAIL:"+ request.getParameter("LOGIN_EMAIL"), request);
					thisResp.addErrorMsg(new SiteErrorMessage("FPWD_NO_USER"));
					thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
				} else {
					cmaLogger.info("[FORGET_PWD] FPWD Request: " + request.getRemoteAddr() + " MEMBER EMAIL:"+ request.getParameter("LOGIN_EMAIL"), request);
					//Forget Email Here
					fpwdMember = (Member)fpwdMemberList.get(0);
					emailParam.add(fpwdMember.getMem_firstname()+fpwdMember.getMem_lastname());
					String url = SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost)+ request.getAttribute("contextPath")+"/do/LOGIN?action=FPWD_RESET&s="+
						Base64.encode(fpwdMember.getMem_login_email())+
						//URLEncoder.encode(fpwdMember.getMem_login_email(), "UTF-8")+
						"&code="+fpwdMember.getMem_passwd().substring(0, 10);
					cmaLogger.debug("[FORGET_PWD URL] "+ url, request);
					emailParam.add("<a href=\""+ url+ "\">"+url+"</a>");
					
					MailUtil mailer = new MailUtil();
					mailer.setToAddress(fpwdMember.getMem_login_email());
					mailer.setSubject(MessageUtil.getV6Message(lang, "EMAIL_FPWD_SUBJ"));
					mailer.setContent(MessageUtil.getV6Message(lang, "EMAIL_FPWD", emailParam));
					if (!mailer.send()){
						cmaLogger.error("[FORGET_PWD] FPWD Email - " + fpwdMember.getMem_login_email(), request);
					}
					request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_TITLE, MessageUtil.getV6Message(lang, "TIT_FORGETPWD"));
					request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_MSG, MessageUtil.getV6Message(lang, "FPWD_MSG_ACK"));
					thisResp.setTargetJSP(CMAJspMapping.JSP_GEN_PAGE);
				}
				
			} catch (Exception e){
				cmaLogger.error("FORGET PASSWORD Request error: ", request,e);
				thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
			}
		} else {
			//Init Forget Password
			thisResp.setTargetJSP(CMAJspMapping.JSP_FORGET_PWD);
		}
		return thisResp;
	}




	private SiteResponse doActivate(HttpServletRequest request,
			HttpServletResponse response) {

		SiteResponse thisResp = super.createResponse();
		String loginEmail = null;
		String code = CommonUtil.null2Empty(request.getParameter("code"));
		try{
			loginEmail = URLDecoder.decode(CommonUtil.null2Empty(request.getParameter("s")),"UTF-8");
			request.setAttribute("LOGIN_EMAIL", loginEmail);
			cmaLogger.debug("LOGIN_EMAIL:"+ loginEmail);
		} catch (UnsupportedEncodingException e){
			
		}
		Member newMember = new Member();
		newMember.setMem_login_email(loginEmail);
		try{
			MemberDAO dao = MemberDAO.getInstance();
			List list = (List) dao.findListWithSample(newMember);
			if(list.size()!=0){
				newMember = (Member)list.get(0); 
			}
			if(list.size()==0){
				//No such member
				cmaLogger.error("[REG_ACTI_NO_MEMBER]:" + newMember.getMem_login_email());
				thisResp.addErrorMsg(new SiteErrorMessage("REG_ACTI_NO_MEMBER"));
			} else if(newMember.isSys_is_live()){
				//Already activated
				cmaLogger.error("[REG_ACTI_ALREADY]:" + newMember.getMem_login_email());
				thisResp.addErrorMsg(new SiteErrorMessage("REG_ACTI_ALREADY"));
			} else if(!newMember.getMem_passwd().substring(0, 10).equalsIgnoreCase(code)){
				//Code mismatch
				cmaLogger.error("[REG_ACTI_CODE_INVALID]:" + newMember.getMem_login_email());
				thisResp.addErrorMsg(new SiteErrorMessage("REG_ACTI_CODE_INVALID"));
			} else {
				newMember.setSys_is_live(true);
				dao.update(newMember);
				request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
				"ACTI_DONE"));
				
			}
		} catch (Exception e){
			cmaLogger.error("REG_ACTI_ERROR",e);
			thisResp.addErrorMsg(new SiteErrorMessage("REG_ACTI_ERROR"));
		}
		
		thisResp.setTargetJSP(CMAJspMapping.JSP_LOGIN);
		return thisResp;
	}

	private SiteResponse doLogout(HttpServletRequest request,
			HttpServletResponse response) {
		
		SiteResponse thisResp = super.createResponse();
		ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
		Member logoutUser =  session.getUser();
		
		//File clear
		ClearFileUtil.clearFile(logoutUser, ClearFileUtil.ALL);
		
		//LOGOUT
		session.setUser(null);
		session.setLogined(false);
		
		//FB access token
		session.setFbAccessToken(null);
		
		//Clear Shopping Cart
		request.getSession().removeAttribute(SystemConstants.PUB_CART);
		request.getSession().removeAttribute(SystemConstants.PUB_CART_INFO);
		request.getSession().removeAttribute(SystemConstants.PUB_BULKORDER_INFO);
                
                                    //Clear Reminder
		request.getSession().removeAttribute(SystemConstants.REQ_ATTR_REMINDER );
                
		thisResp.setTargetJSP(DO_LOGIN);
		request.setAttribute("LOGOUTUSER", logoutUser);
		if(logoutUser!=null){
			request.setAttribute("redirectURL", request.getAttribute("contextPath")+ "/" + logoutUser.getMem_shopurl()+"/.do");
		}
		request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
		"LOGOUT_DONE"));
		thisResp.setTargetJSP(CMAJspMapping.JSP_LOGIN);
		
		return thisResp;
	}

	private SiteResponse doRegister(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		boolean isCheckoutReg = "checkout".equalsIgnoreCase(request.getParameter("regtype"));
		
		cmaLogger.debug("[doRegister START]");
		
		if(isCheckoutReg){
			request.setAttribute("regtype", request.getParameter("regtype"));
		}
		
		String action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
		boolean isAjax = action.equalsIgnoreCase(DO_AJAX_REG);
		try{
			Member newMember = new Member();
			newMember.setMem_login_email(CommonUtil.null2Empty(request.getParameter("REG_MEM_EMAIL")));
			newMember.setMem_passwd(MD5Utility.MD5(CommonUtil.null2Empty(request.getParameter("REM_MEM_PASSWD"))));
			if(!isCheckoutReg){
				newMember.setMem_shopurl(CommonUtil.null2Empty(request.getParameter("REG_SHOPURL")).toLowerCase());
			}
			newMember.setMem_firstname(CommonUtil.null2Empty(request.getParameter("REG_MEM_FIRSTNAME")));
			newMember.setMem_lastname(CommonUtil.null2Empty(request.getParameter("REG_MEM_LASTNAME")));
			newMember.setMem_shopname(CommonUtil.null2Empty(request.getParameter("REG_SHOPNAME")));
			
			
			if(CommonUtil.isNullOrEmpty(newMember.getMem_login_email())){
				thisResp.addErrorMsg(new SiteErrorMessage("REG_ID_EMPTY"));
			} else if(!CommonUtil.isValidEmailAddress(newMember.getMem_login_email())){
				thisResp.addErrorMsg(new SiteErrorMessage("REG_ID_INVALID"));
			}
			
			//Reg type = checkout : bypass URL input checking & captcha
			if(!isCheckoutReg){
				/*** 2014-08-15
				if(CommonUtil.isNullOrEmpty(newMember.getMem_shopurl())){
					thisResp.addErrorMsg(new SiteErrorMessage("REG_URL_EMPTY"));
				} else if (!CommonUtil.isLetterNumeric(newMember.getMem_shopurl()) ||
						!CommonUtil.isLetter(newMember.getMem_shopurl().substring(0, 1))){
					//First character should be alphabet
					thisResp.addErrorMsg(new SiteErrorMessage("REG_URL_INVALID"));
				} ****/
				if(CommonUtil.isNullOrEmpty(request.getParameter("captcha"))){
					thisResp.addErrorMsg(new SiteErrorMessage("REG_CAPTCHA_INVALID"));
				} else if(!request.getParameter("captcha").equalsIgnoreCase((String)request.getSession().getAttribute("dns_security_code"))){
					cmaLogger.debug("Sesion: "+ (String)request.getSession().getAttribute("dns_security_code") + " & "+request.getParameter("captcha"));
					thisResp.addErrorMsg(new SiteErrorMessage("REG_CAPTCHA_INVALID"));
				}
			}
			
			if(request.getParameter("REM_MEM_CPASSWD")!=null){
				if(!request.getParameter("REM_MEM_CPASSWD").equalsIgnoreCase(request.getParameter("REM_MEM_PASSWD"))){
					thisResp.addErrorMsg(new SiteErrorMessage("REG_PWD_NOT_EQUAL"));
				}
			}
			
			if(!thisResp.hasError()){
				Member enqMember = new Member();
				enqMember.setMem_login_email(newMember.getMem_login_email());
				List aList = (List)dao.findListWithSample(enqMember);
				if(aList!=null && aList.size()>0){
					thisResp.addErrorMsg(new SiteErrorMessage("REG_ID_ALREADY_EXIST"));
				}
				//ByPass URL Check for checkout page register
				/*** 2014-08-15
				if(!isCheckoutReg){
					if(dao.validURL(newMember)!=null){
						thisResp.addErrorMsg(new SiteErrorMessage("REG_URL_ALREADY_EXIST"));
					}
					int find = Arrays.binarySearch(PropertiesConstants.getList(PropertiesConstants.urlblacklist), newMember.getMem_shopurl());
					if(find>=0){
						thisResp.addErrorMsg(new SiteErrorMessage("REG_URL_ALREADY_EXIST"));
					}
				}***/
				//initialize new member
				newMember.setSys_is_live(false); //Need activate email
				newMember.setSys_is_node(false);
				newMember.setSys_is_published(false);
				newMember.setMem_max_sellitem_count(30);
				newMember.setSys_create_dt(new java.util.Date());
				newMember.setSys_creator("V6 SYSTEM");
				newMember.setSys_update_dt(new java.util.Date());
				newMember.setSys_updator("V6 SYSTEM");
				newMember.setMem_cash_balance(new Double(0));
			}
			
			cmaLogger.debug("[doRegister Validation COMPLETED]");
			
			//Retain redirectURL
			if(!CommonUtil.isNullOrEmpty(request.getParameter("redirectURL"))){
				request.setAttribute("redirectURL",request.getParameter("redirectURL"));
			}
			
			if(thisResp.hasError()){
				//set to error jsp
				//cmaLogger.debug("[doRegister Validation HAS ERROR]");
				request.setAttribute("formUser",newMember);
			} else {
				if(dao.create(newMember)!=null){
					cmaLogger.debug("[doRegister DAO Create COMPLETED]");
					thisResp.setTargetJSP(CMAJspMapping.JSP_REGISTER_AJAX);
					request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
							"REG_DONE"));
					//Register Email Here
					ArrayList<String> emailParam = new ArrayList<String>();
					String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
					try{
						emailParam.add(newMember.getMem_firstname()+newMember.getMem_lastname());
						String url = SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost)+ request.getAttribute("contextPath")+"/do/LOGIN?action=ACTIVATE&s="+ 
							URLEncoder.encode(newMember.getMem_login_email(), "UTF-8")+
							"&code="+MD5Utility.MD5(request.getParameter("REM_MEM_PASSWD")).substring(0, 10);
						url = "<a href=\""+ url + "\">" + url + "</a>";
						cmaLogger.debug("[ACTI URL] "+ url);
						emailParam.add(url);
						emailParam.add(newMember.getMem_login_email());
						emailParam.add(request.getParameter("REM_MEM_PASSWD"));
						String emailContent = MessageUtil.getV6Message(lang, "EMAIL_REG_SUCCESS", emailParam);
						
						MailUtil mailer = new MailUtil();
						mailer.setToAddress(newMember.getMem_login_email());
						mailer.setSubject(MessageUtil.getV6Message(lang, "EMAIL_REG_SUCCESS_SUBJ"));
						mailer.setContent(emailContent);
						if (!mailer.send()){
							cmaLogger.error("Member registration email failed - " + newMember.getMem_login_email());
						}
						//Set Content for general message page
						ArrayList<String> genParam = new ArrayList<String>();
						genParam.add(newMember.getMem_login_email());
//						request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_PARAM,  genParam);

						request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_TITLE, MessageUtil.getV6Message(lang, "GENTIT_REG_SUCCESS"));
						request.setAttribute(SystemConstants.REQ_ATTR_GENERAL_MSG, MessageUtil.getV6Message(lang, "GENMSG_REG_SUCCESS",genParam));
						if(!isAjax){
							thisResp.setTargetJSP(CMAJspMapping.JSP_GEN_PAGE);
						} else {
							thisResp.setTargetJSP(CMAJspMapping.JSP_GEN_PAGE_AJAX);
						}
						//Temporary login for checkout register
						if(isCheckoutReg){
							//Update lastloginDate
							newMember.setMem_lastlogindate(new java.util.Date());
							dao.update(newMember);
							//Store in session
							ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
							session.setLogined(true);
							session.setUser(newMember);
							request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);
						}
					} catch (Exception e){
						cmaLogger.debug("[doRegister DAO Create FAILED]");
						cmaLogger.error("Generate Register URL Error: " + newMember.getMem_login_email(), e);
					}
					
				} else {
					cmaLogger.error("LOGIN_Handler.doRegister Error: Unknown error" , request);
				}
			}
			cmaLogger.debug("[doRegister DAO COMPLETED]");
			if(CommonUtil.isNullOrEmpty(thisResp.getTargetJSP()) || "/".equals(thisResp.getTargetJSP())){
				if(isAjax)
					thisResp.setTargetJSP(CMAJspMapping.JSP_REGISTER_AJAX);
				else 
					thisResp.setTargetJSP(CMAJspMapping.JSP_REGISTER_FORM);
			}
			cmaLogger.debug("[doRegister : Target JSP = "+ thisResp.getTargetJSP() + "]");
			cmaLogger.debug("[doRegister JSP Assign COMPLETED]");
			
		} catch (BaseDBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			cmaLogger.error("LOGIN_Handler.doRegister Error: " , request, e);
			if(isAjax)
				thisResp.setTargetJSP(CMAJspMapping.JSP_REGISTER_AJAX);
			else 
				thisResp.setTargetJSP(CMAJspMapping.JSP_REGISTER_FORM);
		}
		cmaLogger.debug("[doRegister END]");
		return thisResp;
	}
	
	private SiteResponse doLogin(HttpServletRequest request, HttpServletResponse response) {
		SiteResponse thisResp = super.createResponse();
		
		String action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
		boolean isAjax = action.equalsIgnoreCase(DO_AJAX_LOGIN);
		
		MemberDAO dao = MemberDAO.getInstance();
		try {
			Member loginMember = new Member();
			Member thisLoginMember = null;
			loginMember.setMem_login_email(CommonUtil.null2Empty(request.getParameter("txtMbrID")));
			List returnList = dao.findListWithSample(loginMember);
			if(returnList!=null && returnList.size()>0){
				thisLoginMember = (Member)returnList.get(0);
			}
			//Retain redirectURL
			if(!CommonUtil.isNullOrEmpty(request.getParameter("redirectURL"))){
				request.setAttribute("redirectURL",request.getParameter("redirectURL"));
			}
			
			if(thisLoginMember==null){
				//No such member
				thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_NO_MEMBER"));
			} else {
				cmaLogger.debug(MD5Utility.MD5(CommonUtil.null2Empty(request.getParameter("txtMbrPIN"))));
				cmaLogger.debug(thisLoginMember.getMem_passwd());
				//Validate password
				if(!thisLoginMember.isSys_is_live()){
					//NOT YET ACTIVATE
					thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_ACC_NOT_ACTIVATE"));
				} else if(thisLoginMember.getFb_id()!=null && CommonUtil.isNullOrEmpty(thisLoginMember.getMem_passwd())){
					//FACEBOOK REGISTERED BUT NOT BBM => Redirect to Setting Password
					thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_INV_PASSWD"));
					request.setAttribute("FB_SET_PASSWORD", "Y");
				} else if(MD5Utility.MD5(CommonUtil.null2Empty(request.getParameter("txtMbrPIN"))).equalsIgnoreCase(thisLoginMember.getMem_passwd())){
					//Update lastloginDate
					thisLoginMember.setMem_lastlogindate(new java.util.Date());
			 		dao.update(thisLoginMember);
					//Store in session
					ImagskySession session = (ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
					session.setLogined(true);
					session.setUser(thisLoginMember);
					request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);
					request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String)request.getAttribute(SystemConstants.REQ_ATTR_LANG), 
					"LOGIN_DONE"));
					
					//DEBUG LOG
					Collection<Service> services = thisLoginMember.getServices();
					cmaLogger.debug("Service count:" + services.size());
					Iterator it = services.iterator();
					Service tmpRoles;
					while(it.hasNext()){
						tmpRoles = (Service)it.next();
						cmaLogger.debug("Service of Member"+ thisLoginMember.getMem_login_email() + ":" + tmpRoles.getServ_name());
					}
				} else {
					//Wrong Password
					thisResp.addErrorMsg(new SiteErrorMessage("LOGIN_INV_PASSWD"));
				}
			}
			
			if(isAjax) 
				{ thisResp.setTargetJSP(CMAJspMapping.JSP_LOGIN_AJAX);}
			else  thisResp.setTargetJSP(CMAJspMapping.JSP_LOGIN);
			
		} catch (BaseDBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			cmaLogger.error("LOGIN_Handler.doLogin Error: " , request, e);
		}
		return thisResp;
	}
}



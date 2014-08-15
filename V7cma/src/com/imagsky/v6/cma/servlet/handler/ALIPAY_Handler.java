/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.domain.Member;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jasonmak
 */
public class ALIPAY_Handler extends BaseHandler {

    protected static final String CLASS_NAME = "ALIPAY_Handler.java";
    private Member thisMember = null;
    private String thisLang = null;
    private String action = null;

    @Override
    public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) throws BaseException {

        SiteResponse thisResp = super.createResponse();
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);
        action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));
        cmaLogger.debug("Action = " + action);

        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

        String[] urlToken = (String[]) request.getAttribute(SystemConstants.REQ_ATTR_URL_PATTERN);
        String thisAction = null; //FOR url pattern
        String biid = null; //FOR url pattern
        if (urlToken != null && urlToken.length >= 3) {
            //[0] = appcode, [1] = details, [2] = biid
            thisAction = urlToken[1].toLowerCase();
            biid = urlToken[2].toLowerCase();
        } else {
            thisAction = action;
            biid = request.getParameter("biid");
        }


        boolean isAjax = thisAction.endsWith("_AJ");
        if (thisAction.equalsIgnoreCase("MAIN")) {
            //DISPLAY BANK SCRIPT UPLOAD FORM
            thisResp = showMain(request, response, isAjax);
        } else if (thisAction.equalsIgnoreCase("submit_payment")) {
            thisResp = submitPayment(request, response);
            /**
             * } else if(thisAction.equalsIgnoreCase("newbid") ||
             * thisAction.equalsIgnoreCase("newbid_AJ")){ thisResp =
             * addNewBid(request, response, isAjax); } else
             * if(thisAction.equalsIgnoreCase("hist_AJ")){ thisResp =
             * showHist(request, response, isAjax); *
             */
        } else {
            thisResp = showBidLogin(request, response);
        }
        return thisResp;
    }

    private SiteResponse showBidLogin(HttpServletRequest request, HttpServletResponse response) {
        SiteResponse thisResp = super.createResponse();
        thisResp.setTargetJSP(CMAJspMapping.PUB_ALI_LOGIN);
        return thisResp;

    }

    private SiteResponse doNothing(HttpServletRequest request, HttpServletResponse response, boolean ajax) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    private SiteResponse showMain(HttpServletRequest request, HttpServletResponse response, boolean ajax) {
        SiteResponse thisResp = super.createResponse();

        //TODO: Uncomment it when deploy to PRODUCTION
        //if(!FacebookUtil.isFBLogined(request)) return showBidLogin(request, response);

        if (ajax) {
            thisResp.setTargetJSP(CMAJspMapping.PUB_ALI_MAIN_AJ);
        } else {
            thisResp.setTargetJSP(CMAJspMapping.PUB_ALI_MAIN);
        }
        return thisResp;
    }

    private SiteResponse submitPayment(HttpServletRequest request, HttpServletResponse response) {
        SiteResponse thisResp = super.createResponse();
        cmaLogger.debug("Method submitPayment Start");
        if (CommonUtil.isNullOrEmpty(request.getParameter("c_phone")) && CommonUtil.isNullOrEmpty(request.getParameter("c_email"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("ALI_ERR_ATLEAST_ONECONTACT"));
        }
        if (!CommonUtil.isValidNumber(request.getParameter("c_amount"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("ALI_INVALID_AMOUNT"));
        }
        java.util.Date txnDate = CommonUtil.isValidDate(request.getParameter("c_date"), "dd-mm-yyyy");
        if (txnDate == null) {
            thisResp.addErrorMsg(new SiteErrorMessage("ALI_INVALID_DATE"));
        } else if (txnDate.getTime() > new java.util.Date().getTime()) {
            thisResp.addErrorMsg(new SiteErrorMessage("ALI_INVALID_DATE_FUTURE"));
        }
        if(CommonUtil.isNullOrEmpty(request.getParameter("c_time")) || CommonUtil.isNullOrEmpty(request.getParameter("c_time_m"))){
            thisResp.addErrorMsg(new SiteErrorMessage("ALI_INVALID_TIME"));
        }
        if(!CommonUtil.isValidEmailAddress(request.getParameter("c_ali_email"))){
            thisResp.addErrorMsg(new SiteErrorMessage("ALI_INVALID_ALIEMAIL"));
        }

        request.setAttribute("c_person", request.getParameter("c_person"));
        request.setAttribute("c_phone", request.getParameter("c_phone"));
        request.setAttribute("c_email", request.getParameter("c_email"));
        request.setAttribute("c_amount", request.getParameter("c_amount"));
        request.setAttribute("c_date", request.getParameter("c_date"));
        request.setAttribute("c_ali_name", request.getParameter("c_ali_name"));
        request.setAttribute("c_hkd_amount", request.getParameter("c_hkd_amount"));
        request.setAttribute("c_bank", request.getParameter("c_bank"));
        request.setAttribute("c_time_m", request.getParameter("c_time_m"));
        request.setAttribute("c_ali_email", request.getParameter("c_ali_email"));
        request.setAttribute("SCRIPT_IMAGE_1", request.getParameter("SCRIPT_IMAGE_1"));

        if (!thisResp.hasError()) {
            cmaLogger.debug("Method submitPayment -- no error redirect to confirm page");
            request.setAttribute("confirm", "Y");
        }
        thisResp.setTargetJSP(CMAJspMapping.PUB_ALI_MAIN_AJ);
        return thisResp;
    }
}

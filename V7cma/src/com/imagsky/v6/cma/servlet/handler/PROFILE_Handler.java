package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.V6Util;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.utility.MD5Utility;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.ArticleDAO;
import com.imagsky.v6.dao.MemAddressDAO;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.OrderSetDAO;
import com.imagsky.v6.domain.Article;
import com.imagsky.v6.domain.MemAddress;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.OrderSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PROFILE_Handler extends BaseHandler {

    //Refresh the CMA slide section
    public static final String DO_SLIDE_REFRESH = "SLIDREF";
    private Member thisMember = null;
    private String thisLang = null;
    public static final String EDIT = "EDIT";
    public static final String DO_SAVE = "SAVE";
    protected static final String CLASS_NAME = "PROFILE_Handler.java";

    /*
     * (non-Javadoc) @see
     * com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse)
     */
    public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

        String action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));

        cmaLogger.debug("Action = " + action);

        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

        request.setAttribute("action", action);

        if (action.equalsIgnoreCase(DO_SAVE)) {
            thisResp = doSave(request, response);
        } else if (action.equalsIgnoreCase(EDIT)) {
            thisResp = showEdit(request, response);
        } else {
            thisResp = showMain(request, response);
        }


        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
        return thisResp;
    }

    private SiteResponse showMain(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        OrderSetDAO dao = OrderSetDAO.getInstance();

        OrderSet enqRecord = null;
        ArrayList<String[]> orderBy = new ArrayList<String[]>();
        orderBy.add(new String[]{"order_create_date", "desc"});

        //Purchase Records
        enqRecord = null;
        enqRecord = new OrderSet();
        enqRecord.setDelete_flg(false);
        enqRecord.setMember(thisMember);
        List purchaseRecords = new ArrayList();
        try {
            purchaseRecords = dao.findListWithSampleWithoutFeedback(enqRecord, orderBy);
            if (purchaseRecords != null && purchaseRecords.size() > 0) {
                request.setAttribute("unfeedback", new Integer(purchaseRecords.size()).toString());
            }
        } catch (Exception e) {
            cmaLogger.error("[PROFILE] Obtain un-feedback count error" + thisMember.getMem_login_email(), request, e);
        }
        thisResp.setTargetJSP(CMAJspMapping.JSP_PROF_MAIN);
        return thisResp;
    }

    private SiteResponse showEdit(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        //Otain All Article
        ArticleDAO dao = ArticleDAO.getInstance();
        Article enqObj = new Article();
        enqObj.setArti_owner(thisMember.getSys_guid());
        //Obtain Address 
        MemAddressDAO maDAO = MemAddressDAO.getInstance();
        MemAddress maEnqObj = new MemAddress();
        maEnqObj.setMember(thisMember.getSys_guid());
        try {
            List<?> artiList = dao.findListWithSample(enqObj);
            Iterator<?> it = artiList.iterator();
            StringBuffer sb = new StringBuffer();
            Article tmpObj = null;
            while (it.hasNext()) {
                tmpObj = (Article) it.next();
                sb.append("<option value=\"" + tmpObj.getSys_guid() + "\">" + tmpObj.getArti_name() + "</option>\n");
            }
            request.setAttribute("ARTI_LIST", sb.toString());

            List<?> maList = maDAO.findListWithSample(maEnqObj);
            request.setAttribute("ADDR_LIST", maList);
            cmaLogger.debug("ADDR_LIST:" + maList.size());

        } catch (BaseDBException e) {
            cmaLogger.error("showEdit - ", request, e);
        }

        thisResp.setTargetJSP(CMAJspMapping.JSP_PROF_MAIN);
        return thisResp;

    }

    private SiteResponse doSave(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        Member aMember = new Member();

        //Validation
        if (!CommonUtil.isNullOrEmpty(request.getParameter("CHANGE_PWD"))) {
            if (CommonUtil.isNullOrEmpty(request.getParameter("NEW_PWD"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_NEW_PWD_EMPTY"));
            } else if (!request.getParameter("NEW_PWD").equalsIgnoreCase(CommonUtil.null2Empty(request.getParameter("CNEW_PWD")))) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_NEW_PWD_NOT_MATCH"));
            } else if (request.getParameter("NEW_PWD").length() < 6) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_NEW_PWD_TOO_SHORT"));
            } else {
                aMember.setMem_passwd(MD5Utility.MD5(request.getParameter("NEW_PWD")));
            }
        }

        if (CommonUtil.isNullOrEmpty(request.getParameter("MEM_SHOPNAME"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("PROF_SHOPNAME_EMPTY"));
        } else {
            aMember.setMem_shopname(request.getParameter("MEM_SHOPNAME"));
        }

        if (request.getParameter("MEM_SHOPURL") != null) {
            if (CommonUtil.isNullOrEmpty(request.getParameter("MEM_SHOPURL"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_SHOPURL_EMPTY"));
            } else if (!CommonUtil.isLetter(request.getParameter("MEM_SHOPURL"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_SHOPURL_NOT_LETTER"));
            } else {
                aMember.setMem_shopurl(request.getParameter("MEM_SHOPURL"));
            }
        }

        //cmaLogger.debug(request.getParameter("BANNER_IMAGE_1"));
        if (!CommonUtil.isNullOrEmpty(request.getParameter("BANNER_IMAGE_1"))) {
            aMember.setMem_shopbanner(request.getParameter("BANNER_IMAGE_1"));
        }

        if (request.getParameter("MEM_FIRSTNAME") != null
                && request.getParameter("MEM_LASTNAME") != null
                && request.getParameter("MEM_SALUTATION") != null) {
            if (CommonUtil.isNullOrEmpty(request.getParameter("MEM_FIRSTNAME"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_FIRSTNAME_EMPTY"));
            }
            if (CommonUtil.isNullOrEmpty(request.getParameter("MEM_LASTNAME"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROF_LASTNAME_EMPTY"));
            }
            aMember.setMem_firstname(request.getParameter("MEM_FIRSTNAME"));
            aMember.setMem_lastname(request.getParameter("MEM_LASTNAME"));
            aMember.setMem_salutation(new Integer(request.getParameter("MEM_SALUTATION")));
            cmaLogger.debug("Saluation:" + request.getParameter("MEM_SALUTATION"));
            aMember.setMem_fullname_display_type(new Integer(request.getParameter("MEM_FULLNAME_DISPLAY_TYPE")));
            cmaLogger.debug("MEM_FULLNAME_DISPLAY_TYPE:" + request.getParameter("MEM_FULLNAME_DISPLAY_TYPE"));
            aMember.setMem_display_name(request.getParameter("MEM_DISPLAY_NAME"));
        }

        //20120426 Delivery Address
        MemAddress tmp = new MemAddress();
        MemAddressDAO maDAO = MemAddressDAO.getInstance();
        for (int x = 1; x <= 3; x++) {
            if (!CommonUtil.isNullOrEmpty(request.getParameter("addr_name_" + x))) {
                tmp = new MemAddress();
                tmp.setIsdefault(x == new Integer(request.getParameter("addr_default")));
                tmp.setAddr_line1(CommonUtil.null2Empty(request.getParameter("addr_line1_" + x)));
                tmp.setAddr_line2(CommonUtil.null2Empty(request.getParameter("addr_line2_" + x)));
                tmp.setAttention_name(request.getParameter("addr_name_" + x));
                tmp.setCountryplace(CommonUtil.null2Empty(request.getParameter("addr_country_" + x)));
                tmp.setRegion(CommonUtil.null2Empty(request.getParameter("addr_district_txt_" + x)));
                tmp.setMember(thisMember.getSys_guid());
                try {
                    if (CommonUtil.isNullOrEmpty(request.getParameter("addr_id_" + x))) {
                        maDAO.create(tmp);
                    } else {
                        tmp.setId(new Integer(request.getParameter("addr_id_" + x)));
                        maDAO.update(tmp);
                    }
                } catch (Exception e) {
                    cmaLogger.error("Profile doSave Save address error:", request, e);
                }
            }
        }
        if (thisResp.hasError()) {
            request.setAttribute("action", "EDIT");
            request.setAttribute("retainMember", aMember);
            thisResp.setTargetJSP(CMAJspMapping.JSP_PROF_AJ);
        } else {
            try {
                //Save
                MemberDAO dao = MemberDAO.getInstance();
                aMember.setSys_guid(thisMember.getSys_guid());
                aMember.setMem_lastlogindate(thisMember.getMem_lastlogindate());
                aMember.setMem_shop_hp_arti(request.getParameter("MEM_SHOP_HP_ARTI"));
                dao.update(aMember);
                request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                        "MEM_UPDATE_DONE"));
                cmaLogger.debug("3: ISLOGIN" + V6Util.isLogined(request));
                //Store in session
                ImagskySession session = (ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION);
                cmaLogger.debug("4: ISLOGIN" + V6Util.isLogined(request));
                session.setLogined(true);
                cmaLogger.debug("5: ISLOGIN" + V6Util.isLogined(request));
                aMember = new Member();
                aMember.setMem_login_email(thisMember.getMem_login_email());
                List resultList = (List) dao.findListWithSample(aMember);
                aMember = (Member) (resultList.get(0));
                if (aMember == null) {
                    cmaLogger.debug("aMember==null");
                }
                session.setUser(aMember);
                //request.getSession().setAttribute(SystemConstants.REQ_ATTR_SESSION, session);

                cmaLogger.debug((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG));
                cmaLogger.debug(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_login_email());
                request.setAttribute("action", "EDIT");
                SiteResponse sr = showEdit(request, response);
                thisResp.setTargetJSP(CMAJspMapping.JSP_PROF_AJ);
                //Force remove Public View Session
                request.getSession().removeAttribute(SystemConstants.PUB_SHOP_INFO);
                //Check if input adddress, remove reminder in BID page
                MemberBiz biz = MemberBiz.getInstance();
                try {
                    if (!biz.hasInputAddress(aMember)) {
                        request.getSession().setAttribute(SystemConstants.REQ_ATTR_REMINDER, "MSG_INPUT_ADDRESS");
                    } else {
                        request.getSession().removeAttribute(SystemConstants.REQ_ATTR_REMINDER);
                    }
                } catch (Exception e) {
                    cmaLogger.error("[FB LOGIN] Error: Get Member Delivery Addresss ", request, e);
                }
            } catch (Exception e) {
                cmaLogger.error("PROFILE_Handler.doSave ERROR: ", request, e);
                request.setAttribute("action", "EDIT");
                thisResp.addErrorMsg(new SiteErrorMessage("MEM_UPDATE_ERROR"));
                thisResp.setTargetJSP(CMAJspMapping.JSP_PROF_AJ);
            }
        }

        return thisResp;
    }
}

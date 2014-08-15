package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.V6Util;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.dao.SellItemCategoryDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Node;
import com.imagsky.v6.domain.SellItemCategory;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CAT_Handler extends BaseHandler {

    public static final String DO_CAT_LIST = "LIST";
    public static final String DO_CAT_LIST_AJ = "LISTAJ";
    public static final String DO_CAT_ADD = "ADD";
    public static final String DO_CAT_ADD_AJ = "ADDAJ";
    public static final String DO_CAT_EDIT_AJ = "EDITAJ";
    public static final String DO_CAT_DEL_AJ = "DELAJ";
    public static final String DO_CAT_SAVE = "SAVE";
    public static final String DO_CAT_SAVE_ORDER = "SAVE_ORDER";
    public static final String DO_CAT_COPY = "COPY";
    public static final String DO_CAT_SLIDE = "SLIDE_AJ";
    public static final String DO_CAT_NAV = "NAV_AJ";
    protected static final String CLASS_NAME = "CAT_Handler.java";
    private Member thisMember = null;
    private String thisLang = null;
    private String action = null;

    /*
     * (non-Javadoc) @see
     * com.asiamiles.website.handler.Action#execute(javax.servlet.http.HttpServletRequest,
     * javax.servlet.http.HttpServletResponse)
     */
    public SiteResponse execute(HttpServletRequest request, HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_START);

        action = CommonUtil.null2Empty(request.getParameter(SystemConstants.ACTION_NAME));

        cmaLogger.debug("Action = " + action);

        //TODO: Login check in mainServlet
        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

        if (action.equalsIgnoreCase(DO_CAT_LIST)) {
            thisResp = doList(request, response, false);
        } else if (action.equalsIgnoreCase(DO_CAT_LIST_AJ)) {
            thisResp = doList(request, response, true);
        } else if (action.equalsIgnoreCase(DO_CAT_ADD)) {
            thisResp = showAdd(request, response, false);
        } else if (action.equalsIgnoreCase(DO_CAT_ADD_AJ)) {
            thisResp = showAdd(request, response, true);
        } else if (action.equalsIgnoreCase(DO_CAT_EDIT_AJ)) {
            thisResp = showAdd(request, response, true);
        } else if (action.equalsIgnoreCase(DO_CAT_SAVE)) {
            thisResp = doSave(request, response);
        } else if (action.equalsIgnoreCase(DO_CAT_SAVE_ORDER)) {
            thisResp = doSaveOrder(request, response);
        } else if (action.equalsIgnoreCase(DO_CAT_DEL_AJ)) {
            thisResp = doDel(request, response);
        } else if (action.equalsIgnoreCase(DO_CAT_SLIDE)) {
            thisResp = doList(request, response, true);
        } else if (action.equalsIgnoreCase(DO_CAT_NAV)) {
            thisResp = doList(request, response, true);
        } else if (action.equalsIgnoreCase(DO_CAT_COPY)) {
            thisResp = doCopy(request, response);
        } else {
            thisResp = doList(request, response, false); //Default
        }
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
        return thisResp;
    }

    private SiteResponse doCopy(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        if (!CommonUtil.isNullOrEmpty(request.getParameter("guid"))) {
            try {
                SellItemCategoryDAO dao = SellItemCategoryDAO.getInstance();

                SellItemCategory oldVersion = new SellItemCategory();
                oldVersion.setSys_guid(request.getParameter("guid"));
                oldVersion.setCate_owner(thisMember.getSys_guid());
                oldVersion = (SellItemCategory) dao.findListWithSample(oldVersion).get(0);

                SellItemCategory newVersion = new SellItemCategory();
                JPAUtil jpaUtil = new JPAUtil(SellItemCategory.getFields(oldVersion), SellItemCategory.getWildFields());
                newVersion = (SellItemCategory) jpaUtil.clone(newVersion, UUIDUtil.getNewUUID("cat" + new java.util.Date().toString()));
                if (newVersion.getCate_name().indexOf("(Copy)") >= 0) {
                    newVersion.setCate_name(newVersion.getCate_name() + " * ");
                } else {
                    newVersion.setCate_name(newVersion.getCate_name() + " (Copy)");
                }
                newVersion = (SellItemCategory) dao.create(newVersion);

                V6Util.autoAssociate(newVersion, thisMember);

            } catch (Exception e) {
                cmaLogger.error("CAT_Handler.doCopy ERROR: ", request, e);
                thisResp.addErrorMsg(new SiteErrorMessage("CAT_COPY_ERROR"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("CAT_COPY_ERROR"));
        }
        if (thisResp.hasError()) {
            thisResp.setTargetJSP(doList(request, response, true).getTargetJSP());
        } else {
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "CAT_COPY_DONE"));
            thisResp.setTargetJSP(doList(request, response, true, true).getTargetJSP());
        }

        return thisResp;
    }

    private SiteResponse doDel(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        if (!CommonUtil.isNullOrEmpty(request.getParameter("guid"))) {
            try {
                SellItemCategoryDAO dao = SellItemCategoryDAO.getInstance();
                dao.delete(request.getParameter("guid"));
                request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                        "CAT_DEL_DONE"));
                V6Util.disassociate(request.getParameter("guid"), thisMember);
            } catch (Exception e) {
                cmaLogger.error("CAT_Handler.doDel ERROR: ", request, e);
                thisResp.addErrorMsg(new SiteErrorMessage("CAT_DEL_ERROR"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("CAT_DEL_ERROR"));
        }
        thisResp = doList(request, response, true, true);
        return thisResp;
    }

    private SiteResponse doSaveOrder(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        String[] guids = null;
        if (!CommonUtil.isNullOrEmpty(request.getParameter("guids"))) {
            guids = CommonUtil.stringTokenize(request.getParameter("guids"), ",");
            try {
                SellItemCategoryDAO dao = SellItemCategoryDAO.getInstance();
                dao.updatePriority(guids);
            } catch (Exception e) {
                thisResp.addErrorMsg(new SiteErrorMessage("CAT_SAVE_ORDER_ERROR"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("CAT_SAVE_ORDER_ERROR"));
        }

        if (!thisResp.hasError()) {
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "CAT_SAVE_DONE"));
        }
        thisResp = doList(request, response, true, true);
        return thisResp;
    }

    private SiteResponse doSave(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        boolean isAdd = CommonUtil.isNullOrEmpty(request.getParameter("CAT_GUID"));
        SellItemCategory cat = new SellItemCategory();
        cat.setSys_guid(request.getParameter("CAT_GUID"));
        cat.setCate_lang(request.getParameter("CAT_LANG"));
        cat.setCate_name(request.getParameter("CAT_NAME"));
        cat.setCate_type(CommonUtil.isNullOrEmpty(request.getParameter("CAT_TYPE")) ? null : request.getParameter("CAT_TYPE"));
        if (CommonUtil.isNullOrEmpty(cat.getCate_name())) {
            thisResp.addErrorMsg(new SiteErrorMessage("CAT_NAME_EMPTY"));
        }

        if (!thisResp.hasError()) {
            SellItemCategoryDAO dao = SellItemCategoryDAO.getInstance();
            SellItemCategory returnObj = null;
            try {
                if (isAdd) {
                    //Save Add
                    cat.setSys_cma_name(cat.getCate_name() + " (" + cat.getCate_lang() + ")");
                    cat.setSys_create_dt(new Date());
                    cat.setSys_creator(thisMember.getMem_login_email());
                    cat.setSys_update_dt(new Date());
                    cat.setSys_updator(thisMember.getMem_login_email());
                    cat.setSys_is_live(true);
                    cat.setSys_is_published(true);
                    cat.setSys_is_node(false);
                    cat.setCate_owner(thisMember.getSys_guid());
                    cat.setCate_parent_cate(""); //TODO: Single level at this stage
                    cat.setCate_item_count(0);
                    returnObj = (SellItemCategory) dao.create(cat);
                    V6Util.autoAssociate(returnObj, thisMember); //Auto Assoication
                } else {
                    //Save Edit
                    cat.setSys_cma_name(cat.getCate_name() + " (" + cat.getCate_lang() + ")");
                    cat.setSys_update_dt(new Date());
                    cat.setSys_updator(thisMember.getMem_login_email());
                    if (!dao.update(cat)) {
                        thisResp.addErrorMsg(new SiteErrorMessage("CAT_UDPATE_ERROR"));
                    }
                    returnObj = cat;
                }
            } catch (Exception e) {
                //2012-02-16 ADD Exception message
                cmaLogger.error("SAVE CATEGORY Exception: ", request, e);
            }
            request.setAttribute("THIS_OBJ", returnObj);
        }

        if (thisResp.hasError()) {
            thisResp = showAdd(request, response, true);

        } else {
            thisResp = doList(request, response, true, true);
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "CAT_SAVE_DONE"));
        }

        return thisResp;
    }

    private SiteResponse showAdd(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {

        SiteResponse thisResp = super.createResponse();

        boolean isEdit = !(CommonUtil.isNullOrEmpty(request.getParameter("guid")));

        if (isEdit) {
            try {
                isAjax = true;
                SellItemCategoryDAO dao = SellItemCategoryDAO.getInstance();
                SellItemCategory enqObj = new SellItemCategory();

                enqObj.setSys_guid(request.getParameter("guid"));
                enqObj.setSys_is_live(true);
                List list = dao.findListWithSample(enqObj);
                if (list == null || list.size() == 0) {
                    cmaLogger.error("CAT_HANDLER.showAdd : NOT FOUND GUID for edit (" + enqObj.getSys_guid() + ")", request);
                    thisResp.addErrorMsg(new SiteErrorMessage("CAT_NOT_FOUND_FOR_EDIT_ERR"));
                } else {
                    request.setAttribute("THIS_OBJ", (SellItemCategory) list.get(0));
                }
                //Obtain Node Information
                NodeDAO ndao = NodeDAO.getInstance();
                Node enqNode = new Node();
                enqNode.setNod_contentGuid(request.getParameter("guid"));
                list = ndao.findListWithSample(enqNode);
                if (list == null || list.size() == 0) {
                    cmaLogger.error("CAT_HANDLER.showAdd : NOT FOUND Node information of GUID for edit (" + enqObj.getSys_guid() + ")", request);
                    thisResp.addErrorMsg(new SiteErrorMessage("CAT_NOT_FOUND_FOR_EDIT_ERR"));
                } else {
                    request.setAttribute("THIS_NODE", (Node) list.get(0));
                }
            } catch (Exception e) {
                cmaLogger.error("CAT_HANDLER.showAdd : NOT FOUND GUID for edit (" + request.getParameter("guid") + ")", request);
                thisResp.addErrorMsg(new SiteErrorMessage("CAT_NOT_FOUND_FOR_EDIT_ERR"));
            }

        }

        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_CATADD_AJAX);
        } else {
            request.setAttribute(SystemConstants.REQ_ATTR_INC_PAGE, CMAJspMapping.JSP_CATADD_AJAX);
            thisResp.setTargetJSP(CMAJspMapping.JSP_CAT);
        }
        return thisResp;
    }

    private SiteResponse doList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax, boolean regenerate) {

        SiteResponse thisResp = super.createResponse();
        SellItemCategoryDAO dao = SellItemCategoryDAO.getInstance();

        try {
            SellItemCategory enqObj = new SellItemCategory();
            enqObj.setCate_owner(thisMember.getSys_guid());
            enqObj.setCate_lang("zh");
            List returnList = dao.findListWithSample(enqObj);

            request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, returnList);
            cmaLogger.debug("CAT_Handler.doList = " + returnList.size());
            //Refresh file cache
            if (regenerate) {
                NodeDAO ndao = NodeDAO.getInstance();
                Map nodeMap = ndao.findNodeListWithSample(returnList, SystemConstants.NODMAP_KEY_C_GUID);
                generateSlidingCategoryList(request, response, returnList, nodeMap);
                generateNavgiatorCategoryList(request, response, returnList, nodeMap);
                generateSellItemBreadcrumb(request, response, returnList, nodeMap);
            }

        } catch (Exception e) {
            e.printStackTrace();
            cmaLogger.error("CAT_Handler.doList exception: ", request, e);
        }

        if (action.equalsIgnoreCase(DO_CAT_SLIDE)) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_CAT_SLIDE);
        } else if (action.equalsIgnoreCase(DO_CAT_NAV)) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_CAT_SUBNAV);
        } else if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_CATLIST_AJAX);
        } else {
            request.setAttribute(SystemConstants.REQ_ATTR_INC_PAGE, CMAJspMapping.JSP_CATLIST_AJAX);
            thisResp.setTargetJSP(CMAJspMapping.JSP_CAT);
        }

        return thisResp;
    }

    private SiteResponse doList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {
        return doList(request, response, isAjax, false);
    }

    private void generateSellItemBreadcrumb(HttpServletRequest request,
            HttpServletResponse response, List returnList, Map nodeMap) {

        OutputStreamWriter out = null;
        String url = null;
        Node tmpNode = null;

        try {
            out = new OutputStreamWriter(
                    new FileOutputStream(PropertiesConstants.get(PropertiesConstants.uploadDirectory)
                    + SystemConstants.PATH_COMMON_JSP_SELLITEM_BREADCRUMB + thisMember.getSys_guid() + "_" + thisLang + ".jsp"), "UTF-8");

            String homepageName = MessageUtil.getV6Message(thisLang, "BRM_HOMEPAGE");
            //2012-02-16 Remove sitename in breadcrumb 
            String homepage = "";

            if (V6Util.isMainsiteLogin(thisMember)) {
                homepage = "<li><a href=\\\"" + request.getAttribute("contextPath") + "/" + "\\\">" + homepageName + "</a></li>";
            } else {
                homepage = "<li><a href=\\\"" + request.getAttribute("contextPath") + "/" + "\\\">" + homepageName + "</a></li><li> &gt; </li>"
                        + "<li><a href=\\\"" + request.getAttribute("contextPath") + "/"
                        + thisMember.getMem_shopurl() + "/" + SystemConstants.PUBLIC_SUFFIX + "\\\">" + thisMember.getMem_shopname() + "</li>";
            }
            String tmpStr = "";

            StringBuffer sb = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>");
            sb.append("<%@page import=\"java.util.*\" %>\n");
            sb.append("<% TreeMap sellItemBreadcrumb = new TreeMap();\n");
            sb.append(" String parentGuid  = request.getParameter(\"guid\");\n");
            SellItemCategory tmpObj = null;
            if (returnList != null && returnList.size() > 0) {
                for (int x = 0; x < returnList.size(); x++) {
                    tmpObj = (SellItemCategory) returnList.get(x);
                    tmpNode = (Node) nodeMap.get(tmpObj.getSys_guid());
                    if (tmpObj.isSys_is_live() && tmpObj.isSys_is_published()) {
                        url = request.getAttribute("contextPath") + "/" + thisMember.getMem_shopurl() + "/category" + tmpNode.getNod_url();
                        tmpStr = homepage + "<li> &gt; </li>" + "<li><a href=\\\"" + url + "\\\" >" + tmpObj.getCate_name() + "</a></li>";
                        sb.append("sellItemBreadcrumb.put(\"" + tmpObj.getSys_guid() + "\",\""
                                + tmpStr.replaceAll("\"", "\\\"") + "\");\n");
                    }
                }
            } else {
                //sb.append("商店未有目錄分類");
            }
            sb.append("out.println((String)sellItemBreadcrumb.get(parentGuid)+ \"<li> &gt; </li>\");\n");
            sb.append("%>\n");
            out.write(sb.toString());
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            cmaLogger.error("CAT_Handler.generateSlidingCategoryList exception: ", request, e);
        }

    }

    private void generateSlidingCategoryList(HttpServletRequest request,
            HttpServletResponse response, List returnList, Map nodeMap) {

        OutputStreamWriter out = null;
        String url = null;
        Node tmpNode = null;
        String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
        try {
            out = new OutputStreamWriter(
                    new FileOutputStream(PropertiesConstants.get(PropertiesConstants.uploadDirectory)
                    + SystemConstants.PATH_COMMON_JSP_SLIDING_CAT + thisMember.getSys_guid() + "_" + thisLang + ".jsp"), "UTF-8");

            StringBuffer sb = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>");
            SellItemCategory tmpObj = null;
            if (returnList != null && returnList.size() > 0) {
                for (int x = 0; x < returnList.size(); x++) {
                    tmpObj = (SellItemCategory) returnList.get(x);
                    tmpNode = (Node) nodeMap.get(tmpObj.getSys_guid());
                    if (tmpObj.isSys_is_live() && tmpObj.isSys_is_published()) {
                        cmaLogger.debug("tmpObj - "+ tmpObj.getSys_guid());
                        cmaLogger.debug("tmpObj - "+ tmpObj.getCate_type());
                        if ("A".equalsIgnoreCase(tmpObj.getCate_type())) {//AUCTION
                            url = request.getAttribute("contextPath") + "/do/BID2?action=MAIN";
                        } else if (tmpObj.getCate_type() == null) {//NORMAL
                            url = request.getAttribute("contextPath") + "/" + thisMember.getMem_shopurl() + "/category" + tmpNode.getNod_url();
                        } else {
                            url = "";
                        }
                        cmaLogger.debug("tmpObj - "+ url);
                        if (!CommonUtil.isNullOrEmpty(url)) {
                            sb.append("<li><a href=\"" + url + "\" >" + tmpObj.getCate_name() + "</a></li>\n");
                        }
                    }
                }
            } else {
                sb.append(MessageUtil.getV6Message(lang, "SLI_NO_CAT"));
            }
            out.write(sb.toString());
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            cmaLogger.error("CAT_Handler.generateSlidingCategoryList exception: ", request, e);
        }

    }

    private void generateNavgiatorCategoryList(HttpServletRequest request,
            HttpServletResponse response, List returnList, Map nodeMap) {

        OutputStreamWriter out = null;
        String url = null;
        Node tmpNode = null;
        try {
            out = new OutputStreamWriter(
                    new FileOutputStream(PropertiesConstants.get(PropertiesConstants.uploadDirectory)
                    + SystemConstants.PATH_COMMON_JSP_SUBNAV_CAT + thisMember.getSys_guid() + "_" + thisLang + ".jsp"), "UTF-8");

            StringBuffer sb = new StringBuffer("<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>");
            SellItemCategory tmpObj = null;
            if (returnList != null && returnList.size() > 0) {
                for (int x = 0; x < returnList.size(); x++) {
                    tmpObj = (SellItemCategory) returnList.get(x);
                    tmpNode = (Node) nodeMap.get(tmpObj.getSys_guid());
                    if (tmpObj.isSys_is_live() && tmpObj.isSys_is_published()) {
                        url = request.getAttribute("contextPath") + "/" + thisMember.getMem_shopurl() + "/category" + tmpNode.getNod_url();
                        sb.append("<li><a href=\"" + url + "\" >" + tmpObj.getCate_name() + "</a></li>\n");
                    }
                }
            } else {
                //sb.append("商店未有目錄分類");
            }
            out.write(sb.toString());
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            cmaLogger.error("CAT_Handler.generateNavgiatorCategoryList exception: ", request, e);
        }

    }
}

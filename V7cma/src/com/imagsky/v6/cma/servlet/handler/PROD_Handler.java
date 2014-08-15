package com.imagsky.v6.cma.servlet.handler;

import java.util.Iterator;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.dao.SellItemCategoryDAO;
import com.imagsky.v6.dao.SellItemDAO;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.Node;
import com.imagsky.v6.domain.SellItem;
import com.imagsky.v6.domain.SellItemCategory;
import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.exception.BaseDBException;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.util.logger.*;
import com.imagsky.utility.UUIDUtil;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.InputParams;
import com.imagsky.util.JPAUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.ProductImageUtil;
import com.imagsky.util.V6Util;
import com.imagsky.v6.cma.servlet.handler.BaseHandler;

public class PROD_Handler extends BaseHandler {

    public static final String DO_PROD_LIST = "LIST";
    public static final String DO_PROD_LIST_AJ = "LISTAJ";
    public static final String DO_PROD_ADD = "ADD";
    public static final String DO_PROD_ADD_AJ = "ADDAJ";
    public static final String DO_PROD_EDIT_AJ = "EDITAJ";
    public static final String DO_PROD_DEL_AJ = "DELAJ";
    public static final String DO_PROD_SAVE = "SAVE";
    public static final String DO_PROD_SAVE_ORDER = "SAVE_ORDER";
    public static final String DO_COPY = "COPY";
    protected static final String CLASS_NAME = "PROD_Handler.java";
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

        if (action.equalsIgnoreCase(DO_PROD_LIST)) {
            thisResp = doList(request, response, false);
        } else if (action.equalsIgnoreCase(DO_PROD_LIST_AJ)) {
            thisResp = doList(request, response, true);
        } else if (action.equalsIgnoreCase(DO_PROD_SAVE_ORDER)) {
            thisResp = doSaveOrder(request, response);
        } else if (action.equalsIgnoreCase(DO_PROD_EDIT_AJ)) {
            thisResp = showAdd(request, response, true);
        } else if (action.equalsIgnoreCase(DO_PROD_ADD_AJ)) {
            thisResp = showAdd(request, response, true);
        } else if (action.equalsIgnoreCase(DO_PROD_DEL_AJ)) {
            thisResp = doDel(request, response);
        } else if (action.equalsIgnoreCase(DO_PROD_SAVE)) {
            thisResp = doSave(request, response);
        } else if (action.equalsIgnoreCase(DO_COPY)) {
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
                SellItemDAO dao = SellItemDAO.getInstance();

                SellItem oldVersion = new SellItem();
                oldVersion.setSys_guid(request.getParameter("guid"));
                oldVersion.setProd_owner(thisMember.getSys_guid());
                oldVersion = (SellItem) dao.findListWithSample(oldVersion).get(0);

                SellItem newVersion = new SellItem();
                JPAUtil jpaUtil = new JPAUtil(SellItem.getFields(oldVersion), SellItem.getWildFields());
                newVersion = (SellItem) jpaUtil.clone(newVersion, UUIDUtil.getNewUUID("prod" + new java.util.Date().toString()));

                if (newVersion.getProd_name().indexOf("(Copy)") >= 0) {
                    newVersion.setProd_name(newVersion.getProd_name() + " * ");
                } else {
                    newVersion.setProd_name(newVersion.getProd_name() + " (Copy)");
                }

                newVersion = (SellItem) dao.create(newVersion);

                V6Util.autoAssociate(newVersion, thisMember);

            } catch (Exception e) {
                cmaLogger.error("PROD_Handler.doCopy ERROR: ", request, e);
                thisResp.addErrorMsg(new SiteErrorMessage("PROD_COPY_ERROR"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_COPY_ERROR"));
        }
        if (thisResp.hasError()) {
            thisResp.setTargetJSP(doList(request, response, true).getTargetJSP());
        } else {
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "PROD_COPY_DONE"));
            thisResp.setTargetJSP(doList(request, response, true, true).getTargetJSP());
        }

        return thisResp;
    }

    private SiteResponse doDel(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        if (!CommonUtil.isNullOrEmpty(request.getParameter("guid"))) {
            try {
                SellItemDAO dao = SellItemDAO.getInstance();
                SellItemCategoryDAO cDao = SellItemCategoryDAO.getInstance();

                SellItem oldVersion = new SellItem();
                oldVersion.setSys_guid(request.getParameter("PROD_GUID"));
                oldVersion.setProd_owner(thisMember.getSys_guid());

                oldVersion = (SellItem) dao.findListWithSample(oldVersion).get(0);
                /*
                 * if(!CommonUtil.isNullOrEmpty(oldVersion.getProd_image1())){
                 * ProductImageUtil.deleteProductImage(System.getProperty("uploadDirectory"),thisMember.getSys_guid(),oldVersion.getProd_image1());
                 * } if(!CommonUtil.isNullOrEmpty(oldVersion.getProd_image2())){
                 * ProductImageUtil.deleteProductImage(System.getProperty("uploadDirectory"),thisMember.getSys_guid(),oldVersion.getProd_image2());
                 * } if(!CommonUtil.isNullOrEmpty(oldVersion.getProd_image3())){
                 * ProductImageUtil.deleteProductImage(System.getProperty("uploadDirectory"),thisMember.getSys_guid(),oldVersion.getProd_image3());
                 * }
                 */
                dao.delete(request.getParameter("guid"));
                String catGuid = oldVersion.getProd_cate_guid();
                try {
                    cmaLogger.debug("Cat GUID = " + catGuid);
                    SellItemCategory cat = new SellItemCategory();
                    cat.setSys_guid(catGuid);
                    cat = (SellItemCategory) cDao.findListWithSample(cat).get(0);

                    cat.setCate_item_count(cat.getCate_item_count() - 1);
                    cDao.update(cat);
                } catch (Exception e) {
                    cmaLogger.error("Update Category Count Error:", e);
                }

                V6Util.disassociate(request.getParameter("guid"), thisMember);
            } catch (Exception e) {
                cmaLogger.error("PROD_Handler.doDel ERROR: ", request, e);
                thisResp.addErrorMsg(new SiteErrorMessage("PROD_DEL_ERROR"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_DEL_ERROR"));
        }

        if (thisResp.hasError()) {
            thisResp.setTargetJSP(doList(request, response, true).getTargetJSP());
        } else {
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "PROD_DEL_DONE"));
            thisResp.setTargetJSP(doList(request, response, true, true).getTargetJSP());
        }
        return thisResp;
    }

    private SiteResponse doSaveOrder(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        String[] guids = null;
        if (!CommonUtil.isNullOrEmpty(request.getParameter("guids"))) {
            guids = CommonUtil.stringTokenize(request.getParameter("guids"), ",");
            try {
                SellItemDAO dao = SellItemDAO.getInstance();
                dao.updatePriority(guids);
            } catch (Exception e) {
                thisResp.addErrorMsg(new SiteErrorMessage("PROD_SAVE_ORDER_ERROR"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_SAVE_ORDER_ERROR"));
        }

        if (!thisResp.hasError()) {
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "PROD_SAVE_DONE"));
        }
        thisResp = doList(request, response, true);
        return thisResp;
    }

    private SiteResponse doSave(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        SellItemDAO dao = SellItemDAO.getInstance();

        boolean[] imageIsTmp = new boolean[3];
        boolean isAdd = CommonUtil.isNullOrEmpty(request.getParameter("PROD_GUID"));
        cmaLogger.debug("isAdd?" + isAdd);
        cmaLogger.debug("Prod GUID :" + request.getParameter("PROD_GUID"));
        cmaLogger.debug("Cat GUID: " + request.getParameter("PROD_CAT_GUID"));
        SellItem prod = new SellItem();
        cmaLogger.debug("doSave [START]");

        InputParams inReq = new InputParams(request);
        prod.setProd_name(inReq.get("PROD_NAME"));
        prod.setProd_lang(inReq.get("PROD_LANG"));
        prod.setProd_desc(inReq.get("PROD_DESC"));
        prod.setProd_price(null); //Assign after validation
        prod.setProd_cate_guid(inReq.get("PROD_CAT_GUID"));
        prod.setProd_remarks(inReq.get("PROD_REMARKS"));

        prod.setProd_image1(inReq.get("PROD_IMAGE_1"));
        cmaLogger.debug("Image: " + prod.getProd_image1());
        prod.setProd_image2(inReq.get("PROD_IMAGE_2"));
        cmaLogger.debug("Image: " + prod.getProd_image2());
        prod.setProd_image3(inReq.get("PROD_IMAGE_3"));
        cmaLogger.debug("Image: " + prod.getProd_image3());

        if (isAdd) {
            imageIsTmp[0] = !CommonUtil.isNullOrEmpty(request.getParameter("PROD_IMAGE_1"));
            imageIsTmp[1] = !CommonUtil.isNullOrEmpty(request.getParameter("PROD_IMAGE_2"));
            imageIsTmp[2] = !CommonUtil.isNullOrEmpty(request.getParameter("PROD_IMAGE_3"));
        } else {
        }



        //validation
        if (CommonUtil.isNullOrEmpty(prod.getProd_name())) {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_NAME_EMPTY"));
        }
        if (!CommonUtil.isNullOrEmpty(request.getParameter("PROD_PRICE"))) {
            try {
                prod.setProd_price(new Double(request.getParameter("PROD_PRICE")));
                if (!CommonUtil.isNullOrEmpty(request.getParameter("PROD_PRICE2"))) {
                    prod.setProd_price2(new Double(request.getParameter("PROD_PRICE2")));
                }
            } catch (Exception e) {
                cmaLogger.error("Double error", e);
                thisResp.addErrorMsg(new SiteErrorMessage("PROD_PRICE_INVALID"));
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_PRICE_EMPTY"));
        }


        if (CommonUtil.isNullOrEmpty(prod.getProd_cate_guid())) {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_CAT_EMPTY"));
        }

        if (isAdd && !checkProductQuota(request)) {
            thisResp.addErrorMsg(new SiteErrorMessage("PROD_QUOTA_EXCEED"));
        }


        if (thisResp.hasError()) {
            cmaLogger.debug("hasError");
        }

        if (!thisResp.hasError()) {
            SellItem returnObj = null;
            try {
                if (isAdd) {
                    //Save Add
                    prod.setSys_cma_name(prod.getProd_name() + " (" + prod.getProd_lang() + ")");
                    prod.setSys_create_dt(new Date());
                    prod.setSys_creator(thisMember.getMem_login_email());
                    prod.setSys_update_dt(new Date());
                    prod.setSys_updator(thisMember.getMem_login_email());
                    prod.setSys_is_live(true);
                    prod.setSys_is_node(false);
                    prod.setSys_is_published(true);
                    prod.setProd_owner(thisMember.getSys_guid());
                    prod.setSys_live_dt(new java.util.Date());
                    prod.setSys_exp_dt(CommonUtil.dateAdd(new java.util.Date(), Calendar.DAY_OF_MONTH, new Integer(request.getParameter("PROLONG_EXPR_DATE"))));

                    //Move image from tmp folder to user folder
                    String tmpFile = null;
                    String fileUploadPath = System.getProperty("uploadDirectory");
                    if (!CommonUtil.isNullOrEmpty(prod.getProd_image1())) {
                        tmpFile = ProductImageUtil.moveProductImage(fileUploadPath, thisMember.getSys_guid(), prod.getProd_image1());
                        if (tmpFile != null) {
                            prod.setProd_image1(tmpFile);
                        }
                    }
                    if (!CommonUtil.isNullOrEmpty(prod.getProd_image2())) {
                        tmpFile = ProductImageUtil.moveProductImage(fileUploadPath, thisMember.getSys_guid(), prod.getProd_image2());
                        if (tmpFile != null) {
                            prod.setProd_image2(tmpFile);
                        }
                    }
                    if (!CommonUtil.isNullOrEmpty(prod.getProd_image3())) {
                        tmpFile = ProductImageUtil.moveProductImage(fileUploadPath, thisMember.getSys_guid(), prod.getProd_image3());
                        if (tmpFile != null) {
                            prod.setProd_image3(tmpFile);
                        }
                    }

                    returnObj = (SellItem) dao.create(prod);

                    String catGuid = prod.getProd_cate_guid();
                    SellItemCategory cat = new SellItemCategory();
                    SellItemCategoryDAO cDao = SellItemCategoryDAO.getInstance();
                    cat.setSys_guid(catGuid);
                    cat = (SellItemCategory) cDao.findListWithSample(cat).get(0);

                    cat.setCate_item_count(CommonUtil.null2Zero(cat.getCate_item_count()) + 1);

                    cDao.update(cat);

                    //Keyword / Description
                    String[] keywordDescription = new String[2];
                    if (request.getParameter("nod_keyword") != null) {
                        if (!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_keyword")))) {
                            keywordDescription[0] = CommonUtil.escape(request.getParameter("nod_keyword"));
                        }
                        if (!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_description")))) {
                            keywordDescription[1] = CommonUtil.escape(request.getParameter("nod_description"));
                        }
                        V6Util.autoAssociate(returnObj, thisMember, keywordDescription); //Auto Assoication
                    } else {
                        V6Util.autoAssociate(returnObj, thisMember); //Auto Assoication
                    }
                } else {
                    //Save Edit
                    SellItem oldVersion = new SellItem();
                    oldVersion.setSys_guid(request.getParameter("PROD_GUID"));

                    String tmpFile = null;
                    String fileUploadPath = System.getProperty("uploadDirectory");
                    try {
                        oldVersion = (SellItem) dao.findListWithSample(oldVersion).get(0);
                        //Remove old product image
					/*
                         * if(!CommonUtil.isNullOrEmpty(oldVersion.getProd_image1())
                         * &&
                         * !CommonUtil.null2Empty(oldVersion.getProd_image1()).equalsIgnoreCase(prod.getProd_image1())){
                         * ProductImageUtil.deleteProductImage(fileUploadPath,
                         * thisMember.getSys_guid(),
                         * oldVersion.getProd_image1()); }
                         * if(!CommonUtil.isNullOrEmpty(oldVersion.getProd_image2())
                         * &&
                         * !CommonUtil.null2Empty(oldVersion.getProd_image2()).equalsIgnoreCase(prod.getProd_image2())){
                         * ProductImageUtil.deleteProductImage(fileUploadPath,
                         * thisMember.getSys_guid(),
                         * oldVersion.getProd_image2()); }
                         * if(!CommonUtil.isNullOrEmpty(oldVersion.getProd_image3())
                         * &&
                         * !CommonUtil.null2Empty(oldVersion.getProd_image3()).equalsIgnoreCase(prod.getProd_image3())){
                         * ProductImageUtil.deleteProductImage(fileUploadPath,
                         * thisMember.getSys_guid(),
                         * oldVersion.getProd_image3());
					}
                         */
                        //Move image from tmp folder to user folder
                        if (!CommonUtil.isNullOrEmpty(prod.getProd_image1())) {
                            tmpFile = ProductImageUtil.moveProductImage(fileUploadPath, thisMember.getSys_guid(), prod.getProd_image1());
                            if (tmpFile != null) {
                                prod.setProd_image1(tmpFile);
                            }
                        }
                        if (!CommonUtil.isNullOrEmpty(prod.getProd_image2())) {
                            tmpFile = ProductImageUtil.moveProductImage(fileUploadPath, thisMember.getSys_guid(), prod.getProd_image2());
                            if (tmpFile != null) {
                                prod.setProd_image2(tmpFile);
                            }
                        }
                        if (!CommonUtil.isNullOrEmpty(prod.getProd_image3())) {
                            tmpFile = ProductImageUtil.moveProductImage(fileUploadPath, thisMember.getSys_guid(), prod.getProd_image3());
                            if (tmpFile != null) {
                                prod.setProd_image3(tmpFile);
                            }
                        }

                    } catch (Exception e) {
                        cmaLogger.error("image save error: ", e);
                        prod.setProd_image1("");
                        prod.setProd_image2("");
                        prod.setProd_image3("");
                    }
                    prod.setSys_guid(inReq.get("PROD_GUID"));
                    prod.setSys_cma_name(prod.getProd_name() + " (" + prod.getProd_lang() + ")");

                    if (!CommonUtil.isNullOrEmpty(inReq.get("PROLONG_EXPR_DATE"))
                            && !CommonUtil.null2Empty(inReq.get("PROLONG_EXPR_DATE")).equalsIgnoreCase("0")) {
                        prod.setSys_live_dt(new java.util.Date());
                        prod.setSys_exp_dt(CommonUtil.dateAdd(new java.util.Date(), Calendar.DAY_OF_MONTH, new Integer(inReq.get("PROLONG_EXPR_DATE"))));
                    }

                    prod.setSys_update_dt(new Date());
                    prod.setSys_updator(thisMember.getMem_login_email());
                    if (!dao.update(prod)) {
                        thisResp.addErrorMsg(new SiteErrorMessage("PROD_UDPATE_ERROR"));
                    } else if (request.getParameter("nod_keyword") != null) {
                        cmaLogger.debug("Save keyword" + prod.getSys_guid());
                        //Update keyword / description
                        NodeDAO ndao = NodeDAO.getInstance();
                        ArrayList<Object> aList = new ArrayList<Object>();
                        aList.add(prod);
                        Map nodeMap = ndao.findNodeListWithSample(aList, SystemConstants.NODMAP_KEY_C_GUID);
                        if (nodeMap != null && nodeMap.get(prod.getSys_guid()) != null) {
                            cmaLogger.debug("Node Found");
                            Node aNode = (Node) nodeMap.get(prod.getSys_guid());
                            if (!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_keyword")))) {
                                aNode.setNod_keyword(CommonUtil.escape(request.getParameter("nod_keyword")));
                            }
                            if (!CommonUtil.isNullOrEmpty(CommonUtil.escape(request.getParameter("nod_description")))) {
                                aNode.setNod_description(CommonUtil.escape(request.getParameter("nod_description")));
                            }
                            ndao.update(aNode);
                        }
                    }
                    returnObj = prod;
                }
            } catch (Exception e) {
                cmaLogger.error("save error: ", e);
            }

        }
        request.setAttribute("THIS_OBJ", prod);
        if (thisResp.hasError()) {
            request.setAttribute("cateListSelector", categoryDropDownBox("PROD_CAT_GUID"));
            thisResp.setTargetJSP(CMAJspMapping.JSP_PRODADD_AJAX);
            //thisResp = showAdd(request, response, true);

        } else {
            thisResp = doList(request, response, true);
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                    "PROD_SAVE_DONE"));
        }
        cmaLogger.debug("doSave [END]");
        return thisResp;
    }

    private SiteResponse showAdd(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {

        SiteResponse thisResp = super.createResponse();

        boolean isEdit = !(CommonUtil.isNullOrEmpty(request.getParameter("guid")));

        if (isEdit) {
            try {
                isAjax = true;
                SellItemDAO dao = SellItemDAO.getInstance();
                SellItem enqObj = new SellItem();

                enqObj.setSys_guid(request.getParameter("guid"));
                //enqObj.setSys_priority(JPAUtil.IntegerEmpty);

                List list = dao.findListWithSample(enqObj);
                if (list == null || list.size() == 0) {
                    cmaLogger.error("PROD_HANDLER.showAdd : NOT FOUND GUID for edit (" + enqObj.getSys_guid() + ")", request);
                    thisResp.addErrorMsg(new SiteErrorMessage("PROD_NOT_FOUND_FOR_EDIT_ERR"));
                } else {
                    request.setAttribute("THIS_OBJ", (SellItem) list.get(0));
                }
                //Node Information
                Node thisNode = new Node();
                NodeDAO nDAO = NodeDAO.getInstance();
                try {
                    ArrayList<Object> aList = new ArrayList();
                    aList.add(enqObj);
                    Map nodemap = nDAO.findNodeListWithSample(aList, SystemConstants.NODMAP_KEY_C_GUID);
                    if (nodemap.get(enqObj.getSys_guid()) != null) {
                        request.setAttribute("THIS_NODE", (Node) nodemap.get(enqObj.getSys_guid()));
                    }
                } catch (Exception ne) {
                }
            } catch (Exception e) {
                cmaLogger.error("PROD_HANDLER.showAdd : NOT FOUND GUID for edit (" + request.getParameter("guid") + ")", request);
                thisResp.addErrorMsg(new SiteErrorMessage("PROD_NOT_FOUND_FOR_EDIT_ERR"));
            }

        }
        request.setAttribute("cateListSelector", categoryDropDownBox("PROD_CAT_GUID"));
        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_PRODADD_AJAX);
        } else {
            //request.setAttribute(SystemConstants.REQ_ATTR_INC_PAGE, CMAJspMapping.JSP_CATADD_AJAX);
            thisResp.setTargetJSP(CMAJspMapping.JSP_PRODADD_AJAX);
        }
        return thisResp;
    }

    private SiteResponse doList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {
        return doList(request, response, isAjax, false);
    }

    private SiteResponse doList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax, boolean regenerate) {

        SiteResponse thisResp = super.createResponse();
        SellItemDAO dao = SellItemDAO.getInstance();


        String catGuid = CommonUtil.isNullOrEmpty(request.getParameter("CAT_GUID")) ? "-1" : request.getParameter("CAT_GUID");

        cmaLogger.debug("doList category guid = " + catGuid);
        try {
            //Obtain Categorylist Drop down
            if (!isAjax) {
                StringBuffer sb = categoryDropDownBox("CAT_GUID");
                request.setAttribute("CAT_DROPDOWN", sb);
                if (CommonUtil.isNullOrEmpty(sb.toString())) {
                    thisResp.addErrorMsg(new SiteErrorMessage("PROD_ADD_CAT_FIRST"));
                }
            }
            SellItem enqObj = new SellItem();
            enqObj.setProd_owner(thisMember.getSys_guid());
            enqObj.setProd_lang("zh");
            //enqObj.setSys_is_live(true);
            enqObj.setProd_cate_guid(catGuid);

            List returnList = dao.findListWithSample(enqObj);
            request.setAttribute("CAT_GUID", catGuid);
            request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, returnList);
            cmaLogger.debug("PROD_Handler.doList = " + returnList.size());
            if (regenerate) {
                NodeDAO ndao = NodeDAO.getInstance();
                Map nodeMap = ndao.findNodeListWithSample(returnList, SystemConstants.NODMAP_KEY_C_GUID);

            }
            if (catGuid.equals("-1") && returnList.size() > 0) {
                request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG),
                        "PROD_NO_PARENT_REMINDER"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            cmaLogger.error("PROD_Handler.doList exception: ", request, e);
        }

        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_PRODLIST_AJAX);
        } else {
            request.setAttribute(SystemConstants.REQ_ATTR_INC_PAGE, CMAJspMapping.JSP_PRODLIST_AJAX);
            thisResp.setTargetJSP(CMAJspMapping.JSP_PRODLIST);
        }
        return thisResp;
    }

    private StringBuffer categoryDropDownBox(String boxName) {
        StringBuffer sb = new StringBuffer();
        SellItemCategoryDAO catdao = SellItemCategoryDAO.getInstance();
        SellItemCategory enqCatObj = new SellItemCategory();
        try {
            enqCatObj.setCate_owner(thisMember.getSys_guid());
            enqCatObj.setCate_lang("zh");
            enqCatObj.setSys_is_live(true);
            List returnList = catdao.findListWithSample(enqCatObj);

            if (returnList != null) {
                sb.append("<SELECT name=\"" + boxName + "\" id=\"" + boxName + "\" style=\"width: 300px\">");
                Iterator it = returnList.iterator();
                SellItemCategory tmpObj = null;
                while (it.hasNext()) {
                    tmpObj = (SellItemCategory) it.next();
                    sb.append("<option value=\"").append(tmpObj.getSys_guid() + "\")>").append(tmpObj.getCate_name() + " ("
                            + tmpObj.getCate_item_count()).append(") </option>");
                }
                sb.append("</SELECT>");
                if (returnList.size() == 0) {
                    sb = new StringBuffer();
                }
            }
        } catch (BaseDBException dbe) {
            dbe.printStackTrace();
            cmaLogger.error("PROD_Handler.categoryDropDownBox exception: ", dbe);
        }
        return sb;
    }

    /**
     * *
     * Set -1 when bypass quota
     *
     * @param request
     * @param response
     * @return True => Can Add one more
     */
    private boolean checkProductQuota(HttpServletRequest request) {

        SellItem enqObj = new SellItem();
        SellItemDAO dao = SellItemDAO.getInstance();

        enqObj.setProd_owner(thisMember.getSys_guid());

        if (thisMember.getMem_max_sellitem_count() < 0) {
            return true;
        }

        try {
            List aList = dao.findListWithSample(enqObj);
            if (aList == null) {
                cmaLogger.error("PROD_Handler.exceedProductQuota : Result List is null", request);
                return false;
            } else {
                cmaLogger.debug("Current : " + aList.size());
                cmaLogger.debug("Max : " + thisMember.getMem_max_sellitem_count());
                return aList.size() + 1 <= thisMember.getMem_max_sellitem_count();
            }
        } catch (BaseDBException e) {
            cmaLogger.error("PROD_Handler.exceedProductQuota exception: ", e);
        }
        return false;
    }
}

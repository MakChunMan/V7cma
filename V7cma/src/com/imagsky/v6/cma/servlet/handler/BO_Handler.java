package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.InputParams;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.BulkOrderDAO;
import com.imagsky.v6.dao.SellItemDAO;
import com.imagsky.v6.domain.BulkOrderItem;
import com.imagsky.v6.domain.Member;
import com.imagsky.v6.domain.SellItem;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BO_Handler extends BaseHandler {

    public static final String DO_BO_DEL_ITEM = "DEL";
    public static final String DO_BO_ADD = "ADD";
    public static final String DO_BO_ADD_AJ = "ADD_AJ";
    //public static final String DO_BO_ADD_SAVE = "ADD_SAVE";
    //public static final String DO_BO_ADD_ITEM_AJ = "ADD_ITEM_AJ";
    public static final String DO_BO_ADD_ITEM_SAVE = "ADD_ITEM_SAVE";
    public static final String DO_BO_EDIT = "EDIT";
    public static final String DO_BO_EDIT_SAVE = "EDIT_SAVE";
    public static final String DO_BO_LIST_AJ = "LIST_AJ";
    public static final String DO_BO_LOAD_ITEM = "LOAD";
    public static final String DO_BO_LOAD_SAVE = "LOAD_SAVE";
    public static final String DO_BO_PUBLIC = "BOPUB";
    protected static final String CLASS_NAME = "BO_Handler.java";
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

        thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
        thisLang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);

        if (action.equalsIgnoreCase(DO_BO_DEL_ITEM)) {
            //AJAX DEL
            thisResp = doDel(request, response);
        } else if (action.equalsIgnoreCase(DO_BO_ADD_AJ)) {
            //DO_BO_ADD
            thisResp = showAdd(request, response, true);
        } else if (action.equalsIgnoreCase(DO_BO_ADD_ITEM_SAVE)) {
            //DO_BO_ADD
            thisResp = doSave(request, response);
        } else if (action.equalsIgnoreCase(DO_BO_EDIT)) {
            //Show Edit
            getBOForEdit(request, response);
            thisResp = showAdd(request, response, true);
        } else if (action.equalsIgnoreCase(DO_BO_LIST_AJ)) {
            //MAIN entrance page
            thisResp = doList(request, response, true); //AJAX
        } else if (action.equalsIgnoreCase(DO_BO_PUBLIC)) {
            thisResp = doPublishBO(request, response);
        } else {
            //MAIN entrance page
            thisResp = doList(request, response, false); //Default
        }
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
        return thisResp;
    }

    private SiteResponse doPublishBO(HttpServletRequest request,
            HttpServletResponse response) {
        SiteResponse thisResp = super.createResponse();

        /**
         * *
         * BulkOrderDAO boDao = BulkOrderDAO.getInstance(); try { String
         * slideSectionFile =
         * PropertiesConstants.get(PropertiesConstants.uploadDirectory) + "/" +
         * SystemConstants.PATH_COMMON_JSP_CACHE + "boSlideSection_" + thisLang
         * + ".jsp"; String boFile =
         * PropertiesConstants.get(PropertiesConstants.uploadDirectory) + "/" +
         * SystemConstants.PATH_COMMON_JSP_CACHE + "bo@@1@@_" + thisLang +
         * ".jsp";
         *
         * BulkOrder dummy = new BulkOrder(); List aList =
         * boDao.findListWithSample(dummy); List<BulkOrder> resultList = new
         * ArrayList<BulkOrder>(); cmaLogger.debug("aList size " +
         * aList.size()); for (Object aObj : aList) { dummy = (BulkOrder) aObj;
         * if (dummy.getBo_start_date().getTime() > new
         * java.util.Date().getTime() || (dummy.getBo_end_date() != null &&
         * dummy.getBo_end_date().getTime() < new java.util.Date().getTime())) {
         * } else { resultList.add(dummy); } }
         *
         * StringBuffer sb = new StringBuffer(); ArrayList<String> bList = new
         * ArrayList<String>(); sb.append(MessageUtil.getV6Message(thisLang,
         * "BO_SLIDE_CONTENT_HEADER")); cmaLogger.debug("resultList size " +
         * resultList.size()); for (BulkOrder aBo : resultList) { bList = new
         * ArrayList<String>(); bList.add(aBo.getId() + "");
         * bList.add(aBo.getBo_name());
         * sb.append(MessageUtil.getV6Message(thisLang, "BO_SLIDE_CONTENT_ITEM",
         * bList)); } sb.append(MessageUtil.getV6Message(thisLang,
         * "BO_SLIDE_CONTENT_FOOTER"));
         *
         * Writer fw = new BufferedWriter(new OutputStreamWriter( new
         * FileOutputStream(slideSectionFile), "UTF8"));
         * fw.write(sb.toString()); fw.close();
         *
         * } catch (Exception e) { cmaLogger.error("[CACHE] Error", request, e);
         * } *
         */
        return thisResp;
    }

    private SiteResponse doDel(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        if (CommonUtil.isNullOrEmpty(request.getParameter("BO_ID"))) {
          cmaLogger.error("BO_Handler.doDel ERROR: NO Bulk Order GUID for  DEL"); 
          thisResp.addErrorMsg(new SiteErrorMessage("BO_DEL_ERROR")); 
        } 
        try { 
            BulkOrderDAO dao = BulkOrderDAO.getInstance(); 
            BulkOrderItem bo =  new BulkOrderItem(); 
            
            bo.setId(new  Long(request.getParameter("BO_ID"))); 
            List blist = dao.findListWithSample(bo); if (blist == null || blist.size() == 0) {
            cmaLogger.error("BO_Handler.doDel ERROR: NO such Bulk Order + " +
            bo.getId()); throw new Exception(); }
         
          if (dao.delete((BulkOrderItem) (blist.get(0)))) {
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG,
            MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG), "BO_DEL_DONE"));
           }; 
        } catch (Exception e) { 
            cmaLogger.error("BO_Handler.doDel ERROR:  ", request, e); thisResp.addErrorMsg(new SiteErrorMessage("BO_DEL_ERROR")); 
            thisResp.addErrorMsg(new SiteErrorMessage("BO_DEL_ERROR"));
        }
        if(thisResp.hasError()){
            request.setAttribute("boid",request.getParameter("BO_ID"));
            thisResp.setTargetJSP(showAdd(request, response, true).getTargetJSP());
        } else {
            thisResp.setTargetJSP(doList(request, response, true).getTargetJSP());
        }
        return thisResp;
    }

    private SiteResponse doSave(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();
        InputParams inReq = new InputParams(request);

        boolean isAdd = CommonUtil.isNullOrEmpty(request.getParameter("BO_ID"));
        BulkOrderItem bo = new BulkOrderItem();

        //bo.setBoiStartDate(CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_START_DATE")));
        //bo.setBoiEndDate(CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_END_DATE")));

        bo.setBoiName(inReq.get("BOI_NAME"));
        bo.setBoiDescription(inReq.get("BOI_DESCRIPTION"));
        bo.setBoiPrice1Description(inReq.get("BOI_PRICE1_DESCRIPTION"));
        bo.setBoiPrice2Description(inReq.get("BOI_PRICE2_DESCRIPTION"));
        bo.setBoiOption1Name(inReq.get("BOI_OPTION1_NAME"));
        bo.setBoiOption1(inReq.get("BOI_OPTION1_VALUE"));
        bo.setBoiOption2Name(inReq.get("BOI_OPTION2_NAME"));
        bo.setBoiOption2(inReq.get("BOI_OPTION2_VALUE"));
        bo.setBoiCollectionRemarks(inReq.get("BOI_COLLECTION_REMARKS"));
        if (!isAdd) {
            bo.setId(new Long(inReq.get("BO_ID")));
        }
        if (CommonUtil.isNullOrEmpty(inReq.get("sellitemguid"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_SELLITEM_EMPTY"));
        } else {
            SellItemDAO adao = SellItemDAO.getInstance();
            try {
                SellItem tmp = new SellItem();
                tmp.setSys_guid(inReq.get("sellitemguid"));
                List alist = adao.findListWithSample(tmp);
                if (alist == null || alist.size() < 1) {
                    thisResp.addErrorMsg(new SiteErrorMessage("BOI_GET_SELLITEM_ERROR"));
                } else {
                    bo.setSellitem((SellItem) alist.get(0));
                }
            } catch (Exception e) {
                cmaLogger.error("BOdoSave Get Sell Item Exception :", e);
                thisResp.addErrorMsg(new SiteErrorMessage("BOI_GET_SELLITEM_ERROR"));
            }
        }
        if (CommonUtil.isNullOrEmpty(inReq.get("BOI_NAME"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_NAME_EMPTY"));
        }
        if (CommonUtil.isNullOrEmpty(inReq.get("BOI_START_DATE"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_START_DATE_EMPTY"));
        } else if (CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_START_DATE")) == null) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_START_DATE_INVALID"));
        } else {
            bo.setBoiStartDate(CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_START_DATE")));
        }
        if (CommonUtil.isNullOrEmpty(inReq.get("BOI_END_DATE")) && CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_END_DATE")) == null) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_END_DATE_INVALID"));
        } else {
            bo.setBoiEndDate(CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_END_DATE")));
        }

        //2013-10-16 Add collection information
        if (CommonUtil.isNullOrEmpty(inReq.get("BOI_COLLECTION_START_DATE"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_COLLECTION_START_DATE_EMPTY"));
        } else if (CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_COLLECTION_START_DATE")) == null) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_COLLECTION_START_DATE_INVALID"));
        } else {
            bo.setBoiCollectionStartDate(CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_COLLECTION_START_DATE")));
        }
        if (CommonUtil.isNullOrEmpty(inReq.get("BOI_COLLECTION_END_DATE")) && CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_COLLECTION_END_DATE")) == null) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_COLLECTION_END_DATE_INVALID"));
        } else {
            bo.setBoiCollectionEndDate(CommonUtil.StringDDMMYYHHmm2Date(inReq.get("BOI_COLLECTION_END_DATE")));
        }
        if (!thisResp.hasError() && bo.getBoiCollectionEndDate() != null && !CommonUtil.isBefore(bo.getBoiCollectionStartDate(), bo.getBoiCollectionEndDate())) {
            thisResp.addErrorMsg(new SiteErrorMessage("BO_ADD_COLLECTION_START_ENDDT"));
        }
        //End 2013-10-16 End
        
        if (CommonUtil.isValidNumber(inReq.get("BOI_COST"))) {
            bo.setBoiCost(new Double(inReq.get("BOI_COST")));
        } else if (!CommonUtil.isNullOrEmpty(inReq.get("BOI_COST"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_COST_INVALID"));
        }
        if (CommonUtil.isValidNumber(inReq.get("BOI_SELL_PRICE"))) {
            bo.setBoiSellPrice(new Double(inReq.get("BOI_SELL_PRICE")));
        } else if (!CommonUtil.isNullOrEmpty(inReq.get("BOI_SELL_PRICE"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_SELL_PRICE_INVALID"));
        }
        if (CommonUtil.isValidNumber(inReq.get("BOI_PRICE1"))) {
            bo.setBoiPrice1(new Double(inReq.get("BOI_PRICE1")));
        } else if (!CommonUtil.isNullOrEmpty(inReq.get("BOI_PRICE1"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_PRICE1_INVALID"));
        }
        if (CommonUtil.isValidNumber(inReq.get("BOI_PRICE2"))) {
            bo.setBoiPrice1(new Double(inReq.get("BOI_PRICE2")));
        } else if (!CommonUtil.isNullOrEmpty(inReq.get("BOI_PRICE2"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_PRICE2_INVALID"));
        }
        if (CommonUtil.isValidInteger(inReq.get("BOI_START_QTY"))) {
            bo.setBoiStartQty(new Integer(inReq.get("BOI_START_QTY")));
        } else if (CommonUtil.isNullOrEmpty(inReq.get("BOI_START_QTY"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_START_QTY_EMPTY"));
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_START_QTY_INVALID"));
        }
        if (CommonUtil.isValidInteger(inReq.get("BOI_PRICE1_QTY"))) {
            bo.setBoiPrice1Stock(new Integer(inReq.get("BOI_PRICE1_QTY")));
        } else if (CommonUtil.isNullOrEmpty(inReq.get("BOI_PRICE1_QTY"))) {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_PRICE1_QTY_EMPTY"));
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_PRICE1_QTY_INVALID"));
        }

        if (CommonUtil.isValidInteger(inReq.get("BOI_PRICE2_QTY"))) {
            bo.setBoiPrice2Stock(new Integer(inReq.get("BOI_PRICE2_QTY")));
        } else if (CommonUtil.isNullOrEmpty(inReq.get("BOI_PRICE2_QTY")) && !CommonUtil.isNullOrEmpty("BOI_PRICE2")) {
            //thisResp.addErrorMsg(new SiteErrorMessage("BOI_PRICE2_QTY_EMPTY"));
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("BOI_PRICE2_QTY_INVALID"));
        }


        if (!thisResp.hasError()) {
            BulkOrderDAO dao = BulkOrderDAO.getInstance();
            try {
                if (isAdd) {
                    bo.setBoiStatus("I");
                    dao.create(bo);
                } else {
                    bo.setBoiStatus(inReq.get("BOI_STATUS"));
                    dao.update(bo);
                }
            } catch (Exception e) {
                thisResp.addErrorMsg(new SiteErrorMessage("BOI_CREATE_ERROR"));
                cmaLogger.error("BOI_CREATE_ERROR", e);
                request.setAttribute(SystemConstants.REQ_ATTR_OBJ_BO, bo);
                request.setAttribute("FLG", "ISADD");
            }
        } else {
            showAdd(request, response, true);
            request.setAttribute(SystemConstants.REQ_ATTR_OBJ_BO, bo);
            request.setAttribute("FLG", "ISADD");
        }
        if (thisResp.hasError()) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_BO_ADMIS_LIST_ADD_ITEM_AJ);
        } else {
            thisResp.setTargetJSP(doList(request, response, true).getTargetJSP());
            request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message((String) request.getAttribute(SystemConstants.REQ_ATTR_LANG), "BO_SAVE_DONE"));
        }
        return thisResp;
    }

    /**
     * *
     * Display Add Form for Bulk Order (with SellItem Category selection)
     *
     * @param request
     * @param response
     * @param isAjax
     * @return
     */
    private SiteResponse showAdd(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {

        SiteResponse thisResp = super.createResponse();

        BulkOrderDAO bDAO = BulkOrderDAO.getInstance();
        BulkOrderItem bItem;
        SellItemDAO cDao = SellItemDAO.getInstance();
        SellItem enqObj = new SellItem();
        SellItem aObj = null;
        try {
            if (!CommonUtil.isNullOrEmpty(request.getParameter("boid")) || !CommonUtil.isNullOrEmpty((String)request.getAttribute("boid"))) {
                bItem = new BulkOrderItem();
                if(!CommonUtil.isNullOrEmpty(request.getParameter("boid"))){
                    bItem.setId(new Long(request.getParameter("boid")));
                } else if(!CommonUtil.isNullOrEmpty((String)request.getAttribute("boid"))){
                    bItem.setId(new Long((String)request.getAttribute("boid")));
                }
                List aList = bDAO.findListWithSample(bItem);
                if (aList != null && aList.size() > 0) {
                    bItem = (BulkOrderItem) aList.get(0);
                    request.setAttribute(SystemConstants.REQ_ATTR_OBJ_BO, bItem);
                }
            } else {
                if (!CommonUtil.isNullOrEmpty(request.getParameter("cid"))) {
                    enqObj.setProd_owner(thisMember.getSys_guid());
                    enqObj.setSys_guid(request.getParameter("cid"));
                    List aList = cDao.findListWithSample(enqObj);
                    if (aList != null && aList.size() > 0) {
                        aObj = (SellItem) aList.get(0);
                        request.setAttribute(SystemConstants.REQ_ATTR_OBJ, aObj);
                    }
                }
                if (aObj == null) {
                    enqObj = new SellItem();
                    enqObj.setProd_owner(thisMember.getSys_guid());
                    List aList = cDao.findListWithSample(enqObj);
                    request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, aList);
                }
            }

        } catch (Exception e) {
            cmaLogger.error("BO_Handler.showAdd : Fail to obtain SellItem List", request, e);
            thisResp.addErrorMsg(new SiteErrorMessage("BO_OBTAIN_SELLITEM_ERR"));
        }

        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_BO_ADMIS_LIST_ADD_ITEM_AJ);
        } else {
            //thisResp.setTargetJSP(CMAJspMapping.JSP_BO_ADMIS_LIST_ADD_ITEM);
        }
        return thisResp;
    }

    private void getBOForEdit(HttpServletRequest request,
            HttpServletResponse response) {
        cmaLogger.debug("bo_id: " + request.getParameter("bo_id"));
        if (CommonUtil.isNullOrEmpty(request.getParameter("bo_id"))) {
            return;
        }
        String boid = request.getParameter("bo_id");
        BulkOrderItem bo = new BulkOrderItem();
        bo.setId(new Long(boid));

        try {
            BulkOrderDAO bDAO = BulkOrderDAO.getInstance();
            List returnlist = bDAO.findListWithSample(bo);
            if (returnlist == null) {
                return;
            } else {
                request.setAttribute(SystemConstants.REQ_ATTR_OBJ, returnlist.get(0));
            }
        } catch (Exception e) {
            cmaLogger.error("BO_Handler getBOForEdit Exception: ", e);
        }
    }

    private SiteResponse doList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {

        SiteResponse thisResp = super.createResponse();
        BulkOrderDAO dao = BulkOrderDAO.getInstance();

        try {
            BulkOrderItem enqObj = new BulkOrderItem();

            List returnList = dao.findListWithSample(enqObj);
            cmaLogger.debug("returnList size" + returnList.size());
            if (returnList == null || returnList.size() == 0) {
                /**
                 * *
                 * SellItemCategoryDAO cDao = SellItemCategoryDAO.getInstance();
                 * SellItemCategory cObj = new SellItemCategory();
                 * cObj.setCate_owner(thisMember.getSys_guid()); Object
                 * categoryList = cDao.findListWithSample(cObj);
                 * request.setAttribute("MAINSITE_ITEMCAT", categoryList);
                 * cmaLogger.error("No result from BO_Handler.doList = " +
                 * returnList.size()); **
                 */
            } else if (returnList.size() > 0) {
                //All BO list
                request.setAttribute(SystemConstants.REQ_ATTR_OBJ_LIST, returnList);
            }
        } catch (Exception e) {
            e.printStackTrace();
            cmaLogger.error("BO_Handler.doList exception: ", request, e);
        }


        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_BO_ADMIN_LIST_AJ);
        } else {
            thisResp.setTargetJSP(CMAJspMapping.JSP_BO_ADMIN_LIST);
        }
        return thisResp;
    }
}

package com.imagsky.v6.cma.servlet.handler;

import com.imagsky.common.ImagskySession;
import com.imagsky.common.SiteErrorMessage;
import com.imagsky.common.SiteResponse;
import com.imagsky.util.CommonUtil;
import com.imagsky.util.MessageUtil;
import com.imagsky.util.OrderUtil;
import com.imagsky.util.V6Util;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.CMAJspMapping;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.*;
import com.imagsky.v6.domain.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TXN_Handler extends BaseHandler {

    //Refresh the CMA slide section
    public static final String DO_SLIDE_REFRESH = "SLIDREF";
    private Member thisMember = null;
    private String thisLang = null;
    //Order Record
    public static final String DO_LIST = "LIST";
    public static final String DO_LIST_AJ = "LIST";
    public static final String DO_UPDATE_FEEDBACK = "FEED";
    //Cash Transaction Record
    public static final String DO_CASH_LIST = "CA_LIST";
    public static final String DO_CASH_LIST_AJ = "AJ_CA_LIST";
    //Withdrawn Request
    public static final String DO_WITHDRAWN = "WD_REQ";
    public static final String DO_WITHDRAWN_AJ = "WD_REQ_AJ";
    //Admin Use Bank Script View
    public static final String DO_BS = "BS_LIST";
    public static final String DO_BS_EDIT = "BS_EDIT";
    public static final String DO_BS_SAVE = "BS_SAVE";
    //Friend Share Page
    public static final String DO_SHARE = "SHARE";
    protected static final String CLASS_NAME = "TXN_Handler.java";

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

        if (action.equalsIgnoreCase(DO_LIST)) {
            thisResp = doList(request, response, false);
        } else if (action.equalsIgnoreCase(DO_LIST_AJ)) {
            thisResp = doList(request, response, true);
        } else if (action.equalsIgnoreCase(DO_UPDATE_FEEDBACK)) {
            thisResp = doUpdateFeedBack(request, response);
        } else if (action.equalsIgnoreCase(DO_CASH_LIST) || action.equalsIgnoreCase(DO_CASH_LIST_AJ)) {
            thisResp = doCAList(request, response, action.equalsIgnoreCase(DO_CASH_LIST_AJ));
        } else if (action.equalsIgnoreCase(DO_WITHDRAWN) || action.equalsIgnoreCase(DO_WITHDRAWN_AJ)) {
            thisResp = doWithdrawn(request, response, action.equalsIgnoreCase(DO_WITHDRAWN_AJ));
        } else if (action.equalsIgnoreCase(DO_BS)) {
            thisResp = doBsList(request, response);
        } else if (action.equalsIgnoreCase(DO_BS_SAVE)) {
            thisResp = doBsConfirm(request, response);
        } else {
            thisResp = doList(request, response, false);
        }
        cmaLogger.debug(CLASS_NAME + " " + SystemConstants.LOG_END);
        return thisResp;
    }

    /**
     * **
     *
     * @param request
     * @param response
     * @return
     */
    private SiteResponse doBsList(HttpServletRequest request,
            HttpServletResponse response) {
        SiteResponse thisResp = super.createResponse();

        if (V6Util.isMainsiteLogin(thisMember)) {
            String orderID = CommonUtil.null2Empty(request.getParameter("OID"));

            OrderSet orderSet = new OrderSet();
            //thisResp.addErrorMsg(new SiteErrorMessage("TXN_BS_WRONG_ORDERID"));
            if (!CommonUtil.isNullOrEmpty(orderID)) {
                orderSet.setCode(orderID);
            } else {
                orderSet.setShop(thisMember);//MAINSITE
            }

            if (!thisResp.hasError()) {
                try {
                    OrderSetDAO oDao = OrderSetDAO.getInstance();
                    List os = oDao.findListWithSample(orderSet);
                    if (os == null || os.size() < 1) {
                        thisResp.addErrorMsg(new SiteErrorMessage("TXN_BS_WRONG_ORDERID"));
                    } else if (os.size() > 1) {
                        cmaLogger.debug("os.size" + os.size());
                        request.setAttribute("ORDERSET_LIST", os); //ORDERSET LIST
                    } else {
                        cmaLogger.debug("os.size = 1");
                        request.setAttribute("ORDERSET", os.get(0)); //ORDERSET
                        PaymentDAO pDao = PaymentDAO.getInstance();
                        Payment dummy = new Payment();
                        dummy.setPay_order_num(orderID);
                        List pList = pDao.findListWithSample(dummy);
                        request.setAttribute("PAYMENTLIST", pList); //Payment List
                    }
                } catch (Exception e) {
                    cmaLogger.error("List Bank Script Error : Order = " + orderID);
                }
            }
        } else {
            thisResp.addErrorMsg(new SiteErrorMessage("NOT_ALLOWED"));
        }
        thisResp.setTargetJSP(CMAJspMapping.JSP_TXN_BS_LIST);
        return thisResp;
    }

    /**
     * Admin Confirm Payment - Settle and Confirm Payment of Bank Transfers after use upload the bank receipt
     * @param request
     * @param response
     * @return
     */
    private SiteResponse doBsConfirm(HttpServletRequest request,
            HttpServletResponse response) {
        PaymentDAO pDao = PaymentDAO.getInstance();
        OrderSetDAO oDao = OrderSetDAO.getInstance();

        Payment dummy = new Payment();
        OrderSet oDummy = new OrderSet();

        dummy.setPay_id(new Integer(request.getParameter("PID")));
        dummy.setPay_confirm_date(new java.util.Date());
        dummy.setPay_status("D");
        
        try {
            pDao.update(dummy);
            dummy = (Payment) pDao.findListWithSample(dummy).get(0);
            if(CommonUtil.isNullOrEmpty(dummy.getPay_bt_upload_file())){
            	dummy.setPay_remarks(dummy.getPay_remarks() + "<br/>Confirm Date [No Bank Receipt]: "+ CommonUtil.formatDate(new java.util.Date()));
            } else {
            	dummy.setPay_remarks(dummy.getPay_remarks() + "<br/>Confirm Date [With Receipt]: "+ CommonUtil.formatDate(new java.util.Date()));
            }
            pDao.update(dummy);
            oDummy.setCode(dummy.getPay_order_num());
            oDummy = (OrderSet) oDao.findListWithSample(oDummy).get(0);
            //Update Order Set Status
            if (OrderUtil.isPaymentSuccess(oDummy, true)) {
                cmaLogger.debug("Payment Success - Update Order Status...");
                oDummy.setOrder_status("D");
                oDummy.setOrder_payment_date(dummy.getPay_receive_date());
                oDao.update(oDummy);
            }
        } catch (Exception e) {
            cmaLogger.error("Confirm Bank-transfer error", request, e);
        }
        
        return doList(request, response, true);
    }

    /*****************
     * NOT IMPLEMENT YET (Withdrawn Cash from Account) 
     * @param request
     * @param response
     * @param isAjax
     * @return
     */
    private SiteResponse doWithdrawn(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {
        SiteResponse thisResp = super.createResponse();

        boolean isConfirm = CommonUtil.null2Empty(request.getParameter("confirm")).equalsIgnoreCase("Y");
        request.setAttribute("confirm", CommonUtil.null2Empty(request.getParameter("confirm")));

        WithdrawnRequest aReq = (WithdrawnRequest) request.getSession().getAttribute("WithdrawnRequest");
        if (aReq == null) {
            aReq = new WithdrawnRequest();
        }

        if (isConfirm && !CommonUtil.isNullOrEmpty(request.getParameter("c"))) {
            aReq.setReq_owner_name(CommonUtil.escape(request.getParameter("req_owner_name")));
            aReq.setReq_owner_address1(CommonUtil.escape(request.getParameter("req_owner_address1")));
            aReq.setReq_owner_address2(CommonUtil.escape(request.getParameter("req_owner_address2")));
            //aReq.setReq_amount(new Double(CommonUtil.null2Empty(request.getParameter("req_amount"))));
            aReq.setReq_date(new java.util.Date());

            String email = CommonUtil.null2Empty(request.getParameter("req_email"));

            if (CommonUtil.isNullOrEmpty(request.getParameter("req_amount"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_AMOUNT_MISSING"));
            } else if (!CommonUtil.isValidNumber(request.getParameter("req_amount"))) {
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_AMOUNT_INVALID"));
            } else if (new Double(request.getParameter("req_amount")) <= 0) {
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_AMOUNT_INVALID"));
            } else if (new Double(request.getParameter("req_amount")) > thisMember.getMem_cash_balance()) {
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_AMOUNT_NOT_ENOUGH"));
            } else {
                aReq.setReq_amount(new Double(request.getParameter("req_amount")));
            }


            if (CommonUtil.isNullOrEmpty(aReq.getReq_owner_name())) {
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_NAME_MISSING"));
            }
            if (CommonUtil.isNullOrEmpty(aReq.getReq_owner_address1())) {
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_ADDRESS_MISSING"));
            }


            if (thisResp.hasError()) {
                request.removeAttribute("confirm");
            } else if (aReq.getReq_amount() < new Double(MessageUtil.getV6Message(thisLang, "TXN_WREQ_AMOUNT"))) {
                ArrayList ar = new ArrayList();
                ar.add(MessageUtil.getV6Message(thisLang, "TXN_WREQ_AMOUNT"));
                ar.add(MessageUtil.getV6Message(thisLang, "TXN_WREQ_CHARGE_AMOUNT"));
                thisResp.addErrorMsg(new SiteErrorMessage("TXN_WREQ_CHARGE_REMINDER"));
                aReq.setReq_isCharge(true);
                //aReq.get
                //TODO: Unfinished 2011-04-18

            }
            request.getSession().setAttribute("WithdrawnRequest", aReq);
        } else if (!CommonUtil.isNullOrEmpty(request.getParameter("save"))) {
            //SAVE
            WithdrawnRequestDAO aDAO = WithdrawnRequestDAO.getInstance();
            aReq = (WithdrawnRequest) request.getSession().getAttribute("WithdrawnRequest");
            aReq.setReq_owner(thisMember.getSys_guid());
            aReq.setReq_date(new java.util.Date());
            aReq.setReq_isCharge(aReq.getReq_amount() < new Double(PropertiesConstants.get(PropertiesConstants.cashlimit)));
            try {
                aReq = (WithdrawnRequest) aDAO.create(aReq);
                request.getSession().removeAttribute("WithdrawnRequest");
                request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message(thisLang, "TXN_WREQ_DONE"));
            } catch (Exception e) {
                cmaLogger.error("Create Wtihdrawn Request Error = " + thisMember.getMem_lastname());
            }
        }

        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_TXN_WITH_REQ_AJ);
        } else {
            thisResp.setTargetJSP(CMAJspMapping.JSP_TXN_WITH_REQ);
        }
        return thisResp;
    }

    private SiteResponse doCAList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {

        SiteResponse thisResp = super.createResponse();
        int dayback = 0;

        if (!CommonUtil.isNullOrEmpty(request.getParameter("dayback"))) {
            dayback = new Integer(request.getParameter("dayback"));
        }
        try {
            TransactionDAO tdao = TransactionDAO.getInstance();
            List resultList = tdao.findListWithinDays(thisMember.getSys_guid(), dayback);
            request.setAttribute("cashRecords", resultList);
        } catch (Exception e) {
            cmaLogger.error("Cash Transaction Record Enquire Fail : " + thisMember.getMem_login_email(), request, e);
        }

        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_TXNLIST_CA_AJ);
        } else {
            thisResp.setTargetJSP(CMAJspMapping.JSP_TXNLIST_CA);
        }
        return thisResp;
    }

    private SiteResponse doUpdateFeedBack(HttpServletRequest request,
            HttpServletResponse response) {

        SiteResponse thisResp = super.createResponse();


        String orderSetId = request.getParameter("osid");
        String in_feedback_point = request.getParameter("v");

        //Validation Part 1
        if (CommonUtil.isNullOrEmpty(orderSetId)) {
            cmaLogger.error("Update Transaction feedback Error: Missing ID", request);
            thisResp.addErrorMsg(new SiteErrorMessage("TXT_FEEDBACK_INVALID"));
        }
        if (!in_feedback_point.equalsIgnoreCase("0")
                && !in_feedback_point.equalsIgnoreCase("1")
                && !in_feedback_point.equalsIgnoreCase("-1")) {
            cmaLogger.error("Update Transaction feedback Error: Invalid Point value- " + in_feedback_point, request);
            thisResp.addErrorMsg(new SiteErrorMessage("TXT_FEEDBACK_INVALID"));
        }
        if (in_feedback_point.equalsIgnoreCase("-1") && CommonUtil.isNullOrEmpty(request.getParameter("FB_REMARKS"))) {
            cmaLogger.error("Update Transaction feedback Error: Remarks empty for negative feedback", request);
            thisResp.addErrorMsg(new SiteErrorMessage("TXT_FEEDBACK_NO_REMARKS"));
        }

        if (!thisResp.hasError()) {
            OrderSet aOs = new OrderSet();
            OrderSetDAO dao = OrderSetDAO.getInstance();
            MemberDAO mDao = MemberDAO.getInstance();
            aOs.setId(new Integer(orderSetId));
            try {
                List osList = dao.findListWithSample(aOs);
                //Validation Part 2
                if (osList == null || osList.size() == 0) {
                    cmaLogger.error("Update Transaction feedback Error: No such OrderSetID " + aOs.getId(), request);
                    thisResp.addErrorMsg(new SiteErrorMessage("TXT_FEEDBACK_INVALID"));
                } else {
                    aOs = (OrderSet) osList.get(0);
                    if (aOs.getFeedback_point() != null) {
                        cmaLogger.error("Update Transaction feedback Error: Feedback already existed " + aOs.getId(), request);
                        thisResp.addErrorMsg(new SiteErrorMessage("TXT_FEEDBACK_ALREADY"));
                    }
                }

                //Proceed
                if (!thisResp.hasError()) {
                    aOs.setFeedback_point(new Integer(in_feedback_point));
                    aOs.setFeedback_remarks(CommonUtil.escape(CommonUtil.null2Empty(request.getParameter("FB_REMARKS"))));
                    dao.update(aOs);
                    Integer feedbackpoint = aOs.getShop().getMem_feedback();
                    if (feedbackpoint == null) {
                        feedbackpoint = new Integer(0);
                    }
                    feedbackpoint += new Integer(in_feedback_point);
                    aOs.getShop().setMem_feedback(feedbackpoint);
                    mDao.update(aOs.getShop());
                    request.setAttribute(SystemConstants.REQ_ATTR_DONE_MSG, MessageUtil.getV6Message(thisLang, "TXT_FEEDBACK_DONE"));
                }

            } catch (Exception e) {
                cmaLogger.error("Update Transaction feedback Error: " + e.getMessage(), request, e);
                thisResp.addErrorMsg(new SiteErrorMessage("TXT_FEEDBACK_INVALID"));
            }

        }

        SiteResponse returnResp = doList(request, response, true);
        returnResp.addErrorMsg(thisResp.getErrorMsgList());
        return returnResp;
    }

    private SiteResponse doList(HttpServletRequest request,
            HttpServletResponse response, boolean isAjax) {

        SiteResponse thisResp = super.createResponse();

        OrderSetDAO dao = OrderSetDAO.getInstance();
        OrderSet enqRecord = null;

        BidDAO bdao = BidDAO.getInstance();
        Bid enqBid = null;

        BidItemDAO bidao = BidItemDAO.getInstance();
        BidItem tmpBidItem = null;
        Member thisMember = null;

        ArrayList<String[]> orderByPurchase = new ArrayList<String[]>();
        orderByPurchase.add(new String[]{"order_create_date", "desc"});
        ArrayList<String[]> orderByBid = new ArrayList<String[]>();
        orderByBid.add(new String[]{"last_update_date", "desc"});
        try {
            //Member
            thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();

            //Bidding record
            enqBid = new Bid();
            enqBid.setMember(thisMember);
            List bidRecords = bdao.findListWithSample(enqBid, orderByBid);
            Iterator it = bidRecords.iterator();

            Map biMap = new HashMap();
            while (it.hasNext()) {
                enqBid = (Bid) it.next();
                tmpBidItem = new BidItem();
                tmpBidItem.setId(enqBid.getBiditem_id());
                tmpBidItem.setBid_status(BidItem.BidStatus.BIDDING);
                List biList = bidao.findListWithSample(tmpBidItem);
                if (biList != null && !biList.isEmpty()) {
                    if (biMap.containsValue(biList.get(0))) {
                        //BidItem already loaded
                        bidRecords.remove(enqBid); //Remove the older auction
                    } else {
                        tmpBidItem = (BidItem) biList.get(0);
                        if (CommonUtil.isBefore(new java.util.Date(), tmpBidItem.getBid_end_date())) {
                            biMap.put(enqBid.getBiditem_id(), biList.get(0)); //Put the new coming biditem into the map
                        } else {
                            bidRecords.remove(enqBid); //Remove finished / cancelled bid   
                        }
                    }
                }
            }
            request.setAttribute("bidRecords", bidRecords);
            request.setAttribute("bidItemMap", biMap);

            //Bid Finished Record
            enqRecord = new OrderSet();
            enqRecord.setPrice_idc("A");
            enqRecord.setMember(thisMember);
            List bidCompleteList = dao.findListWithSample(enqRecord, orderByPurchase);
            request.setAttribute("bidCompleteRecords", bidCompleteList);
            //Sales Records (MainSite only currently : Available for BO also)
            enqRecord = new OrderSet();
            enqRecord.setId(null); 
            enqRecord.setDelete_flg(false);
            enqRecord.setShop(thisMember); 
            List salesRecords = dao.findListWithSample(enqRecord,orderByPurchase);
            request.setAttribute("mainSiteSellCompleteRecords", salesRecords);
            //Purchase Records
            enqRecord = null;
            enqRecord = new OrderSet();
            enqRecord.setDelete_flg(false);
            enqRecord.setMember(thisMember);
            List purchaseRecords = dao.findListWithSample(enqRecord, orderByPurchase);

            //request.setAttribute("salesRecords", salesRecords);
            request.setAttribute("purchaseRecords", purchaseRecords);

        } catch (Exception e) {
            cmaLogger.error("Transaction Record Enquire Fail : " + thisMember.getMem_login_email(), request, e);
        }

        if (isAjax) {
            thisResp.setTargetJSP(CMAJspMapping.JSP_TXNLIST_AJ);
        } else {
            thisResp.setTargetJSP(CMAJspMapping.JSP_TXNLIST);
        }
        return thisResp;
    }
}

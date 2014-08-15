package com.imagsky.util;

import com.imagsky.common.ImagskySession;
import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.biz.MemberBiz;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.*;
import com.imagsky.v6.domain.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

public class OrderUtil {

    public static String randPrx_orderid;
    public static String autoinc_orderid;
    public static Random randomGenerator = new Random();

    /**
     * **
     * Given a sell item guid to check if it is alredy in the Bulk Order Cart No
     * where use...
     *
     * @param itemGuid
     * @param myBulkOrder
     * @return
     */
    public static boolean isItemAlreadyInBOCart(String itemGuid, OrderSet myBulkOrder) {
        if (CommonUtil.isNullOrEmpty(itemGuid)) {
            return false;
        }
        if (myBulkOrder == null) {
            return false;
        }
        //MY BULK ORDER
        Iterator it = myBulkOrder.getOrderItems().iterator();
        OrderItem tmp = null;
        while (it.hasNext()) {
            tmp = (OrderItem) it.next();
            if (itemGuid.equalsIgnoreCase(tmp.getContentGuid())) {
                return true;
            }
        }
        return false;
    }

    public static String getOrderID() {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(new java.util.Date());
        String id = "" + calendar.get(Calendar.YEAR);
        //cmaLogger.debug("calendar.get(Calendar.MONTH)+1" + calendar.get(Calendar.MONTH)+1);
        //cmaLogger.debug(id);
        id += ((calendar.get(Calendar.MONTH) + 1) < 10) ? ("0" + (calendar.get(Calendar.MONTH) + 1)) : (calendar.get(Calendar.MONTH) + 1);
        id += (calendar.get(Calendar.DATE) < 10) ? ("0" + calendar.get(Calendar.DATE)) : calendar.get(Calendar.DATE);
        if (randPrx_orderid == null) {
            randPrx_orderid = CommonUtil.leftpadding(new Integer(randomGenerator.nextInt(100)).toString(), "0", 3);
        }
        id += randPrx_orderid;
        if (CommonUtil.isNullOrEmpty(autoinc_orderid)) {
            autoinc_orderid = "0";
        }
        autoinc_orderid = CommonUtil.leftpadding(new Integer((new Integer(autoinc_orderid) + 1)).toString(), "0", 3);
        id += autoinc_orderid;

        OrderSetDAO dao = OrderSetDAO.getInstance();
        boolean exists = false;
        try {
            OrderSet aSet = new OrderSet();
            aSet.setCode(id);
            List aList = dao.findListWithSample(aSet);
            if (aList != null && aList.size() > 0) {
                exists = true;
            }
        } catch (Exception e) {
            cmaLogger.error("Order Set generate Code error:", e);
        }

        int nextId = (new Integer(autoinc_orderid)) + 1;
        if (nextId > 999) {
            nextId = 0;
        }
        autoinc_orderid = nextId + "";
        if (exists) {
            return getOrderID();
        } else {
            return id;
        }
    }

    // 1. Save Order
    // 2. Payment Init
    // 3. Redirect to Paypal
    // 4. Obtain Transaction ID and submit request PDT
    // 5. Validation for PDT return
    // 6. Update Order Set and payment Status
    public static int proceedBulkOrderPaypal(HttpServletRequest request, OrderSet orderInfo, String step) {


        if (step == null) {//INIT
            cmaLogger.debug("[BULK ORDER] 1. Save Order Set... ", request);
            OrderSet aOrderSet = saveBulkOrder(request, orderInfo);
            cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 1. Save Order Set DONE", request);
            cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 2. Payment Initialize...", request);
            Payment aPayment = paymentInit(request, aOrderSet);
            aOrderSet.setPayment_id_pl(aPayment.getPay_id() + "");
            request.getSession().setAttribute(SystemConstants.PUB_BULKORDER_INFO, aOrderSet);
            cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 2. Payment Initialize DONE (" + aPayment.getPay_id() + ")", request);
        } else if ("4".equalsIgnoreCase(step)) {
            cmaLogger.debug("[BULK ORDER - " + orderInfo.getCode() + "] 4. Obtain Transaction ID and submit request PDT...", request);
            String transactionid = request.getParameter("tx");
            if (CommonUtil.isNullOrEmpty(transactionid)) {
                cmaLogger.error("Transaction ID retrieve fail: Order Code = " + orderInfo.getCode());
                paymentFallback(orderInfo, "3");
            } else {
                String returnString = PaypalUtil.getPaymentData(transactionid, orderInfo);
                cmaLogger.debug("[BULK ORDER - " + orderInfo.getCode() + "] 4. Obtain Transaction ID and submit request PDT DONE " + returnString, request);
                cmaLogger.debug("[BULK ORDER - " + orderInfo.getCode() + "] 5. Validation for PDT return... ", request);
                if (PaypalUtil.validateReturn(returnString, orderInfo)) {
                    cmaLogger.debug("[BULK ORDER - " + orderInfo.getCode() + "] 5. Validation for PDT return DONE ", request);
                    cmaLogger.debug("[BULK ORDER - " + orderInfo.getCode() + "] 6.1. Update Payment with Paypal ID...", request);
                    try {
                        //Obtain Paypal Charge
                        Double paymentGwCharge = new Double(CommonUtil.findValueWithStringTokenizer(returnString, "mc_fee", "^", "="));
                        Payment aPayment = new Payment();
                        PaymentDAO dao = PaymentDAO.getInstance();
                        aPayment.setPay_id(new Integer(orderInfo.getPayment_id_pl()));
                        aPayment.setPay_remarks("--PLCheckoutDetails:" + returnString);
                        aPayment.setPay_receive_date(new java.util.Date());
                        aPayment.setPay_ref_num(transactionid);
                        aPayment.setPay_gw_charge(paymentGwCharge);
                        aPayment.setPay_status("D");
                        dao.update(aPayment);
                        cmaLogger.debug("[BULK ORDER - " + orderInfo.getCode() + "] 6.1. Update Payment with Paypal ID DONE", request);
                    } catch (Exception e) {
                        cmaLogger.error("[BULK ORDER - " + orderInfo.getCode() + "] 6.1. Update Payment error:", request, e);
                    }
                } else {
                    paymentFallback(orderInfo, "5");
                    cmaLogger.error("[BULK ORDER - " + orderInfo.getCode() + "] 5. Validation for PDT return FAILED " + returnString, request);
                }
            }
        }
        return 0;
    }

    public static int proceedBulkOrderAccountDeduction(HttpServletRequest request, OrderSet orderInfo) {
        cmaLogger.debug("[BULK ORDER] 1. Save Order Set... ", request);
        OrderSet aOrderSet = saveBulkOrder(request, orderInfo);
        cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 1. Save Order Set DONE", request);
        cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 2. Account Deduction Start... ", request);
        paymentAccountDeduction(orderInfo);
        cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 2. Account Deduction DONE ", request);
        if (OrderUtil.finalizeBulkOrder(request, orderInfo)) {
            OrderUtil.clearSession(request);
            return 1;
        } else {
            paymentFallback(orderInfo, "AD");
            return -1;
        }
    }


    /**
     * *
     * 20120420 - Restore BT Payment Record to OrderSet
     *
     * @param orderInfo
     * @return
     */
    public static String proceedBankTransferReturnOrderCode(OrderSet orderinfo) {
        cmaLogger.debug("[AUCTION ORDER] 1. Save Order Set... ");
        HttpServletRequest dummyReq = null;
        OrderSet aOrderSet = saveBulkOrder(dummyReq, orderinfo); //Commonly use to save Order Set
        cmaLogger.debug("[AUCTION ORDER - " + aOrderSet.getCode() + "] 1. Save Order Set DONE", dummyReq);
        cmaLogger.debug("[AUCTION ORDER - " + aOrderSet.getCode() + "] 2. Payment Initialize...", dummyReq);
        Payment aPayment = paymentInit(dummyReq, orderinfo);
        cmaLogger.debug("[AUCTION ORDER - " + aOrderSet.getCode() + "] 2. Payment Initialize DONE (" + aPayment.getPay_id() + ")");

        //If it is a Bank Transfer, add a pending payment in Orderset Table
        aOrderSet.setPendingBTPayment(aPayment);
        OrderSetDAO osDAO = OrderSetDAO.getInstance();
        try {
            osDAO.update(aOrderSet);
            //If mix-mode,  TODO
            if (orderinfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
                paymentAccountDeduction(orderinfo);
            }

            if (isPaymentSuccess(orderinfo)) {
                return aOrderSet.getCode();
            } else {
                paymentFallback(orderinfo, "BT");
                return null;
            }
        } catch (Exception e) {
            cmaLogger.error("[AUCTION ORDER - " + aOrderSet.getCode() + "] Restore Bank Transfer Payment Error: ", e);
            paymentFallback(orderinfo, "BT");
            return null;
        }
    }

    public static int proceedBulkOrderBankTransfer(OrderSet orderInfo) {
        return proceedBulkOrderBankTransfer(null, orderInfo);
    }

    /**
     * *
     * 20120420 - Restore BT Payment Record to OrderSet
     *
     * @param request
     * @param orderInfo
     * @return
     */
    public static int proceedBulkOrderBankTransfer(HttpServletRequest request, OrderSet orderInfo) {
        cmaLogger.debug("[BULK ORDER] 1. Save Order Set... ", request);
        OrderSet aOrderSet = saveBulkOrder(request, orderInfo);
        cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 1. Save Order Set DONE", request);
        cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 2. Payment Initialize...", request);
        Payment aPayment = paymentInit(request, orderInfo);
        request.getSession().setAttribute(SystemConstants.PUB_BULKORDER_INFO, aOrderSet);
        cmaLogger.debug("[BULK ORDER - " + aOrderSet.getCode() + "] 2. Payment Initialize DONE (" + aPayment.getPay_id() + ")", request);

        //If it is a Bank Transfer, add a pending payment in Orderset Table
        aOrderSet.setPendingBTPayment(aPayment);
        OrderSetDAO osDAO = OrderSetDAO.getInstance();

        try {
            osDAO.update(aOrderSet);
            //If mix-mode
            if (orderInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
                paymentAccountDeduction(orderInfo);
            }

            if (OrderUtil.finalizeBulkOrder(request, orderInfo)) {
                OrderUtil.clearSession(request);
                return 1;
            } else {
                paymentFallback(orderInfo, "BT");
                return -1;
            }
        } catch (Exception e) {
            cmaLogger.error("[BULK ORDER - " + aOrderSet.getCode() + "] Restore Bank Transfer Payment Error: ", e);
            paymentFallback(orderInfo, "BT");
            return -1;
        }
    }

    public static void paymentAccountDeduction(OrderSet orderInfo) {

        Double deductAmt = null;
        if (orderInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL)
                || orderInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
            deductAmt = orderInfo.getMember().getMem_cash_balance();
        } else if (orderInfo.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION)) {
            deductAmt = orderInfo.getOrder_amount();
        } else {
            cmaLogger.error("OrderUtil.paymentAccountDeduction: invalid payment method");
            return;
        }

        Payment aPayment = new Payment();
        java.util.Date now = new java.util.Date();
        PaymentDAO dao = PaymentDAO.getInstance();
        aPayment.setPay_type(Payment.TYPE_ACC_DEDUCTION);
        aPayment.setPay_order_num(orderInfo.getCode());
        aPayment.setPay_amount(deductAmt);
        aPayment.setPay_remarks("Account Deduction");
        aPayment.setPay_init_date(now);
        aPayment.setPay_proc_date(now);
        aPayment.setPay_last_update_date(now);
        aPayment.setPay_receive_date(now);
        aPayment.setPay_status("D");

        MemberBiz biz = MemberBiz.getInstance();

        biz.doMemberTransaction(orderInfo.getMember(), 0 - deductAmt, "Order Code:" + orderInfo.getCode());
        try {
            dao.create(aPayment);
        } catch (Exception e) {
            cmaLogger.error("OrderUtil.paymentAccountDeduction: ", e);
        }
    }

    public static void paymentFallback(OrderSet orderInfo, String step) {
        OrderSetDAO dao = OrderSetDAO.getInstance();
        PaymentDAO pdao = PaymentDAO.getInstance();
        if (orderInfo == null) {
            cmaLogger.error("[PAYMENT FALLBACK]: OrderSet is null, nothing to fallback");
            return;
        } else {
            try {
                orderInfo.setOrder_status("F");
                dao.update(orderInfo);
            } catch (Exception e) {
                cmaLogger.error("[PAYMENT FALLBACK]: Update OrderSet fail ", e);
            }
            try {
                String pid = orderInfo.getPayment_id_pl();
                Payment apayment = new Payment();
                apayment.setPay_id(new Integer(pid));
                apayment.setPay_last_update_date(new java.util.Date());
                apayment.setPay_status("F");
                pdao.update(apayment);
            } catch (Exception e) {
                cmaLogger.error("[PAYMENT FALLBACK]: Update payment fail ", e);
            }
        }
    }

    /**
     * ***
     * Update payment status to S as SetExpressCheckout
     *
     * private static void updatePayment(HttpServletRequest request, String
     * trnasactionid, OrderSet orderInfo){ String payment_pl_id =
     * orderInfo.getPayment_id_pl(); Payment aPayment = new Payment();
     * if(CommonUtil.isNullOrEmpty(payment_pl_id)){ cmaLogger.error("[BULK
     * ORDER] Payment ID of OrderSet is empty, cannot update payment", request);
     * } else { aPayment.setPay_id(new Integer(payment_pl_id));
     * aPayment.setPay_ref_num(trnasactionid);
     * aPayment.setPay_last_update_date(new java.util.Date());
     * aPayment.setPay_status("S"); //SetExpressCheckout DONE PaymentDAO dao =
     * PaymentDAO.getInstance(); try{ dao.update(aPayment); } catch(Exception
     * e){ cmaLogger.error("[BULK ORDER] Payment update Error" , request, e); }
     * } }
     */
    /**
     * ***
     * MAiling Process and Add Message to BO Owner
     */
    public static int bulkOrderMailing(HttpServletRequest request, OrderSet orderSet) {
        cmaLogger.debug("[START bulkOrderMailing]");

        /**
         * *	OrderItem	**
         */
        String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
        //Local Variable
        ArrayList<String> emailParam = new ArrayList<String>();
        Iterator itS = orderSet.getOrderItems().iterator();
        OrderItem tmpItem = null;
        //Member seller = null;
        StringBuffer itemSb = new StringBuffer();
        StringBuffer buyemailSummary = new StringBuffer();

        //
        String adminEmail = "admin@buybuymeat.net";
        int y = 0;

        while (itS.hasNext()) {
            tmpItem = (OrderItem) itS.next();
            tmpItem.setOrderSet(orderSet);

            if (tmpItem.getQuantity() > 0) {
                itemSb.append("#" + (y + 1) + " - ");
                itemSb.append(tmpItem.getProdName() + " ($ " + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice()) + ") x " + tmpItem.getQuantity() + " = "
                        + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice() * tmpItem.getQuantity()) + "<br/>\n");
                itemSb.append(tmpItem.getItemRemarks() + "<br/>");
                buyemailSummary.append(tmpItem.getProdName() + " ($ " + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice()) + ") x " + tmpItem.getQuantity() + " = "
                        + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice() * tmpItem.getQuantity()) + "<br/>\n");
            }
            if (y == 0) {
                adminEmail = tmpItem.getShop().getMem_login_email();
            }
        }
        itemSb.append("<br/>");

        emailParam.add(itemSb.toString()); //@@1@@ Item List

        //Prepare Param
        emailParam.add(orderSet.getMember().getMem_display_name());//@@2@@ Buy Name
        emailParam.add((CommonUtil.isNullOrEmpty(orderSet.getReceiver_phone()) ? "--" : orderSet.getReceiver_phone()));//@@3@@ REcevier Phone
        emailParam.add(CommonUtil.null2Empty(orderSet.getBuyer_remarks()));//@@4@@ Buyer Remarks

        //Payment
        PaymentDAO pdao = PaymentDAO.getInstance();
        Payment enqObj = new Payment();
        enqObj.setPay_order_num(orderSet.getCode());
        List paymentSet = null;
        try {
            paymentSet = pdao.findListWithSample(enqObj);
            if (paymentSet == null || paymentSet.size() == 0) {
                throw new Exception("No payment for Order" + orderSet.getCode() + " is found...");
            }
            String paymethodString = null;
            StringBuffer sb = new StringBuffer();
            Payment pp = null;
            Payment ad = null;
            Payment bt = null;
            Iterator it = paymentSet.iterator();
            while (it.hasNext()) {
                enqObj = (Payment) it.next();
                if (enqObj.getPay_type().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION)) {
                    ad = enqObj;
                } else if (enqObj.getPay_type().equalsIgnoreCase(Payment.TYPE_BT)) {
                    bt = enqObj;
                } else if (enqObj.getPay_type().equalsIgnoreCase(Payment.TYPE_PAYPAL)) {
                    pp = enqObj;
                }
            }
            if (orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_PAYPAL)) {
                paymethodString = MessageUtil.getV6Message(lang, "COUT_PAYMENT_PAYPAL");
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_PL_EMAIL", pp.getPay_amount() + ""));
            } else if (orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_BT)) {
                paymethodString = MessageUtil.getV6Message(lang, "COUT_PAYMENT_BANK");
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_BT_EMAIL", bt.getPay_amount() + ""));
            } else if (orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_PAYPAL)) {
                paymethodString = MessageUtil.getV6Message(lang, "COUT_CASH_PL", pp.getPay_amount() + "");
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_PL_EMAIL", pp.getPay_amount() + ""));
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_AD_EMAIL", ad.getPay_amount() + ""));
            } else if (orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
                paymethodString = MessageUtil.getV6Message(lang, "COUT_CASH_BANK", bt.getPay_amount() + "");
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_BT_EMAIL", bt.getPay_amount() + ""));
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_AD_EMAIL", ad.getPay_amount() + ""));
            } else if (orderSet.getPaymentMethod().equalsIgnoreCase(
                    Payment.TYPE_ACC_DEDUCTION)) {
                paymethodString = MessageUtil.getV6Message(lang, "COUT_ACC_DEDUCTION");
                sb.append(MessageUtil.getV6Message(lang, "PAYMENT_AD_EMAIL", ad.getPay_amount() + ""));
            }
            emailParam.add(CommonUtil.null2Empty(paymethodString)); //@@5@@
            emailParam.add(CommonUtil.null2Empty(sb.toString()));//@@6@@
            emailParam.add("" + orderSet.getOrder_amount());//@@7@@
            if (orderSet.getPrice_idc().equalsIgnoreCase("B")) {
                emailParam.add("");
                //20110929 emailParam.add(MessageUtil.getV6Message(lang, "BO_NOT_YET_MSG")); //@@8@@
            } else {
                emailParam.add("");
            }
            emailParam.add("" + orderSet.getOrder_amount());//@@9@@
            if (orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_BT)
                    || orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT)) {
                String btUploadUrl = "http://" + PropertiesConstants.get(PropertiesConstants.externalHost) + "/main.do?action=BTUPLOAD&O=" + orderSet.getCode() + "&P=" + bt.getPay_id();
                btUploadUrl = "<a href=\"" + btUploadUrl + "\">" + btUploadUrl + "</a><br/>";
                cmaLogger.debug("Bank Transfer URL: " + btUploadUrl);
                emailParam.add(MessageUtil.getV6Message(lang, "BANK_REMINDER", "" + bt.getPay_amount() + "^" + btUploadUrl));//@@10@@
            } else {
                emailParam.add("");//@@10@@
            }

            emailParam.add(orderSet.getCode());//@@11@@ Order Code (For Buyer Email
        } catch (Exception e) {
            cmaLogger.error("[BULK ORDER MAIL] Error: ", e);
        }

        emailParam.add(orderSet.getReceiver_addr1());//@@12@@
        emailParam.add(orderSet.getReceiver_addr2());//@@13@@
        emailParam.add(orderSet.getBuyer_remarks()); //@@14@@
        emailParam.add(orderSet.getMember().getMem_login_email());//@@15@@ Buyer Email
        //cmaLogger.debug("Get Remarks"+ orderSet.getBuyer_remarks());

        /**
         * *	Add message to MAINSITE	**
         */
        EnquiryDAO eDAO = EnquiryDAO.getInstance();
        Enquiry tmpEnq = null;
        try {
            tmpEnq = new Enquiry();
            tmpEnq.setContentid(orderSet.getCode());
            tmpEnq.setCreate_date(new java.util.Date());
            tmpEnq.setDelete_flg(false);
            tmpEnq.setRead_flg(false);
            tmpEnq.setFr_member(orderSet.getMember());
            tmpEnq.setTo_member(orderSet.getShop());
            tmpEnq.setMessage_type("O");
            tmpEnq.setShow_flg(false);
            cmaLogger.debug(MessageUtil.getV6Message(lang, "ORDER_BO_ENQ_CONTENT", emailParam));
            tmpEnq.setMessageContent(MessageUtil.getV6Message(lang, "ORDER_BO_ENQ_CONTENT", emailParam));
            tmpEnq.setDel_by_recipent(false);
            tmpEnq.setDel_by_sender(false);
            tmpEnq = (Enquiry) eDAO.create(tmpEnq);
        } catch (Exception e) {
            cmaLogger.error("[ORDER - SAVE - ENQ] | " + tmpEnq.getContentid() + "|" + e.getMessage(), request);
        }

        //For Buyer to keep record
        //emailParam.add(buyemailSummary.toString());

        String buyerEmailContent = MessageUtil.getV6Message(lang, "BULK_ORDER_TO_BUYER_CONTENT", emailParam);
        MailUtil mailerBuyer = new MailUtil();
        mailerBuyer.setToAddress(orderSet.getReceiver_email());
        mailerBuyer.setSubject(MessageUtil.getV6Message(lang, "BULK_ORDER_TO_BUYER_SUBJ"));
        mailerBuyer.setContent(buyerEmailContent);

        if (!mailerBuyer.send()) {
            cmaLogger.error("[MAIL - BUYER] |" + orderSet.getReceiver_email() + "|" + orderSet.getCode() + "|FAIL", request);
            cmaLogger.error("[MAIL - BUYER - ITEM] " + orderSet.toString());
        } else {
            cmaLogger.info("[MAIL - BUYER] |" + orderSet.getReceiver_email() + "|" + orderSet.getCode(), request);
        }

        //For ADMIN to keep record
        String adminEmailContent = MessageUtil.getV6Message(lang, "ORDER_BO_ENQ_CONTENT", emailParam);
        MailUtil mailerAdmin = new MailUtil();
        mailerAdmin.setToAddress(adminEmail);
        mailerAdmin.setSubject(MessageUtil.getV6Message(lang, "BULK_ORDER_TO_ADMIN_SUBJ", orderSet.getCode() + " - " + orderSet.getMember().getMem_display_name() + " " + orderSet.getReceiver_email()));
        mailerAdmin.setContent(adminEmailContent);

        if (!mailerAdmin.send()) {
            cmaLogger.error("[MAIL - ADMIN] |" + orderSet.getReceiver_email() + "|" + orderSet.getCode() + "|FAIL", request);
            cmaLogger.error("[MAIL - ADMIN - ITEM] " + orderSet.toString());
        } else {
            cmaLogger.info("[MAIL - ADMIN] |" + orderSet.getReceiver_email() + "|" + orderSet.getCode(), request);
        }

        cmaLogger.debug("[END bulkOrderMailing]");
        return 0;
    }

    public static int proceedOrder(HttpServletRequest request, OrderSet orderInfo, TreeMap shoppingCart) {
        ArrayList<String> emailParam = new ArrayList<String>();
        String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);
        Iterator it = shoppingCart.keySet().iterator();
        OrderSet tmpOrderSet = null;
        ArrayList removeList = null; //remove item when quantity = 0
        Member seller = null;
        Member buyer = null;
        int x = 0;

        StringBuffer buyemailSummary = new StringBuffer();
        String emailContent = null;

        EnquiryDAO eDAO = EnquiryDAO.getInstance();
        Enquiry tmpEnq = null;

        while (it.hasNext()) {
            try {
                removeList = new ArrayList();
                tmpOrderSet = (OrderSet) shoppingCart.get((String) it.next());
                tmpOrderSet.setCode(getOrderID());
                //Buy Item Content (HTML)
                Iterator itS = tmpOrderSet.getOrderItems().iterator();
                StringBuffer itemSb = new StringBuffer();
                OrderItem tmpItem = null;
                int y = 0;
                double amount = 0;
                String emailItemSubj = "";
                while (itS.hasNext()) {
                    tmpItem = (OrderItem) itS.next();
                    tmpItem.setOrderSet(tmpOrderSet);
                    if (y++ == 0) {
                        seller = tmpItem.getShop();
                        emailParam.add(tmpItem.getShop().getMem_shopname());//@@1@@ Shop owner name,
                        buyemailSummary.append("<strong>" + tmpItem.getShop().getMem_shopname() + "</strong><br/>\n");
                    }
                    amount += tmpItem.getActuPrice() * tmpItem.getQuantity();
                    if (tmpItem.getQuantity() > 0) {
                        emailItemSubj += " " + tmpItem.getProdName() + "...";
                        itemSb.append(tmpItem.getProdName() + " ($ " + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice()) + ") x " + tmpItem.getQuantity() + " = "
                                + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice() * tmpItem.getQuantity()) + "<br/>\n");
                        buyemailSummary.append(tmpItem.getProdName() + " ($ " + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice()) + ") x " + tmpItem.getQuantity() + " = "
                                + CommonUtil.numericFormatWithComma(tmpItem.getActuPrice() * tmpItem.getQuantity()) + "<br/>\n");
                    } else {
                        removeList.add(tmpItem);
                    }
                }
                tmpOrderSet.setPaymentWarn(Boolean.FALSE);
                tmpOrderSet.setOrder_amount(amount);
                //Remove item when quantity = 0
                for (int i = 0; i < removeList.size(); i++) {
                    tmpOrderSet.removeOrderItem((OrderItem) removeList.get(i));
                }

                //Send mail and save message when orderItem exists
                if (tmpOrderSet.getOrderItems().size() > 0) {
                    emailParam.add(itemSb.toString());//@@2@@

                    //Prepare Param
                    emailParam.add(orderInfo.getReceiver_firstname() + "," + orderInfo.getReceiver_lastname());
                    emailParam.add(orderInfo.getReceiver_email());
                    emailParam.add((CommonUtil.isNullOrEmpty(orderInfo.getReceiver_phone()) ? "--" : orderInfo.getReceiver_phone()));
                    emailParam.add((CommonUtil.isNullOrEmpty(orderInfo.getReceiver_addr1()) ? "--" : orderInfo.getReceiver_addr1()));
                    emailParam.add((CommonUtil.isNullOrEmpty(orderInfo.getReceiver_addr2()) ? "--" : orderInfo.getReceiver_addr2()));
                    emailParam.add(CommonUtil.null2Empty(orderInfo.getBuyer_remarks()));
                    //Save Order Message
                    cmaLogger.debug("Start Save Order Message");
                    orderInfo = saveOrder(request, orderInfo, tmpOrderSet);
                    cmaLogger.debug("Finish Save Order Message");
                    if (orderInfo == null) {
                        cmaLogger.error("Order Save Error - " + tmpOrderSet.toString());
                    } else {
                        try {
                            tmpEnq = new Enquiry();
                            tmpEnq.setContentid(orderInfo.getCode());
                            tmpEnq.setCreate_date(new java.util.Date());
                            tmpEnq.setDelete_flg(false);
                            tmpEnq.setRead_flg(false);
                            tmpEnq.setFr_member(orderInfo.getMember());
                            tmpEnq.setTo_member(orderInfo.getShop());
                            tmpEnq.setMessage_type("O");
                            tmpEnq.setShow_flg(false);
                            tmpEnq.setMessageContent(MessageUtil.getV6Message(lang, "ORDER_ENQ_CONTENT", emailParam));
                            tmpEnq.setDel_by_recipent(false);
                            tmpEnq.setDel_by_sender(false);
                            tmpEnq = (Enquiry) eDAO.create(tmpEnq);
                        } catch (Exception e) {
                            cmaLogger.error("[ORDER - SAVE - ENQ] | " + tmpEnq.getContentid() + "|" + e.getMessage(), request);
                        }
                    }


                    //Order Code @@9@@
                    emailParam.add(orderInfo.getCode());

                    //To Shop Email
                    emailContent = MessageUtil.getV6Message(lang, "ORDER_SUCCESS_CONTENT", emailParam);

                    MailUtil mailer = new MailUtil();
                    mailer.setToAddress(seller.getMem_login_email());
                    ArrayList<String> subjParam = new ArrayList<String>();
                    if (emailItemSubj.length() > 20) {
                        emailItemSubj = emailItemSubj.substring(0, 20);
                    }
                    subjParam.add(emailItemSubj);
                    mailer.setSubject(MessageUtil.getV6Message(lang, "ORDER_SUCCESS_SUBJ", subjParam));
                    mailer.setContent(emailContent);
                    orderInfo.setOrderItems(tmpOrderSet.getOrderItems());

                    if (!mailer.send()) {
                        cmaLogger.error("[MAIL - SHOP] |" + seller.getMem_login_email() + "|" + tmpOrderSet.getCode() + "|FAIL", request);
                        cmaLogger.error("[MAIL - SHOP - ITEM] " + orderInfo.toString());
                    } else {
                        cmaLogger.info("[MAIL - SHOP] |" + seller.getMem_login_email() + "|" + tmpOrderSet.getCode(), request);
                        x++;
                    }
                }
            } catch (Exception e) {
                cmaLogger.error("Order Mail Error - " + tmpOrderSet.toString(), e);
            } finally {
                /**
                 * *
                 * for (int i = 0; i< emailParam.size(); i++){
                 * cmaLogger.debug(emailParam.get(i));
				}**
                 */
            }
        }

        //For Buyer to keep record
        cmaLogger.debug("MAIL - For Buyer to keep record");
        emailParam.add(buyemailSummary.toString());
        String buyerEmailContent = MessageUtil.getV6Message(lang, "ORDER_TO_BUYER_CONTENT", emailParam);
        MailUtil mailerBuyer = new MailUtil();
        mailerBuyer.setToAddress(orderInfo.getReceiver_email());
        mailerBuyer.setSubject(MessageUtil.getV6Message(lang, "ORDER_TO_BUYER_SUBJ"));
        mailerBuyer.setContent(buyerEmailContent);

        if (!mailerBuyer.send()) {
            cmaLogger.error("[MAIL - BUYER] |" + orderInfo.getReceiver_email() + "|" + tmpOrderSet.getCode() + "|FAIL", request);
            cmaLogger.error("[MAIL - BUYER - ITEM] " + orderInfo.toString());
        } else {
            cmaLogger.info("[MAIL - BUYER] |" + orderInfo.getReceiver_email() + "|" + tmpOrderSet.getCode(), request);
        }
        /**
         * *
         * for (int i = 0; i< emailParam.size(); i++){
         * cmaLogger.debug(emailParam.get(i)); }
		**
         */
        cmaLogger.debug("OrderUtil return :" + x);
        return x;
    }


    /**
     * **
     * For single-mode payment (incluide AD) , init it For mix-mode (AD+PL,
     * AD+BT), init non AD payment
     *
     * @param request
     * @param orderSet
     * @return
     */
    private static Payment paymentInit(HttpServletRequest request, OrderSet orderSet) {
        cmaLogger.debug("Start paymentInit" + orderSet.getCode());
        Payment aPayment = new Payment();
        aPayment.setPay_init_date(new java.util.Date());
        aPayment.setPay_last_update_date(new java.util.Date());
        aPayment.setPay_order_num(orderSet.getCode());
        if (orderSet.getPaymentMethod().indexOf("_") >= 0) {
            //Mix-mode
            aPayment.setPay_amount(orderSet.getOrder_amount() - orderSet.getMember().getMem_cash_balance());
            aPayment.setPay_type(orderSet.getPaymentMethod().replaceAll("AD_", ""));
        } else {
            aPayment.setPay_amount(orderSet.getOrder_amount());
            aPayment.setPay_type(orderSet.getPaymentMethod());
        }
        if (Payment.TYPE_PAYPAL.equalsIgnoreCase(aPayment.getPay_type())) {
            aPayment.setPay_proc_date(new java.util.Date());
        }
        aPayment.setPay_remarks("INIT:OID=" + orderSet.getCode() + "\n");
        aPayment.setPay_status("I");//INIT
        PaymentDAO dao = PaymentDAO.getInstance();
        try {
            cmaLogger.debug("paymentInit: "+ aPayment.getPay_amount());
            return (Payment) dao.create(aPayment);
        } catch (BaseDBException e) {
            cmaLogger.error("Payment Save Error - ", e);
            return null;
        }
    }

    /**
     * ****
     * Create and save a OrderSEt for Bulk Order
     *
     * @param request
     * @param orderSet
     * @return
     */
    private static OrderSet saveBulkOrder(HttpServletRequest request, OrderSet orderSet) {

        OrderSetDAO dao = OrderSetDAO.getInstance();
        if (orderSet == null) {
            return null;
        }
        if (CommonUtil.isNullOrEmpty(orderSet.getCode())) {
            orderSet.setCode(getOrderID());
        }
        orderSet.setDelete_flg(false);
        orderSet.setPaymentWarn(Boolean.FALSE);
        if (V6Util.isLogined(request)) {
            Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
            orderSet.setMember(thisMember);
        }

        orderSet.setOrder_create_date(new java.util.Date());
        if (orderSet.getPaymentMethod().equalsIgnoreCase("paypal")) {
            orderSet.setOrder_payment_date(new java.util.Date());
        }
        orderSet.setOrder_status("I");//init
        try {
            return (OrderSet) dao.create(orderSet);
        } catch (BaseDBException e) {
            cmaLogger.error("Order Save Error - ", e);
            return null;
        }
    }

    /**
     * **
     * Create Order and save (Shop purchase only)
     *
     * @param request
     * @param orderInfo
     * @param orderSet
     * @return
     */
    private static OrderSet saveOrder(HttpServletRequest request, OrderSet orderInfo, OrderSet orderSet) {

        OrderSetDAO dao = OrderSetDAO.getInstance();

        if (orderSet == null || orderInfo == null) {
            return null;
        } else if (orderSet.getOrderItems().size() == 0) {
            return null;
        }


        if (CommonUtil.isNullOrEmpty(orderSet.getCode())) {
            orderSet.setCode(getOrderID());
        }

        orderSet.setDelete_flg(false);
        if (V6Util.isLogined(request)) {
            Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
            orderSet.setMember(thisMember);
        }
        orderSet.setOrder_create_date(new java.util.Date());
        orderSet.setOrder_payment_date(null);
        orderSet.setOrder_status("M");
        orderSet.setReceiver_addr1(orderInfo.getReceiver_addr1());
        orderSet.setReceiver_addr2(orderInfo.getReceiver_addr2());
        orderSet.setReceiver_firstname(orderInfo.getReceiver_firstname());
        orderSet.setReceiver_lastname(orderInfo.getReceiver_lastname());
        orderSet.setReceiver_email(orderInfo.getReceiver_email());
        orderSet.setReceiver_phone(orderInfo.getReceiver_phone());
        orderSet.setBuyer_remarks(orderInfo.getBuyer_remarks());
        try {
            return (OrderSet) dao.create(orderSet);
        } catch (BaseDBException e) {
            cmaLogger.error("Order Save Error - ", e);
            return null;
        }
    }

    /**
     * **
     * Query payment table to check if the payment success
     *
     * @param orderSet
     * @param isFullCheck -- indicate bypass bank transfer or not
     * @return
     */
    public static boolean isPaymentSuccess(OrderSet orderSet, boolean isFullCheck) {
        Payment aPayment = new Payment();
        boolean hasBankTransfer = Payment.TYPE_BT.equalsIgnoreCase(orderSet.getPaymentMethod())
                || (Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT).equalsIgnoreCase(orderSet.getPaymentMethod());

        if (!hasBankTransfer || isFullCheck) {
            aPayment.setPay_status("D");
        }
        aPayment.setPay_order_num(orderSet.getCode());

        PaymentDAO dao = PaymentDAO.getInstance();
        try {
            List aList = dao.findListWithSample(aPayment);
            Double sum = new Double(0);
            Iterator it = aList.iterator();
            Payment tmp = null;
            while (it.hasNext()) {
                tmp = (Payment) it.next();
                sum += tmp.getPay_amount();
                //Bank Transfer validation: Bank Transfer may confirm later
                if (hasBankTransfer && tmp.getPay_type().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION)) {
                    if (!tmp.getPay_status().equalsIgnoreCase("D")) {
                        cmaLogger.error("Payment (" + tmp.getPay_id() + "):Account Deduction for AD_BT mix-mode is not paid");
                        return false;
                    }
                }
            }
            if (!sum.equals(orderSet.getOrder_amount())) {
                cmaLogger.error("Payment " + sum + " <> OrderAmount " + orderSet.getOrder_amount() + " : OrderID = " + orderSet.getCode());
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * **
     * Query payment table to check if the payment success -- ByPass
     * Banktransfer payment
     *
     * @param orderSet
     * @return
     */
    public static boolean isPaymentSuccess(OrderSet orderSet) {
        return isPaymentSuccess(orderSet, false);
    }

    /**
     * *****
     * Update Bulk Order current Qty Update OrderSet Status when payment success
      ##REMOVED##  S Proceed BulkOrder Version 2 Rewards - BOBO Send Email to buyer
     *
     * @param orderSet
     * @return
     */
    public static boolean finalizeBulkOrder(HttpServletRequest request, OrderSet orderSet) {
        cmaLogger.debug("[START finalizeBulkOrder]");
        //BulkOrder aBulkOrder = PropertiesUtil.getBulkOrder();
        BulkOrderDAO dao = BulkOrderDAO.getInstance();

        boolean hasBankTransfer = orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_BT)
                || orderSet.getPaymentMethod().equalsIgnoreCase(Payment.TYPE_ACC_DEDUCTION + "_" + Payment.TYPE_BT);

        OrderSetDAO odao = OrderSetDAO.getInstance();
        boolean isPaid = isPaymentSuccess(orderSet);
        if (isPaid) {
            try {
                /**
                 * * DO NOT UPDATE current Qty if it has Bank Transfer Payment **
                 */
                if (!hasBankTransfer) {
                    ArrayList aL = new ArrayList(orderSet.getOrderItems());
                    Iterator it = aL.iterator();
                    OrderItem oi = null;
                    BulkOrderItem boi = null;
                    while(it.hasNext()){
                        oi = (OrderItem)it.next();
                        boi = PropertiesUtil.getBulkOrderItem(oi.getContentGuid());
                        boi.setBoiCurrentQty(boi.getBoiCurrentQty() + oi.getQuantity());
                        dao.updateCurrentQty(boi);
                    }
                    orderSet.setOrder_status("D");//DONE
                } else {
                    orderSet.setOrder_status("P");//Pending for Bank Transfer
                }
                orderSet.setOrder_payment_date(new java.util.Date());
                odao.update(orderSet);
                //Send Bulk order email to buyer
                bulkOrderMailing(request, orderSet);
            } catch (Exception e) {
                cmaLogger.error("Update Bulk Order Current Qty Fail", e);
            }
        } else {
            cmaLogger.error("Payment Fail (May be wrong amount): " + orderSet.getCode());
        }
        cmaLogger.debug("[END finalizeBulkOrder]");
        return isPaid;
    }

    public static boolean clearSession(HttpServletRequest request) {
        if (request != null) {
            request.getSession().removeAttribute(SystemConstants.PUB_BULKORDER_INFO);
        }
        return true;
    }
}

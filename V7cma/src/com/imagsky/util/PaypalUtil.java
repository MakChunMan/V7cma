package com.imagsky.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.domain.OrderItem;
import com.imagsky.v6.domain.OrderSet;
import java.util.*;

public class PaypalUtil {

    private static final String paypal_sandbox = PropertiesConstants.get("sandbox_url");
    private static final String paypal_production = PropertiesConstants.get("paypal_url");
    private static final String PAYPAL = "paypal";
    private static final String PAYPAL_SANDBOX = "sandbox";

    public static String getPaypalURL() {
        String flg = PropertiesConstants.get(PropertiesConstants.paypalFlg);
        if (CommonUtil.isNullOrEmpty(flg)) {
            return null;
        } else if ("sandbox".equalsIgnoreCase(flg)) {
            return paypal_sandbox;
        } else if ("paypal".equalsIgnoreCase(flg)) {
            return paypal_production;
        } else {
            return null;
        }
    }

    public static Map<String, String> getParamMap(OrderSet orderSet) {
        String flg = PropertiesConstants.get(PropertiesConstants.paypalFlg);
        if (flg == null || (!flg.equalsIgnoreCase(PAYPAL) && !flg.equalsIgnoreCase(PAYPAL_SANDBOX))) {
            cmaLogger.info("[PAYPAL] Paypal module is set to OFF - " + orderSet.getCode() + " is not paid...");
            return null;
        }

        Map<String, String> paramMap = new HashMap<String, String>();

        paramMap.put("business", PropertiesConstants.get(flg + "_seller"));
        /*
         * paramMap.put("PWD", PropertiesConstants.get(flg+"_seller_pwd"));
         * paramMap.put("SIGNATURE",
         * PropertiesConstants.get(flg+"_seller_signature"));
         * paramMap.put("VERSION", "2.3"); paramMap.put("PAYMENTACTION","Sale");
         */
        paramMap.put("cmd", "_cart");
        paramMap.put("upload", "1");
        paramMap.put("charset", "utf-8");
        //TODO: Open for Bulk Order only so type=BO
        paramMap.put("return", "http://" + PropertiesConstants.get(PropertiesConstants.externalHost) + "/do/PUBLIC/?action=CHECKOUT&step=paypal&type=BO");
        paramMap.put("currency_code", "HKD");

        Iterator it = ((ArrayList) orderSet.getOrderItems()).iterator();
        OrderItem tmpItem = null;
        int x = 1;
        while (it.hasNext()) {
            tmpItem = (OrderItem) it.next();
            paramMap.put("item_name_" + x, tmpItem.getProdName());
            //paramMap.put("amount_"+x, tmpItem.getItemRemarks());
            paramMap.put("amount_" + x, "" + tmpItem.getActuPrice());
            paramMap.put("quantity_" + x, "" + tmpItem.getQuantity());
            x++;
        }

        paramMap.put("amount", "" + orderSet.getOrder_amount());
        if (orderSet.getPaymentMethod().startsWith("AD_")) {
            //MIX-MODE: Deduction from Member Account displayed as Discount here
            paramMap.put("discount_amount_cart", orderSet.getMember().getMem_cash_balance() + "");
        }
        return paramMap;
    }

    //
    //Step1: Send cart and basic info and get token
    /**
     * * NOT USE (THIS IS FOR PAYPAL API) public static String getToken(OrderSet
     * orderSet){
     *
     * Map paramMap = getParamMap(orderSet); if(paramMap == null){ return null;
     * } else { paramMap.put("METHOD", "SetExpressCheckout"); }
     *
     * StringBuffer sb = new StringBuffer(); Iterator it =
     * paramMap.keySet().iterator(); while(it.hasNext()){ String tmpkey =
     * (String)it.next(); sb.append("&"+tmpkey+"="+paramMap.get(tmpkey)); }
     * cmaLogger.debug("[PAYPAL_PARAM] "+ sb.toString());
     *
     * try{ String returnStr = HttpClientUtil.httpRequestSubmit(getPaypalURL(),
     * paramMap); return returnStr; } catch (Exception e){
     * cmaLogger.error("[PAYPAL] getToken Error:", e); } return null; }
     *
     * //Step3: Request GetExpressCheckoutDetail for logging public static
     * String getExpressCheckoutDetail(String token, OrderSet orderSet){ Map
     * paramMap = getParamMap(orderSet); if(paramMap == null){ return null; }
     * else { paramMap.put("METHOD", "GetExpressCheckoutDetails"); }
     * paramMap.put("TOKEN", token); try{ String returnStr =
     * HttpClientUtil.httpRequestSubmit(getPaypalURL(), paramMap); return
     * returnStr; } catch (Exception e){ cmaLogger.error("[PAYPAL]
     * getExpressCheckoutDetail Error:", e); } return null; }
     *
     * //Step4: DoExpressCheckoutDetail public static String
     * doExpressCheckoutDetail(String token, String payerId, OrderSet orderSet){
     * Map paramMap = getParamMap(orderSet); if(paramMap == null){ return null;
     * } else { paramMap.put("METHOD", "DoExpressCheckoutPayment"); }
     * paramMap.put("TOKEN", token); paramMap.put("PAYERID", payerId); try{
     * String returnStr = HttpClientUtil.httpRequestSubmit(getPaypalURL(),
     * paramMap); return returnStr; } catch (Exception e){
     * cmaLogger.error("[PAYPAL] DoExpressCheckoutPayment Error:", e); } return
     * null; }
	**
     */
    public static String getPaymentData(String txnid, OrderSet orderSet) {
        Map paramMap = new HashMap();
        String flg = PropertiesConstants.get(PropertiesConstants.paypalFlg);

        //PDT token (find in Paypal preference page)
        paramMap.put("at", PropertiesConstants.get(flg + "_PDT_token"));
        //Transaction ID (from Paypal redirect request parameter)
        paramMap.put("tx", txnid);
        //Standard param
        paramMap.put("cmd", "_notify-synch");

        try {
            String returnStr = HttpClientUtil.httpRequestSubmit(getPaypalURL(), paramMap);
            //cmaLogger.debug(returnStr);
            return returnStr.replaceAll("\\\n", "^");
        } catch (Exception e) {
            cmaLogger.error("", e);
            return null;
        }
    }

    //Validate Paypal Return
    public static boolean validateReturn(String returnString, OrderSet orderSet) {
        returnString = returnString.replaceAll("\\\n", "^");
        String[] tokens = CommonUtil.stringTokenize(returnString, "^");
        if (tokens[0].equalsIgnoreCase("SUCCESS")) {
            return true;
        } else {
            return false;
        }
    }
}

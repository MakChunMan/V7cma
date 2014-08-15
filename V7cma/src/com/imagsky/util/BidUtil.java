/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.util;

import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.cma.constants.SystemConstants;
import com.imagsky.v6.dao.BidDAO;
import com.imagsky.v6.dao.BidItemDAO;
import com.imagsky.v6.dao.OrderSetDAO;
import com.imagsky.v6.dao.PaymentDAO;
import com.imagsky.v6.domain.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author jasonmak
 */
public class BidUtil {

    private static final int NumberOfEmailReceiverLastChance = 10;
    /***
     * When a user place a bid, by this function, the system will check if there is a previous bidder. If so, this function will send a nofication email to that user about a higher auction is placed.
     * 
     */
    public static boolean checkAndMailPreviousBidder(BidItem bidItem, String lang ,HttpServletRequest request){
        if(bidItem==null) return false;
        String subject = MessageUtil.getV6Message(lang, "BIDEMAIL_HIGHER_NOTICE_SUBJ", bidItem.getSellitem().getProd_name());
        ArrayList param = new ArrayList();
        
        BidDAO bDAO = BidDAO.getInstance();
        Bid bid = new Bid();
        try{
          bid.setBiditem_id(bidItem.getId());  
          
          //Order By
          ArrayList paramList = new ArrayList();
          paramList.add(new String[]{"last_update_date","DESC"});
          
          List aList = bDAO.findListWithSample(bid,paramList);
          
          Member emailReceiver = null;
          
          if(aList!=null && aList.size()>1){
              bid = (Bid)aList.get(1); //Receive Bid
              emailReceiver = bid.getMember();
              if(emailReceiver==null){
                return true;// Previous User is Robot
              }
          } else {
              cmaLogger.info("[BID_EMAIL] Email Target Not found - no need to send");
              return false;
          }
          
          param.add(emailReceiver.getMem_display_name());//@@1@@
          param.add(SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost) +
                    PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+  "/"+bidItem.getSellitem().getProd_owner()+ "/thm_"+bidItem.getSellitem().getProd_image1());//@@2@@
          param.add(bidItem.getSellitem().getProd_name()); //@@3@@
          param.add(bid.getBid_price().toString()); //@@4@@
          param.add(bidItem.getBid_current_price().toString());  //@@5@@
          param.add(CommonUtil.formatDate(new java.util.Date())); //@@6@@
          param.add(SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost)+"/do/BID2?action=main&sid="+bidItem.getId()+"&fid="+bid.getMember().getFb_id());
          param.add(CommonUtil.formatDate(bidItem.getBid_end_date())); //@@8@@
          
          MailUtil mailer = new MailUtil();
          mailer.setContent(MessageUtil.getV6Message(lang, "BIDEMAIL_HIGHER_NOTICE_CONTENT",param));
          mailer.setSubject(subject);
          mailer.setToAddress(emailReceiver.getMem_login_email());
          boolean sendResult = mailer.send();
          if (!sendResult){
                cmaLogger.error("[BID_EMAIL] FAIL - To: "+ emailReceiver.getMem_login_email());
        } else {
                cmaLogger.info("[BID_EMAIL] DONE - To: "+ emailReceiver.getMem_login_email());
        }
          
          return sendResult;
        } catch (Exception e){
            if(request!=null)
                cmaLogger.error("[BID_EMAIL] HIGHER MAIL SENT FAILED:", request, e);
            else 
                cmaLogger.error("[BID_EMAIL] HIGHER MAIL SENT FAILED:", e);
            return false;
        }
    }

    /***
     * Invoke by timer, notify the bid (latest 10) users the item will be time-out within 1 hour
     * @return 
     */
    public static Boolean bidLastChanceNotifying(){
        BidItemDAO biDAO = BidItemDAO.getInstance();
        BidItem enqObj = new BidItem();
        enqObj.setIsSentLastChanceNotify(Boolean.FALSE);
        
        boolean result = false;
        
        try{
        List bidItemList = biDAO.findListWithSample(enqObj);
        if(bidItemList==null || bidItemList.isEmpty()) {
            cmaLogger.info("[SYS_TIMER] bidLastChanceNotifying: No Bid item will be timeout.");
            return Boolean.FALSE;
        }
        
        Iterator it = bidItemList.iterator();
        BidItem aBidItem = null;
        List<Bid> emailReceiversBid = null;
        ArrayList param = new ArrayList();
        
        while(it.hasNext()){
            aBidItem = (BidItem)it.next();
            //Check will be time-out within 1 hour
            java.util.Date now = new java.util.Date();
            if(CommonUtil.isBefore(now, aBidItem.getBid_end_date()) &&
                    !CommonUtil.isBeforeAdd(now , aBidItem.getBid_end_date(), Calendar.HOUR, 1)){
                    cmaLogger.debug("[SYS_TIMER] bidLastChanceNotifying: " + aBidItem.getId());
                    emailReceiversBid = biDAO.findBidMemberListForLoserLastChangeNotify(aBidItem.getId(), NumberOfEmailReceiverLastChance);
                    Iterator it2 = emailReceiversBid.iterator();
                    while(it2.hasNext()){
                        Bid tmpBid = (Bid)it2.next();
                        param.add(tmpBid.getMember().getMem_display_name()); //1
                        param.add(SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost) +
                                    PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+  "/"+aBidItem.getSellitem().getProd_owner()+ "/thm_"+aBidItem.getSellitem().getProd_image1());//@@2@@
                        param.add(aBidItem.getSellitem().getProd_name()); //@@3@@
                        param.add(aBidItem.getBid_current_price().toString());  //@@4@@
                        param.add(CommonUtil.formatDate(new java.util.Date())); //@@5@@
                        param.add(SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost)+"/do/BID2?action=main&sid="+aBidItem.getId()+"&fid="+tmpBid.getMember().getFb_id()); //@@6@@
                        param.add(CommonUtil.formatDate(aBidItem.getBid_end_date())); //@@7@@
                        
                        MailUtil mailer = new MailUtil();
                        try{
                        mailer.setContent(MessageUtil.getV6Message("zh", "BIDEMAIL_LASTCHANCE_CONTENT",param)); //TODO: Hardcode Lang
                        mailer.setSubject(MessageUtil.getV6Message("zh", "BIDEMAIL_LASTCHANCE_SUBJ", aBidItem.getSellitem().getProd_name()));
                        mailer.setToAddress(tmpBid.getMember().getMem_login_email());
                        if(mailer.send()){
                            cmaLogger.debug("[BID_EMAIL] LAST CHANCE MAIL SENT OKAY: " + tmpBid.getMember().getMem_login_email());
                            result = true;
                        } else {
                            cmaLogger.debug("[BID_EMAIL] LAST CHANCE MAIL SENT FAILED: " + tmpBid.getMember().getMem_login_email());
                        }
                        } catch (Exception e){
                            cmaLogger.error("[BID_EMAIL] LAST CHANCE MAIL SENT FAILED:" + tmpBid.getMember().getMem_login_email(), e);
                        }
                    } //End of Bid Loop
            } 
            
            aBidItem.setIsSentLastChanceNotify(Boolean.TRUE);
            biDAO.update(aBidItem);
            
        }//End of Bid Item Loop
        } catch (Exception e){
            cmaLogger.error("[BID_EMAIL] LAST CHANCE Exception: ",e);
            return false;            
        }
        return result;
    }
    
    /***
     * Invoke by timer, check any bid item is finished
     * @return 
     */
    public static Boolean bidFinishClearing(){
        OrderSetDAO oDAO = OrderSetDAO.getInstance();
        BidItemDAO biDAO = BidItemDAO.getInstance();
        BidItem enqObj = new BidItem();
        enqObj.setBid_status(BidItem.BidStatus.BIDDING);
        List biddingList = null;
        Boolean result = false;
        try{
            biddingList = biDAO.findListWithSample(enqObj);
            if(biddingList==null || biddingList.isEmpty()){
                cmaLogger.info("[SYS_TIMER] bidFinishClearing: No Bid item is timeout.");
                return Boolean.FALSE;
            }
            Iterator it = biddingList.iterator();
            BidItem tmpBidItem = null;
            while(it.hasNext()){
                tmpBidItem = (BidItem)it.next();
                cmaLogger.debug("[SYS_TIMER] : Bid Item "+ tmpBidItem.getId() + " is working");
                //Not now < enddate => Expired
                if(!CommonUtil.isBefore(new java.util.Date(), tmpBidItem.getBid_end_date())
                        ){
                    //0.1a Bid Finished with no winner
                    if(tmpBidItem.getBid_last_bidMember()==null){
                        cmaLogger.debug("[SYS_TIMER] : Bid Item "+ tmpBidItem.getId() + " cancelled");
                        tmpBidItem.setBid_status(BidItem.BidStatus.CANCELLED);
                        biDAO.update(tmpBidItem);
                    }  else {
                        cmaLogger.debug("[SYS_TIMER] : Bid Item "+ tmpBidItem.getId() + " Finalization start....");
                    //0. Create Order Set
                    OrderSet os = new OrderSet();
                    os.setMember(tmpBidItem.getBid_last_bidMember());
                    os.setOrder_amount(tmpBidItem.getBid_current_price());
                    os.setOrder_create_date(new java.util.Date());
                    os.setPaymentMethod("BT");
                    os.setReceiver_firstname(tmpBidItem.getBid_last_bidMember().getMem_firstname());
                    os.setReceiver_lastname(tmpBidItem.getBid_last_bidMember().getMem_lastname());
                    os.setReceiver_email(tmpBidItem.getBid_last_bidMember().getMem_login_email());
                        Member mainsite = new Member();
                        mainsite.setSys_guid("MAINSITE");
                    os.setShop(mainsite);
                    os.setPrice_idc("A"); //Auction, just a indicator as auction item
                    OrderItem oitem = new OrderItem();
                    oitem.setContentGuid(tmpBidItem.getSellitem().getSys_guid());
                    oitem.setActuPrice(tmpBidItem.getBid_current_price());
                    oitem.setOrdPrice(tmpBidItem.getBid_current_price());
                    oitem.setProdName(tmpBidItem.getSellitem().getProd_name());
                    oitem.setProdImage(tmpBidItem.getSellitem().getProd_image1());
                    oitem.setQuantity(1);
                    oitem.setSeqNo(1);
                    oitem.setShop(mainsite);
                    os.addOrderItem(oitem);
                    //0.1 Place Order
                    OrderUtil.proceedBankTransferReturnOrderCode(os);
                    //1. Email to winner (Address nofirication)
                    ArrayList<String> mailParam=  new ArrayList<String>();
                    mailParam.add(os.getMember().getMem_display_name());//1
                    mailParam.add(SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost) +
                                    PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+  "/"+tmpBidItem.getSellitem().getProd_owner()+ "/thm_"+tmpBidItem.getSellitem().getProd_image1());//@@2@@
                    mailParam.add(tmpBidItem.getSellitem().getProd_name()); //@@3@@
                    mailParam.add(tmpBidItem.getBid_current_price().toString());  //@@4@@
                    
                    //Assume all paid by Bank Transfer (TODO)
                    PaymentDAO pDAO = PaymentDAO.getInstance();
                    Payment enqPayment = new Payment();
                    enqPayment.setPay_order_num(os.getCode());
                    List paymentList = null;
                    try{
                        paymentList = pDAO.findListWithSample(enqPayment);
                        if(paymentList==null || paymentList.isEmpty()){
                            cmaLogger.error("[SYS_TIMER] bidFinishClearing: Payment Initialization Fail, not found any payment - orderset code "+ os.getCode());
                            return Boolean.FALSE;
                        }
                        Payment bt = (Payment)paymentList.get(0);
                        String btUploadUrl = "https://"+ PropertiesConstants.get(PropertiesConstants.externalHost)+"/main.do?action=BTUPLOAD&O="+os.getCode()+ "&P="+ bt.getPay_id();
				btUploadUrl = "<a href=\""+ btUploadUrl + "\">"+ btUploadUrl + "</a><br/>";
				cmaLogger.debug("Bank Transfer URL: " + btUploadUrl);
                        mailParam.add(btUploadUrl);//@@5@@ //BT scrupt url            
                        
                    } catch (Exception e){
                        cmaLogger.error("[SYS_TIMER] bidFinishClearing: Payment Initialization Fail, not found any payment - orderset code "+ os.getCode(),e);
                        return Boolean.FALSE;
                    }
                    
                    MailUtil mailer = new MailUtil();
                    
                        try{
                        mailer.setContent(MessageUtil.getV6Message("zh", "BIDEMAIL_WINNER_CONTENT",mailParam)); //TODO: Hardcode Lang
                        mailer.setSubject(MessageUtil.getV6Message("zh", "BIDEMAIL_WINNER_SUBJ", tmpBidItem.getSellitem().getProd_name()));
                        mailer.setToAddress(os.getMember().getMem_login_email());
                        if(mailer.send()){
                            cmaLogger.debug("[BID_EMAIL] WINNER MAIL SENT OKAY: " + os.getMember().getMem_login_email());
                            result = true;
                        } else {
                            cmaLogger.debug("[BID_EMAIL] WINNER SENT FAILED: " + os.getMember().getMem_login_email());
                        }
                        } catch (Exception e){
                            cmaLogger.error("[BID_EMAIL] WINNER MAIL SENT FAILED:" + os.getMember().getMem_login_email(), e);
                        }

                    
                    //2. encourage email inviting (TO be confirmed)
                    //3. change bid Item status to FINISHED and OrderSet is Pending
                    if(result){
                        tmpBidItem.setBid_status(BidItem.BidStatus.FINISHED);
                        tmpBidItem.setBid_deal_price(tmpBidItem.getBid_current_price());
                        biDAO.update(tmpBidItem);
                        os.setOrder_status("P");
                        oDAO.update(os);
                    } 
                    } //End if bid item has winner
                }
            } //Bid Item Loop
        } catch (Exception e){
            cmaLogger.error("[SYS_TIMER] bidFinishClearing: Error", e);
        }
        return result;
    }
    
    public static Boolean notifyBidWinnerClearing(){
        
        OrderSetDAO osDAO = OrderSetDAO.getInstance();
        PaymentDAO pDAO = PaymentDAO.getInstance();
        
        OrderSet dummy = new OrderSet();
        Payment pDummy = new Payment();
        
        dummy.setPrice_idc("A"); //Auction
        dummy.setOrder_status("P");//Pending
        dummy.setPaymentWarn(Boolean.FALSE);
        List orderSetList = null;
        try{
            orderSetList = osDAO.findListWithSample(dummy);
            if(orderSetList==null || orderSetList.isEmpty()){
                cmaLogger.info("[SYS_TIMER] notifyBidWinnerClearing: No Auction OrderSet is pending.");
                return Boolean.FALSE;
            }
            
            Iterator it = orderSetList.iterator();
            java.util.Date today = new java.util.Date();
            
            ArrayList<String> mailParam = new ArrayList<String>(); 
            while(it.hasNext()){
                dummy = (OrderSet)it.next();
                if(!CommonUtil.isBeforeAdd(dummy.getOrder_create_date(), today, Calendar.DAY_OF_MONTH, 3)){
                    mailParam = new ArrayList<String>();
                    mailParam.add(dummy.getMember().getMem_display_name()); //1
                    ArrayList aList = new ArrayList(dummy.getOrderItems());
                    mailParam.add(SystemConstants.HTTPS + PropertiesConstants.get(PropertiesConstants.externalHost) +
                                    PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+  "/"+dummy.getShop().getSys_guid()+ "/thm_"+ ((OrderItem)(aList).get(0)).getProdImage());//@@2@@
                    mailParam.add(((OrderItem)(aList).get(0)).getProdName()); //@@3@@
                    mailParam.add(dummy.getOrder_amount().toString());  //@@4@@
                    
                    pDummy.setPay_order_num(dummy.getCode());
                    try{
                    List paymentList = pDAO.findListWithSample(pDummy);
                     Payment bt = (Payment)paymentList.get(0);
                        String btUploadUrl = "https://"+ PropertiesConstants.get(PropertiesConstants.externalHost)+"/main.do?action=BTUPLOAD&O="+dummy.getCode()+ "&P="+ bt.getPay_id();
				btUploadUrl = "<a href=\""+ btUploadUrl + "\">"+ btUploadUrl + "</a><br/>";
				cmaLogger.debug("Bank Transfer URL: " + btUploadUrl);
                    mailParam.add(btUploadUrl);//@@5@@ //BT scrupt url                        
                    mailParam.add(CommonUtil.formatDate(dummy.getOrder_create_date())); //@@6@@
                    } catch (Exception e){
                        cmaLogger.error("[SYS_TIMER] notifyBidWinnerClearing: Payment Initialization Fail, not found any payment - orderset code "+ dummy.getCode(),e);
                        //return Boolean.FALSE;
                    }
                    
                    MailUtil mailer = new MailUtil();
                    
                    try{
                    mailer.setContent(MessageUtil.getV6Message("zh", "BIDEMAIL_WARN_WINNER_CONTENT",mailParam)); //TODO: Hardcode Lang
                    mailer.setSubject(MessageUtil.getV6Message("zh", "BIDEMAIL_WARN_WINNER_SUBJ", ((OrderItem)(aList).get(0)).getProdName()));
                    mailer.setToAddress(dummy.getMember().getMem_login_email());
                    if(mailer.send()){
                        dummy.setPaymentWarn(Boolean.TRUE);
                        osDAO.update(dummy);
                        cmaLogger.debug("[BID_EMAIL] WINNER WARN SENT OKAY: " + dummy.getMember().getMem_login_email());
                        
                    } else {
                        cmaLogger.debug("[BID_EMAIL] WINNER WARN FAILED: " + dummy.getMember().getMem_login_email());
                    }
                    } catch (Exception e){
                        cmaLogger.error("[BID_EMAIL] WINNER WARN SENT FAILED:" + dummy.getMember().getMem_login_email(), e);
                    }
                };
            }
        } catch(Exception e){
            cmaLogger.error("[SYS_TIMER] notifyBidWinnerClearing Exception: ",e);
            return false;            
        }
        return true;
    }
}

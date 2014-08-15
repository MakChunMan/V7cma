/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.util;

import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.dao.BidDAO;
import com.imagsky.v6.dao.BidItemDAO;
import com.imagsky.v6.domain.Bid;
import com.imagsky.v6.domain.BidItem;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author jasonmak
 */
public class BidRobotUtil {
    
    private static String generateFakeMemberId(){
        String uuid = UUID.randomUUID().toString();
        return  (UUID.randomUUID().toString().replaceAll("-","").substring(0,2) + "xxxxxxx").substring(0, (int)(Math.random()*5)+4); 
    }
    
    public static Boolean bidRobotChecking(){
        /***
         * Robot Logic:
         *  1) Get all bid item with latest bid is not fake
         *  2) Calculate the perform Fake Rate by price and time left (isPerformFake method)
         *  3) 
         */
        cmaLogger.debug("[ROBOT]...start");
        BidItemDAO bDAO = BidItemDAO.getInstance();
        BidDAO bidDAO = BidDAO.getInstance();
        try{
        List onlineBidItem = bDAO.findOnlineBidItem();
        //cmaLogger.debug("[ROBOT] bi.size " + onlineBidItem.size());
        Iterator it  = onlineBidItem.iterator();
        BidItem bi = null;
        while(it.hasNext()){
            bi = (BidItem)it.next();
            //cmaLogger.debug("[ROBOT] bi.id:"+ bi.getId());
            if(bi.getBid_count()>0 && bi.getBid_last_bidMember()!=null){
                //The lastest bid is not fake
                if(isPerformFake(bi)){
                    cmaLogger.debug("[ROBOT] isPerformFake(ID:"+ bi.getId() + ") is true...");
                    Bid anewBid = new Bid();
                    anewBid.setBid_price(bi.getBid_current_price()+(int)(Math.random()*2)+1);
                    anewBid.setBiditem_id(bi.getId());
                    anewBid.setLast_update_date(new java.util.Date());
                    //anewBid.setMember(thisMember);
                    if((int)Math.random()*10<=2){
                        Bid tmp = new Bid();
                        tmp.setBiditem_id(bi.getId());
                        try{
                            List aList = bidDAO.findListWithSample(tmp);
                            if(aList==null || aList.size()==0)
                                anewBid.setMember_f_name(generateFakeMemberId());//New Fake Member
                            else {
                                Iterator tmpIt = aList.iterator();
                                while(tmpIt.hasNext()){
                                   tmp = (Bid)tmpIt.next();
                                   if(tmp.getMember()==null && CommonUtil.isNullOrEmpty(tmp.getMember_f_name())){
                                       anewBid.setMember_f_name(tmp.getMember_f_name());//Existing Fake Member
                                       break;
                                   }
                                }
                                if(CommonUtil.isNullOrEmpty(anewBid.getMember_f_name())){
                                    anewBid.setMember_f_name(generateFakeMemberId());//New Fake Member
                                }
                            }
                        } catch (Exception e){
                            cmaLogger.error("[ROBOT] Exception: ", e);                            
                            anewBid.setMember_f_name(generateFakeMemberId());//New Fake Member
                        }
                    } else {
                         anewBid.setMember_f_name(generateFakeMemberId());//New Fake Member
                    }
                    bidDAO.checkAndCreate(anewBid);
                    BidItem newbi = new BidItem();
                    newbi.setId(bi.getId());
                    List   biList = bDAO.findListWithSample(newbi);
                    if(!BidUtil.checkAndMailPreviousBidder((BidItem)biList.get(0), "zh", null)){
                            cmaLogger.error("[BID EMAIL] Send Fail: Something wrong");
                    };
                } else {
                    cmaLogger.debug("[ROBOT] isPerformFake(ID:"+ bi.getId() + ") is false;");
                }
            }
        }
        } catch (Exception e){
            cmaLogger.error("[ROBOT] Exception: ", e);
        }
        return true;
    }
    
    private static boolean isPerformFake(BidItem bi){
        cmaLogger.debug("[ROBOT] start generate effective rate...");
        if(bi==null) return false;
        java.util.Date today = new java.util.Date();
        long minutesLeft = (bi.getBid_end_date().getTime() - today.getTime())/1000/60;
        int countDownMins = new Integer(PropertiesConstants.get(PropertiesConstants.rbt_strtCountDown));
        
        double effectiveRate = 0;
        if(bi.getBid_current_price() >= bi.getBid_call_price()){
            effectiveRate = new Double(PropertiesConstants.get(PropertiesConstants.rbt_metTargetRate));
        } else if(minutesLeft > 1440){
            effectiveRate = (1 - new Double(bi.getBid_current_price())/bi.getBid_call_price()) * (0.1);
        } else {
            effectiveRate = (1 - new Double(bi.getBid_current_price())/bi.getBid_call_price()) * (0.2 + 0.8 * (1 - minutesLeft /countDownMins));
        }
        cmaLogger.debug("[ROBOT] effective rate...=" + effectiveRate);
        int result = (int)(Math.random()*100);
        cmaLogger.debug("[ROBOT] isPerformFake result = "+ result + "<= "+ (int)(effectiveRate * 100));
        return (result <= (int)(effectiveRate * 100));
    }
    
    public static void main(String[] args){
        /****
         * 
         int minutesLeft = 10000;
         int cost= 20;
         int currentPrice =1;
         double effectiveRate;
         int runTime = 1;
         for (int x = minutesLeft; x>=0; x--){
             if(x%4==0){ //Simulate execute per 4 minutes
                System.out.println(runTime+ "Minute Left: " + x);
                if(currentPrice >= cost){ //Meet Target
                    effectiveRate = 0.2;
                } else if(x>1440){ //Within one day
                    effectiveRate =  (1 - new Double(currentPrice)/cost)*(0.2);
                } else {
                    effectiveRate =  (1 - new Double(currentPrice)/cost)*(0.2+0.8*(1-x/1440));
                }
                System.out.println("Effective Rate: "+ effectiveRate);
                if((int)(Math.random()*100) <= (int)(effectiveRate * 100)){
                    //Perform robot
                    currentPrice += (int)(Math.random()*2)+1;
                    System.out.println("perform bid...new Current Price = " + currentPrice);
                } else {
                    //Nothing
                }
             }
         }
         * ****/
    }
}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.imagsky.util.timer;

import com.imagsky.util.JobQueue;
import javax.ejb.LocalBean;
import javax.ejb.Schedule;
import javax.ejb.Stateless;

/**
 *
 * @author jasonmak
 */
@Stateless
@LocalBean
public class AuctionTimer {

    /**
     * * Timeout every 5 minute: to check if any BidItem will be finished within
     * 1 hour Email all bider about the time-out ***
     **
     */
    @Schedule(minute = "2/5", second = "0", dayOfMonth = "*", month = "*", year = "*", hour = "*")
    public void bidLastChanceNotifying() {
        JobQueue.add("com.imagsky.util.BidUtil.bidLastChanceNotifying", null);
    }

    /**
     * * Timeout every 5 minute: to check if any BidItem is just finished
     * bidding Email the winner, encourage email inviting (TO be confirmed),
     * address input notify ***
     **
     */
    @Schedule(minute = "*/5", second = "0", dayOfMonth = "*", month = "*", year = "*", hour = "*")
    public void bidFinishClearing() {
        JobQueue.add("com.imagsky.util.BidUtil.bidFinishClearing", null);
    }

    /**
     * * Timeout every 8 hour: to check if any winner not pay or confirm **
     */
    @Schedule(minute = "0", second = "0", dayOfMonth = "*", month = "*", year = "*", hour = "*/8")
    public void notifyBidWinnerClearing() {
        JobQueue.add("com.imagsky.util.BidUtil.notifyBidWinnerClearing", null);
    }

    /**
     * * Timeout every 5 minute: to check if any BidItem is just finished
     * bidding Email the winner, encourage email inviting (TO be confirmed),
     * address input notify ***
     **
     */
    @Schedule(minute = "4/7", second = "0", dayOfMonth = "*", month = "*", year = "*", hour = "*")
    public void bidRobot() {
        JobQueue.add("com.imagsky.util.BidRobotUtil.bidRobotChecking", null);
    }
}

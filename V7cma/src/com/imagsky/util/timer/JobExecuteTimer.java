package com.imagsky.util.timer;

import com.imagsky.util.JobQueue;
import com.imagsky.util.logger.cmaLogger;
import javax.ejb.LocalBean;
import javax.ejb.Schedule;
import javax.ejb.Stateless;

/**
 *
 * @author jasonmak
 */
@Stateless
@LocalBean
public class JobExecuteTimer {

    @Schedule(minute = "*", second = "0/30", dayOfMonth = "*", month = "*", year = "*", hour = "*")
    public void jobExecute() {
        cmaLogger.debug("Jason Timer Job Execute Started...");
        JobQueue.execute();
        cmaLogger.debug("Jason Timer Job Execute Ended...");
    }
}

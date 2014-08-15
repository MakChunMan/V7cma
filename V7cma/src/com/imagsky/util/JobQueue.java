package com.imagsky.util;

import com.imagsky.util.logger.cmaLogger;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;

/**
 *
 * @author jasonmak
 */
public class JobQueue {

    private static ArrayList<Object[]> queue = null;
    
    private static boolean isRunning = false;
    
    public static void openLock(){
        isRunning = false;
    }
    
    public static boolean add(String classMethod, Object[] param){
        if(queue==null)
            queue = new ArrayList();
        if(CommonUtil.isNullOrEmpty(classMethod)){
            cmaLogger.error("[JOB_QUEUE].add : Empty class method string");
            return false;
        }
        queue.add(new Object[]{classMethod, new java.util.Date(), param});
        cmaLogger.debug("[JOB_QUEUE].added Length = "+ queue.size() + "; "+ classMethod);
        return true;
    }
    
    public static boolean execute(){
        if(queue==null || queue.isEmpty()){
            //cmaLogger.info("[JOB_QUEUE].execute : Empty Queue"); 
            return false;
        }
        if(isRunning){
            cmaLogger.info("[JOB_QUEUE].execute : Some job is running"); return false;
        }
        isRunning = true;
        Object[] thisObj = queue.get(0); //Get the first job
        cmaLogger.info("[JOB_QUEUE].execute start: "+ (String)thisObj[0]); 
        String className = ((String)thisObj[0]).substring(0,((String)thisObj[0]).lastIndexOf("."));
        String methodName = ((String)thisObj[0]).substring(((String)thisObj[0]).lastIndexOf(".")+1);
        cmaLogger.debug("className: " +className );
        cmaLogger.debug("methodName: " + methodName);
        Object o = null;
        try{
            Class<?> class1;
            class1 = Class.forName(className);
            Method method = class1.getMethod(methodName, null);
            method.invoke(o, null);
        } catch (ClassNotFoundException e) {
            cmaLogger.error("[JOB_QUEUE].execute failed: "+ (String)thisObj[0],e); 
        } catch (IllegalArgumentException e) {
            cmaLogger.error("[JOB_QUEUE].execute failed: "+ (String)thisObj[0],e); 
        } catch (IllegalAccessException e) {
            cmaLogger.error("[JOB_QUEUE].execute failed: "+ (String)thisObj[0],e); 
        } catch (InvocationTargetException e) {
                        cmaLogger.error("[JOB_QUEUE].execute failed: "+ (String)thisObj[0],e); 
        } catch (SecurityException e) {
                        cmaLogger.error("[JOB_QUEUE].execute failed: "+ (String)thisObj[0],e); 
        } catch (NoSuchMethodException e) {
                        cmaLogger.error("[JOB_QUEUE].execute failed: "+ (String)thisObj[0],e); 
        }
        cmaLogger.info("[JOB_QUEUE].execute end: "+ (String)thisObj[0]);         
        queue.remove(0);
        cmaLogger.info("[JOB_QUEUE].executed length: "+ queue.size());   
        printQueue();
        isRunning = false;
        if(o!=null){
            Boolean result = (Boolean)o;
            return result.booleanValue();
        } else {
            return false;
        }
    }
    
    public static void printQueue(){
        if(queue==null || queue.size()==0){
            cmaLogger.info("Queue is empty");
        } else {
            Iterator it = queue.iterator();
            int x = 0;
            while(it.hasNext()){
                Object[] a = (Object[])it.next();
                cmaLogger.info("" + x++ + ":" + a[0] + " | " + a[1]);
            }
        }
    }
}

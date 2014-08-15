package com.imagsky.common;

import java.util.Collection;
import java.util.Iterator;

import com.imagsky.v6.domain.*;

import com.imagsky.v6.domain.Member;
import com.imagsky.util.*;

public class ACLUtil {

    public static final String BNR01 = "BNR01"; // Enable Page-based Banner Setting
    public static final String MET01 = "MET01"; // Enable Page-based Meta Data Edit;
    public static final String BOE01 = "BOE01"; // Enable Bulk Order Edit Link in profile page
    public static final String ART01 = "ART01"; // Enable Choose Article Type
    public static final String ART02 = "ART02"; // Enable Upload Photo for article
    public static final String ART03 = "ART03"; // Enable Input Friendly URL

    /**
     * *
     * Check Access Control List to match the service Code
     *
     * @param member
     * @param serviceCode
     * @return
     */
    public static boolean isValid(Member member, String serviceCode) {
        if (member == null) {
            return false;
        } else if (CommonUtil.isNullOrEmpty(serviceCode)) {
            return false;
        } else if (member.getServices() == null) {
            return false;
        } else if (member.getServices().size() == 0) {
            return false;
        } else {
            Collection<Service> services = member.getServices();
            Service tmpService = null;
            Iterator<Service> it = services.iterator();
            while (it.hasNext()) {
                tmpService = (Service) it.next();
                if (tmpService.getServ_code().equalsIgnoreCase(serviceCode)) {
                    return true;
                }
            }
            return false;
        }
    }
}

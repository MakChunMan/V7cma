package com.imagsky.util;

import java.io.*;

import com.imagsky.v6.cma.constants.PropertiesConstants;
import com.imagsky.v6.dao.MemberDAO;
import com.imagsky.v6.dao.NodeDAO;
import com.imagsky.v6.domain.*;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;

public class SitemapUtil {

    private static final String host = "http://www.buybuymeat.net/";
    private static final String sitemapFile = PropertiesConstants.get(PropertiesConstants.uploadDirectory) + "/sitemap.xml";
    private static final String sitemapHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n";
    private static final HashMap<String, String> shopUrlMap = new HashMap<String, String>();

    public static int generate() {
        int result = 0;
        try {
            Writer smWriter = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(sitemapFile), "UTF8"));

//			FileWriter smWriter = new FileWriter(sitemapFile);
            smWriter.write(sitemapHeader);
            //Homepage
            smWriter.write("<url>\n<loc>" + host + "</loc>\n");
            smWriter.write("	<changefreq>weekly</changefreq>\n");
            smWriter.write("	<priority>0.8</priority>\n");
            smWriter.write("</url>\n");

            NodeDAO dao = NodeDAO.getInstance();
            Node dummy = new Node();

            MemberDAO mdao = MemberDAO.getInstance();
            Member enqMember = new Member();

            ArrayList<String> sellitemBoGuidList = new ArrayList<String>();

            try {
                //BO
                if (V6Util.isBoboModuleOn()) {
                    //BulkOrder bo = PropertiesUtil.getBulkOrder();
                    //Collection<SellItem> newProds = bo.getSellItems();
                    ArrayList boList = PropertiesUtil.getBulkOrderList();
                    //SellItem tmpProd = null;
                    BulkOrderItem tmpBoI;
                    Iterator<BulkOrderItem> boit = boList.iterator();
                    int x = 0;
                    String boid = null;
                    while (boit.hasNext()) {
                        tmpBoI = (BulkOrderItem) boit.next();
                        String prodDetailPath = "main/.do?v=";
                        smWriter.write("<url>\n<loc>" + host + prodDetailPath + tmpBoI.getSellitem().getSys_guid() + "&amp;boid=" + tmpBoI.getId() + "</loc>\n");
                        smWriter.write("	<changefreq>weekly</changefreq>\n");
                        smWriter.write(" 	<lastmod>" + CommonUtil.formatDate(tmpBoI.getBoiStartDate(), "yyyy-MM-dd") + "</lastmod>\n");
                        //smWriter.write("	<priority>0.8</priority>\n");
                        smWriter.write("</url>\n");
                        result++;
                        sellitemBoGuidList.add(tmpBoI.getSellitem().getSys_guid());
                    }
                }
                //CMA
                List nodeList = dao.findListWithSample(dummy);
                Iterator<Node> it = nodeList.iterator();
                boolean write = true;
                while (it.hasNext()) {
                    dummy = (Node) it.next();
                    write = true;
                    //Obtain Shop url
                    if (sellitemBoGuidList.contains(dummy.getNod_contentGuid())) {
                        //Remove duplicated BO sellitem
                        write = false;
                    }
                    if (shopUrlMap.containsKey(dummy.getNod_owner())) {
                        dummy.setNod_url(host + shopUrlMap.get(dummy.getNod_owner()) + dummy.getNod_url());
                    } else {
                        enqMember = new Member();
                        enqMember.setSys_guid(dummy.getNod_owner());
                        try {
                            List aMemberList = mdao.findListWithSample(enqMember);
                            if (aMemberList.size() > 0) {
                                dummy.setNod_url(host + ((Member) aMemberList.get(0)).getMem_shopurl() + dummy.getNod_url());
                                shopUrlMap.put(dummy.getNod_owner(), ((Member) aMemberList.get(0)).getMem_shopurl());
                            } else {
                                write = false;
                            }
                        } catch (Exception memDAOException) {
                            write = false;
                        }
                    }
                    //WRITE
                    if (write) {
                        result++;
                        smWriter.write("<url>\n<loc>" + dummy.getNod_url() + "</loc>\n");
                        smWriter.write("	<changefreq>weekly</changefreq>\n");
                        smWriter.write(" 	<lastmod>" + CommonUtil.formatDate(dummy.getSys_update_dt(), "yyyy-MM-dd") + "</lastmod>\n");
                        //smWriter.write("	<priority>0.8</priority>\n");
                        smWriter.write("</url>\n");
                    }
                }
            } catch (Exception e) {
            }
            smWriter.write("</urlset>\n");
            smWriter.flush();
            smWriter.close();
            return result;
        } catch (IOException ioe) {
            return -1;
        }
    }
}

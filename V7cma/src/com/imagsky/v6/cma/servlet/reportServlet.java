package com.imagsky.v6.cma.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.imagsky.exception.BaseDBException;
import com.imagsky.util.logger.cmaLogger;
import com.imagsky.v6.dao.OrderSetDAO;
import com.imagsky.v6.domain.OrderSet;
import com.imagsky.v7.domain.report.DeliveryOrderPDF;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

public class reportServlet extends HttpServlet
{

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
  {
	cmaLogger.debug("Report Servlet doGet Start");
    ServletOutputStream servletOutputStream = response.getOutputStream();
    File reportFile = new File(getServletConfig().getServletContext()
        .getRealPath("/reports/DeliveryOrder.jasper"));
    byte[] bytes = null;

    try
    {
    	
    	/***** JPA Datasource Sample
    	EntityManager em=PerisitenceManager.getEntityManager(); 				//Use DAO instead  
        Query query= em.createQuery("select s from ShoppingCart s");  			//Use DAO instead
        List<shoppingcart> listOfShoppingCart=(List<OrderSet>)query.getResultList();
        ***/
    	OrderSetDAO dao = OrderSetDAO.getInstance();
    	OrderSet enquiry = new OrderSet();
    	//enquiry.setId(Integer.parseInt(request.getParameter("ORDERID")));
    	enquiry.setCode(request.getParameter("ORDERNO"));
    	List returnList = dao.findListWithSample(enquiry);
    	
    	ArrayList<DeliveryOrderPDF> aList = new ArrayList<DeliveryOrderPDF>();
    	for(Object tmp : returnList){
    		aList.add(new DeliveryOrderPDF((OrderSet)tmp));
    	}
        JRBeanCollectionDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(aList);  

        //String reportPath = FacesContext.getCurrentInstance().getExternalContext().getRealPath("/reports/report.jasper");   //Already exist
        
        //Use JasperRunManager.runReportToPdf instead
        /****
        JasperPrint jasperPrint = JasperFillManager.fillReport(reportPath, new HashMap(), beanCollectionDataSource);  
        HttpServletResponse httpServletResponse = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();  
        httpServletResponse.addHeader("Content-disposition", "attachment; filename=report.pdf");  
        ServletOutputStream servletOutputStream = httpServletResponse.getOutputStream();  
        JasperExportManager.exportReportToPdfStream(jasperPrint, servletOutputStream);  
        FacesContext.getCurrentInstance().responseComplete();  
    	****/
    	    	
      bytes = JasperRunManager.runReportToPdf(reportFile.getPath(),
          new HashMap(), beanCollectionDataSource); //ParamMap

      response.setContentType("application/pdf");
      response.setContentLength(bytes.length);

      servletOutputStream.write(bytes, 0, bytes.length);
      servletOutputStream.flush();
      servletOutputStream.close();
      cmaLogger.debug("Report Servlet doGet end");
    }
    catch(BaseDBException dbe){
        // display stack trace in the browser
        StringWriter stringWriter = new StringWriter();
        PrintWriter printWriter = new PrintWriter(stringWriter);
        dbe.printStackTrace(printWriter);
        response.setContentType("text/plain");
        response.getOutputStream().print(stringWriter.toString());
        cmaLogger.error("DBException", dbe);
    }
    catch (JRException e)
    {
      // display stack trace in the browser
      StringWriter stringWriter = new StringWriter();
      PrintWriter printWriter = new PrintWriter(stringWriter);
      e.printStackTrace(printWriter);
      response.setContentType("text/plain");
      response.getOutputStream().print(stringWriter.toString());
      cmaLogger.error("JRException", e);
    }
  }
}

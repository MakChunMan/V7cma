<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %> 
<%
		Iterator it = null;
		Transaction os = null;
		StringBuffer sb = new StringBuffer();
		List cashRecords = (List)request.getAttribute("cashRecords");
		Double balance = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_cash_balance();
		if(cashRecords==null || cashRecords.size()==0){
			out.println("<div class=\"ui-widget\">");	
			out.println("<div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\">"); 
			out.println("<span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span>");
			out.println(MessageUtil.getV6Message(lang,"TXT_NO_RECORD"));
			out.println("</div>");
			out.println("</div>");			
		} else if(cashRecords.size()>0){
			it = cashRecords.iterator();
			out.println("<br/><table width=\"100%\" class=\"tbl_form\"><thead><tr>");
			out.println("<th>"+ MessageUtil.getV6Message(lang,"TXT_DATE")+"</th><th>"+ 
					MessageUtil.getV6Message(lang,"TXT_DESC") + "</th><th>" + 
					MessageUtil.getV6Message(lang,"TXT_AMOUNT") + "</th><th>" + 
					MessageUtil.getV6Message(lang,"TIT_BALANCE") + "</th></tr></thead>");
			while(it.hasNext()){
				os = (Transaction)it.next();
				if(os.getTxn_cr_dr().equalsIgnoreCase("DR"))
						balance = balance - os.getTxn_amount();
				else {
						balance = balance + os.getTxn_amount();
				}
				sb.append("<tr><td align=center>"+ CommonUtil.formatDate(os.getTxn_date(),"dd-MM-yyyy")+"</td>");
				sb.append("<td>"+ os.getTxn_desc() +"</td>");
				sb.append("<td align=right>"+ (os.getTxn_cr_dr().equalsIgnoreCase("CR")?"- ":"" )+ CommonUtil.numericFormatWithComma(os.getTxn_amount()) + "</td>");
				sb.append("</td></tr>");
			}
			out.println("<tr><td></td><td>Opening Balance</td><td align=center>--</td><td align=right>"+CommonUtil.numericFormatWithComma(balance)+"</td></tr>\n");
			out.println(sb.toString());
			out.println("<tr><td></td><td>Closing Balance</td><td align=center>--</td><td align=right>"+CommonUtil.numericFormatWithComma(((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser().getMem_cash_balance())+"</td></tr>\n");
			out.println("</table>");
		}
%>
<script>
$(function() {
	$('#txn_hist_btn')
			.button()
			.click(function() {
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/TXN?action=AJ_CA_LIST&c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#txn_history").serialize(),       
		             cache: false,  
		             success: function (html) {
		            	 $("#txn_cash_txn").html(html);
		             }         
	    	     });  
				return false;
			});
});
</script>
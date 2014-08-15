<%@page import="com.imagsky.util.MessageUtil"%>
<%@page import="com.imagsky.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
%>  
<%@page import="com.imagsky.v6.domain.Member"%>
<%@page import="com.imagsky.common.ImagskySession"%>
<%@page import="com.imagsky.v6.cma.constants.PropertiesConstants"%>
<%@page import="com.imagsky.v6.domain.BidItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.imagsky.v6.cma.constants.SystemConstants"%>
<div class="ui-widget"><div id="formerr">
	<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
</div>
<form name="bid_items_form" id="bid_items_form">
<table class="tbl_form"><thead><tr>
<th></th>
<th></th>
<th>名稱</th>
<th>成本價</th>
<th>開拍日期</th>
<th>結束日期</th>
<th>狀態</th>
</tr></thead>
 
    <% 
    Member thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/"+
						thisMember.getSys_guid() +"/thm_";
    List prodList = (List)request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST); 
    BidItem tmp = null;
    int x= 0;
    if(prodList!=null && prodList.size()>0){
        Iterator it = prodList.iterator();
        while(it.hasNext()){
            tmp = (BidItem)it.next();
    %>
    <tr>
        <td><input type="checkbox" value="<%=tmp.getId()%>" name="assign_guid" idx="<%=++x%>" id="id_<%=x%>" class="bid_checkbox"/></td>
        <td><img src="<%=userImagePath+tmp.getSellitem().getProd_image1()%>" width="40"></td>
        <td><%=tmp.getSellitem().getProd_name()%></td>
        <td><input type="text" id="cost_<%=x%>" name="cost_<%=tmp.getId()%>"size="3" value="<%=tmp.getBid_call_price()%>"/></td>
        <td><input type="text" idx="<%=x%>" name="startdate_<%=tmp.getId()%>" value="<%=CommonUtil.formatDate(tmp.getBid_start_date(), "dd-MM-yyyy")%>" class="datepicker" size="10"></td>
        <td><input type="text" idx="<%=x%>" name="enddate_<%=tmp.getId()%>" value="<%=CommonUtil.formatDate(tmp.getBid_end_date(), "dd-MM-yyyy")%>" class="datepicker" size="10"/></td>
        <td><SELECT name="status_<%=tmp.getId()%>" id="status_<%=tmp.getId()%>">
                <option value="<%=BidItem.BidStatus.INIT%>"><%=BidItem.BidStatus.INIT.name()%></option>
                <option value="<%=BidItem.BidStatus.BIDDING%>"><%=BidItem.BidStatus.BIDDING.name()%></option>
                <option value="<%=BidItem.BidStatus.FINISHED%>"><%=BidItem.BidStatus.FINISHED.name()%></option>
                <option value="<%=BidItem.BidStatus.CANCELLED%>"><%=BidItem.BidStatus.CANCELLED.name()%></option>
                <option value="<%=BidItem.BidStatus.PENDING%>"><%=BidItem.BidStatus.PENDING.name()%></option>
            </SELECT></td>
    <script>$('#status_<%=tmp.getId()%>').val("<%=tmp.getBid_status()%>");</script>
    </tr>
    <% }
}%>
</table>
* 結束時間為每日的23:00<br/><br/>
</form>
<button id="btn_save_update"><%=MessageUtil.getV6Message(lang,"BUT_SAVE") %></button>	
<button id="btn_new"><%=MessageUtil.getV6Message(lang,"BUT_NEW") %></button>

<div id="newtable" style="display:none">
    <br/>
    <table class="tbl_form">
        <tr><th colspan="2">新増拍賣品</th></tr>
        <tr><td>商品</td><td><SELECT id="new_guid" name="PROD_GUID"><%=request.getAttribute("OPTION_LIST")%></SELECT></td></tr>
        <tr><td>成本價</td><td><input id="new_cost" type=""></td></tr>
    </table>
     <button id="btn_save"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT") %></button>	
</div>
<script>
    $(".datepicker").datepicker({ dateFormat: "dd-mm-yy" });
    $(".datepicker").change(function(){
        var idx = $(this).attr("idx");
        $('#id_'+idx).attr("checked","true");
        $('#newtable').hide(); //Hide the create table
    });
    
    $('#btn_new').button().click(function(){
        $('#newtable').show();
        $(this).hide();
    });
    $('#btn_save_update').button().click(function(){
        $.ajax({  
                                    url: "/do/BID?action=su&c="+new Date().getTime(),   
                                    type: "POST",  
                                    data: $('#bid_items_form').serialize(),
                                    cache: false,  
                                    success: function (html) {                
                                        $('#bid-region').html(html);
                                    }         
                                    });  
             return false;
    });
    $('#btn_save').button().click(function() {
		//AJAX form submit
                           $.ajax({  
                                    url: "/do/BID?action=new&guid="+ $('#new_guid').val() + "&cost="+ $('#new_cost').val() + "&c="+new Date().getTime(),   
                                    type: "POST",  
                                    cache: false,  
                                    success: function (html) {                
                                        $('#bid-region').html(html);
                                    }         
                                    });  
                                        return false;
	});	
    
</script>

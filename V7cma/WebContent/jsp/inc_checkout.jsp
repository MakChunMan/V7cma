<%
//response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.v6.domain.OrderSet" %>
<%@ page import="com.imagsky.v6.domain.OrderItem" %>
<%@ page import="com.imagsky.v6.domain.Member" %>
<%@ page import="com.imagsky.common.ImagskySession" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.util.logger.*" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %> 
<% try{ %>
<style>

div.column { float:left; padding:3px; vertical-align:middle; height:25px; }

div#footer { clear:both; }
</style>
<div class="ui-widget"><div id="formerr">
<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
</div>
<form id="checkout_form">
<%    
    //String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);

	
	Member thisMember = ((ImagskySession)request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
	
	TreeMap shoppingCart =(TreeMap)request.getSession().getAttribute(SystemConstants.PUB_CART);
	OrderSet cartInfo = (OrderSet)request.getSession().getAttribute(SystemConstants.PUB_CART_INFO);
	
	if(thisMember!=null	&& cartInfo == null){ 
		cartInfo = new OrderSet();
		cartInfo.setMember(thisMember);
		cartInfo.setReceiver_email(thisMember.getMem_login_email());
		cartInfo.setReceiver_firstname(thisMember.getMem_firstname());
		cartInfo.setReceiver_lastname(thisMember.getMem_lastname());
	} else if(cartInfo==null){
		cartInfo = new OrderSet();
	} else if(thisMember!=null){
		cartInfo.setMember(thisMember);
		cartInfo.setReceiver_email(thisMember.getMem_login_email());
		cartInfo.setReceiver_firstname(thisMember.getMem_firstname());
		cartInfo.setReceiver_lastname(thisMember.getMem_lastname());
	}
	
	if(thisMember == null)
		thisMember = new Member();

	OrderSet orderSet = null;
	String mode = (String)CommonUtil.null2Empty(request.getAttribute("mode"));
	if(shoppingCart!=null && shoppingCart.size()>0){
		Iterator it = shoppingCart.descendingKeySet().iterator();
		OrderItem item = null; 
		String userImagePath = null; 
		boolean reset = true;
		while(it.hasNext()){
			orderSet = (OrderSet)shoppingCart.get((String)it.next());
			Iterator itItem = orderSet.getOrderItems().iterator();
			reset = true;
			while(itItem.hasNext()){
				item = (OrderItem)itItem.next();
				userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/"+
				item.getShop().getSys_guid() +"/thm_"+item.getProdImage();
				
				if(mode.equalsIgnoreCase("confirm")){
					//Readonly - Confirm Page
					if(item.getQuantity()>0){
				%>
				<%--div class="column">
					<%=(reset)?MessageUtil.getV6Message(lang,"COUT_SHOP")+" : "+ item.getShop().getMem_shopname():"&nbsp;" %>
					<% reset = false; %>
				</div--%>
				<div class="column"><% if(!CommonUtil.isNullOrEmpty(item.getProdImage())){ %>
							<img src="<%=userImagePath%>" height="48"></img><%} %></div>				
				<div class="column" style="width:200px"><%=MessageUtil.getV6Message(lang,"COUT_ITEM") %>:<%=item.getProdName() %> <br/></div>
				<div class="column"><%=MessageUtil.getV6Message(lang,"COUT_PRICE") %>:$&nbsp;<span id="ap<%=item.getContentGuid()%>"><%=CommonUtil.numericFormatWithComma(item.getActuPrice()) %></span></div>
				<div class="column"><%=MessageUtil.getV6Message(lang,"COUT_QTY")%>:<span id="qty<%=item.getContentGuid() %>"/><%=item.getQuantity() %></span>
				</div>
				<div class="column"><%=MessageUtil.getV6Message(lang,"COUT_SUBTOT")%>:$&nbsp;<%=CommonUtil.numericFormatWithComma(item.getActuPrice()*item.getQuantity()) %>
				</div>
				<div class="clearfloat"></div>
				<%
					}
				} else {
					//Edit
				%>
				<%--div class="column">
					<%=(reset)?MessageUtil.getV6Message(lang,"COUT_SHOP")+" : "+ item.getShop().getMem_shopname():"&nbsp;" %>
					<% reset = false; %>
				</div--%>
				<div class="column"><% if(!CommonUtil.isNullOrEmpty(item.getProdImage())){ %>
							<img src="<%=userImagePath%>" height="48"></img><%} %></div>
				<div class="column" style="width:200px"><%=MessageUtil.getV6Message(lang,"COUT_ITEM") %>:<%=item.getProdName() %> <br/></div>
				<div class="column"><%=MessageUtil.getV6Message(lang,"COUT_PRICE") %>:$&nbsp;<span id="ap<%=item.getContentGuid()%>"><%=CommonUtil.numericFormatWithComma(item.getActuPrice()) %></span></div>
				<div class="column"><%=MessageUtil.getV6Message(lang,"COUT_QTY")%>:</div>
				<div class="column"><select name="qty<%=item.getContentGuid() %>" id="qty<%=item.getContentGuid() %>" class="qty"
				refid="<%=item.getContentGuid()%>">
						<%=MessageUtil.getV6Message(lang,"COUT_QTY_VAL")%>
						</select>
						<script>$('#qty<%=item.getContentGuid()%>').val(<%=item.getQuantity() %>);</script>
				</div>
				<div class="column"><%=MessageUtil.getV6Message(lang,"COUT_SUBTOT")%>:$&nbsp;<span id="amount<%=item.getContentGuid() %>"></span>
				<script>$('#amount<%=item.getContentGuid()%>').html($('#qty<%=item.getContentGuid()%>').val()*<%=item.getActuPrice() %>);</script>
				</div>
				<div class="clearfloat"></div>
				<%
				}
			} //End while
		} //End while
	} else {
		cmaLogger.error("[CHECKOUT] Checkout an empty cart.", request);
		out.println("<script>self.location='/';</script>");
	}
%>	
<script>
$(function() {
	$('.qty')
	.bind("change", function()
			 {
				var ref = $(this).attr("refid");
				$('#amount'+ref).html($('#qty'+ref).val()*$('#ap'+ref).html());  
				return false;
			});
});
</script>
<br/>
<br/>
<% if(mode.equalsIgnoreCase("confirm")){ %>
<table width="100%" class="tbl_form">
		<colgroup>
			<col width="15%"  />
			<col width="*"  />
		</colgroup>
		<thead>
		<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"COUT_BUYER_INFO")%></th></tr>
		</thead>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_BEMAIL")%></td><td><%=CommonUtil.null2Empty(cartInfo.getReceiver_email()) %></td></tr>
		<tr><td><%=MessageUtil.getV6Message(lang,"COUT_BNAME")%></td><td><%=CommonUtil.null2Empty(cartInfo.getReceiver_firstname()) %>
		&nbsp;<%=CommonUtil.null2Empty(cartInfo.getReceiver_lastname()) %>
		</td></tr>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_BPHONE")%></td><td><%=CommonUtil.null2Empty(cartInfo.getReceiver_phone()) %></td></tr>
</table>
<table width="100%" class="tbl_form">
		<colgroup>
			<col width="20%"  />
			<col width="*"  />
		</colgroup>
		<thead>
		<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"COUT_RECEIVER")%></th></tr>
		</thead>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_RADDR")%></td><td>
			<%=CommonUtil.null2Empty(cartInfo.getReceiver_addr1()) %><br/>
			<%=CommonUtil.null2Empty(cartInfo.getReceiver_addr2()) %><br/>
		</td></tr>
</table>
	<% if(!CommonUtil.isNullOrEmpty(cartInfo.getBuyer_remarks())){ %>
	<table width="100%" class="tbl_form">
			<thead>
			<tr><th><%=MessageUtil.getV6Message(lang,"COUT_DESCRIPTION")%></th></tr>
			</thead>
			<tr><td><%=CommonUtil.null2Empty(cartInfo.getBuyer_remarks()) %>
			</td></tr>
	</table>
	<% } %>
<% } else { %>
<table width="100%" class="tbl_form">
		<colgroup>
			<col width="15%"  />
			<col width="*"  />
		</colgroup>
		<thead>
		<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"COUT_BUYER_INFO")%></th></tr>
		</thead>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_BEMAIL")%></td>
			<% if(CommonUtil.isNullOrEmpty(cartInfo.getReceiver_email())){ %>
			<td><input type="text" name="buyer_email" id="buyer_email" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_email()) %>"/>
			</td>
			<% } else {%>
			<td><input type="hidden" name="buyer_email" id="buyer_email" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_email()) %>"/>
			<%=CommonUtil.null2Empty(cartInfo.getReceiver_email()) %></td>
			<% } %>
		</tr>
		<% if(!V6Util.isLogined(request)){ %>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_PASSWD")%></td><td><input type="password" name="buyer_passwd" id="buyer_passwd" value=""/><br/><br/>
		<button id="btn_checkoutlogin"/><%=MessageUtil.getV6Message(lang,"COUT_LOGIN")%></button>
		<button id="btn_joinnow"/><%=MessageUtil.getV6Message(lang,"COUT_REG")%></button>
		</td></tr>
		<% } %>		
		
		<% if(CommonUtil.isNullOrEmpty(cartInfo.getReceiver_firstname()) ||
				CommonUtil.isNullOrEmpty(cartInfo.getReceiver_lastname())){ %>
		<tr><td><%=MessageUtil.getV6Message(lang,"COUT_BNAME")%></td><td><%=MessageUtil.getV6Message(lang,"COUT_BFIRSTNAME")%>  <input type="text" name="buyer_first" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_firstname()) %>" size="10"/>
		<%=MessageUtil.getV6Message(lang,"COUT_BLASTNAME")%>&nbsp;<input type="text" name="buyer_lastname" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_lastname()) %>" size="10"/>
		</td></tr>
		<% } else { %>
		<tr><td><%=MessageUtil.getV6Message(lang,"COUT_BNAME")%></td><td><input type="hidden" name="buyer_first" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_firstname()) %>"/>
		<input type="hidden" name="buyer_lastname" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_lastname()) %>"/>
		<%=CommonUtil.null2Empty(cartInfo.getReceiver_firstname()) %>&nbsp;<%=CommonUtil.null2Empty(cartInfo.getReceiver_lastname()) %>
		</td></tr>
		<% } %>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_BPHONE")%></td><td><input type="text" name="buyer_phone" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_phone()) %>"/></td></tr>
		<tr><td width="20%"><%=MessageUtil.getV6Message(lang,"COUT_RADDR")%></td><td>
			<input type="text" name="rec_addr1" size="40" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_addr1()) %>"/><br/>
			<input type="text" name="rec_addr2" size="40" value="<%=CommonUtil.null2Empty(cartInfo.getReceiver_addr2()) %>"/><br/>
		</td></tr>
</table>
<table width="100%" class="tbl_form">
		<thead>
		<tr><th><%=MessageUtil.getV6Message(lang,"COUT_DESCRIPTION")%></th></tr>
		</thead>
		<tr><td><%=MessageUtil.getV6Message(lang,"COUT_DESCRIPTION_MSG") %><br/>
		<textarea cols="40" rows="5" name="buyer_remarks"><%=CommonUtil.null2Empty(cartInfo.getBuyer_remarks()) %></textarea>
		</td></tr>
</table>
<% } %>
<br/>
<% if(mode.equalsIgnoreCase("confirm")){ %>
<button id="checkout-back"><%=MessageUtil.getV6Message(lang,"COUT_EDIT") %></button>
<button id="checkout-proceed"><%=MessageUtil.getV6Message(lang,"COUT_NOW") %></button><div style="display:none" class="loadinggif"><img src="<%=staticPath %>/images/loader.gif"/></div>

<% } else { %>
<button id="checkout-submit"><%=MessageUtil.getV6Message(lang,"COUT_NOW") %></button>
<% } %>
</form>
<script>
$(function() {
	$('#checkout-submit')
			.button()
			.click(function() {
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/PUBLIC/?action=CHECKOUT&step=confirm&c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             data: $("#checkout_form").serialize(),
		             success: function (html) {                
		            	 $("#checkout-region").html(html);
		            	 $.ajax({  
		 		            url: "<%=request.getAttribute("contextPath") %>/do/PUBLIC/?action=REFRESH&c="+new Date().getTime(),   
		 		            type: "POST",  
		 		            cache: false,  
		 		            success: function (html) {                
		 		            	$("#ctnSidebar").html(html);
		 		            }         
		 			     });
		             }         
	    	     });
				return false;
			});
	$('#checkout-back')
	.button()
	.click(function() {
		$.ajax({  
             url: "<%=request.getAttribute("contextPath") %>/do/PUBLIC/?action=CHECKOUT&step=edit&c="+new Date().getTime(),   
             type: "POST",  
             cache: false,  
             success: function (html) {                
            	 $("#checkout-region").html(html);
             }         
	     });  
		return false;
	});
	$('#checkout-proceed')
	.button()
	.click(function() {
		$('#checkout-proceed').hide();
		$('.loadinggif').show();
		$.ajax({  
             url: "<%=request.getAttribute("contextPath") %>/do/PUBLIC/?action=CHECKOUT&step=proceed&c="+new Date().getTime(),   
             type: "POST",  
             cache: false,  
             success: function (html) {                
            	 $("#checkout-region").html(html);
             }         
	     });  
		return false;
	});

	$('#btn_joinnow')
		.click(function(){
			if($("#loadform").html()==""){
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/jsp/registerBuyer.jsp?id="+ $('#buyer_email').val() + "&c="+new Date().getTime(),   
		             type: "POST",  
		             cache: false,  
		             success: function (html) {
		            	 $("#loadform").html(html);
		            	 setTimeout("$('#dialogRegBuyer-form').dialog('open');",1000);
		             }         
			     });
			} else {
				$('#dialogRegBuyer-form').dialog('open');
				$("#REG_MEM_EMAIL").val($('#buyer_email').val());
			}
		return false;
	});

	$('#btn_checkoutlogin')
		.click(function(){
			$('#txtMbrID_cout').val($('#buyer_email').val());
			$('#txtMbrPIN_cout').val($('#buyer_passwd').val());
			$('#checkoutlogin').submit();
			return false;
	});	
});
</script>
<form action="<%=request.getAttribute("contextPath") %>/do/LOGIN" id="checkoutlogin" method="post">
<input type="hidden" name="action" value="LOGIN"/>
<input type="hidden" name="txtMbrID" id="txtMbrID_cout"/>
<input type="hidden" name="txtMbrPIN" id="txtMbrPIN_cout"/>
<input type="hidden" name="redirectURL" value="<%=request.getAttribute("contextPath") %>/do/PUBLIC?action=CHECKOUT"/>
</form>
<% } catch (Exception e){ 
cmaLogger.error("Error:",e);
}
%>
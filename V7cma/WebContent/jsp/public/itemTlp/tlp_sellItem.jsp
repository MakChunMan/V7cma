<%--
2013-09-18 Combine Add Cart and Checkout into ONE click
2013-10-28 SellItem BO Format
2014-01-01 Auto refersh cache if one-day long, hide form when it is expired.
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@page import="com.imagsky.util.logger.cmaLogger"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*"  %>
<%@include file="/init.jsp" %> 
<%  
    SellItem thisObj = (SellItem) request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
    Member thisMember = null;//Shop
    Member me = new Member();//Login
    BulkOrderItem bo = null; //For BO only
    String userImagePath = "";
    if (CommonUtil.null2Empty(request.getAttribute(SystemConstants.PUB_FLG)).equalsIgnoreCase("Y")) {
        thisMember = (Member) request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
        userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                + thisMember.getSys_guid() + "/";
    }
    if (V6Util.isLogined(request)) {
        me = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    }
//Default tab
    String tab = "";
    if ("1".equalsIgnoreCase(request.getParameter("tab"))) {
        tab = request.getParameter("tab");
    } else if ("1".equalsIgnoreCase((String) request.getAttribute("tab"))) {
        tab = (String) request.getParameter("tab");
    }
//Bulk Order
    boolean isBO = V6Util.isMainsite(request) && !CommonUtil.isNullOrEmpty(request.getParameter("boid"));
    OrderSet bulkOrderCart = (OrderSet) request.getSession().getAttribute(SystemConstants.PUB_BULKORDER_INFO);
    OrderItem bulkOrderItem = null;
    if (isBO) {
        ArrayList al = PropertiesUtil.getBulkOrder(request);
        if (!CommonUtil.isNullOrEmpty(al)) {
            bo = (BulkOrderItem) al.get(0);
            thisObj = bo.getSellitem();
        }
        if (bulkOrderCart != null) {
            bulkOrderItem = bulkOrderCart.getItemByGuid(thisObj.getSys_guid());
        }
        if (bulkOrderItem == null) {
            bulkOrderItem = new OrderItem();
        }
    }
//Node information
    Node thisNode;
    if (request.getAttribute("THIS_NODE") == null) {
        thisNode = new Node();
    } else {
        thisNode = (Node) request.getAttribute("THIS_NODE");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="title" content="<%=thisObj.getProd_name()%> <% if (!V6Util.isMainsite(request)) {%>@ <%=thisMember.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%>" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <meta name="robots" content="all, index, follow" />
        <meta name="distribution" content="global" />
        <meta name="Keywords" content="<%=CommonUtil.null2Empty(thisNode.getNod_keyword())%>" />
        <meta name="description" content="<%=CommonUtil.null2Empty(thisNode.getNod_description())%>" />
        <title><%=thisObj.getProd_name()%> <% if (!V6Util.isMainsite(request)) {%>@ <%=thisMember.getMem_shopname()%><%}%> | <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
        <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
        <link rel="image_src" href="<%=CommonUtil.getHttpServerHostWithPort(request) + userImagePath + "thm_" + thisObj.getProd_image1()%>" alt="<%=thisObj.getProd_name()%>" />
        <%}%>
        <link href="<%=staticPath%>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="<%=staticPath%>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
        <link href="<%=staticPath%>/css/flick/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQCSS")%>" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERY")%>"></script>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERYUI")%>"></script>
        <!--// script for Google Analystic -->
        <script type="text/javascript" src="<%=staticPath%>/script/ga.js"></script>
        <!--// script for sliding sidebar //-->
        <script src="<%=staticPath%>/script/common_DOMControl.js" type="text/javascript"></script>
        <script src="<%=staticPath%>/script/slidemenu.js" type="text/javascript"></script>
        <!--// script for dropdown menu //-->
        <script src="<%=staticPath%>/script/init.js" type="text/javascript"></script>
        <script type="text/javascript">
            <!--//--><![CDATA[//><!--
            var cachedate = new Date(<%=new java.util.Date().getTime()%>);
            //Auto refresh cache for 1 day
            var now = new Date();
            var oneday = 1000 * 60 * 60 * 24;
            if(d.getTime() - cachedate.getTime() >  oneday){
            	//Clear cache
            	   $(function() {
                       $.ajax({  
                           url: "/files/export_sellitem.php?v=<%=thisObj.getSys_guid()%>&boid=<%=CommonUtil.null2Empty(request.getParameter("boid"))%>",
                           type: "POST",  
                           cache: false,  
                           success: function (html) {
                        	   self.reload();
                           }         
                       });  
                   });
            }
            //initialize slider
            sb_setting=new Object();
            sb_setting.opened_item=0;
            sb_setting.allowMultiopen=false;
            //sb_setting.delayOpen=1000;		// in ms, -1 for no delay
            sb_setting.delayOpen=-1;
            sb_setting.maxheight=-1;			// set to -1 for autosize

            function pagaInit() {
                drawmenu("ctnSidebar", sb_setting);
            }
                    //]]>
                    //--><!]]>
        </script>
        <style id="styles" type="text/css">
            div.editable
            {
                border: solid 2px Transparent;
                padding-left: 15px;
                padding-right: 15px;
            }
            div.editable:hover
            {
                border-color: black;
            }

        </style>
        <script type="text/javascript">
            //<![CDATA[

            // Uncomment the following code to test the "Timeout Loading Method".
            // CKEDITOR.loadFullCoreTimeout = 5;

            window.onload = function()
            {
                pagaInit();

            };
        </script>


    </head>
    <body>
        <div id="main_container">
            <jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
            <%-- OLD Version
            <jsp:include page="/jsp/common/com_bo_list_slider.jsp"></jsp:include>
             --%>
            <!--  End Slide for BO -->
            <div id="content">
                <div id="ctnMainFull">
                    <div id="mod_how_to_earn_miles" class="mod">
                                <!--div class="bd" id="prod-region">  -->
                                <div style="float:right;width:28%;border-width:1px;border-style:solid;border-color:#dddddd;padding:4px">
                                    <jsp:include page="/jsp/common/com_boslider.jsp"></jsp:include>
                                </div>      
                                <div style="width:70%;float:left">
                                    <div style="background-color:#F3E2A9;font-size:160%;padding:0px 3px" id="JS_PROD_NAME"><h3><%=thisObj.getProd_name()%></h3></div>
                                    <br/>
                                    <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
                                    <div class="img320Right"  style="padding:20px">
                                        <img class="dtl_image imgBorder" id="dtl_image1" src="<%=userImagePath + "dtl_" + thisObj.getProd_image1()%>" alt="<%=thisObj.getProd_name()%>"  width=320/>
                                        <img class="dtl_image imgBorder" id="dtl_image2" src="<%=userImagePath + "dtl_" + thisObj.getProd_image2()%>" alt="<%=thisObj.getProd_name()%>" style="display:none" width=320/>
                                        <img class="dtl_image imgBorder" id="dtl_image3" src="<%=userImagePath + "dtl_" + thisObj.getProd_image3()%>" alt="<%=thisObj.getProd_name()%>" style="display:none" width=320/>
                                        <br/><br/>
                                        <table align="left" cellpadding="0">
                                            <tr>
                                                <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
                                                <td><div onMouseover="changeImage(1);" onClick="changeImage(1);"><img class="imgBorder" src="<%=userImagePath + "thm_" + thisObj.getProd_image1()%>" width="70"/></div></td>
                                                <% }%>
                                                <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image2())) {%>
                                                <td><div onMouseOver="changeImage(2);" onClick="changeImage(2);"><img class="imgBorder" src="<%=userImagePath + "thm_" + thisObj.getProd_image2()%>" width="70"/></div></td>
                                                <% }%>	
                                                <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image3())) {%>
                                                <td><div onMouseover="changeImage(3);" onClick="changeImage(3);"><img class="imgBorder" src="<%=userImagePath + "thm_" + thisObj.getProd_image3()%>" width="70"/></div></td>
                                                <% }%>
                                            </tr>
                                        </table>
                                        <script>
                                            function changeImage(ix){
                                                $('.dtl_image').hide();
                                                $('#dtl_image'+ix).show();
                                            }
                                        </script>
                                    </div>
                                    <% }%>
                                    <div id="JS_PROD_INFO">	
                                        <% if (!isBO) {%>
                                        <!--  For Shop Product -->	                
		                                        <% if (thisObj.getProd_price2() != null && !thisObj.getProd_price2().equals(new Double(0))) {%>
		                                        <p><strong><%=MessageUtil.getV6Message(lang, "PROD_PRICE")%>:</strong><br/> <del>$<%=CommonUtil.numericFormatWithComma(thisObj.getProd_price())%></del></p>
		                                        <p><strong><%=MessageUtil.getV6Message(lang, "PROD_SP_PRICE")%>:</strong><br/> $<%=CommonUtil.numericFormatWithComma(thisObj.getProd_price2())%> 
		                                            <%-- if(!CommonUtil.isNullOrEmpty(thisObj.getProd_remarks())){ %><%=thisObj.getProd_remarks()%><%} --%>
		                                        </p>
		                                        <% } else {%>
		                                        <p><strong><%=MessageUtil.getV6Message(lang, "PROD_PRICE")%>:</strong><br/> $<%=CommonUtil.numericFormatWithComma(thisObj.getProd_price())%></p>
		                                        <% }%>
		                                        <% if (thisObj.getSys_exp_dt() != null) {%>
		                                        <p><strong><%=MessageUtil.getV6Message(lang, "PROD_POST_DATE")%>:</strong><br/>
		                                            <% ArrayList<String> aparam = new ArrayList<String>();
		                                                aparam.add(CommonUtil.formatDate(thisObj.getSys_live_dt(), "dd-MM-yyyy"));
		                                                aparam.add(CommonUtil.formatDate(thisObj.getSys_exp_dt(), "dd-MM-yyyy"));
		                                            %>
		                                            <%=MessageUtil.getV6Message(lang, "PROD_POST_DATE_MSG", aparam)%></p>
                                            <% }%>
                                        <!--  END oF Shop Product -->
                                        <% } else {%>
                                        <!--  For Bulk Order START -->
                                            <div style="height:450px;border-style:solid;border-width:1px;border-color:#aaaaaa;background:#fcfcfc;padding:10px">
	                                        <p style="color:#aaaaaa;font-size:108%">
	                                            <% if (CommonUtil.null2Zero(bo.getBoiCurrentQty()) < CommonUtil.null2Zero(bo.getBoiPrice1Stock())) {%>
	                                            <% } else {%><%=MessageUtil.getV6Message(lang, "PROD_PRICE")%>: $<%=CommonUtil.numericFormatWithComma(bo.getBoiSellPrice())%> - 團購額滿, 已結束<%}%>
	                                        </p>
                                            <p style="color:#DF0101;font-size:140%"><%=MessageUtil.getV6Message(lang, "BO_PRICE")%>: $<%=CommonUtil.numericFormatWithComma(bo.getBoiPrice1())%>
                                            <span style="color:#999999"><del><strong><%=MessageUtil.getV6Message(lang, "PROD_PRICE")%>:</strong> $<%=CommonUtil.numericFormatWithComma(bo.getBoiSellPrice())%></del></span></p>
                                            <%-- Show or hide the Added Message by Ajax --%>            
	                                        <div id="msg_added1" class="ui-widget" style="display:none">	<div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
	                                                <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
	                                                <%=MessageUtil.getV6Message(lang, "BO_MSG_ADDED")%>
	                                            </div>
	                                        </div>
	                                        <%-- End Show or hide the Added Message by Ajax --%>
	                                        <p><strong><%=MessageUtil.getV6Message(lang, "BO_POST_DATE")%>:</strong><% ArrayList<String> aparam = new ArrayList<String>();
	                                            aparam.add(CommonUtil.formatDate(bo.getBoiStartDate(), "dd-MM-yyyy"));
	                                            aparam.add(CommonUtil.formatDate(bo.getBoiEndDate(), "dd-MM-yyyy"));
	                                            %><%=MessageUtil.getV6Message(lang, "PROD_POST_DATE_MSG", aparam)%>
	                                        </p>
	                                        
	                                        <% if(new java.util.Date().getTime() < bo.getBoiEndDate().getTime()){ %>
	                                        <%-- Order Form Start--%>
                                        <form id="bo_form" name="bo_form" style="font-size:85%" autocomplete="off">
                                            <input type="hidden" name="boid" value="<%=bo.getId()%>"/>
                                            <input type="hidden" name="guid" value="<%=thisObj.getSys_guid()%>"/>
                                            <input type="hidden"  id="remarks" name="remarks"><%=CommonUtil.null2Empty(bulkOrderItem.getItemRemarks())%></textarea>
                                                <table width="40%">
                                                    <tbody>
                                                        <tr valign="middle"><td>
                                                                <strong><%=MessageUtil.getV6Message(lang, "BO_I_BUY_QTY")%>:</strong>
                                                                <input name="qty"  id="qty" size=6/><strong><%=MessageUtil.getV6Message(lang, "UNIT_" + 1)%></strong>
                                                               <script>$('#qty').val(<%=(bulkOrderItem.getQuantity() == null) ? "" : "" + bulkOrderItem.getQuantity()%>);</script>
                                                               <button id=menureset>重新輸入</button>
                                                               <br/><br/>
                                                               <script>
                                                               //2013-09-27 Multiple order for with product option
                                                               var rowon = 0;
                                                               $('#menureset').button().click(function(){
                                                            	   $("#qty").keyup();
                                                            	   return false;
                                                               });
                                                               $("#qty").keyup(function() {
                                                            	   var v = $(this).val();
                                                            	   if(v > <%=SystemConstants.PUB_CART_BO_MAX_ITEM %>){
                                                            		   var ToomuchDialog = $('<div id="MenuDialog" style="font-size:85%" title="大量購買">\
                                                            				    如要大量購買, 請直接聯絡銷售部 : buybuymeat@gmail.com\
                                                            				    </div>'); 
                                                            		   ToomuchDialog.dialog({
                                                            			    modal: true,
                                                            			    title: "大量購買"
                                                                       });
                                                            		   //Reset all
                                                            		   $(this).val("");
                                                            		   $('#dummyform').html("");
                                                            		   return;
                                                            	   }
                                                            	   rowon = v;
                                                            	   var str = "<tr id=menuheader align=center><th>件數</th><%=!CommonUtil.isNullOrEmpty(bo.getBoiOption1Name())?"<th>"+bo.getBoiOption1Name()+"</th>":""%> \
                                                            	           <%=!CommonUtil.isNullOrEmpty(bo.getBoiOption2Name())?"<th>"+bo.getBoiOption2Name()+"</th>":""%> \
                                                            			   <%=!CommonUtil.isNullOrEmpty(bo.getBoiOption3Name())?"<th>"+bo.getBoiOption3Name()+"</th>":""%> \
                                                            					   <th></th></tr>";
                                                            	   for (x = 0; x< v; x++){
                                                            		   str += '<tr id=menurow_'+ (x+1) +'><td align=center><input maxlength=2 size=2 id=\"qty_'+(x+1)+'\" name=\"qty_'+(x+1)+'\" class=\"menu_qty\"></td>\
                                                            		   <%=!CommonUtil.isNullOrEmpty(bo.getBoiOption1())?"<td align=center><select name=opt1_'+(x+1)+' id=opt1_'+(x+1)+'>"+HTMLRender.selectOptionRendering(bo.getBoiOption1(), ";")+"</select></td>":""%> \
                                                                       <%=!CommonUtil.isNullOrEmpty(bo.getBoiOption2())?"<td align=center><select name=opt2_'+(x+1)+' id=opt2_'+(x+1)+'>"+HTMLRender.selectOptionRendering(bo.getBoiOption2(), ";")+"</select></td>":""%> \
                                                                       <%=!CommonUtil.isNullOrEmpty(bo.getBoiOption3())?"<td align=center><select name=opt3_'+(x+1)+' id=opt3_'+(x+1)+'>"+HTMLRender.selectOptionRendering(bo.getBoiOption3(), ";")+"</select></td>":""%> \
                                                                    	<td><a href=javascript:removeRow('+x+')>x</a></td></tr>';
                                                            	   }
                                                                   var NewDialog = $('<div id="MenuDialog" style="font-size:85%">\
                                                                       <table width=100% id=dialogTable style=border-style:solid;border-width:1px;border-color:dddddd>'+str+'</table>\
                                                                   </div>');
                                                                   $('#dummyform').html(NewDialog);
                                                                   $(".menu_qty").keyup(function(){
                                                                	   var amount = 0;
                                                                	   $(".menu_qty").each(function(){
                                                                    	   if($(this).val()!=''){
                                                                    		   amount +=parseInt($(this).val()); 
                                                                    	   }
                                                                       });
                                                                	   if(amount > <%=SystemConstants.PUB_CART_BO_MAX_ITEM %>){
                                                                           var ToomuchDialog = $('<div id="MenuDialog" style="font-size:85%">\
                                                                                    如要大量購買, 請直接聯絡銷售部 : buybuymeat@gmail.com\
                                                                                    </div>'); 
                                                                           ToomuchDialog.dialog({
                                                                                modal: true,
                                                                                title: "大量購買"
                                                                           });
                                                                           //Reset all
                                                                           $('#qty').val("");
                                                                           $('#dummyform').html("");
                                                                           return;
                                                                       } else {
                                                                	    $('#qty').val(amount);
                                                                       }
                                                                   });
                                                                   if(rowon==0)
                                                                	   $('#menuheader').hide();
                                                                   return false;
                                                               });
                                                               
                                                               function removeRow(x){
                                                            	   $("#menurow_"+(x+1)).hide();
                                                            	   $('#qty').val($('#qty').val() - $("#qty_"+(x+1)).val());
                                                            	   $("#qty_"+(x+1)).val("");
                                                            	   rowon--;
                                                            	   if(rowon==0)
                                                            		   $('#menuheader').hide();
                                                               }
                                                               </script>
                                                               <div id=dummyform></div>
                                                                </td>
                                                                </tr>
                                                        <tr>
                                                            <td>
                                                                <button id="add-bulkorder1" class="add-bulkorder" ><%=MessageUtil.getV6Message(lang, "COUT_NOW")%></button>
                                                                <%-- Hidden checkout button 2013-09-18
                                                                <button id="checkout-submit3" class="checkout-submit" 
                                                                        <% if (CommonUtil.isNullOrEmpty(bulkOrderItem.getProdName())) {%>style="display:none"<%}%>><%=MessageUtil.getV6Message(lang, "COUT_NOW")%></button>
                                                                 <%-- --%> 
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div id="loading_gif" style="display:none"><img src="<%=staticPath%>/images/ajax-loader.gif"/></div>
                                                <div class="ui-widget" id="msg_added2" style="display:none">  <div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
                                                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                                        <%=MessageUtil.getV6Message(lang, "BO_MSG_ADDED")%>
                                                    </div>
                                                </div>
                                        </form>
                                        <div style="position:relative;height:150;">&nbsp;</div>                                                    
                                        <%-- Order Form End--%>
                                        <% } else { %>
                                        <div class="ui-widget">  <div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; margin-bottom:10px; padding: 0 .7em;"> 
                                                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                                            此團購已完結, 如已購買請留意換領日期及辦法。
                                        </div>
                                        </div>
                                        <div style="position:relative;height:150;">&nbsp;</div>
                                        <% }  %>
                                        </div>
                                        <br/>
                                        <div style="position:relative;background-color:#F3E2A9;font-size:132%;padding:3px"><h3>團購商品資訊</h3></div>
                                        <p><%=thisObj.getProd_desc()%></p>
                                    <% }%>
                                    <%--End of Bulk Order --%>
                                    </div>
                                    <br/>
                                     <div style="position:relative;background-color:#F3E2A9;font-size:132%;padding:3px"><h3>團購備註</h3></div>
                                        <p><%=bo.getBoiDescription()%></p>
                                    <% if (!isBO) {%>
                                    <button id="cart-submit1" class="cart-submit"><%=MessageUtil.getV6Message(lang, "PROD_ADD_CART")%></button>
                                    <button id="checkout-submit1" class="checkout-submit" style="display:none"><%=MessageUtil.getV6Message(lang, "COUT_NOW")%></button>
                                    <% } else {%>
                                    <br/>
                                     <div style="position:relative;background-color:#F3E2A9;font-size:132%;padding:3px"><h3>換領辦法</h3></div>
                                        <p><%=CommonUtil.isNullOrEmpty(bo.getBoiCollectionRemarks())?"--":bo.getBoiCollectionRemarks()%></p>
                                    <% }  %>
                                    <br class="clearfloat;"/>
                                    <!--// required  for IE padding bug //-->
                                    <br/>
                                    <br/>
                                    <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image1())) {%>
                                    <img src="<%=userImagePath + "raw_" + thisObj.getProd_image1()%>"/><br/><br/>
                                    <% }%>
                                    <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image2())) {%>
                                    <img src="<%=userImagePath + "raw_" + thisObj.getProd_image2()%>"/><br/><br/>
                                    <% }%>	
                                    <% if (!CommonUtil.isNullOrEmpty(thisObj.getProd_image3())) {%>
                                    <img src="<%=userImagePath + "raw_" + thisObj.getProd_image3()%>"/><br/><br/>
                                    <% }%>
                                    <br/>	
                                    <input type="hidden" id="guid" value="<%=thisObj.getSys_guid()%>"/>				
                                    <% if (!isBO) {%>
                                    <button id="cart-submit2" class="cart-submit"><%=MessageUtil.getV6Message(lang, "PROD_ADD_CART")%></button>
                                    <button id="checkout-submit2" class="checkout-submit" style="display:none"><%=MessageUtil.getV6Message(lang, "COUT_NOW")%></button>
                                    <%
                                        TreeMap<String, OrderSet> shoppingCart = (TreeMap<String, OrderSet>) request.getSession().getAttribute(SystemConstants.PUB_CART);
                                        if (shoppingCart != null && shoppingCart.size() > 0) {
                                    %>
                                    <script>$('.checkout-submit').show();</script>
                                    <% }%>
                                    <%} else {%>
                                    <% }%>
                                </div>
                                <div style="clear:both"></div>
                                <div style="float:right;" class="bulletLink"><a href="javascript:scroll(0,0)"><%=MessageUtil.getV6Message(lang, "BUT_TOP")%></a></div>
                            <%--    
                            <% if (!isBO) {%>
                            <div id="tabs-2">
                                <div style="float:right"><button id="enquiry-submit-top" class="enquiry_btn"><%=MessageUtil.getV6Message(lang, "PROD_ENQUIRY")%></button></div>
                                <br/>
                                <h3 style="font-size:128%" id="ENQ_PROD_NAME"></h3><br/><br/>
                                <div id="ENQ_PROD_INFO"></div>
                                <script>
                                    $('#ENQ_PROD_NAME').html($('#JS_PROD_NAME').html());
                                    $('#ENQ_PROD_INFO').html($('#JS_PROD_INFO').html());
                                </script>
                                <div id="enq_region"></div>
                                <script>
                                    $(function() {
                                        $.ajax({  
                                            url: "<%=request.getAttribute("contextPath")%>/do/PUBLIC?action=LISTENQ&guid=<%=thisObj.getSys_guid()%>&c="+new Date().getTime(),   
                                            type: "POST",  
                                            cache: false,  
                                            success: function (html) {                
                                                $("#enq_region").html(html);
                                            }         
                                        });  
                                    });
                                </script>
                                <% if (V6Util.isLogined(request)) {%>
                                <form action="" method="post" name="enq_form" id="enq_form">
                                    <input type="hidden" name="guid" value="<%=thisObj.getSys_guid()%>"/>
                                    <input type="hidden" name="enquiry_email" id="enquiry_email" value="<%=CommonUtil.null2Empty(me.getMem_login_email())%>"/><br/><br/>
                                    <%=MessageUtil.getV6Message(lang, "PROD_ENQUIRY_CONTENT")%><br/>
                                    <select id="ENQ_RESP_ID" name="enq_parent_id"><option value=""><%=MessageUtil.getV6Message(lang, "PROD_ENQ_NEW_TOPIC")%></option></select><br/>
                                    <textarea name="enquiry_content" id="enquiry_content" cols="40" row="7"></textarea><br/>
                                    <button id="enquiry-submit-bottom"><%=MessageUtil.getV6Message(lang, "PROD_ENQUIRY_SUBMIT")%></button>
                                </form>
                                <% }%>
                            </div>
                            <% }%>
                            --%>
                        </div>
			         </div>
                </div>
                <%--
<div id="ctnSidebar">
    <jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
</div>
                --%>
            </div>
            <div id="footer">
                <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
            </div>	
        </div>
        <div id="navMenu">
            <jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
        </div>
        <div id="loadform"></div>
        <iframe src="javascript:false" id="frameNavElement" ></iframe>
        <div id="heightTest"></div>
        <script>
            var isSet = false;
            $('#breadcrumb-tail').html('<li> &gt; </li><a href="#"><%=thisObj.getProd_name()%></a>');
         //   $('#breadcrumb-tail').attr("style","font-size:104%;line-height:1.8em;color:#000;padding-top:3px;");
            $(function() {
            <% if (isBO && CommonUtil.isNullOrEmpty(bulkOrderItem.getProdName())) {%>
                    $('#remarks')
                    .focus(function(){
                        if(!isSet ){
                            //alert($('#remarks').attr("style"));
                            $('#remarks').val("");
                            $('#remarks').attr("style","color:#000000");
                            isSet = true;
                        }
                    });
            <% }%>
                    $('#enquiry-submit-top')
                    .button()
                    .click(function() {
                        if(document.getElementById('enq_parent_id')!=null){
                            document.getElementById('enq_parent_id').value='';
                        }
                        if(document.getElementById('enquiry_content')!=null){
                            document.getElementById('enquiry_content').focus();
                        }	else {
                            self.location="<%=request.getAttribute("contextPath")%>/do/LOGIN?redirectURL=<%=java.net.URLEncoder.encode(request.getAttribute("contextPath") + "/" + thisMember.getMem_shopurl() + "/.do?v=" + thisObj.getSys_guid() + "&f=ture&tab=1", "UTF-8")%>";
                        }
                    });
                    $('#enquiry-submit-bottom')
                    .button()
                    .click(function(            ) {
                        $.ajax({  
                            url: "<%=request.getAttribute("contextPath")%>/<%=thisMember.getMem_shopurl()%>/.do?action=ADDENQ&c="+new Date().getTime(),   
                            type: "POST",  
                            data: $("#enq_form").serialize(),
                            cache: false,  
                            success: function (html) {                
                                $("#enq_region").html(html);
                            }         
                        });  
                        return false;
                    });
                    $('.cart-submit')
                    .button()
                    .click(function(            ) {
                        $.ajax({  
                            url: "<%=request.getAttribute("contextPath")%>/<%=thisMember.getMem_shopurl()%>/.do?action=ADDCART&guid="+ $('#guid').val()+"&c="+new Date().getTime(),   
                            type: "POST",  
                            cache: false,  
                            success: function (html) {                
                                $("#ctnSidebar").html(html);
                            }         
                        });  
                        $('.checkout-submit').show();
                        return false;
                    });
                    $('.enquiry_btn')
                    .button()
                    .click(function(){
                        return false;
                    });
                    
                    $('.checkout-submit')
                    .button()
                    .click(function(            ) {
                        self.location = "<%=(V6Util.isSSLOn() ? "https://" : "http://") + PropertiesConstants.get(PropertiesConstants.externalHost) + request.getAttribute("contextPath")%>/<%=thisMember.getMem_shopurl()%>/.do?action=CHECKOUT&<%=isBO ? "type=BO" : ""%>";
                        return false;
                    });
                    
                    $('.add-bulkorder')
                    .button()
                    .click(function() {
                    	var empty = false; //if no option, not empty
                        if(typeof($('#qty_1'))!=="undefined" && $('#qty_1')!=null) //if have option
                            empty = true;
                        for (x = 0; x < 3; x++){
//                        	alert((x+1) +$('#qty_'+ (x+1)) + ($('#qty_'+ (x+1))!=null));
//                        	alert((x+1)+"\""+$('#qty_'+ (x+1)).val()+"\""+ (typeof($('#qty_'+ (x+1)).val())==="undefined")+ ($('#qty_'+ (x+1)).val()!="")+ ($('#qty_'+ (x+1)).val()!="-1"));
                        	
                        	if(typeof($('#qty_'+ (x+1)).val())!=="undefined"){
                        		if($('#qty_'+ (x+1)).val()!="" && $('#qty_'+ (x+1)).val()!="-1")
                        		    empty = false;
                        	}
                        }
                        if(empty){
                            alert("請填上件數及選項");
                            return false;
                        }
                        $('#BO_ALREADY_EXIST').show();
                        $('.add-bulkorder').hide();
                        $('#loading_gif').show();
                        $.ajax({  
                            url: "<%=request.getAttribute("contextPath")%>/main/.do?action=ADDBO&c="+new Date().getTime(),   
                            type: "POST",  
                            data: $("#bo_form").serialize(),
                            cache: false,  
                            success: function (html) {                
                                $("#ctnSidebar").html(html);
                                //Redirect to checkout once the add-cart finished
                                self.location = "<%=(V6Util.isSSLOn() ? "https://" : "http://") + PropertiesConstants.get(PropertiesConstants.externalHost) + request.getAttribute("contextPath")%>/<%=thisMember.getMem_shopurl()%>/.do?action=CHECKOUT&<%=isBO ? "type=BO" : ""%>";
                            }         
                        });  
                        $('.checkout-submit').show();
                        return false;
                    });
                });
            
            //Ajax check if this sellitem is already in BOCART
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/main/.do?action=CHECKCART&guid=<%=thisObj.getSys_guid()%>&c="+new Date().getTime(),   
                type: "GET",  
                cache: false,  
                success: function (html) {
                    /* Fire ajax here to check if show / hide added msg **/
                    var contact;
                    if (typeof (JSON) == 'undefined')
                    	contact = eval(html);
                    else
                    	contact = JSON.parse(html);
                    if(typeof(contact.Options)!=="undefined" && contact.Options!=null){
                        $('#msg_added1').show(); 
                        $('#msg_added2').show();
                        var list1 = contact.Options;
                        var x = 0;
                        $('#qty').val(list1.length);
                        $('#qty').keyup();
                        for(i = 0; i < list1.length; i++){
                        	x+= eval(list1[i].qty);
                        	$('#qty_'+(i+1)).val(list1[i].qty);
                        	$('#opt1_'+(i+1)).val(list1[i].opt1);
                        	$('#opt2_'+(i+1)).val(list1[i].opt2);
                        	$('#opt3_'+(i+1)).val(list1[i].opt3);
                        }
                        
                    } 
                }         
            })
        </script>
    </body>
</html>

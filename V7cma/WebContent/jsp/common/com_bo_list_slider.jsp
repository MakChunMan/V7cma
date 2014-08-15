<%--
2013-11-14 This version is depreciated and replaced by com_bo_list_slider.jsp
included by tlp_sellitempage.jsp
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@include file="/init.jsp" %>
<!-- Slide for BO -->
<%
    ArrayList<BulkOrderItem> bo = PropertiesUtil.getBulkOrderList();
	//Collection<SellItem> newProds = bo.getSellItems();
%>
	<style>
	#demo-frame > div.bo_nav { padding: 10px !important; }
	div.bo_nav {margin: 4px 0px;}
	.scroll-pane { overflow: auto; width: 100%; float:left; background: none; }
	.scroll-content { width: <%=bo.size()*150%>px; float: left;}
	.scroll-content-item { background: none; width: 110px; float: left; margin: 3px; font-size: 3em; line-height: 96px; text-align: center; }
	* html .scroll-content-item { display: inline; } /* IE6 float double margin bug */
	.scroll-bar-wrap { clear: left; padding: 0 4px 0 2px; margin: 0 -1px -1px -1px; }
	.scroll-bar-wrap .ui-slider { background: none; border:0; height: 1.5em; margin: 0 auto; }
	.scroll-bar-wrap .ui-handle-helper-parent { position: relative; width: 100%; height: 100%; margin: 0 auto; }
	.scroll-bar-wrap .ui-slider-handle { top:.1em; height: 1.2em; background: none;}
	.scroll-bar-wrap .ui-slider-handle .ui-icon { margin: -8px auto 0; position: relative; top: 50%;}
	</style>
	<script>
	$(function() {
		//scrollpane parts
		var scrollPane = $( ".scroll-pane" ),
			scrollContent = $( ".scroll-content" );
		
		//build slider
		var scrollbar = $( ".scroll-bar" ).slider({
			slide: function( event, ui ) {
				if ( scrollContent.width() > scrollPane.width() ) {
					scrollContent.css( "margin-left", Math.round(
						ui.value / 100 * ( scrollPane.width() - scrollContent.width() )
					) + "px" );
				} else {
					scrollContent.css( "margin-left", 0 );
				}
			}
		});
		
		//append icon to handle
		var handleHelper = scrollbar.find( ".ui-slider-handle" )
		.mousedown(function() {
			scrollbar.width( handleHelper.width() );
		})
		.mouseup(function() {
			scrollbar.width( "100%" );
		})
		.append( "<span class='ui-icon ui-icon-grip-dotted-vertical'></span>" )
		.wrap( "<div class='ui-handle-helper-parent'></div>" ).parent();
		
		//change overflow to hidden now that slider handles the scrolling
		scrollPane.css( "overflow", "hidden" );
		
		//size scrollbar and handle proportionally to scroll distance
		function sizeScrollbar() {
			var remainder = scrollContent.width() - scrollPane.width();
			var proportion = remainder / scrollContent.width();
			var handleSize = scrollPane.width() - ( proportion * scrollPane.width() );
			scrollbar.find( ".ui-slider-handle" ).css({
				width: handleSize,
				"margin-left": -handleSize / 2,
				"background-color": "#dddddd"
			});
			
			handleHelper.width( "" ).width( scrollbar.width() - handleSize );
		}
		
		//reset slider value based on scroll content position
		function resetValue() {
			var remainder = scrollPane.width() - scrollContent.width();
			var leftVal = scrollContent.css( "margin-left" ) === "auto" ? 0 :
				parseInt( scrollContent.css( "margin-left" ) );
			var percentage = Math.round( leftVal / remainder * 100 );
			scrollbar.slider( "value", percentage );
		}
		
		//if the slider is 100% and window gets larger, reveal content
		function reflowContent() {
				var showing = scrollContent.width() + parseInt( scrollContent.css( "margin-left" ), 10 );
				var gap = scrollPane.width() - showing;
				if ( gap > 0 ) {
					scrollContent.css( "margin-left", parseInt( scrollContent.css( "margin-left" ), 10 ) + gap );
				}
		}
		
		//change handle position on window resize
		$( window ).resize(function() {
			resetValue();
			sizeScrollbar();
			reflowContent();
		});
		//init scrollbar size
		setTimeout( sizeScrollbar, 10 );//safari wants a timeout
	});
	</script>



<div class="bo_nav">
<div class="scroll-pane ui-widget ui-widget-header ui-corner-all">
	
	<div class="scroll-content">
		<div style="padding:10px">		<%=MessageUtil.getV6Message(lang,"BO_THIS") %></div>
		<% 
		Member thisShop = (Member)request.getSession().getAttribute(SystemConstants.PUB_SHOP_INFO);
		String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot)+ "/"+
			thisShop.getSys_guid() +"/";
		String prodDetailPath = contextPath+"/"+thisShop.getMem_shopurl()+"/.do?v=";
		
		BulkOrderItem tmpProd = null;
		String onPic = "style=\"border-color:#ddaaee;border-width:3px\"";
		boolean rowstarted = false;
		Iterator<BulkOrderItem> it = bo.iterator();
		while(it.hasNext()){
			tmpProd = (BulkOrderItem) it.next();
			
			out.println("<div class=\"scroll-content-item ui-widget-header\" "+ ((tmpProd.getSellitem().getSys_guid().equalsIgnoreCase(request.getParameter("v")))?
					onPic:"") + 
					"><a href=\""+ prodDetailPath+tmpProd.getSellitem().getSys_guid() + "&boid="+ tmpProd.getId() +"\">"+
					"<img src=\""+ userImagePath + "thm_"+ tmpProd.getSellitem().getProd_image1()+ "\" alt=\""+ tmpProd.getSellitem().getProd_name() +"\" width=\"110px\">"+
					"</a>"+
					"</div>");
		}
	%>
	</div>
	<% if(bo.size()>=6){ %>
	<div class="scroll-bar-wrap ui-widget-content ui-corner-bottom">
		<div class="scroll-bar"></div>
	</div>
	<% } %>
</div>
</div>
<div style="clear:both;position:relative;height:2px"></div>
--%>	
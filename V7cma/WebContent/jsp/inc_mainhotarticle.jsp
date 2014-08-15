<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.util.*"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>
<div id="main_hot_col1" ><%=MessageUtil.getV6Message(lang,"HOME_HOT_ARTI_LBL") %></div>
<div id="main_hot_col2">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr><td width="50%">
			<div style="padding: 2px"><a class="bulletLink" href="javascript:openArti(1)"><%=CommonUtil.subStringWithDots(CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI1"),"|")[0],18)%></a></div>
			</td>
			<td width="50%">
			<div style="padding: 2px"><a class="bulletLink" href="javascript:openArti(2)"><%=CommonUtil.subStringWithDots(CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI2"),"|")[0],18) %></a></div>
			</td>
		</tr>
		<tr><td>
			<div style="padding: 2px"><a class="bulletLink" href="javascript:openArti(3)"><%=CommonUtil.subStringWithDots(CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI3"),"|")[0],18) %></a></div>
			</td>
			<td>
			<div style="padding: 2px"><a class="bulletLink" href="javascript:openArti(4)"><%=CommonUtil.subStringWithDots(CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI4"),"|")[0],18) %></a></div>
			</td>
		</tr>		
	</table>
</div>
<div id="dialog-modal" title="" style="display:none;font-size:70%"></div>
				<script>
					var currentOpenArti = -1;
					function openArti(i){
						var url = new Array();
						var title = new Array();
						var mode = new Array();
						var prefix = "<%=CommonUtil.getHttpProtocal(request)+ PropertiesConstants.get(PropertiesConstants.externalHost)%>";
						url[1] = prefix+ "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI1"),"|")[1]%>";
						url[2] = prefix+ "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI2"),"|")[1]%>";
						url[3] = prefix+ "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI3"),"|")[1]%>";
						url[4] = prefix+ "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI4"),"|")[1]%>";
						title[1] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI1"),"|")[0]%>";
						title[2] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI2"),"|")[0]%>";
						title[3] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI3"),"|")[0]%>";
						title[4] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI4"),"|")[0]%>";
						mode[1] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI1"),"|")[2]%>";mode[2] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI2"),"|")[2]%>";
						mode[3] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI3"),"|")[2]%>";mode[4] = "<%=CommonUtil.stringTokenize(MessageUtil.getV6Message(lang,"HOME_ARTI4"),"|")[2]%>";
						
						
						if(mode[i]=="AJ"){
							if(i != currentOpenArti || $('#dialog-modal').html()==""){
								//ajax
								$("#dialog-modal" ).dialog( "destroy" );
								$('#dialog-modal').attr("title",title[i]);
								$.ajax({  
						             url: url[i]+"?PAJ=1",
						             type: "POST",  
						             cache: false,  
						             success: function (html) {
						            	 $('#dialog-modal').html(html);
						            	 $("#dialog-modal" ).dialog({
												height: 280, width: 740, modal: true
											});
						             },
						             error: function (objRquest){
						            	 $('#dialog-modal').html("Loading article error.");
						            	 currentOpenArti = -1;
						             }         
					    	     });  
							} else {
								$( "#dialog-modal" ).dialog({
									height: 280, width: 740, modal: true
								});
							}
						} else {
							self.location= url[i];
						}			
						currentOpenArti = i;
					}
				</script>
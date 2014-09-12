<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.constants.*"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%--
2014-08-15 - Remove Shop URL for Mobile enhancement
2014-08-25 - Add Package Type
 --%>
<% 
String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG);
if(CommonUtil.isNullOrEmpty((String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))){
	boolean isCheckoutReg = "checkout".equalsIgnoreCase((String)request.getAttribute("regtype"));
Member aMember = (Member)request.getAttribute("formUser");
if(aMember==null) aMember = new Member();
%>
<form id="reg-form" action="" method="post">
<input type="hidden" name="action" value="AJ_REG"/>
<% if(isCheckoutReg){ %>
<input type="hidden" name="regtype" value="checkout"/>
<input type="hidden" name="redirectURL" value="<%=CommonUtil.null2Empty(request.getAttribute("redirectURL")) %>"/>
<% } %>
							<div class="ui-widget"><div id="formerr">
								<jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
							</div>

							<table width="100%" class="tbl_form">
								<colgroup>
									<col width="20%"  />
									<col width="*"  />
								</colgroup>
								<thead>
								<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"PRF_INFO") %></th></tr>
								</thead>
								<tbody>
								<%-- 2014-08-15
								<% if(!isCheckoutReg){ %>
								<tr>
									<td><label for="username"><%=MessageUtil.getV6Message(lang,"PRF_SHOP_URL")%></label></td>
									<td><input type="text" name="REG_SHOPURL" id="REG_SHOPURL" maxLength="25" value="<%=CommonUtil.null2Empty(aMember.getMem_shopurl()) %>" class="text">
									<br/><span style="font-size: 85%">http://www.buybuymeat.net/&lt;&lt;<%=MessageUtil.getV6Message(lang,"PRF_YR_URL_LABEL") %>&gt;&gt;</span>
									</td>
								</tr>
								<% } %>
								 --%>
								<tr>
									<td><label for="REG_MEM_EMAIL"><%=MessageUtil.getV6Message(lang,"PRF_EMAIL")%></label><br/><%=MessageUtil.getV6Message(lang,"PRF_EMAIL_DESC")%></td>
									<td><input type="text" name="REG_MEM_EMAIL" id="REG_MEM_EMAIL" maxLength="25" value="<%=CommonUtil.null2Empty(aMember.getMem_login_email()) %>" class="text"></td>
								</tr>								
								<tr>
									<td><label for="REM_MEM_PASSWD"><%=MessageUtil.getV6Message(lang,"PRF_PASSWORD") %></label></td>
									<td><input type="password" name="REM_MEM_PASSWD" id="REM_MEM_PASSWD" maxLength="25" value="" class="text"></td>
								</tr>								
								<tr>
									<td><label for="REM_MEM_CPASSWD"><%=MessageUtil.getV6Message(lang,"PRF_PWD_NEW2") %></label></td>
									<td><input type="password" name="REM_MEM_CPASSWD" id="REM_MEM_CPASSWD" maxLength="25" value="" class="text"></td>
								</tr>								
								</tbody>
							</table>
							
							<br/>
							<table width="100%" class="tbl_form">
								<colgroup>
									<col width="20%"  />
									<col width="*"  />
								</colgroup>

								<thead>
								<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"PRF_CONTACT")%></th></tr>
								</thead>
								<tbody>
								<tr>
									<td><label for="REG_MEM_FIRSTNAME"><%=MessageUtil.getV6Message(lang,"COUT_BFIRSTNAME")%></label></td>
									<td><input type="text" name="REG_MEM_FIRSTNAME" id="REG_MEM_FIRSTNAME" maxLength="25" size="10" value="<%=CommonUtil.null2Empty(aMember.getMem_firstname()) %>" class="text"></td>
								</tr>
								<tr>
									<td><label for="REG_MEM_LASTNAME"><%=MessageUtil.getV6Message(lang,"COUT_BLASTNAME")%></label></td>
									<td><input type="text" name="REG_MEM_LASTNAME" id="REG_MEM_LASTNAME" maxLength="25" size="10" value="<%=CommonUtil.null2Empty(aMember.getMem_lastname()) %>" class="text"></td>
								</tr>
								</tbody>
							</table>	
							<% if(!isCheckoutReg){ %>				
							<table width="100%" class="tbl_form">
								<colgroup>
									<col width="20%"  />
									<col width="*"  />
								</colgroup>

								<thead>
								<tr><th colspan="2"><%=MessageUtil.getV6Message(lang,"PRF_SHOP_INFO")%></th></tr>
								</thead>
								<tbody>
								<tr>
									<td><label for="REG_SHOPNAME"><%=MessageUtil.getV6Message(lang,"PRF_SHOP_NAME")%></label></td>
									<td><input type="text" name="REG_SHOPNAME" id="REG_SHOPNAME" maxLength="25" value="<%=CommonUtil.null2Empty(aMember.getMem_shopname()) %>" class="text"></td>
								</tr>
								</tbody>
							</table>				
                            <table width="100%" class="tbl_form">
                                <colgroup>
                                    <col width="20%"  />
                                    <col width="*"  />
                                </colgroup>

                                <thead>
                                <tr><th colspan="2"></th></tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><label for="REG_SHOPNAME"><%=MessageUtil.getV6Message(lang,"PRF_SHOP_NAME")%></label></td>
                                    <td>
                                        <SELECT name="PACKAGE_TYPE" id="PACKAGE_TYPE">
                                                <OPTION value="<%=V7Constant.PACKAGE_TYPECODE_FreeExtLink%>">【免費】50 商品 （外部連結﹚</OPTION>
                                                <OPTION value="<%=V7Constant.PACKAGE_TYPECODE_FreeUpload%>">【免費】20 商品 （站內上載﹚</OPTION>
                                                <OPTION value="<%=V7Constant.PACKAGE_TYPECODE_Basic%>">【VIP商店】500 商品 （站內上載﹚- 月費HKD100 或年費HKD960</OPTION>
                                                <OPTION value="<%=V7Constant.PACKAGE_TYPECODE_Standalone%>">【獨立商店】1500商品 - 獨立商店手機應用程式 - 年費HKD960 及 Google及IOS上架費HKD3200</OPTION>
                                        </SELECT>
                                        <script>
                                        $('#PACKAGE_TYPE').val("<%=CommonUtil.null2Empty(aMember.getPackage_type())%>");
                                        </script>
                                        <br/>
                                        <a href="javascript:void()" id="lnk_detailcompare">詳細比較</a>
                                    </td>
                                </tr>
                                </tbody>
                            </table>							
							<% } %>		
							<table>
							<tr><td></td><td><img id="captcha" src="/captcha.jsp?c=<%=(new java.util.Date()).getTime() %>"/>
							<input size="10" name="captcha"/>&nbsp;<font color="#999999"><%=MessageUtil.getV6Message(lang,"REG_CAPTCHA_MSG") %></font>
							</td></tr>
							</table>	
							<button id="reg-submit"><%=MessageUtil.getV6Message(lang,"BUT_SUBMIT")%></button>	
</form>
<script>
$(function() {
	$('#reg-submit')
			.button()
			.click(function() {
				//AJAX form submit
				$.ajax({  
		             url: "<%=request.getAttribute("contextPath") %>/do/LOGIN?c="+new Date().getTime(),   
		             type: "POST",  
		             data: $("#reg-form").serialize(),       
		             cache: false,  
		             success: function (html) {                
	                 //if process.php returned 1/true (send mail success)
		            	 $('#reg-form-region').html(html);
		             }         
	    	     });  
				return false;
			});
});
</script>			
<% } else { %>
			<div class="ui-widget">
				<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
					<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
					<%=(String)request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG) %>
					</p>
				</div>
			</div>
<% } %>			
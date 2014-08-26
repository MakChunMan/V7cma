<%----
2014-08-27 Add Mobile shop - product mgmt link 
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.ArrayList" %>
<% String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);%>
<% String staticPath = PropertiesConstants.get(PropertiesConstants.staticContextRoot);
    String tmpImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";

    Member loginMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
%>

<script type="text/javascript" src="<%=staticPath%>/js/ajaxupload.js"></script>

<style id="styles" type="text/css">
    .wrapper { width: 500px; margin: 0 auto; }
    div.button {
        border: solid 2px Transparent;
        border-color: #eeeeee;
        height:128px;	
        width: 128px;
        background: url(<%=staticPath%>/images/pictures.png) 0 0;
    }
    div.button.hover {
        border-color: #aaaaaa;
        cursor: pointer;	
    }

    div.button.loading {
        background: url(<%=staticPath%>/images/ajax-loader.gif) 0 0 no-repeat;
    }
</style>
<% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%=(String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
    </div>
</div>
<br/>
<% } else if (request.getAttribute("unfeedback") != null) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%
            ArrayList<String> aL = new ArrayList<String>();
            aL.add((String) request.getAttribute("unfeedback"));
            out.println(MessageUtil.getV6Message(lang, "TXT_UNCOMMENT_COUNT", aL));
        %>
    </div>
</div>
<br/>
<% }%>
<% if (CommonUtil.null2Empty(request.getAttribute("action")).equalsIgnoreCase("")
            && !(CommonUtil.isNullOrEmpty(loginMember.getMem_firstname()) && CommonUtil.isNullOrEmpty(loginMember.getMem_lastname()))) {%> 
<p><%=MessageUtil.getV6Message(lang, "PRF_MAIN_WELCOME")%><br/>
    <br/>
    <%=MessageUtil.getV6Message(lang, "PRF_MAIN_CHOOSE")%>
<ul>
    <% if (V6Util.isMainsiteLogin(loginMember)) {%>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/CAT"><%=MessageUtil.getV6Message(lang, "TIT_CAT")%></a></li>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/PROD"><%=MessageUtil.getV6Message(lang, "TIT_PROD")%></a></li>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/ARTI"><%=MessageUtil.getV6Message(lang, "TIT_ARTICLE")%></a></li>
    <li class="bulletLink"><a href='javascript: $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/jsp/admin/update_sitemap.jsp",   
                type: "GET",  
                cache: false,  
                success: function (html) {
                    alert("已更新"+html + "項連結");                
                }         
            });  '>更新Sitemap</a></li>
    <% }%>
    <% if(CommonUtil.isNullOrEmpty(loginMember.getPackage_type())){ %>
    <%-- 2014-08-27 Mobile shop --%>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/PROD?type=mobile"><%=MessageUtil.getV6Message(lang, "TIT_PROD")%></a></li>
    <% }  %>    
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/ENQ"><%=MessageUtil.getV6Message(lang, "TIT_MSGMGMT")%></a></li>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/TXN"><%=MessageUtil.getV6Message(lang, "TIT_ORDERRECORD")%></a></li>
    <%--<li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/TXN?action=CA_LIST"><%=MessageUtil.getV6Message(lang, "TIT_BALANCE")%></a></li>--%>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/PROFILE?action=EDIT"><%=MessageUtil.getV6Message(lang, "TIT_PROFILE")%></a></li>
    <% if (ACLUtil.isValid(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(), ACLUtil.BNR01)) {%>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/BNR"><%=MessageUtil.getV6Message(lang, "TIT_BANNER")%></a></li>
    <% }%>
    <% if (ACLUtil.isValid(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(), ACLUtil.BOE01)) {%>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/BO"><%=MessageUtil.getV6Message(lang, "TIT_BO_ADMIN")%></a></li>
    <% }%>
    <%-- 2013-09-03 Bank Transfer Receipt Admin Page is merged to Sell Records Page in Mainsite Account --%>
    <%-- if (V6Util.isMainsiteLogin(loginMember)) {%>
    <li class="bulletLink"><a href="<%=request.getAttribute("contextPath")%>/do/TXN?action=BS_LIST"><%=MessageUtil.getV6Message(lang, "TIT_BS_ADMIN")%></a></li>
    <% }--%>
</ul>

</p>
<% } else {
    SiteResponse sR = (SiteResponse) request.getAttribute(SystemConstants.REQ_ATTR_RESPOSNE);
    Member thisUser = null;

    if (sR.hasError()) {
        thisUser = (Member) (request.getAttribute("retainMember"));
    }
    if (thisUser == null) {
        thisUser = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    }
%>
<form id="profile-form">
    <div class="ui-widget"><div id="formerr">
            <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
        </div>
    <% if (CommonUtil.isNullOrEmpty(loginMember.getMem_firstname()) && CommonUtil.isNullOrEmpty(loginMember.getMem_lastname())) {%>
    <div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
            <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <%=MessageUtil.getV6Message(lang, "PRF_DETAILS_MSG")%>
        </div>
    </div>
    <% }%>
    <table width="100%" class="tbl_form">
        <colgroup>
            <col width="15%"  />
            <col width="*"  />
        </colgroup>

        <thead>
            <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "PRF_INFO")%></th></tr>
        </thead>
        <tbody>
            <tr><td><%=MessageUtil.getV6Message(lang, "PRF_EMAIL")%></td><td><%=loginMember.getMem_login_email()%></td></tr>
            <% if (CommonUtil.isNullOrEmpty(loginMember.getMem_firstname()) && CommonUtil.isNullOrEmpty(loginMember.getMem_lastname())) {%>
            <tr><td><%=MessageUtil.getV6Message(lang, "COUT_BNAME")%></td>
                <td>
                    <table class="tbl_transparent">
                        <tr><td>
                                <%=MessageUtil.getV6Message(lang, "COUT_BFIRSTNAME")%> <input type="text" name="MEM_FIRSTNAME" size="3" value="<%=CommonUtil.null2Empty(thisUser.getMem_firstname())%>"/> 
                                <%=MessageUtil.getV6Message(lang, "COUT_BLASTNAME")%><input type="text" name="MEM_LASTNAME" size="3" value="<%=CommonUtil.null2Empty(thisUser.getMem_lastname())%>"/>
                                &nbsp;&nbsp;<%=MessageUtil.getV6Message(lang, "PRF_SAL")%><SELECT name="MEM_SALUTATION" id="MEM_SALUTATION">
                                    <option value="0"><%=MessageUtil.getV6Message(lang, "PRF_SAL_MR")%></option>
                                    <option value="1"><%=MessageUtil.getV6Message(lang, "PRF_SAL_MRS")%></option>
                                    <option value="2"><%=MessageUtil.getV6Message(lang, "PRF_SAL_MS")%></option>
                                    <option value="3"><%=MessageUtil.getV6Message(lang, "PRF_SAL_DR")%></option>
                                </SELECT>
                                <script>
                                    $('#MEM_SALUTATION').val("<%=CommonUtil.null2Empty(thisUser.getMem_salutation())%>");
                                </script>
                            </td></tr>
                        <tr><td>
                                <%=MessageUtil.getV6Message(lang, "COUT_NAME_DISP_ORDER")%> <SELECT name="MEM_FULLNAME_DISPLAY_TYPE" id="MEM_FULLNAME_DISPLAY_TYPE">
                                    <OPTION value="<%=Member.FULLNAME_DISP_FIRSTLAST%>"><%=MessageUtil.getV6Message(lang, "COUT_BFIRSTNAME")%> <%=MessageUtil.getV6Message(lang, "COUT_BLASTNAME")%></OPTION>
                                    <OPTION value="<%=Member.FULLNAME_DISP_FIRSTLAST_COMMA%>"><%=MessageUtil.getV6Message(lang, "COUT_BFIRSTNAME")%>, <%=MessageUtil.getV6Message(lang, "COUT_BLASTNAME")%></OPTION>
                                    <OPTION value="<%=Member.FULLNAME_DISP_LASTFIRST%>"><%=MessageUtil.getV6Message(lang, "COUT_BLASTNAME")%> <%=MessageUtil.getV6Message(lang, "COUT_BFIRSTNAME")%></OPTION>
                                    <OPTION value="<%=Member.FULLNAME_DISP_LASTFIRST_COMMA%>"><%=MessageUtil.getV6Message(lang, "COUT_BLASTNAME")%>, <%=MessageUtil.getV6Message(lang, "COUT_BFIRSTNAME")%></OPTION>
                                </SELECT> <STRONG><SPAN id="FULLNAME_DISP"></SPAN></STRONG>
                                <script>
                                    $('#MEM_FULLNAME_DISPLAY_TYPE').val("<%=CommonUtil.null2Empty(thisUser.getMem_fullname_display_type())%>");
                                </script>
                            </td></tr>
                        <tr><td>
                                <%=MessageUtil.getV6Message(lang, "COUT_DISP_NAME")%> <input name="MEM_DISPLAY_NAME" maxlength="30" value="<%=CommonUtil.null2Empty(thisUser.getMem_display_name())%>" size="25"/>&nbsp;
                                <%=MessageUtil.getV6Message(lang, "COUT_DISP_NAME_MSG")%>
                            </td></tr></table>
                </td></tr>
                <% } else {%>
            <tr><td><%=MessageUtil.getV6Message(lang, "COUT_BNAME")%></td><td><%=Member.getFullName(thisUser)%></td></tr>
            <tr><td><%=MessageUtil.getV6Message(lang, "COUT_DISP_NAME")%></td><td><%=thisUser.getMem_display_name()%></td></tr>
            <% }%>

            <tr valign="top">
                <td><%=MessageUtil.getV6Message(lang, "PRF_PASSWORD")%></td>
                <td><input type="checkbox" id="CHANGE_PWD" name="CHANGE_PWD" onclick="changePwd(this);" value="CHANGE_PWD"/><%=MessageUtil.getV6Message(lang, "PRF_PWD_MSG")%>
                    <span id="C_PWD_REGION" style="display:none">
                        <br/><br/>
                        <table class="tbl_transparent">
                            <tr><td><%=MessageUtil.getV6Message(lang, "PRF_PWD_NEW")%></td><td><input type="password" name="NEW_PWD" id="NEW_PWD"/></td></tr>
                            <tr><td><%=MessageUtil.getV6Message(lang, "PRF_PWD_NEW2")%></td><td><input type="password" name="CNEW_PWD" id="CNEW_PWD"/></td></tr>
                        </table>
                    </span>
                    <script>
                        function changePwd(obj){
                            var region = document.getElementById('C_PWD_REGION');
                            if(obj.checked){
                                region.style.display="";
                                document.getElementById('NEW_PWD').disabled = false;
                                document.getElementById('CNEW_PWD').disabled = false;
                            } else {
                                region.style.display="none";
                                document.getElementById('NEW_PWD').disabled = true;
                                document.getElementById('CNEW_PWD').disabled = true;
                            }
                        }
                    </script>
                </td></tr>
        </tbody>
    </table>
    <br/>
    <h3><%=MessageUtil.getV6Message(lang, "PRF_ADDR_INFO")%></h3>
    <br/>
    <table width="100%" class="tbl_form">
        <colgroup>
            <col width="7%"  />
            <col width="5%"/>
            <col width="20"  />
            <col width="20"  />
            <col width="15"  />
            <col width="20"  />
        </colgroup>

        <thead>
            <tr>
                <th>預設</th>
                <th>#</th>
                 <th>收件人</th>
                 <th>國家 / 地區</th>
                 <th>住區</th>
                 <th>地址</th>
            </tr>
        </thead>
        <tbody>
        <%
            Iterator it = ((List)request.getAttribute("ADDR_LIST")).iterator();
            //out.println(thisUser.getMemAddress().size());
            int x= 0;
            MemAddress addrTmp = null;
            while(it.hasNext()){
                x++;
                addrTmp = (MemAddress)it.next();
            %>
               <tr>
                   <input type="hidden" name="addr_id_<%=x%>" value="<%=addrTmp.getId()%>"/>
                <td><input type="radio" name="addr_default" value="<%=x%>" <%=addrTmp.isIsdefault()?"checked":""%>/></td><td><%=x%></td>
                <td><input name="addr_name_<%=x%>" value="<%=addrTmp.getAttention_name()%>"/></td>
                <td><select name="addr_country_<%=x%>" id="addr_country_<%=x%>" addr_no="<%=x%>">
                        <option/><%=MessageUtil.getV6Message(lang, "SYS_REG_COUNTRY")%>
                    </select>
                    <script>$('#addr_country_<%=x%>').val("<%=addrTmp.getCountryplace()%>");</script>
                </td>
                <td>
                    <input type="text" name="addr_district_txt_<%=x%>" id="addr_district_txt_<%=x%>" size="5" value="<%=addrTmp.getRegion()%>"/>
                    <script>
                        $('#addr_district_<%=x%>').val("<%=addrTmp.getRegion()%>");
                    </script>
                </td>
                <td>
                    <input type="text" name="addr_line1_<%=x%>" size="28" value="<%=addrTmp.getAddr_line1()%>"/><br/><input type="text" name="addr_line2_<%=x%>" size="28" value="<%=addrTmp.getAddr_line2()%>"/>
                </td>
            </tr>
            <% }
                  for (int y= (x+1); y<=3 ; y++){%>
                      <tr>
                <td><input type="radio" name="addr_default" value="<%=y%>"/></td><td><%=y%></td>
                <td><input name="addr_name_<%=y%>" value=""/></td>
                <td><select name="addr_country_<%=y%>" id="addr_country_<%=y%>" addr_no="<%=y%>">
                        <option/><%=MessageUtil.getV6Message(lang, "SYS_REG_COUNTRY")%>
                    </select>
                </td>
                <td>
                    <input type="text" name="addr_district_txt_<%=y%>" id="addr_district_txt_<%=y%>" size="5"/>
                </td>
                <td>
                    <input type="text" name="addr_line1_<%=y%>" size="28"/><br/><input type="text" name="addr_line2_<%=y%>" size="28"/>
                </td>
            </tr>
            <%

            } %>
        </tbody>
    </table>
        
    <div <%=V6Util.isMainsiteLogin(loginMember) ? "" : "style=\"display:none\""%>>		
        <input type=checkbox id="SHOP_INFO" onClick="changeShopinfo();"/><%=MessageUtil.getV6Message(lang, "PRF_SHOP_INFO")%>
    </div>
    <br/>
    <div id="shopinfo_region" style="display:none"	>	
        <table width="100%" class="tbl_form">
            <colgroup>
                <col width="15%"  />
                <col width="*"  />
            </colgroup>
            <thead>
                <tr><th colspan="2"><%=MessageUtil.getV6Message(lang, "PRF_SHOP_INFO")%></th></tr>
            </thead>
            <tbody>
                <tr><td><%=MessageUtil.getV6Message(lang, "PRF_SHOP_NAME")%></td><td>
                        <% if (CommonUtil.isNullOrEmpty(loginMember.getMem_shopname())) {%>
                        <input type="text" name="MEM_SHOPNAME" size="50" maxlength="50" value="<%=CommonUtil.null2Empty(thisUser.getMem_shopname())%>"/>
                        <% } else {%>
                        <%=loginMember.getMem_shopname()%>
                        <input type="hidden" name="MEM_SHOPNAME" value="<%=loginMember.getMem_shopname()%>"/>
                        <% }%>
                    </td></tr>
                <tr><td><%=MessageUtil.getV6Message(lang, "PRF_SHOP_URL")%></td><td>
                        <% if (CommonUtil.isNullOrEmpty(loginMember.getMem_shopurl())) {%>
                        <input type="text" name="MEM_SHOPURL" size="20" maxlength="50" value="<%=thisUser.getMem_shopurl()%>"/>
                        <% } else {%>
                        <%=loginMember.getMem_shopurl()%>
                        <% }%>
                    </td></tr>
                    <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute("ARTI_LIST"))) {%>
                <tr><td><%=MessageUtil.getV6Message(lang, "PRF_MAIN_CONTENT")%></td><td><SELECT name="MEM_SHOP_HP_ARTI" id="MEM_SHOP_HP_ARTI">
                            <option value=""><%=MessageUtil.getV6Message(lang, "COMMON_CHOOSE")%></option>
                            <%=request.getAttribute("ARTI_LIST")%></SELECT>
                            <% if (!CommonUtil.isNullOrEmpty(thisUser.getMem_shop_hp_arti())) {%>
                        <script>
    $('#MEM_SHOP_HP_ARTI').val("<%=thisUser.getMem_shop_hp_arti()%>");
                        </script>
                        <% }%>
                    </td></tr>
                    <% }%>
                <tr><td><%=MessageUtil.getV6Message(lang, "PRF_MAIN_BANNER")%></td><td>
                        <%=MessageUtil.getV6Message(lang, "PRF_MAIN_BANNER_MSG")%><br/><br/>
                        <div class="wrapper" id="button1_region"><div id="button1" class="button" style="border:1px solid #ccc"></div></div>
                        <input type="hidden" name="BANNER_IMAGE_1" id="BANNER_button1"/><br/><br/></td></tr>
            </tbody>
        </table>
    </div>
</form>
<button id="profile-submit"><%=MessageUtil.getV6Message(lang, "BUT_SUBMIT")%></button>	
<button id="profile-back"><%=MessageUtil.getV6Message(lang, "BUT_BACK")%></button>
<script type="text/javascript">
    jQuery.fn.exists = function(){return jQuery(this).length>0;}
    <% if (!CommonUtil.isNullOrEmpty(thisUser.getMem_shopbanner())) {%>
    document.getElementById("BANNER_button1").value = "<%=thisUser.getMem_shopbanner()%>";
    document.getElementById("button1").style.background = "url(<%=tmpImagePath%><%=thisUser.getMem_shopbanner()%>)";
    document.getElementById("button1").style.backgroundRepeat = "no-repeat";
    $('#button1').height(190);
    $('#button1').width(500);
    <%}%>
</script>
<script>
    function changeShopinfo(){
        if($("#SHOP_INFO").attr('checked')){
            $('#shopinfo_region').show();
        } else {
            $('#shopinfo_region').hide();
        }
    }

    $(function() {
        $('#profile-submit')
        .button()
        .click(function() {
            changePwd(document.getElementById('CHANGE_PWD'));
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROFILE?action=SAVE&c="+new Date().getTime(),   
                type: "POST",  
                data: $("#profile-form").serialize(),       
                cache: false,  
                success: function (html) {                
                    $("#profile-region").html(html);
                }         
            });  
            return false;
        });
    });

    $(function() {
        $('#profile-back')
        .button()
        .click(function() {
            self.location="<%=request.getAttribute("contextPath")%>/do/PROFILE";  
            return false;
        });
    });

    function initAjaxUpload(obj,filename1){
        return new AjaxUpload(
        obj,{
            action: '<%=staticPath%>/upload-banr-handler.php?guid=<%=thisUser.getSys_guid()%>', 
            name: 'userfile',
            onSubmit : function(file, ext){
                if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))){
                    alert('Error: invalid file extension');
                    return false;
                }
                document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/ajax-loader.gif)";
                document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
                this.disable();
            },
            onComplete: function(file, response){
                // enable upload button
                if(response.indexOf("success")==0){
                    response = response.replace("success:","");
                    $('#errmsg'+filename1).remove();
                    document.getElementById("BANNER_"+filename1).value = response;
                    document.getElementById(filename1).style.background = "url(<%=tmpImagePath%>"+response+")";
                    document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
                } else {
                    if ($('#errmsg'+filename1).exists()) {
                        $('#errmsg'+filename1).replaceWith('<li id="errmsg1"><font color="red">'+response+'</font></li>');
                    } 
                    document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/pictures.png)";
                }
                this.enable();
            }
        }
    );
    }
    $(document).ready(function(){
        /* Example 1 */
        var button1 = $('#button1'), interval;
        initAjaxUpload(button1,"button1");
    });
</script>
<% }%>

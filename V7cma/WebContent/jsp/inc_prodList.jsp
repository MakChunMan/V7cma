<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.domain.SellItem" %>
<%@ page import="java.util.*" %>
<% String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);%>
<% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG))) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <%=(String) request.getAttribute(SystemConstants.REQ_ATTR_DONE_MSG)%>
        <% if (request.getAttribute("THIS_OBJ") != null) {
                SellItem itm = (SellItem) request.getAttribute("THIS_OBJ");
        %>
        <!-- Close current tab / Refresh tab 1 when action done -->
        <script>
            var selected = $("#tabs").tabs( "option", "selected" );
            $("#tabs").tabs("select",1);
            $("#tabs").tabs('remove', selected);
            tabCount--;
						
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROD?action=LISTAJ&c="+new Date().getTime()+"&CAT_GUID=<%=itm.getProd_cate_guid()%>",   
                type: "POST",  
                cache: false,  
                success: function (html) {                
                    $('#prod_list').html(html); //Refersh product list in tab 1 with modified category
                }         
            });
        </script>
        <%}%>
    </div>
</div>
<br/>
<%}%>
<div class="ui-widget"><div id="formerr">
        <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div></div>
        <%
            List objList = (List) request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
        %>
<table id="prodtab" width="100%  class="tbl_form">    
       <% if (objList != null && objList.size() > 0) {%>		
       <%
           Iterator it = objList.iterator();
           SellItem tmpObj = null;
           while (it.hasNext()) {
               tmpObj = (SellItem) it.next();
               out.println("<tr id=\"" + tmpObj.getSys_guid() + "\">");
               if (!CommonUtil.isNullOrEmpty(tmpObj.getProd_image1())) {
                   String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/"
                           + tmpObj.getProd_owner() + "/thm_" + tmpObj.getProd_image1();%>
       <td><img src="<%=userImagePath%>" height="28"></img></td>
        <% }%>            
    <td><%=tmpObj.getProd_name()%></td>
    <td>
        <a href="#" alt="<%=MessageUtil.getV6Message(lang, "BUT_EDIT")%>" class="a_pencil ui-icon-pencil" name="<%=tmpObj.getSys_guid()%>" prodname="<%=tmpObj.getProd_name()%>">
            <span><%=MessageUtil.getV6Message(lang, "BUT_EDIT")%></span></a>			
        <a href="#" alt="<%=MessageUtil.getV6Message(lang, "BUT_COPY")%>" class="a_copy ui-icon-copy" name="<%=tmpObj.getSys_guid()%>" prodname="<%=tmpObj.getProd_name()%>">
            <span><%=MessageUtil.getV6Message(lang, "BUT_COPY")%></span></a>				
        <a href="#" alt="<%=MessageUtil.getV6Message(lang, "BUT_DEL")%>" class="a_closethick ui-icon-closethick" name="<%=tmpObj.getSys_guid()%>" prodname="<%=tmpObj.getProd_name()%>">
            <span><%=MessageUtil.getV6Message(lang, "BUT_DEL")%></span></a>	
        <a href="#" class="up">Up</a>
        <a href="#" class="down">Down</a>
    </td>
</tr>

<%
    }
} else if (objList == null || objList.size() == 0) {%>
<div class="ui-widget">	<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
        <% if (!CommonUtil.isNullOrEmpty((String) request.getAttribute("CAT_GUID"))
                    && !((String) request.getAttribute("CAT_GUID")).equalsIgnoreCase("-1")) {%><%=MessageUtil.getV6Message(lang, "PROD_NO_FOUND")%>
        <%} else {%><%=MessageUtil.getV6Message(lang, "PROD_CHOOSE_CAT")%>
        <%}%>
    </div></div>
    <%}%>	
</table>
<% if (!CommonUtil.isNullOrEmpty(
            (String) request.getAttribute("CAT_GUID"))) {%>
<script>
    $('#CAT_GUID').val("<%=request.getAttribute("CAT_GUID")%>");
    //document.getElementById('CAT_GUID').value="<%=request.getAttribute("CAT_GUID")%>";
</script>
<% }%>

<script type="text/javascript">
    $(function() {
        $('#add-prod')
        .button()
        .click(function() {
            if(tabCount+1 > tabMax){
                //alert("<%=MessageUtil.getV6Message(lang, "PROD_CLOSE_TAB")%>");
                return false;
            }
            tabCount++;
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROD?action=ADDAJ&c="+new Date().getTime()+"&tabidx="+tabCount,   
                type: "POST",  
                cache: false,  
                success: function (html) {                
                    $('#tabs-'+tabCount).html(html);
                }         
            });
            $("#tabs").tabs("add",'#tabs-'+tabCount,"<%=MessageUtil.getV6Message(lang, "BUT_ADD")%>...");
            $("#tabs").tabs("select",tabCount-1);
						
            return false;
        });
        $('#saveorder-prod')
        .button()
        .click(function() {
            //AJAX form submit
            /****
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROD?action=SAVE_ORDER&c="+new Date().getTime()+"&CAT_GUID=<%=CommonUtil.null2Empty(request.getAttribute("CAT_GUID"))%>",   
                type: "POST",  
                data: "guids="+$("#sortable").sortable("toArray"),
                cache: false,  
                success: function (html) {                
                    //if process.php returned 1/true (send mail success)
                    $('#prod_list').html(html);
                }         
            });  ***/
            return false;
        });	
	
        $(".ui-icon-closethick")
        .bind("click", function(){
            if (confirm("<%=MessageUtil.getV6Message(lang, "BUT_DEL_CONFIRM_MSG")%>\""+ $(this).attr("prodname")+"\"?")){
                $.ajax({  
                    url: "<%=request.getAttribute("contextPath")%>/do/PROD?action=DELAJ&CAT_GUID=<%=request.getAttribute("CAT_GUID")%>&c="+new Date().getTime(),   
                    type: "POST",  
                    data: "guid="+$(this).attr("name"),
                    cache: false,  
                    success: function (html) {                
                        //if process.php returned 1/true (send mail success)
                        $('#prod_list').html(html);
                    }         
                });  
            }
            return false;
        });
	
        $('.ui-icon-pencil')
        .bind("click", function(){
            if(tabCount+1 > tabMax){
                alert("<%=MessageUtil.getV6Message(lang, "PROD_CLOSE_TAB")%>");
                return false;
            }
            tabCount++;
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROD?action=EDITAJ&CAT_GUID=<%=request.getAttribute("CAT_GUID")%>&c="+new Date().getTime()+"&tabidx="+tabCount,   
                type: "POST",  
                data: "guid="+$(this).attr("name"),
                cache: false,  
                success: function (html) {                
                    $('#tabs-'+tabCount).html(html);
                }         
            });
            $("#tabs").tabs("add",'#tabs-'+tabCount,"<%=MessageUtil.getV6Message(lang, "BUT_EDIT")%>..."+$(this).attr("prodname"));
            $("#tabs").tabs("select",tabCount-1);
        });

        $('.ui-icon-copy')
        .bind("click", function(){
            alert($(this).attr("name"));
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROD?action=COPY&CAT_GUID=<%=request.getAttribute("CAT_GUID")%>&&c="+new Date().getTime(),   
                type: "POST",  
                data: "guid="+$(this).attr("name"),
                cache: false,  
                success: function (html) {                
                    $('#prod_list').html(html);
                }         
            });
        });	
    });
</script>
<br/><br/>
<button id="add-prod"><%=MessageUtil.getV6Message(lang, "BUT_ADD")%></button>
<% if (objList
            != null && objList.size()
            > 0) {%>
<%--<button id="saveorder-prod"><%=MessageUtil.getV6Message(lang, "BUT_SAVE_ORDER")%></button>--%>
<% }%>

<script>
    $(document).ready(function(){
        $(".up,.down").click(function(){
            var row = $(this).parents("tr:first");
            if ($(this).is(".up")) {
                row.insertBefore(row.prev());
            } else {
                row.insertAfter(row.next());
            }
        });
    });
</script>

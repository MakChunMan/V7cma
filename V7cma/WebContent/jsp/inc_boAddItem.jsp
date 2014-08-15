<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@ page import="java.util.*" %>
<%@ page import="com.imagsky.common.*"%>
<%@ page import="com.imagsky.util.*"%>
<%@ page import="com.imagsky.v6.cma.servlet.handler.BO_Handler" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@ page import="java.util.*" %>
<%@include file="/init.jsp" %>
<%--
JSP:            inc_boAddItem.jsp
2013-09-02:         BO Date is editable if the status is "Active"
2013-10-28:         Add Clear Cache Link
 --%>
<%
    List sellItemList = (List) request.getAttribute(SystemConstants.REQ_ATTR_OBJ_LIST);
    SellItem sellItem = (SellItem) request.getAttribute(SystemConstants.REQ_ATTR_OBJ);
    BulkOrderItem boItem = (BulkOrderItem) request.getAttribute(SystemConstants.REQ_ATTR_OBJ_BO);
    boolean isEdit = (boItem != null && boItem.getId() != null);
    Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/" + thisMember.getSys_guid() + "/";
%>
<div class="ui-widget"><div id="formerr">
        <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
    </div>
    <form id="bo_additem_form">
        <input type="hidden" name="BO_ID" value="<%=isEdit ? boItem.getId() : ""%>"/>
    <table>
        <tr><td><%=MessageUtil.getV6Message(lang, "BO_PROD_SELLITEM")%> </td>
        <% if (sellItem == null && sellItemList != null && !isEdit) {%>
        <td colspan="3"><select name="sellitemguid" id="sellitemguid">
                <option value=""></option>
                <%
                    if (sellItemList != null && sellItemList.size() > 0) {
                        SellItem tmpItem;
                        for (Object tmpA : sellItemList) {
                            tmpItem = (SellItem) (tmpA);
                            out.println("<option value=\"" + tmpItem.getSys_guid() + "\">" + tmpItem.getProd_name() + "</option>");
                        }
                    }
                %>
            </select>
            <% if (boItem != null) {%>
            <script>
                    $('#sellitemguid').val("<%=boItem.getSellitem().getSys_guid()%>");
            </script>
            <% }%>
        </td>
        <% } else {
                if (boItem != null && boItem.getSellitem() != null) {%>
        <td colspan="3"><center>
                <img src="<%=userImagePath + "thm_"+boItem.getSellitem().getProd_image1()%>"/><br/><br/>
                <div style="font-size:130%;color:#999999"><%=boItem.getSellitem().getProd_name()%><br/><br/></div>
                <input type="hidden" name="sellitemguid" value="<%=boItem.getSellitem().getSys_guid()%>"/>
            </center>
        </td>       
        <%} else {%>
        <td colspan="3"><center>
            <img src="<%=userImagePath + "thm_"+sellItem.getProd_image1()%>"/><br/><br/>
            <div style="font-size:130%;color:#999999"><%=sellItem.getProd_name()%><br/><br/></div>
            </center>
        </td>       
        <%}
                }%>
        </tr>
        <tr><td>團購專用名稱</td><td colspan="3"><input name="BOI_NAME" value="<%=boItem != null ? boItem.getBoiName() : (sellItem == null ? "" : sellItem.getProd_name())%>"/></td></tr>
        <tr><td>團購專用簡介及條款</td><td colspan="3"><textarea name="BOI_DESCRIPTION"  cols=60 rows=10><%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiDescription()) : ""%></textarea></td></tr>
        <tr>
        <td>上架開始日期</td><td><input type="text" name="BOI_START_DATE" id="BOI_START_DATE" /></td>
        <td>上架結束日期</td><td><input type="text" name="BOI_END_DATE" id="BOI_END_DATE" />
            <% if(!isEdit){%>
            <a href="#" onclick="$('#BOI_END_DATE').val('');return false;">清除</a>
            <% } %>
        </td>            
        </tr>
        <tr>
        <td>領取開始日期</td><td><input type="text" name="BOI_COLLECTION_START_DATE" id="BOI_COLLECTION_START_DATE"  /></td>
        <td>領取結束日期</td><td><input type="text" name="BOI_COLLECTION_END_DATE" id="BOI_COLLECTION_END_DATE" />
            <% if(!isEdit){%>
            <a href="#" onclick="$('#BOI_COLLECTION_END_DATE').val('');return false;">清除</a>
            <% } %>
        </td>            
        </tr>        
        <tr><td>狀態</td><td>
        <select name="BOI_STATUS" id="BOI_STATUS">
            <option value="I">設定中</option>
            <option value="A">生效中</option>
            <option value="C">已中止</option>
        </select>
            <script>
            <% if (isEdit) {%>
                $('#BOI_START_DATE').val("<%=CommonUtil.formatDate(boItem.getBoiStartDate(), "dd.MM.yyyy HH:mm")%>");
                $('#BOI_END_DATE').val("<%=CommonUtil.formatDate(boItem.getBoiEndDate(), "dd.MM.yyyy HH:mm")%>");
                $('#BOI_COLLECTION_START_DATE').val("<%=CommonUtil.formatDate(boItem.getBoiCollectionStartDate(), "dd.MM.yyyy HH:mm")%>");
                $('#BOI_COLLECTION_END_DATE').val("<%=CommonUtil.formatDate(boItem.getBoiCollectionEndDate(), "dd.MM.yyyy HH:mm")%>");
                $('#BOI_STATUS').val("<%=boItem.getBoiStatus()%>");
                if($('#BOI_STATUS').val()=="A"){
                	$('#BOI_START_DATE').readOnly = true;
                	$('#BOI_END_DATE').readOnly = true;
                	$('#BOI_COLLECTION_START_DATE').readOnly = true;
                    $('#BOI_COLLECTION_END_DATE').readOnly = true;
                }
            <%}%>        
                $('#BOI_START_DATE').datetimepicker({dateFormat: 'dd.mm.yy'});
                $('#BOI_END_DATE').datetimepicker({dateFormat: 'dd.mm.yy'});
                $('#BOI_COLLECTION_START_DATE').datetimepicker({dateFormat: 'dd.mm.yy'});
                $('#BOI_COLLECTION_END_DATE').datetimepicker({dateFormat: 'dd.mm.yy'});
            </script>
                
    </td>
        <tr><td>起初數量</td><td colspan="3"><input type="text" name="BOI_START_QTY" size="5" value="<%=boItem != null ? boItem.getBoiStartQty() + "" : ""%>"/></td></tr>
            <% if (isEdit) {%>
    <tr><td>已售出</td><td colspan="3"><%=CommonUtil.null2Zero(boItem.getBoiCurrentQty())%></td></tr>
        <% }%>
        <tr><td>成本</td><td><input type="text" name="BOI_COST" value="<%=boItem != null ? boItem.getBoiCost() + "" : ""%>" size="5"/></td><td>原價</td><td><input type="text" name="BOI_SELL_PRICE" size="5" value="<%=boItem != null ? boItem.getBoiSellPrice() + "" : ""%>"></td></tr>
        <tr><td>團購價1</td><td><input type="text" name="BOI_PRICE1" size="5" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiPrice1()) + "" : ""%>"/> 限量<input type="text" name="BOI_PRICE1_QTY" size="3" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiPrice1Stock()) + "" : ""%>"/></td><td>團購1 (說明)</td><td><input type="text" name="BOI_PRICE1_DESCRIPTION" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiPrice1Description()) + "" : ""%>"/></td></tr>
        <tr><td>團購價2</td><td><input type="text" name="BOI_PRICE2" size="5" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiPrice2()) + "" : ""%>"/> 限量<input type="text" name="BOI_PRICE2_QTY" size="3" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiPrice2Stock()) + "" : ""%>"/></td><td>團購2 (說明)</td><td><input type="text" name="BOI_PRICE2_DESCRIPTION" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiPrice2Description()) + "" : ""%>"/></td></tr>    
        <tr><td>選項一</td><td><input type="text" name="BOI_OPTION1_NAME" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiOption1Name() )+ "" : ""%>"/>(名稱)</td><td colspan="2"><input name="BOI_OPTION1_VALUE" value="<%=boItem != null ? boItem.getBoiOption1() + "" : ""%>"/></td></tr>
        <tr><td>選項二</td><td><input type="text" name="BOI_OPTION2_NAME" value="<%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiOption2Name()) + "" : ""%>"/>(名稱)</td><td colspan="2"><input name="BOI_OPTION2_VALUE" value="<%=boItem != null ? boItem.getBoiOption2() + "" : ""%>"/></td></tr>
        <tr><td>取貨備註</td><td><textarea name="BOI_COLLECTION_REMARKS" cols=60 rows=10><%=boItem != null ? CommonUtil.null2Empty(boItem.getBoiCollectionRemarks()) : ""%></textarea></td></tr>
    </table>
</form>
<br/>
<% if(boItem!=null){ %>
<a href="/files/export_sellitem.php?v=<%=boItem.getSellitem().getSys_guid() %>&boid=<%=boItem.getId()%>" target="_blank">Clear Cache</a>
<br/>
<% }  %>
<button id="bo-save"><%=MessageUtil.getV6Message(lang, "BUT_SAVE")%></button>
<% if(isEdit){%>
<button id="bo-del"><%=MessageUtil.getV6Message(lang, "BUT_DEL")%></button>
<% } %>
<button id="bo-back"><%=MessageUtil.getV6Message(lang, "BUT_BACK")%></button>
<script>
    $('#bo-save')
    .button()
    .click(function() {
        $.ajax({  
            url: "<%=request.getAttribute("contextPath")%>/do/BO?action=ADD_ITEM_SAVE&c="+new Date().getTime(),
            data: $("#bo_additem_form").serialize(),
            type: "POST",  
            cache: false,  
            success: function (html) {                
                $("#boAdmin-region").html(html);
            }         
        });
    });
<% if(isEdit){%>    
   $('#bo-del')
    .button()
    .click(function() {
        $.ajax({  
            url: "<%=request.getAttribute("contextPath")%>/do/BO?action=DEL&c="+new Date().getTime(),
            data: $("#bo_additem_form").serialize(),
            type: "POST",  
            cache: false,  
            success: function (html) {                
                $("#boAdmin-region").html(html);
            }         
        });
    });
<% } %>
    $('#bo-back')
    .button()
    .click(function() {
        $.ajax({  
            url: "<%=request.getAttribute("contextPath")%>/do/BO?action=<%=BO_Handler.DO_BO_LIST_AJ%>&c="+new Date().getTime(),
            data: $("#bulkorder_form").serialize(),
            type: "POST",  
            cache: false,  
            success: function (html) {                
                $("#boAdmin-region").html(html);
            }         
        });  
        return false;
    });
</script>
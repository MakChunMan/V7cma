<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<% String lang = (String) request.getAttribute(SystemConstants.REQ_ATTR_LANG);%>
<% String tabidx = CommonUtil.null2Empty(request.getParameter("tabidx"));%>
<% Member thisMember = ((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser();
    String userImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/" + thisMember.getSys_guid() + "/";
    String tmpImagePath = PropertiesConstants.get(PropertiesConstants.uploadContextRoot) + "/";
    String staticPath = PropertiesConstants.get(PropertiesConstants.staticContextRoot);
%>
<link href="<%=staticPath%>/css/jquery.Jcrop.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=staticPath%>/js/ajaxupload.js"></script>
<script type="text/javascript" src="<%=staticPath%>/js/jquery.Jcrop.js"></script>
<script>
    var editor<%=tabidx%>;
    function createEditor(editContainerId)
    {
	if ( editor<%=tabidx%> ) return;
	var html = document.getElementById( editContainerId+'_content' ).innerHTML;
	document.getElementById( editContainerId+'_content' ).style.display="none";
	// Create a new editor inside the <div id="editor">
	editor<%=tabidx%> = CKEDITOR.appendTo(editContainerId);
	editor<%=tabidx%>.setData( html );
	$('#editor_open').hide();
	$('#editor_close').show();
    }
 
    function removeEditor(editContainerId)
    {
	if ( !editor<%=tabidx%> )	return;
 
	// Retrieve the editor contents. In an Ajax application, this data would be
	// sent to the server or used in any other way.
	document.getElementById( editContainerId+'_content' ).innerHTML = editor<%=tabidx%>.getData();
	document.getElementById( editContainerId+'_content' ).style.display = '';
 
	// Destroy the editor.
	editor<%=tabidx%>.destroy();
	editor<%=tabidx%> = null;

	$('#editor_close').hide();
	$('#editor_open').show();
    }
</script>
<%
    String prod_lang = "";
    String prod_guid = "";
    SellItem obj = (SellItem) request.getAttribute("THIS_OBJ");
    if (obj == null) {
        obj = new SellItem();
    }
%>
<style id="styles" type="text/css">
    .wrapper { width: 160px; margin: 0 auto; }
    div.button {
        border: solid 2px Transparent;
        border-color: #eeeeee;
        height:120px;	
        /*width: 128px;*/
        width: 160px;
        background: url(<%=staticPath%>/images/pictures.png) 0 0 no-repeat;
    }
    /* 
    We can't use ":hover" preudo-class because we have
    invisible file input above, so we have to simulate
    hover effect with JavaScript. 
    */
    div.button.hover {
        border-color: #aaaaaa;
        cursor: pointer;	
    }

    div.button.loading {
        background: url(<%=staticPath%>/images/ajax-loader.gif) 0 0 no-repeat;
    }
</style>
<form id="prod_add_form" action="" method="post">
    <input type="hidden" name="action" value="SAVE"/>
    <div class="ui-widget"><div id="formerr">
            <jsp:include page="/jsp/common/renderErrorMsg.jsp"></jsp:include></div>
        </div>
    <% if (!CommonUtil.isNullOrEmpty(obj.getSys_guid())) {%>
    <input type="hidden" name="PROD_GUID" value="<%=obj.getSys_guid()%>"/><%}%>
    <table width="95%" class="tbl_form">
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_NAME")%></td><td><input type="text" name="PROD_NAME" size="20" maxlength="30" value="<%=CommonUtil.null2Empty(obj.getProd_name())%>"/></td> </tr>
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_CAT")%></td><td><%=request.getAttribute("cateListSelector")%>
                <% if (!CommonUtil.isNullOrEmpty(obj.getProd_cate_guid())) {%>
                <script>document.getElementById('PROD_CAT_GUID').value="<%=obj.getProd_cate_guid()%>";</script>
                <% }%>
            </td></tr>
        <tr><td><%=MessageUtil.getV6Message(lang, "ARTI_LANG")%></td><td><SELECT name="PROD_LANG">
                    <OPTION value="zh" <%=CommonUtil.isSelected(prod_lang, "zh")%>><%=MessageUtil.getV6Message(lang, "COMMON_LANG_ZH")%></OPTION>
                </SELECT>
            </td>
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_PRICE")%> </td><td><input type="text" name="PROD_PRICE" size="6" maxlength="10" value="<%=CommonUtil.null2Empty(obj.getProd_price())%>"/></td></tr>
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_PRICE")%> 2</td><td><input type="text" name="PROD_PRICE2" size="6" maxlength="10" value="<%=CommonUtil.null2Empty(obj.getProd_price2())%>"/></td></tr>
                <% if (obj.getSys_exp_dt() != null) {%>
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_EXPR_DATE")%></td><td>
                <%=CommonUtil.formatDate(obj.getSys_exp_dt(), "dd-MM-yyyy")%>
                <% if (obj.getSys_exp_dt().before(new java.util.Date())) {%>
                <%=MessageUtil.getV6Message(lang, "PROD_EXPR")%>
                <% }%>
            </td></tr>
            <% }%>
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_EXT_EXPR_DATE")%></td>
            <td><SELECT name="PROLONG_EXPR_DATE">
                    <% if (!CommonUtil.isNullOrEmpty(obj.getSys_guid())) {%><option value="0"><%=MessageUtil.getV6Message(lang, "PROD_EXT_0")%></option><% }%>
                    <option value="7"><%=MessageUtil.getV6Message(lang, "PROD_EXT_7")%></option>
                    <option value="14"><%=MessageUtil.getV6Message(lang, "PROD_EXT_14")%></option>
                </SELECT></td></tr>
        <tr><td colspan="2">
                <br/>
                <%=MessageUtil.getV6Message(lang, "PROD_IMAGE")%> <%=MessageUtil.getV6Message(lang, "PROD_IMAGE_MSG")%>
                <br/>
                <br/>
                <table width="90%">
                    <tr valign="top">
                        <td><div class="wrapper" id="button1_region"><div id="button1" class="button"></div></div></td>
                        <td><div class="wrapper" id="button2_region"><div id="button2" class="button"></div></div></td>
                        <td><div class="wrapper" id="button3_region"><div id="button3" class="button"></div></div></td>
                    </tr>
                </table>
            </td></tr>
    </table>
    <%=MessageUtil.getV6Message(lang, "PROD_DESC")%>
    <p>
        <input class="btnGeneric" id="editor_open" style="display:none" onclick="createEditor('PROD_DESC<%=tabidx%>');" type="button" value="<%=MessageUtil.getV6Message(lang, "ARTI_EDITOR_OPEN")%>" />
        <input class="btnGeneric" id="editor_close" onclick="removeEditor('PROD_DESC<%=tabidx%>');" type="button" value="<%=MessageUtil.getV6Message(lang, "ARTI_EDITOR_CLOSE")%>" />
    </p>
    <input type="hidden" name="PROD_IMAGE_1" id="IMG_button1"/>
    <input type="hidden" name="PROD_IMAGE_2" id="IMG_button2"/>
    <input type="hidden" name="PROD_IMAGE_3" id="IMG_button3"/>
    <input type="hidden" name="PROD_DESC" id="DESC_content"/>
    <div id="PROD_DESC<%=tabidx%>">
    </div>
    <div id="PROD_DESC<%=tabidx%>_content">
        <% if (CommonUtil.isNullOrEmpty(obj.getProd_desc())) {
                out.println(MessageUtil.getV6Message(lang, "ARTI_DUMMY_CONTENT"));
            } else {
                out.println(CommonUtil.null2Empty(obj.getProd_desc()));
            }%>
    </div>
    <br/>
    <br/>
    <script>
    if(editor<%=tabidx%>){
        editor<%=tabidx%>.destroy();
	editor<%=tabidx%> = null;
    }
    createEditor('PROD_DESC<%=tabidx%>');</script>
    <table width="95%">
        <tr><td><%=MessageUtil.getV6Message(lang, "PROD_REMARKS")%></td> </tr>
        <tr><td><textarea name="PROD_REMARKS" cols="70" rows="7"><%=CommonUtil.null2Empty(obj.getProd_remarks())%></textarea></td></tr>
    </table>
    <% if (ACLUtil.isValid(((ImagskySession) request.getSession().getAttribute(SystemConstants.REQ_ATTR_SESSION)).getUser(), ACLUtil.MET01)) {%>
    <jsp:include page="/jsp/inc_web_meta.jsp"></jsp:include>
    <% }%>
</form>
<button id="prod-submit"><%=MessageUtil.getV6Message(lang, "BUT_SUBMIT")%></button>	
<button id="prod-back"><%=MessageUtil.getV6Message(lang, "BUT_BACK")%></button>

<script type="text/javascript">
    jQuery.fn.exists = function(){return jQuery(this).length>0;}
    <% if (!CommonUtil.isNullOrEmpty(obj.getProd_image1())) {%>
    document.getElementById("IMG_button1").value = "<%=obj.getProd_image1()%>";
    document.getElementById("button1").style.background = "url(<%=userImagePath%>thm_<%=obj.getProd_image1()%>)";
    document.getElementById("button1").style.backgroundRepeat = "no-repeat";
    <%}%>
    <% if (!CommonUtil.isNullOrEmpty(obj.getProd_image2())) {%>
    document.getElementById("IMG_button2").value = "<%=obj.getProd_image2()%>";
    document.getElementById("button2").style.background = "url(<%=userImagePath%>thm_<%=obj.getProd_image2()%>)";
    document.getElementById("button2").style.backgroundRepeat = "no-repeat";	
    <%}%>
    <% if (!CommonUtil.isNullOrEmpty(obj.getProd_image3())) {%>
    document.getElementById("IMG_button3").value = "<%=obj.getProd_image3()%>";
    document.getElementById("button3").style.background = "url(<%=userImagePath%>thm_<%=obj.getProd_image3()%>)";
    document.getElementById("button3").style.backgroundRepeat = "no-repeat";
    <%}%>
</script>

<script>
    var jcrop_api; //jcrop object
    var onactiveimage;
    var isSetImage = false;
    function initAjaxUpload(obj,filename1){
        return new AjaxUpload(
        obj,{
            action: '<%=staticPath%>/upload-handler.php?sid=<%=request.getSession().getId()%>', 
            name: 'userfile',
            onSubmit : function(file, ext){
                if (! (ext && /^(jpg|png|jpeg|gif)$/i.test(ext))){
                    // extension is not allowed
                    alert('Error: invalid file extension');
                    // cancel upload
                    return false;
                }
                document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/ajax-loader.gif)";
                document.getElementById(filename1).style.backgroundRepeat = "no-repeat";
                // If you want to allow uploading only 1 file at time,
                // you can disable upload button
                //this.disable();
            },
            onComplete: function(file, response){
                // enable upload button
                if(response.indexOf("success")==0){
                    response = response.replace("success:","");
                    $('#errmsg'+filename1).remove();
                    //SET image button background : TO BE REMOVE
                    document.getElementById("IMG_"+filename1).value = response;
                    onactiveimage = filename1;
                    $("#crop_src").val("raw_"+response); //Assign raw image to crop program  (
                    $("#cropbox").attr("src","<%=tmpImagePath%>raw_"+response);
                    isSetImage = true;
                } else {
                    if ($('#errmsg'+filename1).exists()) {
                        $('#errmsg'+filename1).replaceWith('<li id="errmsg1"><font color="red">'+response+'</font></li>');
                    } else {
                    }
                    //$('#'+filename1+'_region').html($('#'+filename1+'_region').html +	response); 
                    document.getElementById(filename1).style.background = "url(<%=staticPath%>/images/pictures.png)";
                    //this.enable();
                }
            }
        }
    );
    }
    $(document).ready(function(){
        /* Example 1 */
        var button1 = $('#button1'), interval;
        var button2 = $('#button2'), interval;
        var button3 = $('#button3'), interval;
        initAjaxUpload(button1,"button1");
        initAjaxUpload(button2,"button2");
        initAjaxUpload(button3,"button3");
    });


    function onLoadCropbox(){
        if(document.getElementById('cropbox').src!= null){
            if(isSetImage){
                $("#crop_dialog").show();
                $("#crop_dialog").dialog({
                    width: 1200, 
                    height:800, 
                    modal: true
                });
                jcrop_api = null;
                jcrop_api = $.Jcrop('#cropbox');
                jcrop_api.setOptions( {aspectRatio: 289 / 193} );
                jcrop_api.setOptions( {onSelect: updateCoords} );
                jcrop_api.focus();
                isSetImage = false;
                $('#crop_submit').show();
            }
        } }
</script>
<div id="crop_dialog" title="裁切圖片" style="width:800px;display:none">		
    <!-- This is the image we're attaching Jcrop to -->
    <img id="cropbox" onLoad="onLoadCropbox();"/>
    <!-- This is the form that our event handler fills -->
    <form method="post" id="crop_form">
        <input type="hidden" id="x" name="x" />
        <input type="hidden" id="y" name="y" />
        <input type="hidden" id="w" name="w" />
        <input type="hidden" id="h" name="h" />
        <input type="hidden" id="crop_src" name="crop_src" value=""/>
        <input type="button" id="crop_submit" value="裁切圖片" />
    </form>
</div>
<script>
    /// BUTTON

    $(function() {
        $('#prod-submit')
        .button()
        .click(function() {
            removeEditor('PROD_DESC<%=tabidx%>');
            document.getElementById('DESC_content').value = 
                $('#PROD_DESC<%=tabidx%>_content').html();
            $.ajax({  
                url: "<%=request.getAttribute("contextPath")%>/do/PROD?c="+new Date().getTime(),   
                type: "POST",  
                data: $("#prod_add_form").serialize(),       
                cache: false,  
                success: function (html) {                
                    $('#tabs-'+tabCount).html(html);
                }         
            });  
            return false;
        });
    });

    $(function() {
        $('#prod-back')
        .button()
        .click(function() {
            removeEditor('PROD_DESC<%=tabidx%>');
            var selected = $("#tabs").tabs( "option", "selected" );
            $("#tabs").tabs("select",1);
            $("#tabs").tabs('remove', selected);
            tabCount--;
            return false;
        });
        //SAV
        $('#crop_submit')
        .button()
        .click(function(){
            $('#crop_submit').hide();
            if(checkCoords()){
                $.ajax({  
                    url: "<%=request.getAttribute("contextPath")%>/files/crop.php?c="+new Date().getTime(),   
                    type: "POST",  
                    data: $("#crop_form").serialize(),       
                    cache: false,  
                    success: function (html) { 
                        if(html.indexOf("success")==0){
                            response = html.replace("success:","");    
                            document.getElementById(onactiveimage).style.background = "url(<%=tmpImagePath%>thm_"+response+")";//DISPLAY thumbnail
                            document.getElementById(onactiveimage).style.backgroundRepeat = "no-repeat";
                            jcrop_api.destroy();
                            jcrop_api = null;
                            $('#crop_dialog').dialog('close');
                            $("#crop_dialog").hide();
                        } else {
                            alert("Error:"+ html);
                        }
                    }         
                });
            }
            return false;
        });
    });


    function updateCoords(c)
    {
        $('#x').val(c.x);
        $('#y').val(c.y);
        $('#w').val(c.w);
        $('#h').val(c.h);
    };

    function checkCoords()
    {
        if (parseInt($('#w').val())) return true;
        alert('Please select a crop region then press submit.');
        return false;
    };
</script>
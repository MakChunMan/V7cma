<%--
2014-09-08 Mobile apps product management page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", -1);
%>
<%@ page import="com.imagsky.util.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Pragma" content="no-cache" />   
        <meta http-equiv="Cache-Control" content="no-cache"/>   
        <meta http-equiv="Expires" content="0" />   
        <meta content="NOINDEX, NOFOLLOW" name="ROBOTS" />
        <meta content="" name="Keywords"/>
        <meta content="" name="Description"/>
        <title><%=MessageUtil.getV6Message(lang, "TIT_PROD")%> @ <%=MessageUtil.getV6Message(lang, "TIT_CORP")%></title>
        <link href="<%=staticPath%>/css/en.css" rel="stylesheet" type="text/css" media="all"/>
        <link href="<%=staticPath%>/css/en_print.css" rel="stylesheet" type="text/css" media="print"/>
        <link href="<%=staticPath%>/css/flick/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQCSS")%>" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERY")%>"></script>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERYUI")%>"></script>
        <script type="text/javascript" src="<%=staticPath%>/ckeditor/ckeditor.js"></script>
        <script type="text/javascript" src="<%=staticPath%>/ckfinder/ckfinder.js"></script>
        <!--// script for sliding sidebar //-->
        <script src="<%=staticPath%>/script/common_DOMControl.js" type="text/javascript"></script>
        <script src="<%=staticPath%>/script/slidemenu.js" type="text/javascript"></script>
        <!--// script for dropdown menu //-->
        <script src="<%=staticPath%>/script/init.js" type="text/javascript"></script>
        <script type="text/javascript">
            <!--//--><![CDATA[//><!--

            //initialize slider
            sb_setting=new Object();
            sb_setting.opened_item=0;
            sb_setting.allowMultiopen=false;
            //sb_setting.delayOpen=1000;        // in ms, -1 for no delay
            sb_setting.delayOpen=-1;
            sb_setting.maxheight=-1;            // set to -1 for autosize

            //initialize auto complete
            //var ACManager = new autoComplete();
            var config=[{id:"txt_search", hasScroll:false, maxRow:10} ];

            function pagaInit() {
                drawmenu("ctnSidebar", sb_setting);
                //  ACManager.setFields(config);
            }
            var tabCount = 1;
            var tabMax = 2;

            $(function(){
                //Tabs
                // tabs init with a custom tab template and an "add" callback filling in the content
    var $tabs = $('#tabs').tabs(        {
                    tabTemplate: '<li><a href="#{href}">#{label}</a><span class="ui-icon ui-icon-close"></span></li>'
                });

                $('#tabs span.ui-icon-close').live('click', function() {
                    for(x=0; x<=5; x++){
                        if(document.getElementById('PROD_DESC'+x)!=null){
                            removeEditor('PROD_DESC'+x);
                        }
                    }
                    var index = $('li',$tabs).index($(this).parent());
                    $tabs.tabs('remove', index);
                    tabCount--;
                });
            });
            //]]>
            //--><!]]>
        </script>
        <style id="styles" type="text/css">
            #tabs li .ui-icon-close { float: left; margin: 0.4em 0.2em 0 0; cursor: pointer; }
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
            window.onload = function()
            {
                pagaInit();

            };
        </script>
    </head>
    <body>
        <div id="main_container">
            <jsp:include page="/jsp/common/com_header.jsp"></jsp:include>
                <div id="content">
                    <div id="ctnMainFull">
                        <div id="mod_product" class="mod">
                            <div class="hd2">
                                <h2><%=MessageUtil.getV6Message(lang, "TIT_PROD")%></h2>
                        </div>
                        <div class="bd" id="prod-region">
                            <div id="tabs">
                                <ul>
                                    <li><a href="#tabs-1"><%=MessageUtil.getV6Message(lang, "PROD_LIST")%></a></li>
                                </ul>
                                <div id="tabs-1">
                                    <%=MessageUtil.getV6Message(lang, "PROD_CATLIST")%> 
                                    <% if (request.getAttribute("CAT_DROPDOWN") == null) {%>
                                    <%=MessageUtil.getV6Message(lang, "PROD_CATLIST_NULL")%>
                                    <% } else {%>
                                    <%=((StringBuffer) request.getAttribute("CAT_DROPDOWN")).toString()%> <a href="" title="<%=MessageUtil.getV6Message(lang, "BUT_SEARCH")%>" id="prod_list_search"><img src="<%=staticPath%>/images/Search.png"/ height="20"></a>
                                    <% }%>
                                    <br/>
                                    <br/>
                                    <div id="prod_list">
                                        <jsp:include page="/jsp/inc_prodList.jsp"></jsp:include>             
                                        </div>
                                    </div>
                                    <div id="tabs-2"></div>
                                    <div id="tabs-3"></div>
                                    <div id="tabs-4"></div>
                                    <div id="tabs-5"></div>                     
                                </div>
                            </div>
                            <div class="shadow940px"></div>
                        </div>

                    </div>
                </div>
                <div id="footer">
                <jsp:include page="/jsp/common/com_footer.jsp"></jsp:include>
                </div>  
            </div>
            <div id="navMenu">
            <jsp:include page="/jsp/common/com_subnav.jsp"></jsp:include>
            </div>
            <div id="loadform"></div>
            <script type="text/javascript">
                $(function() {
                    $('#prod_list_search')
                    .click(function(){
            var item = $("#CAT_GUID").val(            );
                        $.ajax({  
                            url: "<%=contextPath%>/do/PROD?action=LISTAJ&c="+new Date().getTime()+"&CAT_GUID="+item,   
                            type: "POST",  
                            cache: false,  
                            success: function (html) {                
                                //if process.php returned 1/true (send mail success)
                                $('#prod_list').html(html);
                            }         
                        });  
                        return false;
                    });
                });
        </script>

        <iframe src="javascript:false" id="frameNavElement" ></iframe>
        <div id="heightTest"></div>
    </body>
</html>

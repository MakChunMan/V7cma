<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@page import="com.imagsky.util.CommonUtil"%>
<%@page import="com.imagsky.v7.domain.ContentFolder"%>
<%@page import="com.imagsky.v6.cma.constants.SystemConstants"%>
<%
    ContentFolder parenetFolder = ((ContentFolder) request.getAttribute("PARENT_FOLDER"));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link href="/files/css/custom-theme/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
        <link href="/files/js/jtable.2.2.1/themes/lightcolor/red/jtable.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="/files/js/jquery-1.9.1.js"></script>
        <script type="text/javascript" src="/files/js/jquery-ui-1.10.2.custom.min.js"></script>
        <script type="text/javascript" src="/files/js/jtable.2.3.0/jquery.jtable.js" ></script>
        <!-- Import Javascript files for validation engine (in Head section of HTML) -->
        <script type="text/javascript" src="/files/js/jquery.validationEngine.js"></script>
        <script type="text/javascript" src="/files/js/languages/jquery.validationEngine-zh_TW.js"></script>
        <script type="text/javascript" src="/files/ckeditor/ckeditor.js"></script>
        <script type="text/javascript" src="/files/ckfinder/ckfinder.js"></script>
        <script type="text/javascript" src="/files/ckeditor/adapters/jquery.js"></script>
        <link href="/files/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
        <title>CMA - Article @ BuyBuyMeat Content Management System</title>
        <style>
            .jtable a.jtable-inline-link{ color:#666666;text-decoration: none}
            .jtable a.jtable-inline-link:hover{ color:#333333;text-decoration: underline}
            #sub-title a { color:#dddddd;text-decoration: none}
            #sub-title a:hover { color:#ffffff;text-decoration: underline}
        </style>
    </head>
    <body>
        <div class="site-container">
            <div class="content-container">
                <div class="padded-content-container">
                    <!-- Container for jTable -->
                    <div id="ContentTableContainer"></div>
                    <script type="text/javascript">
                        var folderPath = '<a href="/cma/FOLDER/?CF_NAME=<%=CommonUtil.escape(parenetFolder.getCF_NAME())%>"><%=parenetFolder.getCF_NAME()%></a>';
                        $(document).ready(function () {
                            $('#ContentTableContainer').jtable({
                                title: '<span id="main-title" style="font-size:140%">Content List</span> <span id="sub-title" style="font-size:75%">'+ folderPath + '</span>',
                                paging: true, //Enable paging
                                pageSize: 10, //Set page size (default: 10)
                                sorting: true, //Enable sorting
                                selecting: true, //Enable selecting
                                multiselect: true, //Allow multiple selecting
                                selectingCheckboxes: true, //Show checkboxes on first column
                                defaultSorting: 'arti_name ASC', //Set default sorting
                                actions: {
                                    listAction: '/cma/CT/CTLISTJ/<%=request.getAttribute(SystemConstants.REQ_ATTR_OBJ)%>',
                                    deleteAction: '/cma/CT/CTDEL',
                                    updateAction: '/cma/CT/CTUPDATE',
                                    createAction: '/cma/CT/CTADD'
                                },
                                toolbar: {
                                    items: [{
                                            tooltip: 'Click here ',
                                            icon: '/images/bulb.fw.png',
                                            text: 'test',
                                            click: function () {
                                                $('#srcregion').text($('#ContentTableContainer').html());
                                            }
                                        }]
                                },
                                fields: {
                                    sys_guid: {key: true,create: false, edit: false, list: false},
                                    arti_name:{title: 'Name',width: '20%',create:true, edit:true},
                                    arti_content:{list:false, title: 'Content', type:'textarea'},
                                    sys_clfd_guid:{list:false, title: "Folder", options: "/cma/FOLDER/CFOPTIONS"},
                                    arti_type:{title: 'Article Type', options: { '': '-- Blank --', 'S': '有趣分享','J':'著數專區' }},
                                    sys_is_live:{list:true, title: "Is Live", type: 'checkbox', width: '10%', values: { 'false': 'No', 'true': 'Yes' } },
//                                    sys_is_published:{list:true, title: "Is Published", type: 'checkbox', width: '10%', values: { 'false': 'No', 'true': 'Yes' } },
                                    sys_create_dt: {  title: 'Create date', type: 'date',create: false, edit: false, list: true, width: '10%'},
                                    arti_isTopNav: { title: 'Is top Navigation item', type:'checkbox', list: false, values: { 'false': 'No', 'true': 'Yes' }},
                                    arti_isSubNav: { title: 'Is sub Navigation item', type:'checkbox', list: false, values: { 'false': 'No', 'true': 'Yes' }},
                                    ShowDetailColumn: {  title: '', width: '1%',  sorting:false, edit: false, create: false, display: function (idata) {
                                            var $img = $('<img src="/files/images/link.png" title="Content Association" />');
                                            $img.click(function () {
                                                $('#ContentTableContainer').jtable('openChildTable',
                                                $img.closest('tr'), //Parent row
                                                {
                                                    title: idata.record.arti_name + ': URL association',
                                                    actions: {
                                                        listAction: '/cma/CT/NODLIST/' + idata.record.sys_guid,
                                                        deleteAction: '/cma/CT/NODDEL',
                                                        updateAction: '/cma/CT/NODUPDATE',
                                                        createAction: '/cma/CT/NODADD'
                                                    },
                                                    fields: {
                                                        nod_contentGuid: {      type: 'hidden', defaultValue: idata.record.sys_guid   },
                                                        sys_guid: {                  key: true, create: false, edit: false, list: false   },
                                                        nod_url: {                    title: 'URL',  width: '15%', create:true, edit:false },
                                                        nod_bannerurl: {          title: 'Banner URL', width: '15%'},
                                                        nod_keyword: {           title: 'Page Keyword (SEO)' },
                                                        nod_description: {       title: 'Page Description (SEO)' },
                                                        nod_cacheurl: {           title: 'Cache URL',  width: '5%' },
                                                        sys_is_published:{list:true, title: "Is Published", type: 'checkbox', width: '10%', values: { 'false': 'No', 'true': 'Yes' },  width: '5%' }
                                                    },
                                                    formCreated: function (event, data) {
                                                        data.form.width(700).height(400);
                                                        data.form.find('input[name="nod_url"]').addClass('validate[required]').width("220");
                                                        data.form.validationEngine();
                                                    },
                                                    //Validate form when it is being submitted
                                                    formSubmitting: function (event, data) {
                                                        return data.form.validationEngine('validate');
                                                    },
                                                    //Dispose validation logic when form is closed
                                                    formClosed: function (event, data) {
                                                        data.form.validationEngine('hide');
                                                        data.form.validationEngine('detach');
                                                    }
                                                }, function (idata) { //opened handler
                                                    idata.childTable.jtable('load');
                                                });
                                            });
                                            //Return image to show on the person row
                                            return $img;
                                        }
                                    }
                                },
                                //Initialize validation logic when a form is created
                                formCreated: function (event, data) {
                                    data.form.width(1200).height(750);
                                    data.form.find("#errormsg").hide();
                                    data.form.find('input[name="arti_name"]').addClass('validate[required]').width("220");
                                    data.form.find('select[name="sys_clfd_guid"]').addClass('validate[required]').width("220");
                                    data.form.find('textarea[name="arti_content"]').addClass("editor");
                                    data.form.find('textarea.editor').ckeditor();
                                    data.form.validationEngine();
                                    var $dialogDiv = data.form.closest('.ui-dialog');
                                    $dialogDiv.position({
                                        my: "left+20 top+20",
                                        at: "left top",
                                        of: window
                                    });
                                },
                                //Validate form when it is being submitted
                                formSubmitting: function (event, data) {
                                    return data.form.validationEngine('validate');
                                },
                                //Dispose validation logic when form is closed
                                formClosed: function (event, data) {
                                    var editor=jQuery(data.form.find('textarea.editor')).ckeditorGet();
                                    editor.destroy();
                                    data.form.validationEngine('hide');
                                    data.form.validationEngine('detach');
                                }
                            });
                            //Load student list from server
                            $('#ContentTableContainer').jtable('load');
                            $('.jtable-title-text').css("font-size","20");
                            $('.jtable-title-text').append("<div style='float:auto;positon:relative;left:400;width:500'><input id=searchValue value='Search'><span id='searchBtn' title='Keyword Search' class='ui-icon ui-icon-search'>Search</span><span id='resetBtn' title='Reset' class='ui-icon ui-icon-cancel' >Reset</span></div>");
                            $("#searchBtn").button().click(
                            function(){
                                $('#ContentTableContainer').jtable('load', {
                                    SEARCH_CF_NAME: $('#searchValue').val()},
                                function(){
                                    $('#sub-title').html(" - search result: \"" + $('#searchValue').val() + "\" in " + folderPath);
                                    $('#sub-title').show();
                                });
                            });
                            $("#resetBtn").button().click(
                            function(){
                                $('#ContentTableContainer').jtable('load',null,
                                function(){
                                    $('#sub-title').html(folderPath);
                                    $('#searchValue').val("");
                                });
                            });
                        });
                    </script>
                </div>
            </div>
        </div>
        <div id="srcregion"></div>
    </body>
</html>

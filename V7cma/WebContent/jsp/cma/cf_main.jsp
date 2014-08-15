<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
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
        <link href="/files/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
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

                        $(document).ready(function () {

                            //Prepare jtable plugin
                            $('#ContentTableContainer').jtable({
                                title: '<span id="main-title" style="font-size:140%">Folder List</span> <span id="sub-title" style="font-size:75%"></span>',
                                paging: true, //Enable paging
                                pageSize: 10, //Set page size (default: 10)
                                sorting: true, //Enable sorting
                                selecting: true, //Enable selecting
                                multiselect: true, //Allow multiple selecting
                                selectingCheckboxes: true, //Show checkboxes on first column
                                defaultSorting: 'CF_Name ASC', //Set default sorting
                                actions: {
                                    listAction: '/cma/FOLDER/CFLISTJ',
                                    deleteAction: '/cma/FOLDER/CFDEL',
                                    updateAction: '/cma/FOLDER/CFUPDATE',
                                    createAction: '/cma/FOLDER/CFADD'
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
                                    CF_NAME:{title: 'Name',width: '30%',create:true, edit:false, display: function(data){
                                            return "<a href='/cma/CT/CTMAIN/"+data.record.sys_guid+ "' class='jtable-inline-link'>" + data.record.CF_NAME + "</a>";
                                        }},
                                    CF_DESC:{title: 'Description',width: '30%'},
                                    sys_create_dt: { title: 'Create date', type: 'date',create: false, edit: false, list: true}
                                },
                                //Initialize validation logic when a form is created
                                formCreated: function (event, data) {
                                    data.form.width(750);
                                    //data.form.prepend("<div id=errormsg class=ui-state-error>TEST JASON (this is error message)</div>");
                                    data.form.find("#errormsg").hide();
                                    data.form.find('input[name="CF_NAME"]').addClass('validate[required]').width("220");
                                    data.form.find('input[name="CF_DESC"]').addClass('validate[required]').width("250");
                                    //alert(data.form.html());
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


                            });

                            //Load student list from server
                            $('#ContentTableContainer').jtable('load');

                            //Load student list from server
                            $('#ContentTableContainer').jtable('load');
                            $('.jtable-title-text').append("<div style='float:auto;positon:relative;left:400;width:500'><input id=searchValue value='Search'><span id='searchBtn' title='Keyword Search' class='ui-icon ui-icon-search'>Search</span><span id='resetBtn' title='Reset' class='ui-icon ui-icon-cancel' >Reset</span></div>");
                            $("#searchBtn").button().click(
                            function(){
                                $('#ContentTableContainer').jtable('load', {
                                    SEARCH_CF_NAME: $('#searchValue').val()},
                                function(){
                                    $('#sub-title').text(" - search result: \"" + $('#searchValue').val() + "\"");
                                    $('#sub-title').show();
                                });
                            });
                            $("#resetBtn").button().click(
                            function(){
                                $('#ContentTableContainer').jtable('load',null,
                                function(){
                                    $('#sub-title').hide();
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

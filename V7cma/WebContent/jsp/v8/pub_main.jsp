<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.imagsky.v8.constants.*" %>
<!DOCTYPE html>
<!--[if IE 9]>         <html class="no-js lt-ie10"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">

        <title>AppUI - Bootstrap Admin Web App Template</title>

        <meta name="description" content="AppUI is a Bootstrap Admin Web App Template created by pixelcave and published on Themeforest">
        <meta name="author" content="pixelcave">
        <meta name="robots" content="noindex, nofollow">

        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0">

        <!-- Icons -->
        <!-- The following icons can be replaced with your own, they are used by desktop and mobile browsers -->
        <link rel="shortcut icon" href="<%=V8SystemConstants.V8_PATH %>img/favicon.ico">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon57.png" sizes="57x57">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon72.png" sizes="72x72">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon76.png" sizes="76x76">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon114.png" sizes="114x114">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon120.png" sizes="120x120">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon144.png" sizes="144x144">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon152.png" sizes="152x152">
        <link rel="apple-touch-icon" href="<%=V8SystemConstants.V8_PATH %>img/icon180.png" sizes="180x180">
        <!-- END Icons -->

        <!-- Stylesheets -->
        <!-- Bootstrap is included in its original form, unaltered -->
        <link rel="stylesheet" href="<%=V8SystemConstants.V8_PATH %>css/bootstrap.min.css">

        <!-- Related styles of various icon packs and plugins -->
        <link rel="stylesheet" href="<%=V8SystemConstants.V8_PATH %>css/plugins.css">

        <!-- The main stylesheet of this template. All Bootstrap overwrites are defined in here -->
        <link rel="stylesheet" href="<%=V8SystemConstants.V8_PATH %>css/main.css">

        <!-- Include a specific file here from css/themes/ folder to alter the default theme of the template -->

        <!-- The themes stylesheet of this template (for using specific theme color in individual elements - must included last) -->
        <link rel="stylesheet" href="<%=V8SystemConstants.V8_PATH %>css/themes.css">
        <!-- END Stylesheets -->

        <!-- Modernizr (browser feature detection library) -->
        <script src="<%=V8SystemConstants.V8_PATH %>js/vendor/modernizr-2.8.3.min.js"></script>
    </head>
    <body>
        <!-- Page Wrapper -->
        <!-- In the PHP version you can set the following options from inc/config file -->
        <!--
            Available classes:

            'page-loading'      enables page preloader
        -->
        <div id="page-wrapper" class="page-loading">
            <!-- Preloader -->
            <!-- Preloader functionality (initialized in js/app.js) - pageLoading() -->
            <!-- Used only if page preloader enabled from inc/config (PHP version) or the class 'page-loading' is added in #page-wrapper element (HTML version) -->
            <div class="preloader">
                <div class="inner">
                    <!-- Animation spinner for all modern browsers -->
                    <div class="preloader-spinner themed-background hidden-lt-ie10"></div>

                    <!-- Text for IE9 -->
                    <h3 class="text-primary visible-lt-ie10"><strong>Loading..</strong></h3>
                </div>
            </div>
            <!-- END Preloader -->

            <!-- Page Container -->
            <!-- In the PHP version you can set the following options from inc/config file -->
            <!--
                Available #page-container classes:

                'sidebar-visible-lg-mini'                       main sidebar condensed - Mini Navigation (> 991px)
                'sidebar-visible-lg-full'                       main sidebar full - Full Navigation (> 991px)

                'sidebar-alt-visible-lg'                        alternative sidebar visible by default (> 991px) (You can add it along with another class)

                'header-fixed-top'                              has to be added only if the class 'navbar-fixed-top' was added on header.navbar
                'header-fixed-bottom'                           has to be added only if the class 'navbar-fixed-bottom' was added on header.navbar

                'fixed-width'                                   for a fixed width layout (can only be used with a static header/main sidebar layout)
            -->
            <div id="page-container" class="header-fixed-top sidebar-visible-lg-full">
                <!-- Alternative Sidebar -->
                <div id="sidebar-alt" tabindex="-1" aria-hidden="true">
                    <!-- Toggle Alternative Sidebar Button (visible only in static layout) -->
                    <a href="javascript:void(0)" id="sidebar-alt-close" onclick="App.sidebar('toggle-sidebar-alt');"><i class="fa fa-times"></i></a>

                    <!-- Wrapper for scrolling functionality -->
                    <div id="sidebar-scroll-alt">
                        <!-- Sidebar Content -->
                        <div class="sidebar-content">
                            <!-- Profile -->
                            <jsp:include page="/jsp/v8/common_sidebar_profile.jsp"></jsp:include>
                            <!-- END Profile -->

                            <!-- Settings -->
                            <jsp:include page="/jsp/v8/common_sidebar_setting.jsp"></jsp:include>
                            <!-- END Settings -->
                        </div>
                        <!-- END Sidebar Content -->
                    </div>
                    <!-- END Wrapper for scrolling functionality -->
                </div>
                <!-- END Alternative Sidebar -->

                <!-- Main Sidebar -->
                <div id="sidebar">
                    <!-- Sidebar Brand -->
                    <div id="sidebar-brand" class="themed-background">
                        <a href="index.html" class="sidebar-title">
                            <i class="fa fa-cube"></i> <span class="sidebar-nav-mini-hide">App<strong>UI</strong></span>
                        </a>
                    </div>
                    <!-- END Sidebar Brand -->

                    <!-- Wrapper for scrolling functionality -->
                    <div id="sidebar-scroll">
                        <!-- Sidebar Content -->
                        <div class="sidebar-content">
                            <!-- Sidebar Navigation -->
                            <ul class="sidebar-nav">
                                <li>
                                    <a href="index.html" class=" active"><i class="gi gi-compass sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">Dashboard</span></a>
                                </li>
                                <li class="sidebar-separator">
                                    <i class="fa fa-ellipsis-h"></i>
                                </li>
                                <li>
                                    <a href="#" class="sidebar-nav-menu"><i class="fa fa-chevron-left sidebar-nav-indicator sidebar-nav-mini-hide"></i><i class="fa fa-rocket sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">User Interface</span></a>
                                    <ul>
                                        <li>
                                            <a href="page_ui_widgets.html">Widgets</a>
                                        </li>
                                        <li>
                                            <a href="#" class="sidebar-nav-submenu"><i class="fa fa-chevron-left sidebar-nav-indicator"></i>Elements</a>
                                            <ul>
                                                <li>
                                                    <a href="page_ui_blocks_grid.html">Blocks &amp; Grid</a>
                                                </li>
                                                <li>
                                                    <a href="page_ui_typography.html">Typography</a>
                                                </li>
                                                <li>
                                                    <a href="page_ui_buttons_dropdowns.html">Buttons &amp; Dropdowns</a>
                                                </li>
                                                <li>
                                                    <a href="page_ui_navigation_more.html">Navigation &amp; More</a>
                                                </li>
                                                <li>
                                                    <a href="page_ui_progress_loading.html">Progress &amp; Loading</a>
                                                </li>
                                                <li>
                                                    <a href="page_ui_tables.html">Tables</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="#" class="sidebar-nav-submenu"><i class="fa fa-chevron-left sidebar-nav-indicator"></i>Forms</a>
                                            <ul>
                                                <li>
                                                    <a href="page_forms_components.html">Components</a>
                                                </li>
                                                <li>
                                                    <a href="page_forms_wizard.html">Wizard</a>
                                                </li>
                                                <li>
                                                    <a href="page_forms_validation.html">Validation</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="#" class="sidebar-nav-submenu"><i class="fa fa-chevron-left sidebar-nav-indicator"></i>Icon Packs</a>
                                            <ul>
                                                <li>
                                                    <a href="page_ui_icons_fontawesome.html">Font Awesome</a>
                                                </li>
                                                <li>
                                                    <a href="page_ui_icons_glyphicons_pro.html">Glyphicons Pro</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" class="sidebar-nav-menu"><i class="fa fa-chevron-left sidebar-nav-indicator sidebar-nav-mini-hide"></i><i class="gi gi-airplane sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">Components</span></a>
                                    <ul>
                                        <li>
                                            <a href="page_comp_todo.html">To-do List</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_gallery.html">Gallery</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_maps.html">Google Maps</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_calendar.html">Calendar</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_charts.html">Charts</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_animations.html">CSS3 Animations</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_tree.html">Tree View Lists</a>
                                        </li>
                                        <li>
                                            <a href="page_comp_nestable.html">Nestable &amp; Sortable Lists</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" class="sidebar-nav-menu"><i class="fa fa-chevron-left sidebar-nav-indicator sidebar-nav-mini-hide"></i><i class="gi gi-more_items sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">UI Layouts</span></a>
                                    <ul>
                                        <li>
                                            <a href="page_layout_static.html">Static</a>
                                        </li>
                                        <li>
                                            <a href="page_layout_static_fixed_width.html">Static Fixed Width</a>
                                        </li>
                                        <li>
                                            <a href="page_layout_fixed_top.html">Top Header (Fixed)</a>
                                        </li>
                                        <li>
                                            <a href="page_layout_fixed_bottom.html">Bottom Header (Fixed)</a>
                                        </li>
                                        <li>
                                            <a href="page_layout_static_sidebar_mini.html">Sidebar Mini (Static)</a>
                                        </li>
                                        <li>
                                            <a href="page_layout_fixed_sidebar_mini.html">Sidebar Mini (Fixed)</a>
                                        </li>
                                        <li>
                                            <a href="page_layout_alternative_sidebar_visible.html">Visible Alternative Sidebar</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" class="sidebar-nav-menu"><i class="fa fa-chevron-left sidebar-nav-indicator sidebar-nav-mini-hide"></i><i class="fa fa-gift sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">Extra Pages</span></a>
                                    <ul>
                                        <li>
                                            <a href="page_ready_error.html">Error Page</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_blank.html">Blank</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_article.html">Article</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_timeline.html">Timeline</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_invoice.html">Invoice</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_search_results.html">Search Results</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_pricing_tables.html">Pricing Tables</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_faq.html">FAQ</a>
                                        </li>
                                        <li>
                                            <a href="page_ready_profile.html">User Profile</a>
                                        </li>
                                        <li>
                                            <a href="#" class="sidebar-nav-submenu"><i class="fa fa-chevron-left sidebar-nav-indicator"></i>Login, Register &amp; Lock</a>
                                            <ul>
                                                <li>
                                                    <a href="page_ready_login.html">Login</a>
                                                </li>
                                                <li>
                                                    <a href="page_ready_reminder.html">Password Reminder</a>
                                                </li>
                                                <li>
                                                    <a href="page_ready_register.html">Register</a>
                                                </li>
                                                <li>
                                                    <a href="page_ready_lock_screen.html">Lock Screen</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li class="sidebar-separator">
                                    <i class="fa fa-ellipsis-h"></i>
                                </li>
                                <li>
                                    <a href="page_app_email.html"><i class="gi gi-inbox sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">Email Center</span></a>
                                </li>
                                <li>
                                    <a href="page_app_social.html"><i class="fa fa-share-alt sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">Social Net</span></a>
                                </li>
                                <li>
                                    <a href="page_app_media.html"><i class="gi gi-picture sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">Media Box</span></a>
                                </li>
                                <li>
                                    <a href="page_app_estore.html"><i class="gi gi-shopping_cart sidebar-nav-icon"></i><span class="sidebar-nav-mini-hide">eStore</span></a>
                                </li>
                            </ul>
                            <!-- END Sidebar Navigation -->

                            <!-- Color Themes -->
                            <!-- Preview a theme on a page functionality can be found in js/app.js - colorThemePreview() -->
                            <jsp:include page="/jsp/v8/common_themecolor.jsp"></jsp:include>
                            <!-- END Color Themes -->
                        </div>
                        <!-- END Sidebar Content -->
                    </div>
                    <!-- END Wrapper for scrolling functionality -->

                    <!-- Sidebar Extra Info -->
                    <div id="sidebar-extra-info" class="sidebar-content sidebar-nav-mini-hide">
                        <div class="push-bit">
                            <span class="pull-right">
                                <a href="javascript:void(0)" class="text-light"><i class="fa fa-plus"></i></a>
                            </span>
                            <small><strong class="text-light">78 GB</strong> / 100 GB</small>
                        </div>
                        <div class="progress progress-mini push-bit">
                            <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100" style="width: 78%"></div>
                        </div>
                        <div class="text-center">
                            <small>Crafted with <i class="fa fa-heart text-danger"></i> by <a href="http://goo.gl/vNS3I" target="_blank">pixelcave</a></small><br>
                            <small><span id="year-copy"></span> &copy; <a href="http://goo.gl/RcsdAh" target="_blank">AppUI 1.2</a></small>
                        </div>
                    </div>
                    <!-- END Sidebar Extra Info -->
                </div>
                <!-- END Main Sidebar -->

                <!-- Main Container -->
                <div id="main-container">
                    <!-- Header -->
                    <!-- In the PHP version you can set the following options from inc/config file -->
                    <!--
                        Available header.navbar classes:

                        'navbar-default'            for the default light header
                        'navbar-inverse'            for an alternative dark header

                        'navbar-fixed-top'          for a top fixed header (fixed main sidebar with scroll will be auto initialized, functionality can be found in js/app.js - handleSidebar())
                            'header-fixed-top'      has to be added on #page-container only if the class 'navbar-fixed-top' was added

                        'navbar-fixed-bottom'       for a bottom fixed header (fixed main sidebar with scroll will be auto initialized, functionality can be found in js/app.js - handleSidebar()))
                            'header-fixed-bottom'   has to be added on #page-container only if the class 'navbar-fixed-bottom' was added
                    -->
                    <header class="navbar navbar-inverse navbar-fixed-top">
                        <!-- Left Header Navigation -->
                        <jsp:include page="/jsp/v8/common_head_left.jsp"></jsp:include>
                        <!-- END Left Header Navigation -->

                        <!-- Right Header Navigation -->
                        <jsp:include page="/jsp/v8/common_head_right.jsp"></jsp:include>
                        <!-- END Right Header Navigation -->
                    </header>
                    <!-- END Header -->

                    <!-- Page content -->
                    <div id="page-content">
                        <!-- First Row -->
                        <div class="row">
                            <!-- Simple Stats Widgets -->
                            <div class="col-sm-6 col-lg-3">
                                <a href="javascript:void(0)" class="widget">
                                    <div class="widget-content widget-content-mini themed-background-success text-light-op">
                                        <i class="fa fa-clock-o"></i> <strong>Today</strong>
                                    </div>
                                    <div class="widget-content text-right clearfix">
                                        <div class="widget-icon pull-left">
                                            <i class="gi gi-user text-muted"></i>
                                        </div>
                                        <h2 class="widget-heading h3 text-success">
                                            <i class="fa fa-plus"></i> <strong><span data-toggle="counter" data-to="2862"></span></strong>
                                        </h2>
                                        <span class="text-muted">NEW USERS</span>
                                    </div>
                                </a>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <a href="javascript:void(0)" class="widget">
                                    <div class="widget-content widget-content-mini themed-background-warning text-light-op">
                                        <i class="fa fa-clock-o"></i> <strong>Last Month</strong>
                                    </div>
                                    <div class="widget-content text-right clearfix">
                                        <div class="widget-icon pull-left">
                                            <i class="gi gi-briefcase text-muted"></i>
                                        </div>
                                        <h2 class="widget-heading h3 text-warning">
                                            <i class="fa fa-plus"></i> <strong><span data-toggle="counter" data-to="75"></span></strong>
                                        </h2>
                                        <span class="text-muted">PROJECTS</span>
                                    </div>
                                </a>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <a href="javascript:void(0)" class="widget">
                                    <div class="widget-content widget-content-mini themed-background-danger text-light-op">
                                        <i class="fa fa-clock-o"></i> <strong>Last Month</strong>
                                    </div>
                                    <div class="widget-content text-right clearfix">
                                        <div class="widget-icon pull-left">
                                            <i class="gi gi-wallet text-muted"></i>
                                        </div>
                                        <h2 class="widget-heading h3 text-danger">
                                            <i class="fa fa-dollar"></i> <strong><span data-toggle="counter" data-to="5820"></span></strong>
                                        </h2>
                                        <span class="text-muted">EARNINGS</span>
                                    </div>
                                </a>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <a href="javascript:void(0)" class="widget">
                                    <div class="widget-content widget-content-mini themed-background text-light-op">
                                        <i class="fa fa-clock-o"></i> <strong>Last Month</strong>
                                    </div>
                                    <div class="widget-content text-right clearfix">
                                        <div class="widget-icon pull-left">
                                            <i class="gi gi-cardio text-muted"></i>
                                        </div>
                                        <h2 class="widget-heading h3">
                                            <strong><span data-toggle="counter" data-to="2835"></span></strong>
                                        </h2>
                                        <span class="text-muted">SALES</span>
                                    </div>
                                </a>
                            </div>
                            <!-- END Simple Stats Widgets -->
                        </div>
                        <!-- END First Row -->

                        <!-- Second Row -->
                        <div class="row">
                            <div class="col-sm-6 col-lg-8">
                                <!-- Chart Widget -->
                                <div class="widget">
                                    <div class="widget-content widget-content-mini themed-background-dark text-light-op">
                                        <span class="pull-right text-muted">2013</span>
                                        <i class="fa fa-fw fa-database"></i> <strong>Last Year Data</strong>
                                    </div>
                                    <div class="widget-content themed-background-muted">
                                        <!-- Flot Charts (initialized in js/pages/readyDashboard.js), for more examples you can check out http://www.flotcharts.org/ -->
                                        <div id="chart-classic-dash" style="height: 393px;"></div>
                                    </div>
                                    <div class="widget-content">
                                        <div class="row text-center">
                                            <div class="col-xs-4">
                                                <h3 class="widget-heading"><i class="gi gi-wallet text-primary push-bit"></i> <br><small>41k Earnings</small></h3>
                                            </div>
                                            <div class="col-xs-4">
                                                <h3 class="widget-heading"><i class="gi gi-cardio text-black push-bit"></i> <br><small>17k Sales</small></h3>
                                            </div>
                                            <div class="col-xs-4">
                                                <h3 class="widget-heading"><i class="gi gi-life_preserver text-muted push-bit"></i> <br><small>3165 Tickets</small></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END Chart Widget -->
                            </div>
                            <div class="col-sm-6 col-lg-4">
                                <!-- Stats User Widget -->
                                <a href="javascript:void(0)" class="widget">
                                    <div class="widget-content widget-content-mini themed-background-dark text-light-op">
                                        <i class="fa fa-fw fa-trophy"></i> <strong>Creator of the day</strong>
                                    </div>
                                    <div class="widget-content text-center">
                                        <img src="<%=V8SystemConstants.V8_PATH %>img/placeholders/avatars/avatar13@2x.jpg" alt="avatar" class="img-circle img-thumbnail img-thumbnail-avatar-2x">
                                        <h2 class="widget-heading h3 text-muted">Anna Wigren</h2>
                                    </div>
                                    <div class="widget-content themed-background-muted text-dark text-center">
                                        <strong>Logo Designer</strong>, Sweden
                                    </div>
                                    <div class="widget-content">
                                        <div class="row text-center">
                                            <div class="col-xs-4">
                                                <h3 class="widget-heading"><i class="gi gi-share_alt text-success push-bit"></i> <br><small>58.6k Followers</small></h3>
                                            </div>
                                            <div class="col-xs-4">
                                                <h3 class="widget-heading"><i class="gi gi-briefcase text-info push-bit"></i> <br><small>35 Projects</small></h3>
                                            </div>
                                            <div class="col-xs-4">
                                                <h3 class="widget-heading"><i class="gi gi-heart_empty text-danger push-bit"></i> <br><small>5.3k Likes</small></h3>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <!-- END Stats User Widget -->

                                <!-- Mini Widgets Row -->
                                <div class="row">
                                    <div class="col-xs-6">
                                        <a href="javascript:void(0)" class="widget text-center">
                                            <div class="widget-content themed-background-info text-light-op text-center">
                                                <div class="widget-icon center-block push">
                                                    <i class="fa fa-facebook"></i>
                                                </div>
                                                <strong>98k Likes</strong>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="javascript:void(0)" class="widget">
                                            <div class="widget-content themed-background-danger text-light-op text-center">
                                                <div class="widget-icon center-block push">
                                                    <i class="fa fa-database"></i>
                                                </div>
                                                <strong>3 Servers</strong>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END Mini Widgets Row -->
                            </div>
                        </div>
                        <!-- END Second Row -->

                        <!-- Third Row -->
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <!-- Project Widget -->
                                        <div class="widget">
                                            <div class="widget-content widget-content-mini themed-background-dark text-light-op">
                                                <span class="pull-right text-muted">60%</span>
                                                <i class="fa fa-fw fa-check"></i> Custom Project
                                            </div>
                                            <a href="javascript:void(0)" class="widget-content text-right clearfix">
                                                <img src="<%=V8SystemConstants.V8_PATH %>img/placeholders/avatars/avatar6.jpg" alt="avatar" class="img-circle img-thumbnail img-thumbnail-avatar pull-left">
                                                <h2 class="widget-heading h3 text-muted">Logo</h2>
                                                <div class="progress progress-striped progress-mini active">
                                                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width: 85%"></div>
                                                </div>
                                            </a>
                                            <a href="javascript:void(0)" class="widget-content text-right clearfix">
                                                <img src="<%=V8SystemConstants.V8_PATH %>img/placeholders/avatars/avatar2.jpg" alt="avatar" class="img-circle img-thumbnail img-thumbnail-avatar pull-left">
                                                <h2 class="widget-heading h3 text-muted">Icon Pack</h2>
                                                <div class="progress progress-striped progress-mini active">
                                                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"></div>
                                                </div>
                                            </a>
                                            <a href="javascript:void(0)" class="widget-content text-right clearfix">
                                                <img src="<%=V8SystemConstants.V8_PATH %>img/placeholders/avatars/avatar11.jpg" alt="avatar" class="img-circle img-thumbnail img-thumbnail-avatar pull-left">
                                                <h2 class="widget-heading h3 text-muted">Design</h2>
                                                <div class="progress progress-striped progress-mini active">
                                                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" style="width: 55%"></div>
                                                </div>
                                            </a>
                                            <div class="widget-content themed-background-muted text-dark">
                                                <div class="row text-center">
                                                    <div class="col-xs-6">
                                                        <i class="fa fa-check-circle-o"></i> On Time
                                                    </div>
                                                    <div class="col-xs-6">
                                                        <i class="fa fa-clock-o"></i> 17 Days
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- END Project Widget -->
                                    </div>
                                    <div class="col-sm-6">
                                        <!-- Image Widget -->
                                        <div class="widget">
                                            <div class="widget-content widget-content-mini themed-background-dark text-light-op">
                                                <span class="pull-right text-muted">Featured</span>
                                                <i class="fa fa-fw fa-pencil"></i> <strong>Story</strong>
                                            </div>
                                            <div class="widget-image">
                                                <img src="<%=V8SystemConstants.V8_PATH %>img/placeholders/photos/photo9.jpg" alt="image">
                                                <div class="widget-image-content">
                                                    <h2 class="widget-heading"><a href="page_ready_article.html" class="text-light"><strong>The autumn trip that changed my life</strong></a></h2>
                                                    <h3 class="widget-heading text-light-op h4">It changed the way I think</h3>
                                                </div>
                                                <i class="gi gi-airplane"></i>
                                            </div>
                                            <div class="widget-content text-dark">
                                                <div class="row text-center">
                                                    <div class="col-xs-4">
                                                        <i class="fa fa-heart-o"></i> 9.5k
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <i class="fa fa-eye"></i> 76k
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <i class="fa fa-share-alt"></i> 7.2k
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- END Image Widget -->
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="row">
                                    <!-- Mini Stats Widgets -->
                                    <div class="col-xs-12">
                                        <a href="javascript:void(0)" class="widget text-center">
                                            <div class="widget-content text-center clearfix">
                                                <div class="widget-icon themed-background-warning pull-right">
                                                    <i class="gi gi-warning_sign fa-fw text-light"></i>
                                                </div>
                                                <img src="<%=V8SystemConstants.V8_PATH %>img/placeholders/avatars/avatar9.jpg" alt="avatar" class="img-circle img-thumbnail img-thumbnail-avatar pull-left">
                                                <h2 class="widget-heading h3 text-warning">
                                                    <i class="fa fa-plus"></i> <strong><span data-toggle="counter" data-to="26"></span></strong>
                                                </h2>
                                                <span class="text-muted">Requests</span>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="javascript:void(0)" class="widget text-center">
                                            <div class="widget-content">
                                                <i class="fa fa-3x fa-cloud-download text-success"></i>
                                            </div>
                                            <div class="widget-content themed-background-muted text-dark">
                                                <strong>35k</strong> Downloads
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="javascript:void(0)" class="widget text-center">
                                            <div class="widget-content">
                                                <i class="fa fa-3x fa-bookmark text-danger"></i>
                                            </div>
                                            <div class="widget-content themed-background-muted text-dark">
                                                <strong>760</strong> Bookmarks
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="javascript:void(0)" class="widget text-center">
                                            <div class="widget-content">
                                                <i class="fa fa-3x fa-twitter"></i>
                                            </div>
                                            <div class="widget-content themed-background-muted text-dark">
                                                <strong>35k</strong> Followers
                                            </div>
                                        </a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="javascript:void(0)" class="widget text-center">
                                            <div class="widget-content">
                                                <i class="fa fa-3x fa-wordpress text-dark"></i>
                                            </div>
                                            <div class="widget-content themed-background-muted text-dark">
                                                <strong>15</strong> Themes
                                            </div>
                                        </a>
                                    </div>
                                    <!-- END Mini Stats Widgets -->
                                </div>
                            </div>
                        </div>
                        <!-- END Third Row -->
                    </div>
                    <!-- END Page Content -->
                </div>
                <!-- END Main Container -->
            </div>
            <!-- END Page Container -->
        </div>
        <!-- END Page Wrapper -->

        <!-- Include Jquery library from Google's CDN but if something goes wrong get Jquery from local file (Remove 'http:' if you have SSL) -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script>!window.jQuery && document.write(decodeURI('%3Cscript src="js/vendor/jquery-2.1.1.min.js"%3E%3C/script%3E'));</script>

        <!-- Bootstrap.js, Jquery plugins and Custom JS code -->
        <script src="<%=V8SystemConstants.V8_PATH %>js/vendor/bootstrap.min.js"></script>
        <script src="<%=V8SystemConstants.V8_PATH %>js/plugins.js"></script>
        <script src="<%=V8SystemConstants.V8_PATH %>js/app.js"></script>

        <!-- Load and execute javascript code used only in this page -->
        <script src="<%=V8SystemConstants.V8_PATH %>js/pages/readyDashboard.js"></script>
        <script>$(function(){ ReadyDashboard.init(); });</script>
    </body>
</html>
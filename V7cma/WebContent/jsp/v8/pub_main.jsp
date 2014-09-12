<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%@ page import="com.imagsky.util.*"%>
<%@ page import="com.imagsky.v6.domain.*" %>
<%@ page import="com.imagsky.common.*" %>
<%@ page import="com.imagsky.v6.cma.constants.*" %>
<%@include file="/init.jsp" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Value Website Template | Home :: w3layouts</title>
        <link href="/files/web/css/bootstrap.css" rel='stylesheet' type='text/css' />
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <!-- <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERY")%>"></script>-->
        <script src="/files/web/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=staticPath%>/js/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQUERYUI")%>"></script>
         <!-- Custom Theme files -->
        <link href="/files/web/css/style.css" rel='stylesheet' type='text/css' />
        <!-- 
        <link href="<%=staticPath%>/css/flick/<%=MessageUtil.getV6Message(lang, "SYS_JS_JQCSS")%>" rel="stylesheet" type="text/css"/>
         -->
         <link href="/files/css/custom-theme/jquery-ui-1.11.1.css" rel="stylesheet" type="text/css"/>
         <!-- Custom Theme files -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        </script>
        <!----webfonts--->
        <link href='http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900' rel='stylesheet' type='text/css'>
        <!---//webfonts--->
        <!---- start-smoth-scrolling---->
        <script type="text/javascript" src="/files/web/js/move-top.js"></script>
        <script type="text/javascript" src="/files/web/js/easing.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function($) {
                $(".scroll").click(function(event){     
                    event.preventDefault();
                    $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
                });
            });
        </script>
         <!---- start-smoth-scrolling---->
    </head>
    <body>
        <!---- container ---->
        <div class="container">
            <!---- header ---->
            <div class="header">
                <div class="col-md-5 header-left">
                    <!----sreen-gallery-cursual---->
                        <div class="sreen-gallery-cursual">
                             <!-- requried-jsfiles-for owl -->
                            <link href="/files/web/css/owl.carousel.css" rel="stylesheet">
                                <script src="/files/web/js/owl.carousel.js"></script>
                                    <script>
                                $(document).ready(function() {
                                  $("#owl-demo").owlCarousel({
                                    items : 1,
                                    lazyLoad : true,
                                    autoPlay : true,
                                    navigation : false,
                                    navigationText :  false,
                                    pagination : true,
                                  });
                                });
                                </script>
                             <!-- //requried-jsfiles-for owl -->
                             <!-- start content_slider -->
                               <div id="owl-demo" class="owl-carousel">
                                    <div class="item">
                                        <img src="/files/web/images/divice.png" title="name" />
                                    </div>
                                    <div class="item">
                                        <img src="/files/web/images/divice.png" title="name" />
                                    </div>
                                    <div class="item">
                                        <img src="/files/web/images/divice.png" title="name" />
                                    </div>
                              </div>
                        <!--//sreen-gallery-cursual---->
                </div>
                </div>
                <div class="col-md-7 header-right" id="dcontent">
                    <!-- Dynamic Content Page -->
                    <script>
                    var jqxhr = $.ajax( "/do/PAGE/INPUT_EMAIL" )
                    .done(function(html) {
                    	$('#dcontent').append(html);
   //                   alert( "success" );
                    })
                    .fail(function() {
                      alert( "error" );
                    })
                    .always(function() {
//                      alert( "complete" );
                    });
                    jqxhr.always(function() {
//                    	  alert( "second complete" );
                   });
                    </script>
                    <!-- End of Dynamic Content-->
                </div>
                <div class="clearfix"> </div>
            </div>
            </div>
            <!---- header ---->
            <!----- top-grids ----->
            <div class="top-grids">
                <div class="container">
                    <div class="top-grids-head text-center">
                        <h3>Clean and simple Landing page for  Apps</h3>
                        <p>Reference site about Lorem Ipsum, giving information on its origins, as well as a random Lipsum In publishing and graphic design, lorem ipsum is a  a document or visual presentation.generator.</p>
                    </div>
                    <div class="top-grids-box">
                        <div class="col-md-4  top-grid text-center">
                                <span class="t-icon1"> </span>
                                <h4>Very Smart</h4>
                                <p>Lorem Ipsum is simply Ipsum has been the industry's text of the printing and typesetting industry. </p>
                        </div>
                        <div class="col-md-4  top-grid text-center">
                                <span class="t-icon2"> </span>
                                <h4>Responsive</h4>
                                <p>Lorem Ipsum is simply Ipsum has been the industry's text of the printing and typesetting industry. </p>
                        </div>
                        <div class="col-md-4  top-grid text-center">
                                <span class="t-icon3"> </span>
                                <h4>Crisp & clear</h4>
                                <p>Lorem Ipsum is simply Ipsum has been the industry's text of the printing and typesetting industry. </p>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
            <!----- top-grids ----->
            <!----- featrues-grids----->
            <div class="fea-grids">
                <div class="container">
                <div class="col-md-6 fea-grids-left">
                    <script>
                                $(document).ready(function() {
                                  $("#owl-demo1").owlCarousel({
                                    items : 1,
                                    lazyLoad : true,
                                    autoPlay : true,
                                    navigation : false,
                                    navigationText :  false,
                                    pagination : true,
                                  });
                                });
                                </script>
                             <!-- //requried-jsfiles-for owl -->
                             <!-- start content_slider -->
                               <div id="owl-demo1" class="owl-carousel">
                                    <div class="item">
                                        <img src="/files/web/images/divice-screen.png" title="name" />
                                    </div>
                                    <div class="item">
                                        <img src="/files/web/images/divice-screen.png" title="name" />
                                    </div>
                                    <div class="item">
                                        <img src="/files/web/images/divice-screen.png" title="name" />
                                    </div>
                              </div>
                        <!--//sreen-gallery-cursual---->
                </div>
                <div class="col-md-6 fea-grids-left">
                        <h3>Features availalbe with Easy perfect free app </h3>
                        <div class="fea-grids-left-grids">
                            <div class="fea-grids-left-grid">
                                <div class="fea-grids-left-grid-left">
                                    <span class="fea-icon1"> </span>
                                </div>
                                <div class="fea-grids-left-grid-right">
                                    <h4>Beautiful, modern design</h4>
                                    <p>Duis bibendum diam non erat facilaisis tincidunt. </p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>
                            <div class="fea-grids-left-grid">
                                <div class="fea-grids-left-grid-left">
                                    <span class="fea-icon2"> </span>
                                </div>
                                <div class="fea-grids-left-grid-right">
                                    <h4>Easy to customize</h4>
                                    <p>Duis bibendum diam non erat facilaisis tincidunt. </p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>
                            <div class="fea-grids-left-grid">
                                <div class="fea-grids-left-grid-left">
                                    <span class="fea-icon3"> </span>
                                </div>
                                <div class="fea-grids-left-grid-right">
                                    <h4>Developer Friendly</h4>
                                    <p>Duis bibendum diam non erat facilaisis tincidunt. </p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>
                            <div class="fea-grids-left-grid">
                                <div class="fea-grids-left-grid-left">
                                    <span class="fea-icon4"> </span>
                                </div>
                                <div class="fea-grids-left-grid-right">
                                    <h4>Fully Responsive</h4>
                                    <p>Duis bibendum diam non erat facilaisis tincidunt. </p>
                                </div>
                                <div class="clearfix"> </div>
                            </div>
                        </div>
                </div>
                <div class="clearfix"> </div>
            </div>
            </div>
            <!----- featrues-grids----->
            <!----- testmonials ---->
            <div class="testmonials">
                <div class="container">
                    <script>
                                $(document).ready(function() {
                                  $("#owl-demo2").owlCarousel({
                                    items : 1,
                                    lazyLoad : true,
                                    autoPlay : true,
                                    navigation : false,
                                    navigationText :  false,
                                    pagination : true,
                                  });
                                });
                                </script>
                             <!-- //requried-jsfiles-for owl -->
                             <!-- start content_slider -->
                               <div id="owl-demo2" class="owl-carousel">
                                    <div class="item">
                                        <div class="testmonial-grids">
                                            <div class="testmonial-head text-center">
                                                <img src="/files/web/images/quit.png" title="name" />
                                                <p>"Sed sagittis tortor vel arcu sollicitudin nec tincidunt metus suscipit Nunc velit risus, dapibus non interdum.Nunc velit risus, dapibus non"</p>
                                            </div>
                                            <div class="testmonial-row">
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic1.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Wells Riley</h4>
                                                        <span>Designer</span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic2.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Anthony Lagoon</h4>
                                                        <span>photographer</span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic3.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Anna Yeaman</h4>
                                                        <span>Creative Director </span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="clearfix"> </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testmonial-grids">
                                            <div class="testmonial-head text-center">
                                                <img src="/files/web/images/quit.png" title="name" />
                                                <p>"Sed sagittis tortor vel arcu sollicitudin nec tincidunt metus suscipit Nunc velit risus, dapibus non interdum.Nunc velit risus, dapibus non"</p>
                                            </div>
                                            <div class="testmonial-row">
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic1.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Wells Riley</h4>
                                                        <span>Designer</span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic2.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Anthony Lagoon</h4>
                                                        <span>photographer</span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic3.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Anna Yeaman</h4>
                                                        <span>Creative Director </span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="clearfix"> </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item">
                                        <div class="testmonial-grids">
                                            <div class="testmonial-head text-center">
                                                <img src="/files/web/images/quit.png" title="name" />
                                                <p>"Sed sagittis tortor vel arcu sollicitudin nec tincidunt metus suscipit Nunc velit risus, dapibus non interdum.Nunc velit risus, dapibus non"</p>
                                            </div>
                                            <div class="testmonial-row">
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic1.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Wells Riley</h4>
                                                        <span>Designer</span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic2.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Anthony Lagoon</h4>
                                                        <span>photographer</span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="col-md-4 testmonial-grid">
                                                    <div class="t-people-left">
                                                        <img src="/files/web/images/t-pic3.png" title="name" />
                                                    </div>
                                                    <div class="t-people-right">
                                                        <h4>Anna Yeaman</h4>
                                                        <span>Creative Director </span>
                                                    </div>
                                                    <div class="clearfix"> </div>
                                                </div>
                                                <div class="clearfix"> </div>
                                            </div>
                                        </div>
                                    </div>
                              </div>
                        <!--//sreen-gallery-cursual---->
                </div>
            </div>
            <!----- testmonials ---->
            <!----- notify ---->
            <div class="notify">
                <div class="container">
                    <div class="notify-grid">
                        <img src="/files/web/images/msg-icon.png" title="mail" />
                        <h3>Get Notified of any updates!</h3>
                        <p>Subscribe to our newsletter to be notified about new version release</p>
                        <form>
                            <input type="text" class="text" value="Your email address" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Your email address';}">
                            <input type="submit" value="Submit" />
                        </form>
                    </div>
                </div>
            </div>
            <!----- notify ---->
            <!----- social-icons ---->
            <div class="social-icons">
                <div class="container">
                    <ul>
                        <li><a class="twitter" href="#"><span> </span></a></li>
                        <li><a class="facebook" href="#"><span> </span></a></li>
                        <li><a class="vemeo" href="#"><span> </span></a></li>
                        <li><a class="pin" href="#"><span> </span></a></li>
                        <div class="clearfix"> </div>
                    </ul>
                </div>
                <!---- footer-links ---->
                <div class="footer-links">
                    <ul>
                        <li><p>Design by <a href="http://w3layouts.com/">W3layouts</a></p><span> </span></li>
                        <li><a href="#"> Terms of Use </a><span> </span></li>
                        <li><a href="#"> Support </a><span> </span></li>
                        <li><a href="#">  Help </a></li>
                    </ul>
                    <script type="text/javascript">
                                    $(document).ready(function() {
                                        /*
                                        var defaults = {
                                            containerID: 'toTop', // fading element id
                                            containerHoverID: 'toTopHover', // fading element hover id
                                            scrollSpeed: 1200,
                                            easingType: 'linear' 
                                        };
                                        */
                                        
                                        $().UItoTop({ easingType: 'easeOutQuart' });
                                        
                                    });
                                </script>
                                    <a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>
                </div>
                <!---- footer-links ---->
            </div>
            <!----- social-icons ---->
        </div>
        <!---- container ---->
    </body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="Asia Miles, Air travels, Hotels, Asiamiles, Airline benefits, Dining, CX, Airline companies, Restaurants, Hong Kong, Airline members, partners, Cathay, Loyalty programmes, Petrol stations, Cathay Pacific, Loyalty programs, Credit cards, Cathay Pacific Frequent Flyer, Airline programmes, Financial services, Lifestyle awards, Airline programs, Conversion, Lifestyle award catalogue, Airline, Petrol stations, Lifestyle award catalog, Award programs, Health and beauty, Gift Miles, Award tickets, Car rental, Top up, Clubs, Luggage, Top-up, Earn free travel, Flowers, Transfer miles, Flight information, Telecommunications, Renew miles, Flight planner, Internet, Purchase miles, Flights, Holidays, Buy miles, Free air tickets, Frequent flyer program, enews, Free flights, Frequent flyer programme, subscription, Free travel, Reward programmes, Mileage calculator, Frequent flyer, Reward programs, Ticket offers, Ticket redemption, Travel awards" name="Keywords"/>
<meta content="Asia's leading travel reward programme that offers you a range of exciting rewards that match your lifestyle." name="Description"/>
<title>加油</title>
<link href="css/flick/jquery-ui-1.8.custom.css" rel="stylesheet" type="text/css"/>
<link href="css/en.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/en_print.css" rel="stylesheet" type="text/css" media="print"/>

<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="/files/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/files/ckfinder/ckfinder.js"></script>

<!--// script for sliding sidebar //-->
<script src="script/common_DOMControl.js" type="text/javascript"></script>
<script src="script/slidemenu.js" type="text/javascript"></script>
<!--// script for dropdown menu //-->
<script src="script/init.js" type="text/javascript"></script>
<script type="text/javascript">
<!--//--><![CDATA[//><!--

//initialize slider
sb_setting=new Object();
sb_setting.opened_item=0;
sb_setting.allowMultiopen=false;
//sb_setting.delayOpen=1000;		// in ms, -1 for no delay
sb_setting.delayOpen=-1;
sb_setting.maxheight=-1;			// set to -1 for autosize

//initialize auto complete
//var ACManager = new autoComplete();
var config=[{id:"txt_search", hasScroll:false, maxRow:10} ];

function pagaInit() {
	drawmenu("ctnSidebar", sb_setting);
//	ACManager.setFields(config);
}

$(function(){
	//Tabs
	$('#tabs').tabs();
});
//--><!]]>
</script>
<style id="styles" type="text/css">

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

// Uncomment the following code to test the "Timeout Loading Method".
// CKEDITOR.loadFullCoreTimeout = 5;

window.onload = function()
{
	pagaInit();
	// Listen to the double click event.
	if ( window.addEventListener )
		document.body.addEventListener( 'dblclick', onDoubleClick, false );
	else if ( window.attachEvent )
		document.body.attachEvent( 'ondblclick', onDoubleClick );

};

function onDoubleClick( ev )
{
	// Get the element which fired the event. This is not necessarily the
	// element to which the event has been attached.
	var element = ev.target || ev.srcElement;

	// Find out the div that holds this element.
	element = element.parentNode;

	if ( element.nodeName.toLowerCase() == 'div'
		 && ( element.className.indexOf( 'editable' ) != -1 ) )
		replaceDiv( element );
}

var editor;

function replaceDiv( div )
{
	if ( editor )
		editor.destroy();

	editor = CKEDITOR.replace( div );
	CKFinder.SetupCKEditor( editor, '/files/ckfinder/' );
}

	//]]>
	</script>


</head>
<body>
<div id="main_container">
	<div id="header">
		<div class="logo_bar">
			<h1 class="AE_logo"><a href="index.htm"><span></span><img src="/cma/images/aelogo.jpg" alt=""/></a></h1>
		
			<ul class="lang_switch">
				<li><a href="/web/homepage?lang=en" >ENG</a></li>
				<li><a href="/web/homepage?lang=zh"  class="selected">&#x7E41;&#x9AD4;&#x4E2D;&#x6587;</a></li>
				<li><a href="/web/homepage?lang=sc" >&#x7B80;&#x4F53;&#x4E2D;&#x6587;</a></li>
		
				<li><a href="/web/homepage?lang=ja" >&#x65E5;&#x672C;&#x8A9E;</a></li>
				<li><a href="/web/homepage?lang=ko" >&#xD55C;&#xAD6D;&#xC5B4;</a></li>
			</ul>

		</div>
		<div id="main_nav">
			<ul class="menu">
				<jsp:include page="/jsp/common/com_topnav.jsp"></jsp:include>
			</ul>
			<div class="search">
				<input  id="txt_search" name="txt_search" type="text" accesskey="h" tabindex="1" value="Search" maxlength="50" onfocus="fn_focusSearch(this);" onblur="fn_blurSearh(this);"  class="txt_search_off" />
				<input  type="button" name="btn_go" id="btn_go" value="Go" class="btnGeneric" />
			</div>
		</div>
		<div id="breadcrumb">
			<ul>
				<li><a href="#" >Parent Page</a></li>
				<li> > </li>
				<li><a href="#" >Parent Page</a></li>
				<li> > </li>
				<li><strong>Current Page</strong></li>
			</ul>
		</div>
		<div class="banner_row">
			<div id="hdrBanner"> <img class="bannerImg" src="images/banner_about.jpg" alt="Banner Image" width="699" height="160"/>
				<div class="bannerMsg"> <img src="images/hdr_about.gif" alt="About Asia Miles" /> </div>
			</div>
			<div class="login_form">
				<form action="do/LOGIN?action=LOGIN">
					<input type="hidden" name="action" value="LOGIN"/>
					<table class="tbl_transparent">
						<tr>
							<td colspan="2"><label for="txtMbrID">登入電郵</label>
								<input  name="txtMbrID" id="txtMbrID" type="text" title="Enter your membership number or username here" class="text" />
							</td>
						</tr>
						<tr>
							<td colspan="2"><label for="txtMbrPIN">密碼</label>
								<input  name="txtMbrPIN" id="txtMbrPIN" type="password"  title="Enter your PIN here" class="text" />
							</td>
						</tr>
						<tr>
							<td><label>
								<input  name="chkRbrMe" id="chkRbrMe" type="checkbox" title="Remember your login next time" class="chkbox" />
								Remember Me </label>
							</td>
							<td><input  type="button" name="btn_login" id="btn_login" value="登入" class="btnGeneric" /></td>
						</tr>
						<tr>
							<td colspan="2"><div><a title="Click here if you have login problems" href="#" ><strong>Sign-In Help</strong></a></div>
								<div>有o野想賣? <a href="#" id="link_joinnow"><strong>立即免費開店</strong></a></div></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<div id="header_cover"></div>
	<div id="content">
		<div id="ctnMain">
			<div id="mod_how_to_earn_miles" class="mod">
				<div class="hd2">
					<h2>What is Asia Miles</h2>
				</div>
				<div class="bd">
					<div class="editable">
					<p>Welcome to Asia Miles - Asia's leading travel reward programme that offers you a range of exciting rewards that match your lifestyle.</p>
					<p>In addition to flying, it's easy to earn Asia Miles simply by doing what you borderowly do every day - staying at hotels, dining, shopping and spending on your credit cards.</p>
					<p>Then it's just a matter of redeeming your miles for free flights, upgrades, companion tickets, holidays or other exciting lifestyle awards for yourself, family and friends.</p>
					<p>Not a member of Asia Miles?<a href="#" > Join right now!</a> It's free and only takes a few minutes. You can then start earning Asia Miles straightaway!</p>
					<p>Learn more on:<br />
						<br />
						<a href="#" class="bulletLink">How to earn Asia Miles</a><br />
						<a href="#" class="bulletLink">How to redeem Asia Miles</a><br />
					</p>
					<p>You can also download the <a href="#" >Asia Miles members' guide</a> for further information.</p>
					</div>
				</div>
				<div class="shadow690px"></div>
			</div>
			
		<!-- Tabs -->
		<h2 class="demoHeaders">Tabs</h2>
		<div id="tabs">

			<ul>
				<li><a href="#tabs-1">First</a></li>
				<li><a href="#tabs-2">Second</a></li>
				<li><a href="#tabs-3">Third</a></li>
			</ul>
			<div id="tabs-1"><button id="create-user">Create new user</button></div>
			<div id="tabs-2">Phasellus mattis tincidunt nibh. Cras orci urna, blandit id, pretium vel, aliquet ornare, felis. Maecenas scelerisque sem non nisl. Fusce sed lorem in enim dictum bibendum.</div>

			<div id="tabs-3">Nam dui erat, auctor a, dignissim quis, sollicitudin eu, felis. Pellentesque nisi urna, interdum eget, sagittis et, consequat vestibulum, lacus. Mauris porttitor ullamcorper augue.</div>
		</div>
			
		<!-- Message -->	
			<!-- Highlight / Error -->
			<h2 class="demoHeaders">Highlight / Error</h2>
			<div class="ui-widget">
				<div class="ui-state-highlight ui-corner-all" style=" margin-top:10px; margin-bottom:10px; padding: 0 .7em;"> 
					<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
					<strong>Hey!</strong> Sample ui-state-highlight style.</p>
				</div>
			</div>
			<br/>
			<div class="ui-widget">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
					<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
					<strong>Alert:</strong> Sample ui-state-error style.
				</div>
			</div>
			
		</div>
		<div id="ctnSidebar">
			<jsp:include page="/jsp/common/com_slidesection.jsp"></jsp:include>
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
		$('#create-user')
		.button()
		.click(function() {
			$('#loadform').load('/cma/sampleForm.html',
				function(){
				$('#dialog-form').dialog('open');
				});
			
		});
	});
	</script>

<iframe src="javascript:false" id="frameNavElement" ></iframe>
<div id="heightTest"></div>
</body>
</html>

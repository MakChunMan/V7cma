<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<title>Authorize in Facebook using hidden iframe</title>
<script src="http://connect.facebook.net/en_US/all.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/files/js/jquery-1.4.2.min.js"></script>
</head>
<body>
	<p>
		<input type="email" id="email" placeholder="email" />
	</p>
	<p>
		<input type="password" id="password" placeholder="password" />
	</p>
	<p>
		<input type="button" onclick="" value="Authorize in Facebook using hidden iframe!" id="iLogin" />
	</p>
	<iframe id="fbFrame" src="about:blank;" border="0" style="display:none;"></iframe>
	<p style="color:green;font-size:30px;" id="fbtoken"></p>
	<p style="color:green;font-size:30px;" id="fbuid"></p>
	<script>
		var my_client_id 	= "105043739575289",
			my_redirect_uri	= "http://www.facebook.com/connect/login_success.html",
			my_type			= "user_agent",
			my_display		= "popup"
			authorize_url 	= "https://graph.facebook.com/oauth/authorize?"

		authorize_url += "client_id="+my_client_id
		authorize_url += "&redirect_uri="+my_redirect_uri,
		authorize_url += "&type="+my_type,
		authorize_url += "&display="+my_display,
		authorize_url += "&scope=offline_access"

		setIFrameUrl = function(){
			$("#fbFrame").attr("src", authorize_url);
		}

		getToken = function(){
			var loc = document.getElementById("fbFrame").contentWindow.location.href
			if (/access_token/.test(loc)) {
				var fbToken = loc.match(/access_token=(.*)$/)[1]
				var fbId = loc.match(/-(\d*)%/)[1]
				$("#fbtoken").html("Facebook access token: "+fbToken);
				$("#fbuid").html("Facebook user id: "+fbId);
			} else {
				var grantAccessButton = $("#fbFrame").contents().find("input[name=grant_clicked]");
				if (grantAccessButton) { // if app asks for permissions, grant 'em
					grantAccessButton.click();
				}
				setTimeout(getToken, 1000)
			}
		}

		doTheLogin = function(){
			var emailInput = $("#fbFrame").contents().find("input[name=email]");
			var passInput = $("#fbFrame").contents().find("input[name=pass]");
			var loginButton = $("#fbFrame").contents().find("input[name=login]");
			emailInput.val($("#email").val());
			passInput.val($("#password").val());
			loginButton.click();
		}

		$(document).ready(function(){
			setIFrameUrl();
			$("#iLogin").click(function(){
				//console.log("iLogin clicked!")
				doTheLogin();
			})
			getToken();
		})
	</script>
</body>
</html>
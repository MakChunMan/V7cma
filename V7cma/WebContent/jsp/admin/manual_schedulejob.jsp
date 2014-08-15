<%@page import="com.imagsky.util.BidUtil"%>
<%@page import="com.imagsky.util.BidRobotUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
if("bidLastChanceNotifying".equals(request.getParameter("job"))){
    BidUtil.bidLastChanceNotifying();
} else if("bidFinishClearing".equals(request.getParameter("job"))){
    BidUtil.bidFinishClearing();
} else if("notifyBidWinnerClearing".equals(request.getParameter("job"))){
    BidUtil.notifyBidWinnerClearing();
} else if("bidRobotChecking".equals(request.getParameter("job"))){
    BidRobotUtil.bidRobotChecking();
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="manual_schedulejob.jsp" action="post">
            <table>
                <tr><td><input type="radio" name="job" value="bidLastChanceNotifying">bidLastChanceNotifying</td></tr>
                <tr><td><input type="radio" name="job" value="bidFinishClearing">bidFinishClearing</td></tr>
                <tr><td><input type="radio" name="job" value="notifyBidWinnerClearing">notifyBidWinnerClearing</td></tr>
                <tr><td><input type="radio" name="job" value="bidRobotChecking">bidRobotChecking</td></tr>
            </table>
            <input type="submit"/>
        </form>
    </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="com.imagsky.v6.cma.constants.*" %>
 <%@ page import="com.imagsky.util.*" %>
 <% String lang = (String)request.getAttribute(SystemConstants.REQ_ATTR_LANG); %>
<!--Reminder Form --> 
                    <div class="form-group">
                        <div class="col-xs-12">
                            <input type="text" id="reminder-email" name="reminder-email" class="form-control" placeholder="Enter your email..">
                        </div>
                    </div>
                    <div class="form-group form-actions">
                        <div class="col-xs-12 text-right">
                            <button type="submit" class="btn btn-effect-ripple btn-sm btn-primary"><i class="fa fa-check"></i> Remind Password</button>
                        </div>
                    </div>
<!--End Reminder Form -->
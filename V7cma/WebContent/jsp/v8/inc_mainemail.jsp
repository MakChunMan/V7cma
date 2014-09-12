<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!-- Dynamic Content Page -->
                    <a href="#"><img src="/files/web/images/logo.png" title="value" /></a>
                    <p>你好, Perfect app that makes your everyday life so much easier!</p>
                    <span class="notify-grid" style="margin:4em">
                        <form id="main_form">
                                <input name="main_email" id="main_email" type="text" class="text" value="Your email address" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Your email address';}">
                                <!-- 
                                <input type="submit" value="<<<" />
                                 -->
                                <br/><br/>
			                    <ul class="big-btns">
			                        <li><a class="btn-g" href="#" id="btn_register">Register</a></li>
			                        <li><a class="btn-g" href="#" id="btn_login">Login</a></li>
			                    </ul>
                        </form>
                    </span>
                    <div id="dialog-message" title="Download complete">
                      <p>
                        <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
                        Your files have downloaded successfully into the My Downloads folder.
                      </p>
                      <p>
                        Currently using <b>36% of your storage space</b>.
                      </p>
                    </div>
                    
                    <script>
                    $(function() {
					    $( "#dialog-message" ).dialog({
					      modal: true,
					      buttons: {
					        Ok: function() {
					          $( this ).dialog( "close" );
					        }
					      }
					    });
					  });
                    
                    $('#btn_register').click(function(){
                        $.post( "/do/PAGE/INPUT_NEW_PASS_APPNAME", $('#main_form').serialize() )
                        .done(function(html) {
                            $('#dcontent').append(html);
                        });
                    });
                    $('#btn_login').click(function(){
                        $.post( "/do/PAGE/INPUT_PASS", $('#main_form').serialize() )
                        .done(function(html) {
                            $('#dcontent').html(html);
                        });
                    });
                    

                    </script>
                    <!-- 
                    <ul class="usefull-for">
                        <li><a class="u-apple" href="#"><span> </span></a></li>
                        <li><a class="u-and"href="#"><span> </span></a></li>
                        <li><a class="u-windows" href="#"><span> </span></a></li>
                    </ul>
                     -->
<!-- End of Dynamic Content-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!-- Dynamic Content Page -->
                    <a href="#"><img src="/files/web/images/logo.png" title="value" /></a>
                    <p>LOGIN : Input your password.</p>
                    <span class="notify-grid" style="margin:4em">
                        <form>
                                <input name="main_password" id="main_password" type="password" class="text">
                                <br/><br/>
			                    <ul class="big-btns">
			                        <li><a class="btn-g" href="#" id="btn_submit">Submit</a></li>
			                    </ul>
                        </form>
                    </span>
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
                    
                    $('#btn_submit').click(function(){
                        alert('btn_register click');
                    });
                    </script>
<!-- End of Dynamic Content-->
<%@page contentType="text/html;charset=utf-8"%>
<html class="js modern yui3-js-enabled">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>用户注册</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="css/register.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		/* 两个密码的比较 */
		$(document).ready(function(){  
				$("#b").blur(function(){
					var pass1 = $("#a").val();  
					var pass2 = $("#b").val();
					if(pass1 != pass2){
						$("#qr").empty().append("<font color='red'>两次密码不一致</font>");
						$("#a").val("");
						$("#b").val("");
					} else {
						$("#qr").empty();
					}
				});
		});
		$(document).ready(function(){  
			$("#ac").blur(function(){
				var acco = $("#ac").val();  
				$("#ss").empty();
				$("#sss").attr("disabled",false);
			 $.ajax({
			        type: "POST",
			        url: "register_conf.jsp",
			        data: {account : acco},
			    })
			 .done(function( msg ) {
				  if(msg == 1) {
				   		$("#ss").empty().append("<font color='red'>账号重复</font>");
				   		$("#sss").attr("disabled",true);
				   	} 
				  });
			});	
		});
		$(document).ready(function(){ 
			$("#ac").blur(function(){
				if($('#ac').val().length > 16){
					$("#ss").empty().append("<font color='red'>账号过长</font>");	
					$("#ac").val("");
			   		/* $("#sss").attr("disabled",true); */
				} else {
					$("#ss").empty();
					/* $("#sss").attr("disabled",false);  */
				}
			});
			$("#a").blur(function(){
				if($('#a').val().length < 6 && $('#a').val().length >0 || $('#a').val().length > 14){
					$("#mm").empty().append("<font color='red'>密码长度不符合标准</font>");	
					$("#a").val("");
			   		/* $("#sss").attr("disabled",true); */
				} else {
					$("#mm").empty();
					/* $("#sss").attr("disabled",false);  */
				}
			});
			
		});

		/* 判断添加为空 */
		function aa(){
				var pass1 = $("#a").val();  
				var pass2 = $("#b").val();
				if($("input[name='name']:first").val()==""){
					alert(	"名字不能为空");
					$("form").submit(function() {return false;});
				} else if($("input[name='account']:first").val()==""){
					alert(	"账号不能为空");
					$("form").submit(function() {return false;});
				} else if($("input[name='password']:first").val()==""){
					alert(	"密码不能为空");
					$("form").submit(function() {return false;});
				} else if($("input[name='password_two']:first").val()==""){
					alert(	"密码不能为空");
					$("form").submit(function() {return false;});
				} else if(pass1 != pass2){
					$("#qr").empty().append("<font color='red'>两次密码不一致</font>");
					$("#a").val("");
					$("#b").val("");
				} else {
					$("#qr").empty();
					$("form").submit(function() {return true;});
				}
		}

	</script>
</head>
<body>
		<div class="container ">
		<div class="header" align="center">
		<p><img src="image/head5.jpg"></p>
		<div class="uhd">
		<div id="yucsHead" class="yucs-login yucs-en-us"><!-- meta -->
		<div id="yucs" class="yucs-mc " data-lang="en-us" data-property="login" data-flight="1397567517" data-linktarget="_top" data-uhvc="/">       	  
		<div class="yucs-fl-right">  
		<div id="yucs-profile" class="yucs-profile yucs-signedout">   
		<div id="yucs-profile_text" class="yucs-fc">        
		<a id="yucs-login_signIn" href="login.jsp" target="_top" rel="nofollow" class="yucs-fc">登陆  </a></div>
		</div>       
		<div id="yucs-help" class="yucs-activate yucs-help yucs-menu_nav">    
		<a id="yucs-help_link" href="list_invitation.jsp" aria-label="Help" rel="nofollow">返回首页</a>
		</div>                             
		</div>            
		</div>
		</div>		  
		</div>
	    </div>
	    <div class="main">
		<!-- <p class="validation-message" id="general-message"></p> -->
		<div class="row" style="height: 36px;">
		  <div class="column">
		    <h1>注册BBS账号</h1>
		  </div>
		</div>
		<form action="register_do.jsp" method="post">
			<div class="input-container">
			  <!-- <p class="validation-message" id="name-validation-message"></p> -->
			  <div class="row input-row" dir="ltr">
		      <label for="user-name" class="clipped"></label>
			  	 <div class="row input-row"> <font color="4c00b7" size="+1">用户名</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="name" placeholder="建议实名" title="用户名" autocorrect="off" autocapitalize="off" autocomplete="off" maxlength="32" aria-required="true" aria-describedby="id-validation-message" aria-haspopup="true" dir="ltr" type="text"></div>
				 <div class="row input-row"><font color="4c00b7" size="+1">用户账号</font><input name="account" placeholder="1~16位字母或数字" title="用户账号" id="ac" autocorrect="off" autocapitalize="off" autocomplete="off" maxlength="32" aria-required="true" aria-describedby="id-validation-message" aria-haspopup="true" dir="ltr" type="text">
				 <div id="ss"></div>
				 </div>
			  </div>
              </div>
			  <!-- <p class="validation-message" id="user-name-validation-message"></p> -->
			  <div class="row input-row">
		      <label for="password" class="clipped">Password</label>
			   <font color="4c00b7" size="+1">密码</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="password" placeholder="6~14位字母或数字" title="密码" id="a" autocorrect="off" autocapitalize="off" autocomplete="off" maxlength="32" aria-required="true" aria-describedby="password-validation-message" type="password"> 
			   <div id="mm"></div>
			 <font color="4c00b7" size="+1">确认密码</font><input name="password" placeholder="6~14位字母或数字" title="确认密码" id="b" autocorrect="off" autocapitalize="off" autocomplete="off" maxlength="32" aria-required="true" aria-describedby="password-validation-message" type="password">
			 <div id="qr"></div>
			  </div>
			  <!-- <p class="validation-message" id="password-validation-message"></p> -->
	          <div class="row input-row">
				<input class="button submit" value="注册" type="submit" onclick="aa()" id="sss">
				<input class="button submit" value="重置" type="reset">
	          </div>
	        </div>

        </form>
      </div>
    <!-- Include the scripts -->
    
</body>
</html>
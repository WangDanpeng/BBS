<%@page contentType="text/html;charset=utf-8"%>
<html class="yui3-js-enabled" style="overflow-x: hidden; overflow-y: auto;">
<head>
	<title>用户登录</title>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<link rel="stylesheet" type="text/css" href="css/login.css" media="all">
	<script type="text/javascript" src="jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	/* 判断添加为空 */
	function aa(){
			if($("input[name='account']:first").val()==""){
				alert(	"账号不能为空");
				//$("form").submit(function() {return false;});
			} else if($("input[name='password']:first").val()==""){
				alert(	"密码不能为空");
				//$("form").submit(function() {return false;});
			} else {
				//$("form").submit(function() {return true;});
				$("form").submit();
			}
	}
	</script>
</head>
<body style="overflow: hidden; width: 1133px;" id="mnbd">
  <div id="hdBg">
  <!-- intl = us, locale = en-US, spaceid = 150002530 offset = 0 Header 2.0 -->
<div style="width: 1133px;" id="yucsHead" class="yucs-login yucs-en-us"><!-- meta -->
<div id="yucs" class="yucs-mc  login_mailflow" data-lang="en-us" data-property="login" data-flight="1397562062" data-linktarget="_top" data-uhvc="/">
<div class="yucs-fl-right">
<div id="yucs-profile" class="yucs-profile yucs-signedout">
<div id="yucs-profile_text" class="yucs-fc">
<a id="yucs-login_signIn" href="login.jsp" target="_top" rel="nofollow" class="yucs-fc">登陆 </a>
</div>
</div>
<div id="yucs-help" class="yucs-activate yucs-help yucs-menu_nav">
<a id="yucs-help_link" href="list_invitation.jsp" aria-label="Help" rel="nofollow">返回首页</a>
</div>
</div>
</div>
</div>             
  </div>
    <div id="mainBox">
      <div id="loginHolder">
        <div id="leftContent">
              <div style="display: block;" id="static">
<div class="lofb_wrap">
<div class="lofb">
<h3>BBS makes it easy to enjoy what matters most in your world.</h3>
<p>Best in class BBS, breaking local, national and global news, finance, sports, music, movies and  more. You get more out of the web, you get more out of life.</p>
</div>
</div>
          </div>
          </div>
        <div id="loginBox">
          <div id="yreglg">

      <div class="top mm-lgbx">
	<div class="lgbx lisu">
		<div class="lgbx-ltr">
        <div class="lgbx-logo ">
        	<img src="image/logo.jpg">
                </div>
</div>
<fieldset id="fsLogin" class="clear">
<form action="login_conf.jsp" method="post">
	<div class="yui-skin-sam" id="inputs">
					<input name="account" id="username" maxlength="96" tabindex="1" aria-required="true" placeholder="BBS ID" autocorrect="off" autocomplete="off" value="" type="text" style="height: 38px;">
					<input name="password" id="passwd" maxlength="64" tabindex="2" aria-required="true" placeholder="Password" autocorrect="off" autocomplete="off" value="" type="password" style="height: 38px;">
			</div>
	<div id="submit">
		<button type="button" id=".save" name=".save" class="lgbx-btn purple-bg" tabindex="4" onclick="aa()">登陆</button>
	</div>
</form>
</fieldset>
<div class="lgbx-signup">
    <span class="mm-or">OR</span>
		<a id="signUpBtn" tabindex="9" class="lgbx-btn blue-bg" href="register.jsp">注册</a>
	</div>
	
        <div id="idp">
			<div class="clear">
	<%
		if(request.getParameter("a") != null) {
			String a = request.getParameter("a");
			if(a.equals("err")) {
		%>
				<br><h3><font color='red'>账号密码错误</font></h3>
		<%
			} else if(a.equals("null")) {
		%>
				<br><h3><font color='red'>请先登录</font></h3>
		<%		
			} else if(a.equals("suc")) {
		%>
				<br><h3><font color='red'>密码修改成功，请重新登陆</font></h3>
		<%		
			} else if(a.equals("reg")) {
		%>
				<br><h3><font color='red'>注册成功，请登陆</font></h3>
		<%		
			} else if(a.equals("ree")) {
		%>
			<br><h3><font color='red'>注册失败</font></h3>
		<%
			} else if(a.equals("tp")) {
		%>
				<br><h3><font color='red'>又调皮</font></h3>
		<%	
			}
		}
	%>
			</div>
        </div>
			</div>
</div>
          </div>
        </div>
      </div><!-- end loginHolder -->
    </div><!-- end mainBox -->
</body>
</html>
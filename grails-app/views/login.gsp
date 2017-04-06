<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title>易损件跟踪管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.9.0.min.js')}"></script>
<script type="text/javascript" src="${resource(dir:'images',file:'login.js')}"></script>
<link href="${resource(dir:'css',file:'login2.css')}" rel="stylesheet" type="text/css" />
</head>
<body>
<h1>易损件跟踪管理系统<sup></sup></h1>

<div class="login" style="margin-top:50px;">
    
    <div class="header">
        <div class="switch" id="switch"><a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
		<div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>    
  
    
    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 290px;">

            <!--登录-->
            <div class="web_login" id="web_login">
               
               
               <div class="login-box">
    

			<div class="login_form">

                <form action="<g:createLink controller="auth" action="login"/>" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                    <g:if test="${flash.message}">
                        <label style="color:red">${flash.message}</label>
                    </g:if>
                <div class="uinArea" id="uinArea">
                <label class="input-tips" for="u">帐号：</label>
                <div class="inputOuter" id="uArea">
                    
                    <input type="text" id="u" name="userName" class="inputstyle"/>
                </div>
                </div>
                <div class="pwdArea" id="pwdArea">
               <label class="input-tips" for="p">密码：</label> 
               <div class="inputOuter" id="pArea">
                    
                    <input type="password" id="p" name="password" class="inputstyle"/>
                </div>
                </div>
                    <div class="pwdArea" id="userType">
                        <label class="input-tips" for="p">入口：</label>
                        <div class="inputOuter" >
                        <select name="userType">
                            <option value="zzkj">展卓科技</option>
                            <option value="company">集团</option>
                            <option value="branceCompany">分公司</option>
                            <option value="admin">管理员</option>
                        </select>
                        </div>
                    </div>
               
                <div style="padding-left:50px;margin-top:20px;"><input type="submit" value="登 录" style="width:150px;" class="button_blue"/></div>
              </form>
           </div>
           
            	</div>
               
            </div>
            <!--登录end-->
  </div>



<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
</body></html>
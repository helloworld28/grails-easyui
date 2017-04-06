<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>易损件跟踪管理系统</title>
    <link href="${resource(dir:'css',file:'default.css')}" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes/default',file:'easyui.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes',file:'icon.css')}" />

    <script type="text/javascript" src="${resource(dir:'js/themes',file:'jquery-1.4.4.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir:'js/themes',file:'jquery.easyui.min.1.2.2.js')}"></script>
    <script type="text/javascript" src="${resource(dir:'js',file:'outlook2.js')}"> </script>

    <script type="text/javascript">
	 var _menus = {"menus":[

                    <g:if test="${session.user.userType == 'admin'}">
        {"menuid":"1","icon":"icon-sys","menuname":"易损件管理",
             "menus":[
                 {"menuid":"11","menuname":"分公司管理","icon":"icon-users","url":"<g:createLink controller="company" action="index"/>"},
                 {"menuid":"12","menuname":"分公司账号管理","icon":"iicon-users","url":"<g:createLink controller="User" action="index"/>"},
                 {"menuid":"13","menuname":"易损件原始资料管理","icon":"icon-users","url":"<g:createLink controller="spare" action="index"/>"},
                 {"menuid":"14","menuname":"添加易损件跟踪表","icon":"icon-users","url":"<g:createLink controller="traceTable" action="index"/>"},
                 {"menuid":"14","menuname":"易损件跟踪管理-汇总","icon":"icon-users","url":"<g:createLink controller="traceTable" action="summary"/>"},
/*
                 {"menuid":"15","menuname":"发货单管理","icon":"icon-users","url":"<g:createLink controller="delivery" action="index"/>"},
*/
                 {"menuid":"16","menuname":"验收入库","icon":"icon-users","url":"<g:createLink controller="delivery" action="viewListAccept"/>"},
                 {"menuid":"16","menuname":"使用情况反馈","icon":"icon-users","url":"<g:createLink controller="traceTable" action="feedBackForm"/>"},
                 {"menuid":"16","menuname":"汇总报表","icon":"icon-users","url":"<g:createLink controller="report" action="summary"/>"},
                 {"menuid":"16","menuname":"分公司汇总报表","icon":"icon-users","url":"<g:createLink controller="reportCompany" action="summary"/>"},
                 {"menuid":"16","menuname":"分公司报表","icon":"icon-users","url":"<g:createLink controller="reportCompanyAndSpare" action="summary"/>"}
             ]
         }
         </g:if>
         <g:if test="${session.user.userType == 'zzkj'}">
         {"menuid":"1","icon":"icon-sys","menuname":"易损件管理",
             "menus":[
                 {"menuid":"13","menuname":"易损件原始资料管理","icon":"icon-users","url":"<g:createLink controller="spare" action="index"/>"},
                 {"menuid":"14","menuname":"添加易损件跟踪表","icon":"icon-users","url":"<g:createLink controller="traceTable" action="index"/>"},
                 {"menuid":"14","menuname":"易损件跟踪管理-汇总","icon":"icon-users","url":"<g:createLink controller="traceTable" action="summary"/>"},
/*
                 {"menuid":"15","menuname":"发货单管理","icon":"icon-users","url":"<g:createLink controller="delivery" action="index"/>"}
*/
             ]
         }
         </g:if>
         <g:if test="${session.user.userType == 'company'}">
         {"menuid":"1","icon":"icon-sys","menuname":"易损件管理",
             "menus":[
                 {"menuid":"16","menuname":"汇总报表","icon":"icon-users","url":"<g:createLink controller="report" action="summary"/>"},
                 {"menuid":"16","menuname":"分公司汇总报表","icon":"icon-users","url":"<g:createLink controller="reportCompany" action="summary"/>"},
                 {"menuid":"16","menuname":"分公司报表","icon":"icon-users","url":"<g:createLink controller="reportCompanyAndSpare" action="summary"/>"}
             ]
         }
         </g:if>
         <g:if test="${session.user.userType == 'branceCompany'}">
         {"menuid":"1","icon":"icon-sys","menuname":"易损件管理",
             "menus":[
                 {"menuid":"16","menuname":"验收入库","icon":"icon-users","url":"<g:createLink controller="delivery" action="viewListAccept"/>"},
                 {"menuid":"16","menuname":"使用情况反馈","icon":"icon-users","url":"<g:createLink controller="traceTable" action="feedBackForm"/>"}
             ]
         }
         </g:if>
				]};
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable:false
            });
        }
        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }

        


        $(function() {

            openPwd();

            $('#editpass').click(function() {
                $('#w').window('open');
            });

            $('#btnEp').click(function() {
                var pwd = $('#txtNewPass').val();
                var repwd =  $('#txtRePass').val();
                if(pwd == ''){
                    $.messager.alert('错误', '新密码不能为空')
                    return;
                }
                if(pwd != repwd){
                    $.messager.alert('错误', '确认密码与新密码不一致')
                    return;
                }
                $.ajax({
                    url:'<g:createLink controller="user" action="updatePwd"/>',
                    data:$('#form-updatepwd').serialize(),
                    dataType:'JSON',
                    type:'POST',
                    success:function (data) {
                        if(data == '1'){
                            $('#w').window('close');
                            $.messager.alert('提示', '修改成功');
                        }else{
                            $.messager.alert('错误', '操作失败');
                        }
                    }

                });
            });

			$('#btnCancel').click(function(){closePwd();})

            $('#loginOut').click(function() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                    if (r) {
                        location.href = '<g:createLink controller="auth" action="logout"/>';
                    }
                });
            })
        });
		
		

    </script>

</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
<noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript>
    <div region="north" split="true" border="false" style="overflow: hidden; height: 30px;
        background: url('${resource(dir:'images',file: 'layout-browser-hd-bg.gif')}') #7f99be repeat-x center 50%;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
        <span style="float:right; padding-right:20px;" class="head">欢迎 ${session.user?.userName}
            【<g:if test="${session.user.userType == 'admin'}">
            超级管理员
            </g:if>
            <g:if test="${session.user.userType == 'zzkj'}">
                展卓科技用户
            </g:if>
            <g:if test="${session.user.userType == 'company'}">
               集团用户
            </g:if>
            <g:if test="${session.user.userType == 'branceCompany'}">
               分公司用户
            </g:if>
            】
            <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span>
        <span style="padding-left:10px; font-size: 16px; "><img src="${resource(dir:'images',file: 'blocks.gif')}" width="20" height="20" align="absmiddle" />易损件管理</span>
    </div>
    <div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
        <div class="footer">易损件管理</div>
    </div>
    <div region="west" hide="true" split="true" title="导航菜单" style="width:180px;" id="west">
<div id="nav" class="easyui-accordion" fit="true" border="false">
		<!--  导航内容 -->
				
			</div>

    </div>
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
			<div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; " >


			</div>
		</div>
    </div>
    
    
    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">

        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">

                <form name="form-updatepwd">
                <table cellpadding=3>
                    <tr>
                        <td>新密码：</td>
                        <td><input id="txtNewPass" type="Password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td><input id="txtRePass" type="Password" class="txt01" /></td>
                    </tr>
                </table>
       </form>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" >
                    确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>

    </div>

	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>


</body>
</html>
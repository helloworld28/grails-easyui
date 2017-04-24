<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-01-20
  Time: 16:59
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes/default',file:'easyui.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes',file:'icon.css')}" />
    <script type="text/javascript" src="${resource(dir:'js',file:'jquery-1.8.0.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir:'js',file:'jquery.easyui.min.js')}"></script>
    <script type="text/javascript" src="${resource( dir: "js", file: "easyui-scaffold.js")}"></script>
    <script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-scaffold-lang-en.js")}"></script>

    <script type="text/javascript" src="${resource(dir:'js',file:'datagrid-filter.js')}"></script>
    <script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-lang-zh_CN.js")}"></script>
    <link rel="stylesheet" type="text/css" href="${resource( dir:"css", file: "easyui-scaffold.css")}"/>

<script>
    $(document).ready(function(){
        $('#win-traceTable').window('close');
        $('#table-result').datagrid();
        $('#btn-export').click(function () {
           if($('table#table-result tbody tr').length == 0){
               $.messager.alert("提示", "请先点击查询");
           }else{
               window.open("<g:createLink controller="reportCompanyAndSpare" action="export"/>");
           }
        });

       $('#company').combogrid('setValue', '${params.company}');

        var height1 = $(window).height()-20;
        $("#main_layout").attr("style","width:100%;height:"+height1+"px");
        $("#main_layout").layout("resize",{
            width:"100%",
            height:height1+"px"
        });
    });

    function showWin(companyAndSpareId) {
        var companySpare = companyAndSpareId.split("_");
        var spareId = companySpare[0];
        var companyId = companySpare[1];

        $('#openReceiveFeedBack').attr('src',
                '<g:createLink controller="traceTable" action="index"/>?spareId='+spareId+'&companyId='+companyId);
         $('#win-traceTable').window('open');

    }



</script>


</head>

<body>
<div class="easyui-layout" id="main_layout" style="">
    <div data-options="region:'north'" title="查询条件" style="height: 80px;">

    <div style="margin: 10px;"></div>

            <form action="<g:createLink controller="traceTable" action="summary"/>" method="POST">
                <table><tr><td><e:combogrid
                        name="company"
                        id="company"
                        width="300px"
                        url="${createLink(controller: 'company', action:'list.json')}"
                        idField="id"
                        textField="name"
                        fitColumns="true"
                        remote="true"
                        required="true"
                        columns="js:[[
					{field:'id', title:'id', width:20},
					{field:'name', title:'分公司', width:250}
				]]"/></td>
                    <td>

                        <input name="spare" id="spare" type="hidden" value="${params?.spare}" readonly="true"/>
                        <input name="spare_Number" id="spareNumber"type="text" value="${params?.spare_Number}" readonly="true"/><a href="#" id="btn-choose">选择</a>
                    </td>

                    <td width="80">下单日期</td><td><input  class="easyui-datebox"  type="text" name="startTime"  value="${params?.startTime}"/></td><td>至</td><td><input class="easyui-datebox" name="endTime" value="${params?.endTime}"/></td>
                    <td><input type="submit" id="btn-query" value="查询" /></td>
                    %{--  <td><input type="button" id="btn-export" value="导出结果" /></td>--}%
                </tr></table>
            </form>


    </div>

    <div data-options="region:'center',iconCls:'icon-ok'" title="总数量：${totalAmount}, 总价：${totalPrice}">
       %{-- <lable>总数量：${totalAmount}, 总价：${totalPrice}</lable>--}%
        <table id="table-result" style="width:auto;height:auto;border:1px solid #ccc;">
            <thead>
            <tr>

                <th data-options="field:'companyName', width:200">公司</th>
                <th data-options="field:'spareNumber',width:200">易损件型号</th>
                <th data-options="field:'amount', width:200">数量</th>
                <th data-options="field:'totalPrice' ,width:200">总价</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${summaryMap.entrySet()}" status="i" var="entry">
                <tr >
                    <td ><a href="#" onclick="showWin('${entry.key}')">${fieldValue(bean:entry.value, field:'companyName')}</a></td>
                    <td>${fieldValue(bean:entry.value, field:'spareNumber')}</td>
                    <td>${fieldValue(bean:entry.value, field:'amount')}</td>
                    <td>${fieldValue(bean:entry.value, field:'totalPrice')}</td>
                </tr>
            </g:each>
            </tbody>


        </table>

    </div>

</div>







<div  class="easyui-window" id="win-traceTable" title="易损件跟踪信息"  data-options="iconCls:'icon-save',modal:true,width:800,height:500">
    <iframe scrolling="auto" id='openReceiveFeedBack' name="openReceiveFeedBack" frameborder="0"  src="" style="width:100%;height:98%;"></iframe>

</div>

<!--选择易损件页面-->
<g:render template="../spare/spare"/>

<script>

    $(document).ready(function () {
        $('#btn-choose').click(function () {
            $('#win-chooseSpare').dialog('open');
        });
    });
</script>
</body>
</html>
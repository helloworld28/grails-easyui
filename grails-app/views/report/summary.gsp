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
    <script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-lang-zh_CN.js")}"></script>
    <link rel="stylesheet" type="text/css" href="${resource( dir:"css", file: "easyui-scaffold.css")}"/>

<script>
    $(document).ready(function(){
        $('#table-result').datagrid();
        $('#btn-export').click(function () {
           if($('table#table-result tbody tr').length == 0){
               $.messager.alert("提示", "请先点击查询");
           }else{
               window.open("<g:createLink controller="report" action="export"/>");
           }
        })
    });

</script>
</head>

<body>

<div id="tb" class="scaffoldbar">

    <form action="<g:createLink controller="report" action="summary"/>" method="POST">
    <table><tr><td width="80">时间起止</td><td><input  class="easyui-datebox"  type="text" name="startTime"  value="${params?.startTime}"/></td><td>至</td><td><input class="easyui-datebox" name="endTime" value="${params?.endTime}"/></td>
        <td><input type="submit" id="btn-query" value="查询" /></td>
        <td><input type="button" id="btn-export" value="导出结果" /></td>
    </tr></table>
    </form>


</div>

<br>
        <lable>总数量：${totalAmount}, 总价：${totalPrice}</lable>
        <table id="table-result" style="width:auto;height:auto;border:1px solid #ccc;">
            <thead>
            <tr>

                <th data-options="field:'companyName',width:200">公司名</th>
                <th data-options="field:'amount', width:200">数量</th>
                <th data-options="field:'totalPrice' ,width:200">总价</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${summaryList}" status="i" var="summary">
                <tr>
                    <td>${fieldValue(bean:summary, field:'companyName')}</td>
                    <td>${fieldValue(bean:summary, field:'amount')}</td>
                    <td>${fieldValue(bean:summary, field:'totalPrice')}</td>
                </tr>
            </g:each>
            </tbody>


        </table>



</body>
</html>
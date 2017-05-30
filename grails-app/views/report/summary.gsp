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

    <script>
        $(document).ready(function () {
            $('#zljxh').combobox({
                url:'<g:createLink controller="spare" action="listZljxh"/>',
                valueField:'code',
                textField:'code',
                filter: function(q, row){
                    var opts = $(this).combobox('options');
                    return row[opts.textField].indexOf(q) > -1;
                },
                onLoadSuccess:function () {
                    $('#zljxh').combobox('setValue', '${params.zljxh}');
                    $('#category').combobox('setValue', '${params.category}');
                }
            });



        });

    </script>

</head>

<body>

<div id="tb" class="scaffoldbar">

    <form action="<g:createLink controller="report" action="summary"/>" method="POST">
    <table><tr>
        <td>品类：<select name="category" id="category" class="easyui-combobox">
            <option value="">--全部--</option>
            <option value="环模">环模</option>
            <option value="压轮">压轮</option>
        </select> </td>
        <td>制粒机型号：<input name="zljxh" id="zljxh"  class="easyui-combobox" /> </td>

        <td width="80">下单日期<span style="color: red">*</span></td><td><input  class="easyui-datebox"  type="text" name="startTime"  value="${params?.startTime}"/></td><td>至</td><td><input class="easyui-datebox" name="endTime" value="${params?.endTime}"/></td>
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

                <th data-options="field:'companyName',width:200">公司</th>
                <th data-options="field:'amount', width:200">数量</th>
                <th data-options="field:'totalPrice' ,width:200">总价</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${summaryList}" status="i" var="summary">
                <tr>
                    <td><a href="#" onclick="showDetails('${fieldValue(bean:summary, field:'companyName')}')">${fieldValue(bean:summary, field:'companyName')}</a></td>
                    <td>${fieldValue(bean:summary, field:'amount')}</td>
                    <td>${fieldValue(bean:summary, field:'totalPrice')}</td>
                </tr>
            </g:each>
            </tbody>


        </table>

<!--明细跟踪表信息窗口-->
<g:render template="list_trace_table"/>
</body>
</html>
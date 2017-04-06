
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes/default',file:'easyui.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes',file:'icon.css')}" />
	<script type="text/javascript" src="${resource(dir:'js',file:'jquery-1.8.0.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js',file:'jquery.easyui.min.js')}"></script>
	<script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-lang-zh_CN.js")}"></script>

	<script type="text/javascript" src="${resource( dir: "js", file: "easyui-scaffold.js")}"></script>
	<script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-scaffold-lang-en.js")}"></script>
	<link rel="stylesheet" type="text/css" href="${resource( dir:"css", file: "easyui-scaffold.css")}"/>
	<script>
		$(document).ready(function () {

			$('#btn-queryTraceTable').click(function (data) {
				var spareNumber = $('#inputSpareNumber').val();
				if(spareNumber == ''){
					$.messager.alert("提示","请先输入生产编号");
					return;
				}

				$.get('<g:createLink controller="traceTable" action="queryTraceTable"/>',{'spareNumber':spareNumber},function (data) {
					if(data == '' || isEmptyObject(data)){
						$.messager.alert("提示","查无相关数据, 请确认该生产编号");
					}else{
						$("#frm").form('load', data);
					}

				});


			});

			$('#btn-save').click(function (data) {
				var traceTableId = $('#input-id').val();
				if(traceTableId == ''){
					$.messager.alert('请先查询');
					return;
				}else{
					$.ajax({
						url:'<g:createLink controller="traceTable" action="saveFeedback"/>',
						data:$('#frm').serialize(),
						type:'POST',
						dataType:'JSON',
						success:function (data) {
							if(data == '1'){
								$.messager.alert("提示","保存成功");
							}else {
								$.messager.alert("错误","操作失败");

							}
						}

					})
				}
			})

		});
		function isEmptyObject(e) {
			var t;
			for (t in e)
				return !1;
			return !0
		}
	</script>
</head>
<body>
	<div>

	<fieldset name="查询">
		<legend>查询</legend>

		<table><tr><td width="80">生产编号</td><td><input id="inputSpareNumber" value="" type="text"/></td><td><input type="button" id="btn-queryTraceTable" value="查询" /></td></tr></table>
	</fieldset>

	</div>
<fieldset >

	<legend>使用情况反馈</legend>

	<form id="frm" method='POST' action="<g:createLink controller="traceTable" action="saveFeedback"/>"  >
		<input type="hidden" id="input-id" name="id"/>
		<table>

			<tr><td width="100">使用时间</td><td width="200"><e:datetimebox name="beginUseTime" /></td>
				<td width="100">使用结束时间</td><td width="200"><e:datetimebox name="endUseTime"/></td></tr>
			<tr><td>使用时产</td><td><e:numberbox name="outputPerHour" precision="2"  maxlenght="8"/>T/H</td>
				<td>使用总量</td><td><e:numberbox name="totalOutput" precision="2"  maxlenght="8"/>T/P</td></tr>
			<tr><td>质量</td><td colspan="3"><select name="qualified"><option value="1">合格</option><option value="0">不合格</option></select></td></tr>
			<tr><td>备注</td><td colspan="3"><g:textArea name="remark" width="200"/></td></tr>
			<tr><td colspan="4"><input type="button" id="btn-save" value="保存/修改"/> </td></tr>
		</table>


	</form>
</fieldset>
</body>
</html>
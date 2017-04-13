
<e:window id="win-edit" title="查看/修改跟踪表" width="600px" closed="true"
	maximizable="true" minimizable="false" collapsible="false" modal="true">
	<form id="frm-edit" method='POST' autocomplete="on" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />												
		<table>
		<tr><td><label>易损件</label></td><td><span id="spareInfo"></span></td></tr>
		<tr><td><label for="company"><g:message code="traceTable.company"/></label></td><td>
			<e:combogrid
					name="company"
					width="300px"
					url="${createLink(controller: 'company', action:'list.json')}"
					idField="id"
					textField="name"
					fitColumns="true"
					remote="true"
					required="true"
					columns="js:[[
					{field:'id', title:'id', width:20},
					{field:'name', title:'公司', width:250}
				]]"/></td></tr>
		<tr><td><label for="contractNo">合同编号</label></td><td>	<e:validatebox name="contractNo" /></td></tr>
		<tr><td><label for="spareNumber"><g:message code="traceTable.spareNumber"/></label></td><td>	<e:validatebox name="spareNumber" /></td></tr>
		<tr><td><label for="orderDate"><g:message code="traceTable.orderDate"/></label></td><td><e:datebox name="orderDate" width="100px"/></td></tr>
		<tr><td><label for="orderAmount"><g:message code="traceTable.orderAmount"/></label></td><td><e:numberbox name="orderAmount"  width="100px" maxlenght="8"/></td></tr>
		<tr><td><label for="remark">发货信息</label></td><td>	<table id="dg-delivery" class="easyui-datagrid"style="width:500px;height:auto;margin:	20px;"
																	data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb-delivery',
				url: '',
				method: 'get'
			">
			<thead>
			<tr>
				<th data-options="field:'id',hidden:true,width:100,align:'left'">id</th>
				<th data-options="field:'deliveryTime',width:100,align:'left',editor:{type:'datebox'}">发货时间</th>
				<th data-options="field:'deliveryNumber',width:150,editor:'validatebox'">物流单号</th>
				<th data-options="field:'deliverAmount',width:80,align:'right',editor:{type:'numberbox',options:{precision:1}}">发货数量</th>
			</tr>
			</thead>
		</table></td></tr>
		<tr><td><label for="deliveryedAmount"><g:message code="traceTable.deliveryedAmount"/></label></td><td><e:numberbox name="deliveryedAmount" id="deliveryedAmount" width="100px"  maxlenght="8"/></td></tr>
		<tr><td><label for="notDevliveryedAmout"><g:message code="traceTable.notDevliveryedAmout"/></label></td><td><e:numberbox name="notDevliveryedAmout" id="notDevliveryedAmout"  width="100px" maxlenght="8"/></td></tr>
		<tr><td><label for="beginUseTime"><g:message code="traceTable.beginUseTime"/></label></td><td><e:datetimebox name="beginUseTime" width="100px"/></td></tr>
		<tr><td><label for="endUseTime"><g:message code="traceTable.endUseTime"/></label></td><td><e:datetimebox name="endUseTime" width="100px"/></td></tr>
		<tr><td>	<label for="outputPerHour"><g:message code="traceTable.outputPerHour"/></label></td><td>	<e:numberbox name="outputPerHour" precision="2" width="100px" maxlenght="8"/></td></tr>
		<tr><td><label for="totalOutput"><g:message code="traceTable.totalOutput"/></label></td><td>	<e:numberbox name="totalOutput" precision="2" width="100px" maxlenght="8"/></td></tr>
		<tr><td><label ><g:message code="traceTable.qualified"/></label></td><td><select name="qualified"><option value="1">合格</option><option value="0">不合格</option></select></td></tr>
		<tr><td><label for="remark"><g:message code="traceTable.remark"/></label></td><td><e:textarea name="remark" /></td></tr>

		</table>


			<div id="tb-delivery" style="height:auto">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">添加发货单</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
			</div>


		<script type="text/javascript">

			$(document).ready(function () {
				$('#btn-save', '#win-edit').click(function(){
					var url = '<g:createLink controller="traceTable" action="update"/>.json';
					$.post(url, $('#frm-edit').serialize(), function (data, status) {

						if(status == "success"){
							$('#grid').datagrid('reload');
							$('#win-edit').window('close');
							$.messager.alert("提示", "已经保存成功");
						}else{
							$.messager.error("保存出错");
						}
					});
				});
			});

			function append(){
				//打开添加发货单的窗口
				$('#winDelivery').window('open');
			}
			function removeit(){
				if(window.confirm("确认要删除该发货单？")){
					var row = $('#dg-delivery').datagrid('getSelected');
					if(row == ''){
						$.messager.alert('提示', "请先选择一行记录");
					}else{
						var deliveryId = row['id'];
						var deliveryAmount = row['deliverAmount'];
						var url = '<g:createLink controller="delivery" action="delete"/>/'+deliveryId;
						$.post(url,{}, function (result) {
							//把输入框的发货数量减少
							cutDeliveryAmount(deliveryAmount);
							//刷新发货信息列表
							$('#dg-delivery').datagrid('reload');
							$('#grid').datagrid('reload');
						})
					}
				}
			}

			function addDeliveryAmount(deliveryAmount) {
				var currentAmount = $('#deliveryedAmount', '#frm-edit').numberbox('getValue');
				$('#deliveryedAmount', '#frm-edit').numberbox('setValue',parseInt(currentAmount) + parseInt(deliveryAmount));
				currentAmount = $('#notDevliveryedAmout', '#frm-edit').numberbox('getValue');
				$('#notDevliveryedAmout', '#frm-edit').numberbox('setValue', currentAmount - deliveryAmount);
			}

			function cutDeliveryAmount(deliveryAmount) {
				var currentAmount = $('#deliveryedAmount', '#frm-edit').numberbox('getValue');
				$('#deliveryedAmount', '#frm-edit').numberbox('setValue',parseInt(currentAmount) - parseInt(deliveryAmount));
				currentAmount = $('#notDevliveryedAmout', '#frm-edit').numberbox('getValue');
				$('#notDevliveryedAmout', '#frm-edit').numberbox('setValue', parseInt(currentAmount) + parseInt(deliveryAmount));
			}
			function showSpareInfo(){
				var spare_number = $('form#frm-edit input[name=spare_number]').val();
				var spare_category = $('form#frm-edit input[name=spare_category]').val();
				var spare_zljxh = $('form#frm-edit input[name=spare_zljxh]').val();
				var spare_sizes = $('form#frm-edit input[name=spare_sizes]').val();
				var spare_radius = $('form#frm-edit input[name=spare_radius]').val();
				var spare_percent = $('form#frm-edit input[name=spare_percent]').val();
				var spare_material = $('form#frm-edit input[name=spare_material]').val();

				var txt = spare_number + '|' +spare_category + '|'  + spare_zljxh +"|"+spare_sizes+"|"+spare_radius+"|"+spare_percent+"|"+spare_material;
				$('#spareInfo').text(txt);
			}

		</script>

		<div class="row-buttons">
			<e:linkbutton id="btn-save" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>  			
		</div>

		<input name="spare_number" type="hidden" >
		<input name="spare_category" type="hidden" >
		<input name="spare_zljxh" type="hidden" >
		<input name="spare_sizes" type="hidden" >
		<input name="spare_radius" type="hidden" >
		<input name="spare_percent" type="hidden" >
		<input name="spare_material" type="hidden" >
	</form>		
</e:window>
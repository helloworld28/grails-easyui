
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes/default',file:'easyui.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes',file:'icon.css')}" />
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery-1.8.0.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.easyui.min.js')}"></script>
		<script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-lang-zh_CN.js")}"></script>
		<script type="text/javascript" src="${resource(dir:'js',file:'datagrid-filter.js')}"></script>
		<script type="text/javascript" src="${resource( dir: "js", file: "easyui-scaffold.js")}"></script>
		<script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-scaffold-lang-en.js")}"></script>
		<link rel="stylesheet" type="text/css" href="${resource( dir:"css", file: "easyui-scaffold.css")}"/>

	<script>
			$(function() {
				$('#win-chooseSpare').window('close');
				var scaffold = new Scaffold({
					window: $('#win'),
				 	grid: $('#grid'),
				 	route: '${g.createLink()}'
				});

				$('#btn-add').click(function(){
					scaffold.add();
				});

				$('#btn-edit').click(function(){
						var traceTableId = $('#grid').datagrid('getSelected').id;
						var url = '<g:createLink action="show"/>'+"/"+traceTableId+'.json';
						$('#frm-edit').form('reset');

					$.get(url,function (data) {
						$('#frm-edit').form('load', data);
						showSpareInfo();
					});


					$('#dg-delivery').datagrid({'url':'<g:createLink controller="delivery" action="listByTraceTable"/>?traceTableId='+traceTableId})

						$('#win-edit').window('open');


				});

				$('#btn-delete').click(function(){
					scaffold.remove();
				});

				$('#btn-refresh').click(function(){
					scaffold.refresh();
				});

				$('#btn-save').click(function(){
					scaffold.save();
				});



				$('#txtSearch').searchbox({
					searcher: function(value, name){
						scaffold.search(name, value);
					}
				});
				$('#btn-addDelivery').click(function(){
					var rows = $('#grid').datagrid('getChecked');
					if(rows == ''){
						alert('请选中其中一条记录');
					}else if(rows.length > 1){
						alert('只能选择其中一条');
					}else{

						$('#winDelivery').window('open');
					}


				});
				$('#btn-choose').click(function () {
					$('#win-chooseSpare').dialog('open');
				});

			});
		</script>
	</head>							
	<body>		
		<div id="tb" class="scaffoldbar">			
			<div class="scaffoldbar-left">
				<e:linkbutton id="btn-add" plain="true" iconCls="icon-add"><g:message code="default.button.create.label"/></e:linkbutton>
				<e:linkbutton id="btn-edit" plain="true" iconCls="icon-edit"><g:message code="default.button.edit.label"/>/查看</e:linkbutton>
				<e:linkbutton id="btn-delete" plain="true" iconCls="icon-remove"><g:message code="default.button.delete.label"/></e:linkbutton>
				<e:linkbutton id="btn-refresh" plain="true" iconCls="icon-reload"><g:message code="default.button.refresh.label"/></e:linkbutton>
				%{--<e:linkbutton id="btn-addDelivery" plain="true" iconCls="icon-add">添加发货单</e:linkbutton>--}%
			</div>
			<div class="scaffoldbar-right">
				<e:searchbox id="txtSearch" menu="#mm"/>												
				<div id="mm" >
					<div data-options="name:'spare'">易损件型号</div>
					<div data-options="name:'company'">公司名称</div>
					<div data-options="name:'spareNumber'"><g:message code="traceTable.spareNumber"/></div>
				</div>
			</div>
		</div>

		<e:datagrid id="grid" idField="id" fit="true" singleSelect="true" fitColumns="true" pagination="true" toolbar="#tb"
			url="${createLink(action:'list.json',params: ['companyId':params.companyId, 'spareId':params.spareId])}" >
			<e:columns>
				<e:column field="ck" checkbox="true" />  						
				<e:column field="id" hidden="true" width="7"><g:message code="traceTable.id"/></e:column>  						
				<e:column field="spare_number" sortable="true" width="7"><g:message code="traceTable.spare"/></e:column>
				<e:column field="company_name" sortable="true" width="12"><g:message code="traceTable.company"/></e:column>
				<e:column field="contractNo" sortable="true" width="12">合同编号</e:column>
				<e:column field="spareNumber" sortable="true" width="7"><g:message code="traceTable.spareNumber"/></e:column>
				<e:column field="orderDate" sortable="true" width="7"><g:message code="traceTable.orderDate"/></e:column>  						
				<e:column field="orderAmount" sortable="true" width="7"><g:message code="traceTable.orderAmount"/></e:column>																				  												
				<e:column field="orderPrice" sortable="true" width="7">报价</e:column>
				<e:column field="deliveryedAmount" sortable="true" width="7"><g:message code="traceTable.deliveryedAmount"/></e:column>
				<e:column field="notDevliveryedAmout" sortable="true" width="7"><g:message code="traceTable.notDevliveryedAmout"/></e:column>
			</e:columns>
		</e:datagrid>
		<!--添加跟踪表表单-->
		<g:render template="form"/>
		<!--修改或查看跟踪表表单-->
		<g:render template="editform"/>
		<!--添加发货单表单-->
		<g:render template="../delivery/form"/>
		<!--选择易损件页面-->
		<g:render template="../spare/spare"/>

	</body>	
</html>
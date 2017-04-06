
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes/default',file:'easyui.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes',file:'icon.css')}" />
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery-1.8.0.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.easyui.min.js')}"></script>
	<script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-lang-zh_CN.js")}"></script>

		<script type="text/javascript" src="${resource( dir: "js", file: "easyui-scaffold.js")}"></script>
		<link rel="stylesheet" type="text/css" href="${resource( dir:"css", file: "easyui-scaffold.css")}"/>
		<script type="text/javascript" src="${resource( dir: "js/locale", file: "easyui-scaffold-lang-en.js")}"></script>
		<script type="text/javascript" src="${resource( dir: "js", file: "tracetable.js")}"></script>

		<script>
			$(function() {						
				var scaffold = new Scaffold({
					window: $('#win'), 
				 	grid: $('#grid'), 
				 	route: '${g.createLink()}'
				});
															
				$('#btn-add').click(function(){
					scaffold.add();
				});

				$('#btn-edit').click(function(){
					scaffold.edit();
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

				$('#grid').datagrid({
					columns:[[
						{field:'id',title:'id', hidden:true,width:80},
						{field:'traceTable_company_name',title:'分公司', width:80},
						{field:'traceTable_spare_number',title:'易损件编号', width:80},
						{field:'deliveryTime',title:'<g:message code="delivery.deliveryTime"/>', width:80},
						{field:'deliveryNumber',title:'<g:message code="delivery.deliveryNumber"/>', width:80},
						{field:'deliverAmount',title:'<g:message code="delivery.deliverAmount"/>', width:80},
						{field:'acceptTime',title:'入库时间', width:80},
						{field:'state',title:'<g:message code="delivery.state"/>', width:80,
							formatter: function(value,row,index){
								if (row.state == 1){
									return "已入库";
								} else {
									return "未入库";
								}
							}
						}
					]]
				});
			});
		</script>
	</head>							
	<body>		
		<div id="tb" class="scaffoldbar">			
			<div class="scaffoldbar-left">
				<e:linkbutton id="btn-add" plain="true" iconCls="icon-add"><g:message code="default.button.create.label"/></e:linkbutton>
				<e:linkbutton id="btn-edit" plain="true" iconCls="icon-edit"><g:message code="default.button.edit.label"/></e:linkbutton>  
				<e:linkbutton id="btn-delete" plain="true" iconCls="icon-remove"><g:message code="default.button.delete.label"/></e:linkbutton>
				<e:linkbutton id="btn-refresh" plain="true" iconCls="icon-reload"><g:message code="default.button.refresh.label"/></e:linkbutton>
			</div>
			%{--<div class="scaffoldbar-right">
				<e:searchbox id="txtSearch" menu="#mm"/>												
				<div id="mm" >
					<div data-options="name:'cusumableRecord'"><g:message code="delivery.cusumableRecord"/></div>
					<div data-options="name:'deliveryTime'"><g:message code="delivery.deliveryTime"/></div>
					<div data-options="name:'deliveryNumber'"><g:message code="delivery.deliveryNumber"/></div>
					<div data-options="name:'deliverAmount'"><g:message code="delivery.deliverAmount"/></div>
					<div data-options="name:'state'"><g:message code="delivery.state"/></div>       					 
				</div>
			</div>--}%
		</div>

		<e:datagrid id="grid" idField="id" fit="true" fitColumns="true" pagination="true" toolbar="#tb" 
			url="${createLink(action:'list.json')}" >
			<e:columns>
				<e:column field="ck" checkbox="true" />  						
				<e:column field="id" hidden="true" width="16"><g:message code="delivery.id"/></e:column>  						
				<e:column field="traceTable_company_name" sortable="true" width="16">分公司</e:column>
				<e:column field="traceTable_spare_number" sortable="true" width="16">易损件编号</e:column>
				<e:column field="deliveryTime" sortable="true" width="16"><g:message code="delivery.deliveryTime"/></e:column>
				<e:column field="deliveryNumber" sortable="true" width="16"><g:message code="delivery.deliveryNumber"/></e:column>  						
				<e:column field="deliverAmount" sortable="true" width="16"><g:message code="delivery.deliverAmount"/></e:column>  						
				<e:column field="state" sortable="true" width="16" ><g:message code="delivery.state"/></e:column>
			</e:columns>			
		</e:datagrid>
				
		<g:render template="form1"/>
	</body>	
</html>
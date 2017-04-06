
<!DOCTYPE html>
<html>·
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
						},
						{field:'traceTable_spare_price',title:'操作', width:80,
							formatter: function(value,row,index){
								if (row.state == 1){
									return "";
								} else {
									return "<input type='button' class='btn-confirm' onclick='acceptA("+row.id+")' value='确认入库'/>";
								}
							}
						}
					]]
				});
			});


			function acceptA(id) {
				$.post('<g:createLink controller="delivery" action="accept"/>',{'id':id}, function (data) {
					if(data == '1'){
						$.messager.alert('tip','操作成功');
						$('#grid').datagrid('reload')
					}else{
						$.messager.alert('Error','操作失败');
					}
				});
			}
		</script>
	</head>							
	<body>		
		<div id="tb" class="scaffoldbar">
			<div class="scaffoldbar-left">
				<e:searchbox id="txtSearch" menu="#mm"/>												
				<div id="mm" >
					<div data-options="name:'deliveryNumber'"><g:message code="delivery.deliveryNumber"/></div>
					<div data-options="name:'spareNumber'">生产编号</div>
				</div>
			</div>
		</div>
		<e:datagrid id="grid" idField="id" fit="true" fitColumns="true" pagination="true" toolbar="#tb" 
			url="${createLink(action:'listAccept.json')}" >
			<e:columns>
				<e:column field="ck" checkbox="true" />  						
				<e:column field="id" hidden="true" width="16"></e:column>
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
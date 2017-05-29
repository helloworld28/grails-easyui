
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
						{field:'traceTable_company_name',title:'分公司', width:150},
						{field:'traceTable_contractNo',title:'合同号', width:80},
						{field:'traceTable_spare_number',title:'易损件编号', width:80},
						{field:'traceTable_spare_category',title:'品类', width:60},
						{field:'traceTable_spare_zljxh',title:'制粒机型号', width:80},
						{field:'traceTable_spare_material',title:'材质 ', width:60},
						{field:'traceTable_spare_radius',title:'孔径 ', width:50},
						{field:'traceTable_orderAmount',title:'数量 ', width:60},
						{field:'traceTable_orderPrice',title:'单价 ', width:80},
						{field:'traceTable_orderPrice1',title:'金额 ', width:80,formatter: function(value,row,index){
                            return row.traceTable_orderAmount * row.traceTable_orderPrice;
                        }},
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

		</e:datagrid>
				
		<g:render template="form1"/>
	</body>	
</html>
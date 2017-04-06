
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
				$('#btn-fileUpload').click(function(){
					$('#winFileUpload').window('open');
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
				<e:linkbutton id="btn-fileUpload" plain="true" iconCls="icon-add">批量导入</e:linkbutton>
			</div>
			<div class="scaffoldbar-right">
				<e:searchbox id="txtSearch" menu="#mm"/>												
				<div id="mm" >
					<div data-options="name:'number'"><g:message code="spare.number"/></div>
					<div data-options="name:'category'"><g:message code="spare.category"/></div>
					<div data-options="name:'zljxh'"><g:message code="spare.zljxh"/></div>
					<div data-options="name:'sizes'"><g:message code="spare.sizes"/></div>
					<div data-options="name:'radius'"><g:message code="spare.radius"/></div>
					<div data-options="name:'percent'"><g:message code="spare.percent"/></div>       					 
					<div data-options="name:'material'"><g:message code="spare.material"/></div>
				</div>
			</div>
		</div>

		<e:datagrid id="grid" idField="id" fit="true" fitColumns="true" pagination="true" toolbar="#tb" 
			url="${createLink(action:'list.json')}" >
			<e:columns>
				<e:column field="ck" checkbox="true" />  						
				<e:column field="id" hidden="true" width="14"><g:message code="spare.id"/></e:column>  						
				<e:column field="number" sortable="true" width="14"><g:message code="spare.number"/></e:column>
				<e:column field="category" sortable="true" width="14"><g:message code="spare.category"/></e:column>
				<e:column field="zljxh" sortable="true" width="14"><g:message code="spare.zljxh"/></e:column>
				<e:column field="sizes" sortable="true" width="14"><g:message code="spare.sizes"/></e:column>  						
				<e:column field="radius" sortable="true" width="14"><g:message code="spare.radius"/></e:column>  						
				<e:column field="percent" sortable="true" width="14"><g:message code="spare.percent"/></e:column>																				  												
				<e:column field="material" sortable="true" width="14"><g:message code="spare.material"/></e:column>
				<e:column field="price" sortable="true" width="14"><g:message code="spare.price"/></e:column>
			</e:columns>
		</e:datagrid>
		<g:render template="form"/>


	<e:window id="winFileUpload" title="上传文件" width="400px" closed="true"
			  maximizable="false" minimizable="false" collapsible="false" modal="true">

		<g:form controller="spare" action="batchInput" method="post" enctype="multipart/form-data">
			<input type="file" name="myFile" />
			<input type="submit" value="上&nbsp;&nbsp;&nbsp;传" />
		</g:form>
	</e:window>
	</body>	
</html>
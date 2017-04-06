
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes/default',file:'easyui.css')}" />
		<link rel="stylesheet" type="text/css" href="${resource(dir:'js/themes',file:'icon.css')}" />
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery-1.8.0.min.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js',file:'jquery.easyui.min.js')}"></script>

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
			<div class="scaffoldbar-right">
				<e:searchbox id="txtSearch" menu="#mm"/>												
				<div id="mm" >
					<div data-options="name:'userName'"><g:message code="user.userName"/></div>

				</div>
			</div>
		</div>

		<e:datagrid id="grid" idField="id" fit="true" fitColumns="true" pagination="true" toolbar="#tb" 
			url="${createLink(action:'list.json')}" >
			<e:columns>
				<e:column field="ck" checkbox="true" />  						
				<e:column field="id" hidden="true" width="20"></e:column>
				<e:column field="userName" sortable="true" width="20"><g:message code="user.userName"/></e:column>  						
				<e:column field="password" sortable="true" width="20">密码</e:column>
				<e:column field="company_name" sortable="true" width="20">所属公司</e:column>
			</e:columns>			
		</e:datagrid>

		<g:render template="form"/>	
	</body>	
</html>
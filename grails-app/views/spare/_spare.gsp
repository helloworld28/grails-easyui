

<div  class="easyui-dialog" id="win-chooseSpare" title="选择易损件" width="700px"  style="width:700px;height:500px;padding:5px"height="200px" closed="true"
		  maximizable="false" minimizable="false" collapsible="false" modal="true"
data-options="buttons: [{
					text:'Ok',
					iconCls:'icon-ok',
					handler:function(){
					   var selectedRows =  $('#grid-spare').datagrid('getChecked');
					  if(selectedRows == ''){
						alert('请选中其中一条记录');
						}else if(selectedRows.length > 1){
							alert('只能选择其中一条');
						}else{
							var id =  selectedRows[0].id;
							var number = selectedRows[0].number;
							$('#spareNumber').val(number);
							$('#spare').val(id);
							$('#win-chooseSpare').dialog('close');
						}
					}
				},{
					text:'Cancel',
					handler:function(){
						alert('cancel');;
					}
				}]">
		<e:datagrid id="grid-spare" idField="id" fit="true" fitColumns="true" singleSelect="true"
			url="${createLink(controller: 'spare', action:'listByFilter.json', params: ['page':0, 'rows':50])}" >
			<e:columns>
				<e:column field="id" checkbox="true" />
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

	<script>
		$(function() {
			var dg = $('#grid-spare').datagrid({
				filterBtnIconCls:'icon-filter',
				remoteFilter:true
			});

			dg.datagrid('enableFilter');
		});
	</script>

</div>

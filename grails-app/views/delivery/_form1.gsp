
<e:window id="win" title="${g.message(code: 'delivery.label')}" width="400px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">
	<form id="frm" method='POST' autocomplete="off" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />
		<input type="hidden" name="traceTableId" id="traceTableId" />

		<div class="row-input">
			<label for="deliveryTime"><g:message code="delivery.deliveryTime"/></label>
			<e:datebox name="deliveryTime" width="100px"/>
		</div>												
		
		<div class="row-input">
			<label for="deliveryNumber"><g:message code="delivery.deliveryNumber"/></label>
			<e:validatebox name="deliveryNumber"  required="true"/>
		</div>												
		
		<div class="row-input">
			<label for="deliverAmount"><g:message code="delivery.deliverAmount"/></label>
			<e:numberbox name="deliverAmount"  width="100px" maxlenght="8"/>
		</div>												
		<div class="row-errors">
		</div>
														
		<div class="row-buttons">
			<e:linkbutton id="btn-save-delivery" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>
		</div>			
	</form>		
</e:window>
<script>
	$('#btn-save-delivery').click(
			function(){
				var rows  = $('#grid').datagrid('getChecked');


				if(rows != '' && rows.length == 1){

					var traceTableId = rows[0].id;
					console.log("traceTableId:"+traceTableId)
					$('#traceTableId').val(traceTableId);
					$.ajax({
						url:'<g:createLink controller="delivery" action="createDevlivery"/>',
						data:$('#frmDelivery').serialize(),
						dataType:'JSON',
						type:'POST',
						success:function (data) {

							if(data == '1'){
								//$('#frmDelivery').reset()
								alert('保存成功');
								$('#grid').datagrid('reload');
								$('#winDelivery').window('close');
							}else{
								alert('保存失败');
							}
						}
					});
				}
			}

	);
</script>
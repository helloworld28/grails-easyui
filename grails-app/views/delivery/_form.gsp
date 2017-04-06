
<e:window id="winDelivery" title="${g.message(code: 'delivery.label')}" width="400px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">
	<form id="frmDelivery" method='POST' autocomplete="off" >
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
			<e:numberbox name="deliverAmount" id="deliverAmount"  width="100px" maxlenght="8"/>
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
				var row  = $('#grid').datagrid('getSelected');


				if(row != '' ){

					var traceTableId = row['id'];
					var deliveryAmount = $('#deliverAmount').val();
					$('#traceTableId').val(traceTableId);
					$.ajax({
						url:'<g:createLink controller="delivery" action="createDevlivery"/>',
						data:$('#frmDelivery').serialize(),
						dataType:'JSON',
						type:'POST',
						success:function (data) {

							if(data == '1'){
								//$('#frmDelivery').form.reset()
								//$.messager.alert('提示','保存成功');
								$('#grid').datagrid('reload');
								$('#winDelivery').window('close');
								$('#dg-delivery').datagrid('reload');
								addDeliveryAmount(deliveryAmount);

							}else{
								alert('保存失败');
							}
						}
					});
				}
			}

	);
</script>
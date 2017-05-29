
<e:window id="win" title="${g.message(code: 'traceTable.label')}" width="500px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">

	<form id="frm" method='POST' autocomplete="off" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />												
		
		<div class="row-input">
			<label for="spareNumber"><g:message code="traceTable.spare"/></label>
		<input name="spare" id="spare" type="hidden" readonly="true"/>
		<input name="spare-Number" id="spareNumber"type="text" readonly="true"/><a href="#" id="btn-choose">选择</a>
		</div>
		
		<div class="row-input">
			<label for="company"><g:message code="traceTable.company"/></label>
			<input id="company" class="easyui-combobox" style="width: 200px" width="100px" name="company" />
		</div>

		<div class="row-input">
			<label for="contractNo">合同编号</label>
			<e:validatebox name="contractNo" />
		</div>
		
		<div class="row-input">
			<label for="spareNumber"><g:message code="traceTable.spareNumber"/></label>
			<e:validatebox name="spareNumber" />
		</div>



		<div class="row-input">
			<label for="orderDate"><g:message code="traceTable.orderDate"/></label>
			<e:datebox name="orderDate" width="100px"/>
		</div>												
		
		<div class="row-input">
			<label for="orderAmount"><g:message code="traceTable.orderAmount"/></label>
			<e:numberbox name="orderAmount"  width="100px" maxlenght="8"/>
		</div>												
		
	%{--	<div class="row-input">
			<label for="deliveryedAmount"><g:message code="traceTable.deliveryedAmount"/></label>
			<e:numberbox name="deliveryedAmount"  width="100px" maxlenght="8"/>
		</div>

		<div class="row-input">
			<label for="notDevliveryedAmout"><g:message code="traceTable.notDevliveryedAmout"/></label>
			<e:numberbox name="notDevliveryedAmout"  width="100px" maxlenght="8"/>
		</div>	--}%
		%{--
		<div class="row-input">
			<label for="beginUseTime"><g:message code="traceTable.beginUseTime"/></label>
			<e:datebox name="beginUseTime" width="100px"/>
		</div>												
		
		<div class="row-input">
			<label for="endUseTime"><g:message code="traceTable.endUseTime"/></label>
			<e:datebox name="endUseTime" width="100px"/>
		</div>												
		
		<div class="row-input">
			<label for="outputPerHour"><g:message code="traceTable.outputPerHour"/></label>
			<e:numberbox name="outputPerHour" precision="2" width="100px" maxlenght="8"/>
		</div>												
		
		<div class="row-input">
			<label for="totalOutput"><g:message code="traceTable.totalOutput"/></label>
			<e:numberbox name="totalOutput" precision="2" width="100px" maxlenght="8"/>
		</div>												
		
		<div class="row-input">
			<label for="qualified"><g:message code="traceTable.qualified"/></label>
			<e:numberbox name="qualified"  width="100px" maxlenght="8"/>
		</div>												
		
		<div class="row-input">
			<label for="remark"><g:message code="traceTable.remark"/></label>
			<e:validatebox name="remark" />
		</div>--}%
		
		<div class="row-errors">
		</div>
														
		<div class="row-buttons">
			<e:linkbutton id="btn-save" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>  			
		</div>			
	</form>
	<script>
        $(document).ready(function () {
            $('#company').combobox({
                url:'<g:createLink controller="company" action="listAll"/>',
                valueField:'id',
                textField:'name',
                filter: function(q, row){
                    var opts = $(this).combobox('options');
                    return row[opts.textField].indexOf(q) > -1;
                },
                onLoadSuccess:function () {
                    $('#company').combobox('setValue', '${params.company}');
                }
            });



        });

	</script>
</e:window>
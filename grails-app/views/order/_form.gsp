
<e:window id="win" title="${g.message(code: 'order.label')}" width="400px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">
	<form id="frm" method='POST' autocomplete="off" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />												
		
		<div class="row-input">
			<label for="amount"><g:message code="order.amount"/></label>
			<e:numberbox name="amount"  width="100px" maxlenght="8"/>
		</div>												
		
		<div class="row-input">
			<label for="createDate"><g:message code="order.createDate"/></label>
			<e:datebox name="createDate" width="100px"/>
		</div>												
		
		<div class="row-input">
			<label for="name"><g:message code="order.name"/></label>
			<e:validatebox name="name" />
		</div>
		
		<div class="row-errors">
		</div>
														
		<div class="row-buttons">
			<e:linkbutton id="btn-save" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>  			
		</div>			
	</form>		
</e:window>
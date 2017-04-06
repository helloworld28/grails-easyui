
<e:window id="win" title="${g.message(code: 'company.label')}" width="400px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">
	<form id="frm" method='POST' autocomplete="off" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />												
		
		<div class="row-input">
			<label for="name"><g:message code="company.name"/></label>
			<e:validatebox name="name"  maxlength="50" required="true"/>
		</div>
		
		<div class="row-errors">
		</div>
														
		<div class="row-buttons">
			<e:linkbutton id="btn-save" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>  			
		</div>			
	</form>		
</e:window>
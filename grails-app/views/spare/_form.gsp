
<e:window id="win" title="${g.message(code: 'spare.label')}" width="400px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">
	<form id="frm" method='POST' autocomplete="off" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />												
		
		<div class="row-input">
			<label for="number"><g:message code="spare.number"/></label>
			<e:validatebox name="number" />
		</div>

		<div class="row-input">
			<label for="number"><g:message code="spare.category"/></label>
			<e:validatebox name="category" />
		</div>

		<div class="row-input">
			<label for="zljxh"><g:message code="spare.zljxh"/></label>
			<e:validatebox name="zljxh" />
		</div>												
		
		<div class="row-input">
			<label for="sizes"><g:message code="spare.sizes"/></label>
			<e:validatebox name="sizes" />
		</div>												
		
		<div class="row-input">
			<label for="radius"><g:message code="spare.radius"/></label>
			<e:validatebox name="radius" />
		</div>												
		
		<div class="row-input">
			<label for="percent"><g:message code="spare.percent"/></label>
			<e:validatebox name="percent" />
		</div>

		<div class="row-input">
			<label for="percent"><g:message code="spare.material"/></label>
			<e:validatebox name="material" />
		</div>


		<div class="row-input">
			<label for="price"><g:message code="spare.price"/></label>
			<e:numberbox name="price"  width="100px" maxlenght="8"/>
		</div>
		
		<div class="row-errors">
		</div>
														
		<div class="row-buttons">
			<e:linkbutton id="btn-save" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>  			
		</div>			
	</form>		
</e:window>
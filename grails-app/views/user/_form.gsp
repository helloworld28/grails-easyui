
<e:window id="win" title="${g.message(code: 'user.label')}" width="500px" closed="true"
	maximizable="false" minimizable="false" collapsible="false" modal="true">
	<form id="frm" method='POST' autocomplete="off" >
		<g:hiddenField name="id" />
		<g:hiddenField name="version" />												
		
		<div class="row-input">
			<label for="userName"><g:message code="user.userName"/></label>
			<e:validatebox name="userName"  maxlength="50" required="true"/>
		</div>												
		
		<div class="row-input">
			<label for="password">初始密码</label>
			<e:validatebox name="password"  maxlength="50" value="123456" required="true"/>
		</div>												
		

		
		<div class="row-input">
			<label for="company">公司</label>
			<e:combogrid
					name="company"
					width="300px"
					url="${createLink(controller: 'company', action:'list.json')}"
					idField="id"
					textField="name"
					fitColumns="true"
					remote="true"
					required="true"
					columns="js:[[
					{field:'id', title:'id', width:20},
					{field:'name', title:'公司名', width:250}
				]]"/>
		</div>
		
		<div class="row-errors">
		</div>
														
		<div class="row-buttons">
			<e:linkbutton id="btn-save" iconCls="icon-ok"><g:message code="default.button.save.label" /></e:linkbutton>  			
		</div>			
	</form>		
</e:window>
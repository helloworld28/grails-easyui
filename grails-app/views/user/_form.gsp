
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
			<input id="company" class="easyui-combobox" style="width: 200px" width="100px" name="company" />
		</div>
		
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
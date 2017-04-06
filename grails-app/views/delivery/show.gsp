
<%@ page import="com.amr333.zzkj.Delivery" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'delivery.label', default: 'Delivery')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-delivery" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-delivery" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list delivery">
			
				<g:if test="${deliveryInstance?.cusumableRecord}">
				<li class="fieldcontain">
					<span id="cusumableRecord-label" class="property-label"><g:message code="delivery.cusumableRecord.label" default="Cusumable Record" /></span>
					
						<span class="property-value" aria-labelledby="cusumableRecord-label"><g:link controller="cusumablesRecord" action="show" id="${deliveryInstance?.cusumableRecord?.id}">${deliveryInstance?.cusumableRecord?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${deliveryInstance?.deliveryTime}">
				<li class="fieldcontain">
					<span id="deliveryTime-label" class="property-label"><g:message code="delivery.deliveryTime.label" default="Delivery Time" /></span>
					
						<span class="property-value" aria-labelledby="deliveryTime-label"><g:formatDate date="${deliveryInstance?.deliveryTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${deliveryInstance?.deliveryNumber}">
				<li class="fieldcontain">
					<span id="deliveryNumber-label" class="property-label"><g:message code="delivery.deliveryNumber.label" default="Delivery Number" /></span>
					
						<span class="property-value" aria-labelledby="deliveryNumber-label"><g:fieldValue bean="${deliveryInstance}" field="deliveryNumber"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${deliveryInstance?.deliverAmount}">
				<li class="fieldcontain">
					<span id="deliverAmount-label" class="property-label"><g:message code="delivery.deliverAmount.label" default="Deliver Amount" /></span>
					
						<span class="property-value" aria-labelledby="deliverAmount-label"><g:fieldValue bean="${deliveryInstance}" field="deliverAmount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${deliveryInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="delivery.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${deliveryInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:deliveryInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${deliveryInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

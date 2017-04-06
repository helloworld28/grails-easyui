
<%@ page import="com.amr333.zzkj.Spare" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'spare.label', default: 'Spare')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-spare" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-spare" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list spare">
			
				<g:if test="${spareInstance?.number}">
				<li class="fieldcontain">
					<span id="number-label" class="property-label"><g:message code="spare.number.label" default="Number" /></span>
					
						<span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${spareInstance}" field="number"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${spareInstance?.zljxh}">
				<li class="fieldcontain">
					<span id="zljxh-label" class="property-label"><g:message code="spare.zljxh.label" default="Zljxh" /></span>
					
						<span class="property-value" aria-labelledby="zljxh-label"><g:fieldValue bean="${spareInstance}" field="zljxh"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${spareInstance?.sizes}">
				<li class="fieldcontain">
					<span id="sizes-label" class="property-label"><g:message code="spare.sizes.label" default="Sizes" /></span>
					
						<span class="property-value" aria-labelledby="sizes-label"><g:fieldValue bean="${spareInstance}" field="sizes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${spareInstance?.radius}">
				<li class="fieldcontain">
					<span id="radius-label" class="property-label"><g:message code="spare.radius.label" default="Radius" /></span>
					
						<span class="property-value" aria-labelledby="radius-label"><g:fieldValue bean="${spareInstance}" field="radius"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${spareInstance?.percent}">
				<li class="fieldcontain">
					<span id="percent-label" class="property-label"><g:message code="spare.percent.label" default="Percent" /></span>
					
						<span class="property-value" aria-labelledby="percent-label"><g:fieldValue bean="${spareInstance}" field="percent"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${spareInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="spare.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${spareInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:spareInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${spareInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>

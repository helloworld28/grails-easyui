
<%@ page import="com.amr333.zzkj.Delivery" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'delivery.label', default: 'Delivery')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-delivery" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-delivery" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="delivery.cusumableRecord.label" default="Cusumable Record" /></th>
					
						<g:sortableColumn property="deliveryTime" title="${message(code: 'delivery.deliveryTime.label', default: 'Delivery Time')}" />
					
						<g:sortableColumn property="deliveryNumber" title="${message(code: 'delivery.deliveryNumber.label', default: 'Delivery Number')}" />
					
						<g:sortableColumn property="deliverAmount" title="${message(code: 'delivery.deliverAmount.label', default: 'Deliver Amount')}" />
					
						<g:sortableColumn property="state" title="${message(code: 'delivery.state.label', default: 'State')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${deliveryInstanceList}" status="i" var="deliveryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${deliveryInstance.id}">${fieldValue(bean: deliveryInstance, field: "cusumableRecord")}</g:link></td>
					
						<td><g:formatDate date="${deliveryInstance.deliveryTime}" /></td>
					
						<td>${fieldValue(bean: deliveryInstance, field: "deliveryNumber")}</td>
					
						<td>${fieldValue(bean: deliveryInstance, field: "deliverAmount")}</td>
					
						<td>${fieldValue(bean: deliveryInstance, field: "state")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${deliveryInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>

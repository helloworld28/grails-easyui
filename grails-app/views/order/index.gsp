
<%@ page import="com.amr333.zzkj.Order" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'order.label', default: 'Order')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-order" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-order" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="amount" title="${message(code: 'order.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="createDate" title="${message(code: 'order.createDate.label', default: 'Create Date')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'order.name.label', default: 'Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${orderInstanceList}" status="i" var="orderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${orderInstance.id}">${fieldValue(bean: orderInstance, field: "amount")}</g:link></td>
					
						<td><g:formatDate date="${orderInstance.createDate}" /></td>
					
						<td>${fieldValue(bean: orderInstance, field: "name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${orderInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
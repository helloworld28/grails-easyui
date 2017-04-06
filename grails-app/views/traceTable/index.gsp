
<%@ page import="com.amr333.zzkj.TraceTable" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'traceTable.label', default: 'TraceTable')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-traceTable" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-traceTable" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="traceTable.spare.label" default="Spare" /></th>
					
						<th><g:message code="traceTable.company.label" default="Company" /></th>
					
						<g:sortableColumn property="spareNumber" title="${message(code: 'traceTable.spareNumber.label', default: 'Spare Number')}" />
					
						<g:sortableColumn property="orderDate" title="${message(code: 'traceTable.orderDate.label', default: 'Order Date')}" />
					
						<g:sortableColumn property="orderAmount" title="${message(code: 'traceTable.orderAmount.label', default: 'Order Amount')}" />
					
						<g:sortableColumn property="deliveryedAmount" title="${message(code: 'traceTable.deliveryedAmount.label', default: 'Deliveryed Amount')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${traceTableInstanceList}" status="i" var="traceTableInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${traceTableInstance.id}">${fieldValue(bean: traceTableInstance, field: "spare")}</g:link></td>
					
						<td>${fieldValue(bean: traceTableInstance, field: "company")}</td>
					
						<td>${fieldValue(bean: traceTableInstance, field: "spareNumber")}</td>
					
						<td><g:formatDate date="${traceTableInstance.orderDate}" /></td>
					
						<td>${fieldValue(bean: traceTableInstance, field: "orderAmount")}</td>
					
						<td>${fieldValue(bean: traceTableInstance, field: "deliveryedAmount")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${traceTableInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>

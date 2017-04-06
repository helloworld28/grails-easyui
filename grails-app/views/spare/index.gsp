
<%@ page import="com.amr333.zzkj.Spare" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'spare.label', default: 'Spare')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-spare" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-spare" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="number" title="${message(code: 'spare.number.label', default: 'Number')}" />
					
						<g:sortableColumn property="zljxh" title="${message(code: 'spare.zljxh.label', default: 'Zljxh')}" />
					
						<g:sortableColumn property="sizes" title="${message(code: 'spare.sizes.label', default: 'Sizes')}" />
					
						<g:sortableColumn property="radius" title="${message(code: 'spare.radius.label', default: 'Radius')}" />
					
						<g:sortableColumn property="percent" title="${message(code: 'spare.percent.label', default: 'Percent')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'spare.price.label', default: 'Price')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${spareInstanceList}" status="i" var="spareInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${spareInstance.id}">${fieldValue(bean: spareInstance, field: "number")}</g:link></td>
					
						<td>${fieldValue(bean: spareInstance, field: "zljxh")}</td>
					
						<td>${fieldValue(bean: spareInstance, field: "sizes")}</td>
					
						<td>${fieldValue(bean: spareInstance, field: "radius")}</td>
					
						<td>${fieldValue(bean: spareInstance, field: "percent")}</td>
					
						<td>${fieldValue(bean: spareInstance, field: "price")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${spareInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>

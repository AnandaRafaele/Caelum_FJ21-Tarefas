<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" href="resources/css/tarefas.css" rel="stylesheet" />

<style type="text/css">
td {
	padding: 5px;
}
</style>
<link rel="stylesheet"
	href="<c:url value="/resources/css/jquery-ui.css"></c:url>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/jquery-ui.min.css"></c:url>" />
<script src="<c:url value="/resources/js/jquery.js"></c:url>"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
		function finalizaAgora(id) {
			$.post('finalizaTarefa', {'id' : id}, function(resposta) {
				$('#tarefa_'+id).html(resposta);
			});
		}
	</script>

	<h3>Lista de Tarefas</h3>
	<table border="2">
		<tr style="text-align: center">
			<td>ID</td>
			<td>DESCRICAO</td>
			<td>FINALIZADO?</td>
			<td>DATA FINALIZACAO</td>
			<td>REMOÇÃO</td>
			<td>ALTERAÇÃO</td>
		</tr>
		<!-- percorre contatos montando as linhas da tabela -->
		<c:forEach var="tarefa" items="${tarefas}" varStatus="cont">
			<tr id="tarefa_${tarefa.id}"
				bgcolor="#${cont.count % 2 == 0 ? 'ffffff' : 'aaee88'}">
				<td>${tarefa.id}</td>
				<td>${tarefa.descricao}</td>

				<!-- 	Condição do boolean "Finalizado" -->

				<c:choose>
					<c:when test="${tarefa.finalizado eq true}">
						<td>Finalizado</td>
					</c:when>
					<c:otherwise>
						<td><a href="#" onclick="finalizaAgora(${tarefa.id})">Finaliza
								agora!</a></td>
					</c:otherwise>
				</c:choose>

				<!-- Condição da data de Finalização -->

				<td><fmt:formatDate value="${tarefa.dataFinalizacao.time}"
						pattern="dd/MM/yyyy" /></td>

				<!-- Ações altera e remove -->

				<td><a href="removeTarefa?id=${tarefa.id}">REMOVER</a></td>
				<td><a href="mostraTarefa?id=${tarefa.id}">ALTERAR</a></td>
			</tr>
		</c:forEach>
	</table>
	<br />
	<a href="novaTarefa" class="ui-button ui-widget ui-corner-all"><span
		class="ui-icon ui-icon-circle-plus"></span> Criar nova tarefa</a>

</body>
</html>
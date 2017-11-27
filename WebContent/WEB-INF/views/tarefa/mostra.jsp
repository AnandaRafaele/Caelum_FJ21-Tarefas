<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="caelum"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" href="resources/css/tarefas.css" rel="stylesheet" />
<link href="<c:url value="/resources/css/jquery-ui.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/jquery.js" />"></script>
<script src="<c:url value="/resources/js/jquery-ui.js" />"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mostrando Tarefa</title>
</head>
<body>
	<form class="form-group" action="alteraTarefa" method="post">
		<fieldset>
			<legend>Alterar Tarefa</legend>
			<input type="hidden" class="form-control" name="id"
				value="${tarefa.id}">

			<p>Descrição:</p>
			<textarea name="descricao" rows="5" cols="100">${tarefa.descricao}</textarea>

			<p>
				Finalizado: <input type="checkbox"
					name="finalizado" value="true"
					${tarefa.finalizado ? 'checked' : '' } />
			</p>

			<p>
				Data de finalização:
				<caelum:campoData id="dataFinalizacao"
					value="${tarefa.dataFinalizacao.time}"></caelum:campoData>
			</p>



			<br /> <input type="submit"
				class="ui-button ui-corner-all ui-widget" value="Alterar" />
		</fieldset>
	</form>
</body>
</html>
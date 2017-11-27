<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/jquery-ui.css"></c:url>">
<script src="<c:url value="/resources/js/jquery.js" />"></script>
<script src="<c:url value="/resources	/js/jquery-ui.js" />"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form:errors path="tarefa.descricao" cssStyle="color:red"></form:errors>
	<form action="adicionaTarefa" method="post">
		<fieldset>
			<legend>Adicionar Tarefa</legend>
			<p>Descrição:</p>
			
			<p><textarea name="descricao" rows="5" cols="100"></textarea></p>
			<br/>
			<input type="submit" class="ui-button ui-corner-all ui-widget" value="Adicionar">
		</fieldset>
	</form>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
	<meta charset="ISO-8859-1">
	<title>GP Brasil de Atletismo</title>
	<link rel="stylesheet" type="text/css" href="CSS/gp.css"/>
	<link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css" />
	
	<script type="text/javascript" src="JS/jquery-3.5.0.min.js"></script>
	<script type="text/javascript" src="JS/bootstrap.min.js"></script>
</head>
<body>

	<img src="IMAGENS/faixa_superior.png">	
	<div class="logo">
		<img src="IMAGENS/logo.png">
	</div>
	<div class="bandeira">
		<img src="IMAGENS/bandeira.png">
	</div>	
	<div class="container">
		
		<a class="list_atleta" href="atletaServelet">&#62 &#62 LISTA GERAL DE ATLETAS</a>
		<a class="list_paises" href="paisServelet">&#62 &#62 LISTA DE PAÍSES</a>

		<div class="container_cinza">
			<div>
				<div class="barra_lateral">
					<img src="IMAGENS/lateral_gp.png">
				</div>
				<img class="barra_lateral_iaaf" src="IMAGENS/iaaf.png">
				
				<input class="texto_barra_lateral" type="text"  value="GP BRASIL 2020 - LISTA DE PROVAS">
				
				<div class="teste"></div>
				<table class="table table-sm table-hover table-bordered tbl_provas">
					<thead>
						<tr class="linha_azul">
							<th class="centralizar">HORA</th>
							<th>PROVA</th>
							<th>GENERO</th>
							<th class="centralizar">STAUS</th>
						</tr>						
					</thead>
					<tbody>
						<c:forEach var="prova" items="${list_Provas}">
							<tr>
								<td>${prova.horario}</td>
								<td>${prova.descricao}</td>
								<td>${prova.genero}</td>
								<td>
									<a class="link_azul" href=participantesServlet?acao=listarParticipantes&codigo_prova=${prova.codigo_prova}><img src="IMAGENS/lista_atletas.png"/>LISTA</a>
									<a class="link_azul" href=bateriasServlet?acao=listarbaterias&codigo_prova=${prova.codigo_prova}><img src="IMAGENS/classificatoria.png"/>CLASSIFICATÓRIA</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
	<meta charset="ISO-8859-1">
	<title>GP Brasil de Atletismo</title>
	<link rel="stylesheet" type="text/css" href="CSS/paises.css"/>
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
	<div class="link">
		<a href="provaServelet">&#60 &#60 VOLTAR</a>
	</div>
	<div class="container">
		<div class="container_cinza">
			<div>
				<div class="barra_lateral">
					<img src="IMAGENS/lateral_gp.png">
				</div>
				<img class="barra_lateral_iaaf" src="IMAGENS/iaaf.png">
				<img class="barra_lateral_pais" src="IMAGENS/planeta.png">
				
				<input class="texto_barra_lateral" type="text"  value="GP BRASIL 2020 - LISTA DE PAÍSES">
				
				<div class="teste"></div>
					<div class="scroll">
						<table class="table table-sm table-hover table-bordered tbl_provas">
							<thead>
								<tr class="linha_azul centralizar">
									<th>C.O.I</th>
									<th>PAÍS</th>
									<th>ATLETAS</th>
								</tr>
							</thead>
							
							<c:forEach var="pais" items="${list_Paises}">
								<tbody>
									<tr class="centralizar">
										<td>${pais.codigo}</td>
										<td>${pais.pais}</td>
										<td>${pais.atletas}</td>
									</tr>
								</tbody>
							</c:forEach>
						</table>
					</div>
			</div>
		</div>
	</div>
</body>
</html>
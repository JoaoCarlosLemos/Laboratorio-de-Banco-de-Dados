<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
	<meta charset="ISO-8859-1">
	<title>GP Brasil de Atletismo</title>
	<link rel="stylesheet" type="text/css" href="CSS/participantes.css"/>
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
				
				<c:if test="${descricao_prova == 'ARREMESSO DE PESO  - FEMININO'}"> 
					<img class="boneco" src="IMAGENS/arremesso.png">
				</c:if>
				
				<c:if test="${descricao_prova == 'LANÇAMENTO DE DARDO - FEMININO'}"> 
					<img class="boneco" src="IMAGENS/dardo.png">
				</c:if>
				
				<c:if test="${descricao_prova == 'LANÇAMENTO DE DISCO - MASCULINO'}"> 
					<img class="boneco" src="IMAGENS/disco.png">
				</c:if>
				
				<c:if test="${descricao_prova == 'SALTO COM VARA - MASCULINO'}"> 
					<img class="boneco" src="IMAGENS/vara.png">
				</c:if>
				
				<c:if test="${descricao_prova == 'SALTO EM DISTÂNCIA - MASCULINO'}"> 
					<img class="boneco" src="IMAGENS/distancia.png">
				</c:if>
				
				<c:if test="${descricao_prova == 'SALTO TRIPLO - FEMININO'}"> 
					<img class="boneco" src="IMAGENS/salto.png">
				</c:if>
				
				<c:if test="${descricao_prova =='100 M - FEMININO'or descricao_prova =='100 M - MASCULINO' 
							  or descricao_prova =='200 M - FEMININO'or descricao_prova =='200 M - MASCULINO'
							  or descricao_prova =='400 M - MASCULINO'or descricao_prova =='800 M - FEMININO'
							  or descricao_prova =='800 M - MASCULINO'or descricao_prova =='3000 M - MASCULINO'}"> 
					<img class="boneco" src="IMAGENS/corrida.png">
				</c:if>
				
				<c:if test="${descricao_prova =='400 M COM BARREIRAS - MASCULINO'
							  or descricao_prova =='3000 M COM OBSTÁCULOS - FEMININO'}"> 
					<img class="boneco" src="IMAGENS/obstaculo.png">
				</c:if>
				
				<input class="texto_barra_lateral" type="text"  value="<c:out value="${descricao_prova}"></c:out>"/>
				<input class="input_recorde gp_titulo" type="text"  value="RECORDE GP  BRASIL"/>
				<input class="input_recorde gp_valor" type="text"  value="<c:out value="${recorde_gp}"></c:out>"/>
				<input class="input_recorde mundial_titulo" type="text"  value="RECORDE MUNDIAL"/>
				<input class="input_recorde mundial_valor" type="text" value="<c:out value="${recorde_mundial}"></c:out>"/>
				
				<div class="teste"></div>
					<div class="scroll">
						<table class="table table-sm table-hover table-bordered tbl_provas">
							<thead>
								<tr class="linha_azul centralizar">
									<th>CODIGO</th>
									<th>NOME</th>
									<th>C.O.I</th>
									<th>PAIS</th>
								</tr>
							</thead>
							
							<c:forEach var="participantes" items="${list_ParticipantesProva}">
								<tbody>
									<tr class="centralizar">
										<td>${participantes.codigo_atleta}</td>
										<td>${participantes.nome}</td>
										<td>${participantes.codigo_coi}</td>
										<td>${participantes.pais_coi}</td>
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
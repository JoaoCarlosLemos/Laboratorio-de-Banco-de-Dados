<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
	<meta charset="ISO-8859-1">
	<title>GP Brasil de Atletismo</title>
	<link rel="stylesheet" type="text/css" href="CSS/atleta.css"/>
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
		<a class="voltar" href="provaServelet">&#60 &#60 VOLTAR</a>
	</div>
	
	<div class="container">
		<div class="container_cinza">
			<div>
				<div class="barra_lateral">
					<img src="IMAGENS/lateral_gp.png">
				</div>
				<div class="ordenacao">
					<p>ORDENAÇÃO<p>
				</div>
				
				<img class="barra_lateral_iaaf" src="IMAGENS/iaaf.png">
				<a class="ordenacao_atleta" href=atletaServelet?acao=ordenacaoAtleta>- ATLETA</a>
				<a class="ordenacao_masculino" href=atletaServelet?acao=ordenacaoMasculino>- MASCULINO</a>
				<a class="ordenacao_feminino" href=atletaServelet?acao=ordenacaoFeminino>- FEMININO</a>
				<a class="ordenacao_pais" href=atletaServelet?acao=ordenacaoPais>- PAÍS</a>
				<a class="ordenacao_prova" href=atletaServelet?acao=ordenacaoProva>- PROVA</a>
				
				<div class="teste"></div>
					<div class="scroll">
						<table class="table table-sm table-hover table-bordered tbl_provas">
							<thead>
								<tr class="linha_azul">
									<th>CODIGO</th>
									<th>NOME</th>
									<th>GENERO</th>
									<th>C.O.I</th>
									<th>PAÍS</th>
									<th>PROVA</th>
								</tr>
							</thead>
							
							<c:forEach var="atleta" items="${list_Atletas}">
								<tbody>
									<tr>
										<td>${atleta.codigo_atleta}</td>
										<td>${atleta.nome}</td>
										<td>${atleta.sexo}</td>
										<td>${atleta.codigo_coi}</td>
										<td>${atleta.pais_coi}</td>
										<td>${atleta.descricao}</td>
										
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
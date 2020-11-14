<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
	<meta charset="ISO-8859-1">
	<title>GP Brasil de Atletismo</title>
	<link rel="stylesheet" type="text/css" href="CSS/bateriaA.css"/>
	<link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css" />
	
	<script type="text/javascript" src="JS/jquery-3.5.0.min.js"></script>
	<script type="text/javascript" src="JS/bootstrap.min.js"></script>
</head>
<body>

	<img src="IMAGENS/faixa_superior.png">	
	<div class="logo">
		<img src="IMAGENS/logo.png">
	</div>	
	<img class="legenda" src="IMAGENS/legenda.png">
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
				
				<c:if test="${empty listBateriaInicial}">
					<a class="fase_inicial" href=bateriasServlet?acao=listarBateriaInicial&codigo_prova=${codigo_prova}>- INICIAL</a>			
				</c:if>
				
				<c:if test="${!empty listBateriaInicial && empty listBateriaFinal}">
					<a class="fase_final" href=bateriasServlet?acao=listarBateriaFinal&codigo_prova=${codigo_prova}>- FINAL</a>
				</c:if>	
				
				<input class="texto_barra_lateral" type="text"  value="<c:out value="${descricao_prova}"></c:out>"/>
				
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
				
				<input class="input_recorde gp_titulo" type="text"  value="RECORDE GP  BRASIL"/>
				<input class="input_recorde gp_valor" type="text"  value="<c:out value="${recorde_gp}"></c:out>"/>
				<input class="input_recorde mundial_titulo" type="text"  value="RECORDE MUNDIAL"/>
				<input class="input_recorde mundial_valor" type="text" value="<c:out value="${recorde_mundial}"></c:out>"/>
				
				<div class="teste"></div>
					<table class="table table-sm table-hover table-bordered tbl_provas">
						<thead>
							<tr class="linha_azul centralizar">
								<th></th>
								<th></th>
								<th>CODIGO</th>
								<th>ATLETA</th>
								<th>PAIS</th>
								<th>RESULTADO</th>
							</tr>
						</thead>
						
						<c:if test="${empty listBateriaInicial}">
							<tr class="centralizar">
								<td colspan="12">
									<b>( A PROVA AINDA NÃO OCORREU )</b>
									<i>*** FAVOR EXECUTAR A FASE INICIAL ***</i>
								</td>
							</tr>
						</c:if>
							
						<c:forEach var="bateriaInicial" items="${listBateriaInicial}">
							<tbody>
								<c:if test="${bateriaInicial.codigo_prova==codigo_prova}"> 
								
									<c:if test="${bateriaInicial.resultado<recorde_mundial}">
										<tr class="mundial">
											<c:if test="${colocacao<8}"> 
												<th><img src="IMAGENS/v.png"/></th>
											</c:if>
											<c:if test="${colocacao>7}"> 
												<th><img src="IMAGENS/x.png"/></th>
											</c:if>
											<td>${colocacao=colocacao+1}º</td>
											<td>${bateriaInicial.codigo_atleta}</td>
											<td>${bateriaInicial.nome}</td>
											<td>${bateriaInicial.pais_coi}</td>
											
											<c:if test="${bateriaInicial.resultado=='99:99:99:999'}"> 
												<th class="centralizar">D.N.F</th>
											</c:if>
											<c:if test="${bateriaInicial.resultado!='99:99:99:999'}"> 
												<td class="centralizar">${bateriaInicial.resultado}</td>
											</c:if>
										</tr>
									</c:if>
									
									<c:if test="${bateriaInicial.resultado>recorde_mundial && bateriaInicial.resultado<recorde_gp}">
										<tr class="gp_brasil">
											<c:if test="${colocacao<8}"> 
												<th><img src="IMAGENS/v.png"/></th>
											</c:if>
											<c:if test="${colocacao>7}"> 
												<th><img src="IMAGENS/x.png"/></th>
											</c:if>
											<td>${colocacao=colocacao+1}º</td>
											<td>${bateriaInicial.codigo_atleta}</td>
											<td>${bateriaInicial.nome}</td>
											<td>${bateriaInicial.pais_coi}</td>
											
											<c:if test="${bateriaInicial.resultado=='99:99:99:999'}"> 
												<th class="centralizar">D.N.F</th>
											</c:if>
											<c:if test="${bateriaInicial.resultado!='99:99:99:999'}"> 
												<td class="centralizar">${bateriaInicial.resultado}</td>
											</c:if>
										</tr>
									</c:if>
									
									<c:if test="${bateriaInicial.resultado>recorde_gp}">
										<tr>
											<c:if test="${colocacao<8}"> 
												<th><img src="IMAGENS/v.png"/></th>
											</c:if>
											<c:if test="${colocacao>7}"> 
												<th><img src="IMAGENS/x.png"/></th>
											</c:if>
											<td>${colocacao=colocacao+1}º</td>
											<td>${bateriaInicial.codigo_atleta}</td>
											<td>${bateriaInicial.nome}</td>
											<td>${bateriaInicial.pais_coi}</td>
												
											<c:if test="${bateriaInicial.resultado=='99:99:99:999'}"> 
												<th class="centralizar">D.N.F</th>
											</c:if>
											<c:if test="${bateriaInicial.resultado!='99:99:99:999'}"> 
												<td class="centralizar">${bateriaInicial.resultado}</td>
											</c:if>
										</tr>
									</c:if>
								</c:if>		
							</tbody>
						</c:forEach>
					</table>
				
					<c:if test="${!empty listBateriaInicial}">
						<table class="table table-sm table-hover table-bordered tbl_final">
							<thead>
								<tr class="linha_azul centralizar">
									<th></th>
									<th></th>
									<th>CODIGO</th>
									<th>ATLETA</th>
									<th>PAIS</th>
									<th>RESULTADO</th>
								</tr>
							</thead>
							
							<c:if test="${empty listBateriaFinal}">
								<tr class="centralizar">
									<td colspan="12">
										<b>( A PROVA AINDA NÃO OCORREU )</b>
										<i>*** FAVOR EXECUTAR A FASE FINAL ***</i>
									</td>
								</tr>
							</c:if>
								
							<c:forEach var="bateriaFinal" items="${listBateriaFinal}">
							<tbody>
								<c:if test="${bateriaFinal.codigo_prova==codigo_prova}"> 
								
									<c:if test="${bateriaFinal.resultado<recorde_mundial}">
										<tr class="mundial">
											<c:if test="${colocacaoF<1}"> 
												<th><img src="IMAGENS/1.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==1}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==2}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF>2}"> 
												<th></th>
											</c:if>
											<td>${colocacaoF=colocacaoF+1}º</td>
											<td>${bateriaFinal.codigo_atleta}</td>
											<td>${bateriaFinal.nome}</td>
											<td>${bateriaFinal.pais_coi}</td>
											
											<c:if test="${bateriaFinal.resultado=='99:99:99:999'}"> 
												<th class="centralizar">D.N.F</th>
											</c:if>
											<c:if test="${bateriaFinal.resultado!='99:99:99:999'}"> 
												<td class="centralizar">${bateriaFinal.resultado}</td>
											</c:if>
										</tr>
									</c:if>
									
									<c:if test="${bateriaFinal.resultado>recorde_mundial && bateriaFinal.resultado<recorde_gp}">
										<tr class="gp_brasil">
											<c:if test="${colocacaoF<1}"> 
												<th><img src="IMAGENS/1.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==1}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==2}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF>2}"> 
												<th></th>
											</c:if>
											<td>${colocacaoF=colocacaoF+1}º</td>
											<td>${bateriaFinal.codigo_atleta}</td>
											<td>${bateriaFinal.nome}</td>
											<td>${bateriaFinal.pais_coi}</td>
											
											<c:if test="${bateriaFinal.resultado=='99:99:99:999'}"> 
												<th class="centralizar">D.N.F</th>
											</c:if>
											<c:if test="${bateriaFinal.resultado!='99:99:99:999'}"> 
												<td class="centralizar">${bateriaFinal.resultado}</td>
											</c:if>
										</tr>
									</c:if>
									
									<c:if test="${bateriaFinal.resultado>recorde_gp}">
										<tr>
											<c:if test="${colocacaoF<1}"> 
												<th><img src="IMAGENS/1.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==1}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==2}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF>2}"> 
												<th></th>
											</c:if>
											<td>${colocacaoF=colocacaoF+1}º</td>
											<td>${bateriaFinal.codigo_atleta}</td>
											<td>${bateriaFinal.nome}</td>
											<td>${bateriaFinal.pais_coi}</td>
												
											<c:if test="${bateriaFinal.resultado=='99:99:99:999'}"> 
												<th class="centralizar">D.N.F</th>
											</c:if>
											<c:if test="${bateriaFinal.resultado!='99:99:99:999'}"> 
												<td class="centralizar">${bateriaFinal.resultado}</td>
											</c:if>
										</tr>
									</c:if>
								</c:if>		
							</tbody>
						</c:forEach>	
					</table>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>
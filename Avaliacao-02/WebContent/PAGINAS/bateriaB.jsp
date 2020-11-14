<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
	<meta charset="ISO-8859-1">
	<title>GP Brasil de Atletismo</title>
	<link rel="stylesheet" type="text/css" href="CSS/bateriaB.css"/>
	<link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css" />
	
	<script type="text/javascript" src="JS/jquery-3.5.0.min.js"></script>
	<script type="text/javascript" src="JS/bootstrap.min.js"></script>
</head>
<body>

	<img src="IMAGENS/faixa_superior.png">	
	<div class="logo">
		<img src="IMAGENS/logo2.png">
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
				
				<input class="input_recorde gp_titulo" type="text"  value="RECORDE GP  BRASIL"/>
				<input class="input_recorde gp_valor" type="text"  value="<c:out value="${recorde_gp}"></c:out>"/>
				<input class="input_recorde mundial_titulo" type="text"  value="RECORDE MUNDIAL"/>
				<input class="input_recorde mundial_valor" type="text" value="<c:out value="${recorde_mundial}"></c:out>"/>
				
				<div class="teste"></div>
					<div class="scroll">
						<table class="table table-sm table-hover table-bordered tbl_provas">
							<thead>
								<tr class="linha_azul centralizar">
									<th></th>
									<th></th>
									<th>CODIGO</th>
									<th>ATLETA</th>
									<th>PAIS</th>
									<th>MARCA 01</th>
									<th>MARCA 02</th>
									<th>MARCA 03</th>
									<th>MARCA 04</th>
									<th>MARCA 05</th>
									<th>MARCA 06</th>
									<th>RESULTADO</th>
								</tr>
							</thead>
							
							<c:if test="${empty listBateriaInicial}">
								<tr class="centralizar">
									<td colspan="12">
										<b>( AS PROVAS AINDA NÃO OCORRERAM )</b>
										<i>*** FAVOR EXECUTAR A FASE INICIAL ***</i>
									</td>
								</tr>
							</c:if>
							
							<c:forEach var="bateriaInicial" items="${listBateriaInicial}">
								<tbody>
									<c:if test="${bateriaInicial.codigo_prova==codigo_prova}">
									
									 	<c:if test="${bateriaInicial.resultado>recorde_mundial}">
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
												
												<c:if test="${bateriaInicial.marca01=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca01!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca01} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca02=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca02!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca02} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca03=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca03!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca03} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca04=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca04!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca04} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca05=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca05!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca05} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca06=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca06!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca06} M</td>
												</c:if>
							
												<td class="centralizar">${bateriaInicial.resultado} M</td>
											</tr>
										</c:if>
										
										<c:if test="${bateriaInicial.resultado>recorde_gp && bateriaInicial.resultado<recorde_mundial}">
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
												
												<c:if test="${bateriaInicial.marca01=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca01!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca01} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca02=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca02!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca02} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca03=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca03!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca03} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca04=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca04!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca04} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca05=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca05!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca05} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca06=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca06!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca06} M</td>
												</c:if>
							
												<td class="centralizar">${bateriaInicial.resultado} M</td>
											</tr>
										</c:if>
										
										<c:if test="${bateriaInicial.resultado<recorde_gp}">
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
												
												<c:if test="${bateriaInicial.marca01=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca01!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca01} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca02=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca02!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca02} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca03=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca03!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca03} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca04=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca04!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca04} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca05=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca05!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca05} M</td>
												</c:if>
												
												<c:if test="${bateriaInicial.marca06=='00.00'}"> 
													<th class="centralizar">FAULT</th>
												</c:if>
												<c:if test="${bateriaInicial.marca06!='00.00'}"> 
													<td class="centralizar">${bateriaInicial.marca06} M</td>
												</c:if>
							
												<td class="centralizar">${bateriaInicial.resultado} M</td>
											</tr>
										</c:if>
									</c:if>		
								</tbody>
							</c:forEach>	
					</table>
				</div>
				
				<c:if test="${!empty listBateriaInicial}">
						<table class="table table-sm table-hover table-bordered tbl_final">
							<thead>
								<tr class="linha_azul centralizar">
									<th></th>
									<th></th>
									<th>CODIGO</th>
									<th>ATLETA</th>
									<th>PAIS</th>
									<th>MARCA 01</th>
									<th>MARCA 02</th>
									<th>MARCA 03</th>
									<th>MARCA 04</th>
									<th>MARCA 05</th>
									<th>MARCA 06</th>
									<th>RESULTADO</th>
								</tr>
							</thead>
								
							<c:if test="${empty listBateriaFinal}">
								<tr class="centralizar">
									<td colspan="12">
										<b>( AS PROVAS AINDA NÃO OCORRERAM )</b>
										<i>*** FAVOR EXECUTAR A FASE FINAL ***</i>
									</td>
								</tr>
							</c:if>
								
							<c:forEach var="bateriaFinal" items="${listBateriaFinal}">
							<tbody>
								<c:if test="${bateriaFinal.codigo_prova==codigo_prova}">
									
								 	<c:if test="${bateriaFinal.resultado>recorde_mundial}">
										<tr class="mundial">
											<c:if test="${colocacaoF<1}"> 
												<th><img src="IMAGENS/1.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==1}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==2}"> 
												<th><img src="IMAGENS/3.png"/></th>
											</c:if>
											<c:if test="${colocacaoF>2}"> 
												<th></th>
											</c:if>
											<td>${colocacaoF=colocacaoF+1}º</td>
											<td>${bateriaFinal.codigo_atleta}</td>
											<td>${bateriaFinal.nome}</td>
											<td>${bateriaFinal.pais_coi}</td>
												
											<c:if test="${bateriaFinal.marca01=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca01!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca01} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca02=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca02!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca02} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca03=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca03!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca03} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca04=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca04!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca04} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca05=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca05!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca05} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca06=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca06!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca06} M</td>
											</c:if>
							
											<td class="centralizar">${bateriaFinal.resultado} M</td>
										</tr>
									</c:if>
										
									<c:if test="${bateriaFinal.resultado>recorde_gp && bateriaFinal.resultado<recorde_mundial}">
										<tr class="gp_brasil">
											<c:if test="${colocacaoF<1}"> 
												<th><img src="IMAGENS/1.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==1}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==2}"> 
												<th><img src="IMAGENS/3.png"/></th>
											</c:if>
											<c:if test="${colocacaoF>2}"> 
												<th></th>
											</c:if>
											<td>${colocacaoF=colocacaoF+1}º</td>
											<td>${bateriaFinal.codigo_atleta}</td>
											<td>${bateriaFinal.nome}</td>
											<td>${bateriaFinal.pais_coi}</td>
												
											<c:if test="${bateriaFinal.marca01=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca01!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca01} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca02=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca02!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca02} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca03=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca03!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca03} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca04=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca04!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca04} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca05=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca05!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca05} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca06=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca06!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca06} M</td>
											</c:if>
							
											<td class="centralizar">${bateriaFinal.resultado} M</td>
										</tr>
									</c:if>
										
									<c:if test="${bateriaFinal.resultado<recorde_gp}">
										<tr>
											<c:if test="${colocacaoF<1}"> 
												<th><img src="IMAGENS/1.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==1}"> 
												<th><img src="IMAGENS/2.png"/></th>
											</c:if>
											<c:if test="${colocacaoF==2}"> 
												<th><img src="IMAGENS/3.png"/></th>
											</c:if>
											<c:if test="${colocacaoF>2}"> 
												<th></th>
											</c:if>
											<td>${colocacaoF=colocacaoF+1}º</td>
											<td>${bateriaFinal.codigo_atleta}</td>
											<td>${bateriaFinal.nome}</td>
											<td>${bateriaFinal.pais_coi}</td>
												
											<c:if test="${bateriaFinal.marca01=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca01!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca01} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca02=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca02!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca02} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca03=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca03!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca03} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca04=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca04!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca04} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca05=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca05!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca05} M</td>
											</c:if>
												
											<c:if test="${bateriaFinal.marca06=='00.00'}"> 
												<th class="centralizar">FAULT</th>
											</c:if>
											<c:if test="${bateriaFinal.marca06!='00.00'}"> 
												<td class="centralizar">${bateriaFinal.marca06} M</td>
											</c:if>
							
											<td class="centralizar">${bateriaFinal.resultado} M</td>
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
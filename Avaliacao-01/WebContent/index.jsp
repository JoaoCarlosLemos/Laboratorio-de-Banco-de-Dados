<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Carvanal - 2013 !!</title>
	<link rel="stylesheet" type="text/css" href="CSS/style.css"/>
	<link rel="stylesheet" type="text/css" href="CSS/bootstrap.min.css" />
	
	<script type="text/javascript" src="JS/jquery-3.5.0.min.js"></script>
	<script type="text/javascript" src="JS/jquery.validate.min.js"></script>
	<script type="text/javascript" src="JS/bootstrap.min.js"></script>
	<script type="text/javascript" src="JS/validacao.js"></script>
	<script type="text/javascript" src="JS/localization/messages_pt_BR.js"></script>
	<script type="text/javascript" src="JS/additional-methods.min.js"></script>
</head>
<body>

	<div class="containers">
	
		<form id="formNota" class="form-horizontal" action="apuracao" method="post">
		
			<c:if test="${cont_d>630}">
				<audio class="audio" src="MUSICA/Musica.mp3" autoplay controls loop ></audio>
			</c:if>
			
			<img class="logo" src="IMAGENS/logo-tela.png">
			
			
			<fieldset class="fieldset">
				
				<div class="bloqueio"></div>
				
				<c:if test="${cont_d>630}">
					<div class="bloqueio_enviar">
						<img src="IMAGENS/apurracao-encerrada.png">
					</div>
				</c:if>
						
				<div class="form-row">
			
					<div class="form-group">
						<label for="jurado">JURADO</label> 
						<select class="form-control form-control-sm" id="block-j" name="jurado" >
							
							<option value="1" selected >JURADO 01</option>
							
							<c:if test="${ cont_j<14}">
								<option value="1" selected >JURADO 01</option>
							</c:if>
							<c:if test="${cont_j>14}">
								<option value="1">JURADO 01</option>
							</c:if>
							
							<c:if test="${cont_j>13 and cont_j<28}">
								<option value="2" selected >JURADO 02</option>
							</c:if>
							<c:if test="${cont_j>28}">
								<option value="2">JURADO 02</option>
							</c:if>
							
							<c:if test="${cont_j>27 and cont_j<42}">
								<option value="3" selected >JURADO 03</option>
							</c:if>
							<c:if test="${cont_j>42}">
								<option value="3">JURADO 03</option>
							</c:if>
							
							<c:if test="${cont_j>41 and cont_j<56}">
								<option value="4" selected >JURADO 04</option>
							</c:if>
							<c:if test="${cont_j>56}">
								<option value="4">JURADO 04</option>
							</c:if>
							
							<c:if test="${cont_j>55 and cont_j<70}">
								<option value="5" selected >JURADO 05</option>
							</c:if>
							<c:if test="${cont_j>70}">
								<option value="5">JURADO 05</option>
							</c:if>
						</select>
					</div>
			
					<div class="form-group">
						<label for="escola">ESCOLA</label> 
						<select class="form-control form-control-sm" id="block-e" name="escola" id="escola">
							
							<option value="1" selected>ACADÊMICOS DO TATUAPÉ</option>
								
							<c:if test="${cont_e!=1}">
								<option value="1">ACADÊMICOS DO TATUAPÉ</option>
							</c:if>
								
							<c:if test="${ cont_e==2}">
								<option value="2" selected>ACADÊMICOS DO TUCURUVI</option>
							</c:if>
							<c:if test="${cont_e!=2}">
								<option value="2">ACADÊMICOS DO TUCURUVI</option>
							</c:if>
							
							<c:if test="${ cont_e==3}">
								<option value="3" selected>ÁGUIA DE OURO</option>
							</c:if>
							<c:if test="${cont_e!=3}">
								<option value="3">ÁGUIA DE OURO</option>
							</c:if>
							
							<c:if test="${ cont_e==4}">
								<option value="4" selected>DRAGÕES DA REAL</option>
							</c:if>
							<c:if test="${cont_e!=4}">
								<option value="4">DRAGÕES DA REAL</option>
							</c:if>
							
							<c:if test="${ cont_e==5}">
								<option value="5" selected>GAVIÕES DA FIEL</option>
							</c:if>
							<c:if test="${cont_e!=5}">
								<option value="5">GAVIÕES DA FIEL</option>
							</c:if>
							
							<c:if test="${ cont_e==6}">
								<option value="6" selected>IMPÉRIO DE CASA VERDE</option>
							</c:if>
							<c:if test="${cont_e!=6}">
								<option value="6">IMPÉRIO DE CASA VERDE</option>
							</c:if>
							
							<c:if test="${ cont_e==7}">
								<option value="7" selected>MANCHA VERDE</option>
							</c:if>
							<c:if test="${cont_e!=7}">
								<option value="7">MANCHA VERDE</option>
							</c:if>
							
							<c:if test="${ cont_e==8}">
								<option value="8" selected>MOCIDADE ALEGRE</option>
							</c:if>
							<c:if test="${cont_e!=8}">
								<option value="8">MOCIDADE ALEGRE</option>
							</c:if>
							
							<c:if test="${ cont_e==9}">
								<option value="9" selected>NENÊ DE VILA MATILDE</option>
							</c:if>
							<c:if test="${cont_e!=9}">
								<option value="9">NENÊ DE VILA MATILDE</option>
							</c:if>
							
							<c:if test="${ cont_e==10}">
								<option value="10" selected>ROSAS DE OURO</option>
							</c:if>
							<c:if test="${cont_e!=10}">
								<option value="10">ROSAS DE OURO</option>
							</c:if>
							
							<c:if test="${ cont_e==11}">
								<option value="11" selected>TOM MAIOR</option>
							</c:if>
							<c:if test="${cont_e!=11}">
								<option value="11">TOM MAIOR</option>
							</c:if>
							
							<c:if test="${ cont_e==12}">
								<option value="12" selected>UNIDOS DE VILA MARIA</option>
							</c:if>
							<c:if test="${cont_e!=12}">
								<option value="12">UNIDOS DE VILA MARIA</option>
							</c:if>
							
							<c:if test="${ cont_e==13}">
								<option value="13" selected>VAI-VAI</option>
							</c:if>
							<c:if test="${cont_e!=13}">
								<option value="13">VAI-VAI</option>
							</c:if>
							
							<c:if test="${ cont_e==14}">
								<option value="14" selected>X-9 PAULISTANA</option>
							</c:if>
							<c:if test="${cont_e!=14}">
								<option value="14">X-9 PAULISTANA</option>
							</c:if>
							
						</select>
					</div>
			
					<div class="form-group">
						<label for="quesito">QUESITO</label> 
						<select class="form-control form-control-sm" id="quesito" name="quesito" >
								
								<option value="1" selected>ALEGORIA</option>
								
								<c:if test="${ cont_q<70}">
									<option value="1" selected>ALEGORIA</option>
								</c:if>
								<c:if test="${cont_q>70}">
									<option value="1">ALEGORIA</option>
								</c:if>
								
								<c:if test="${cont_q>70 and cont_q<141}">
									<option value="2" selected>BATERIA</option>
								</c:if>
								<c:if test="${cont_q>140}">
									<option value="2">BATERIA</option>
								</c:if>
								
								<c:if test="${cont_q>140 and cont_q<211}">
									<option value="3" selected>COMISSÃO DE FRENTE</option>
								</c:if>
								<c:if test="${cont_q>210}">
									<option value="3">COMISSÃO DE FRENTE</option>
								</c:if>
								
								<c:if test="${cont_q>210 and cont_q<281}">
									<option value="4" selected >ENREDO</option>
								</c:if>
								<c:if test="${cont_q>280}">
									<option value="4">ENREDO</option>
								</c:if>
								
								<c:if test="${cont_q>280 and cont_q<351}">
									<option value="5" selected>EVOLUÇÃO</option>
								</c:if>
								<c:if test="${cont_q>350}">
									<option value="5">EVOLUÇÃO</option>
								</c:if>
								
								<c:if test="${cont_q>350 and cont_q<421}">
									<option value="6" selected>FANTASIA</option>
								</c:if>
								<c:if test="${cont_q>420}">
									<option value="6">FANTASIA</option>
								</c:if>
								
								<c:if test="${cont_q>420 and cont_q<491}">
									<option value="7" selected>HARMONIA</option>
								</c:if>
								<c:if test="${cont_q>490}">
									<option value="7">HARMONIA</option>
								</c:if>
								
								<c:if test="${cont_q>490 and cont_q<561}">
									<option value="8" selected>MESTRE-SALA E PORTA-BANDEIRA</option>
								</c:if>
								<c:if test="${cont_q>560}">
									<option value="8">MESTRE-SALA E PORTA-BANDEIRA</option>
								</c:if>
								
								<c:if test="${cont_q>560 and cont_q<631}">
									<option value="9" selected>SAMBA-ENREDO</option>
								</c:if>
								<c:if test="${cont_q>630}">
									<option value="9">SAMBA-ENREDO</option>
								</c:if>
								
						</select>
					</div>
				
					<div class="nota">
						<label for="nota">NOTA</label> 
						<input class="form-control form-control-sm" type="text" name="nota" id="nota" autofocus="autofocus">
											
						<c:if test="${cont_d>630}">
							<script type="text/javascript">
						   		$(document).ready(function(){
						        		$("#nota").prop("autofocus", false);
						        		$("#jurado_0").prop("hidden", true); 
						        		$("#jurado_1").prop("hidden", true); 
						        		$("#jurado_2").prop("hidden", true); 
						        		$("#jurado_3").prop("hidden", true); 
						        		$("#jurado_4").prop("hidden", true); 
						        		$("#jurado_5").prop("hidden", true);
						        		$("#nota").prop("disabled", true);
						        		$("#btn_enviar").prop("disabled", true); 
						    	});
						    </script>
						</c:if>

					</div>
				
					<div class="form-group">
						<input type="submit"  id="btn_enviar" name="enviar" class="enviar" value="enviar" >
					</div>
				
				</div>
			</fieldset>

		</form>
		
		<div class="conteiner_tabela">
		
			 <img class="mascara" src="IMAGENS/mascara.png">
			 <input class="quesito" type="text" id="text"> 
		
			<script type="text/javascript">
				function update() {
					var select = document.getElementById('quesito');
					var option = select.options[select.selectedIndex];
					document.getElementById('text').value = option.text;
				}

				update();
			</script>
		
			<table class="table ">
				<tr>
					<th class="centralizado">Escola</th>
					<th>Jurado 01</th>
					<th class="cinza">Jurado 02</th>
					<th>Jurado 03</th>
					<th class="cinza">Jurado 04</th>
					<th>Jurado 05</th>
					<th class="cinza">- Nota</th>
					<th class="cinza">+ Nota</th>
					<th class="azul">Total com desconto</th>
				</tr>
				<c:forEach var="apq" items="${list_APQ}">
					<tr>
						<td><b><i>${apq.escola}</i></b></td>
						<td class="centralizado">${apq.nota1}</td>
						<td class="cinza">${apq.nota2}</td>
						<td class="centralizado">${apq.nota3}</td>
						<td class="cinza">${apq.nota4}</td>
						<td class="centralizado">${apq.nota5}</td>
						<td class="cinza">${apq.menor}</td>
						<td class="cinza">${apq.maior}</td>
						<td class="azul">${apq.total}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div class="conteiner_tabela_resultado">
		
			<img class="morena" src="IMAGENS/morena.png">
			
			<img class="jurado" src="IMAGENS/jurado_1.png" id="jurado_0">
			<c:if test="${ cont_j<14}">
				<img class="jurado" src="IMAGENS/jurado_1.png" id="jurado_1">				
			</c:if>
			<c:if test="${cont_j>13 and cont_j<28}">
				<img class="jurado" src="IMAGENS/jurado_2.png" id="jurado_2">				
			</c:if>
			<c:if test="${cont_j>27 and cont_j<42}">
				<img class="jurado" src="IMAGENS/jurado_3.png" id="jurado_3">
			</c:if>
			<c:if test="${cont_j>41 and cont_j<56}">
				<img class="jurado" src="IMAGENS/jurado_4.png" id="jurado_4">
			</c:if>
			<c:if test="${cont_j>55 and cont_j<70}">
				<img class="jurado" src="IMAGENS/jurado_5.png" id="jurado_5">
			</c:if>
			
			<input class="titulo_resultado" type="text" value="Apuração - 2013">
			
			<table class="table ">
				<tr>
					<th class="cinza">Nº</th>
					<th>Escola</th>
					<th class="azul">Total Geral</th>
				</tr>
				<c:if test="${cont_d>29 }">
					<c:forEach var="eds" items="${list_EDS}">
						<tr>
							<td class="cinza"><b><i>${colocacao=colocacao+1}º</i></b></td>
							<td><b><i>${eds.nome}</i></b></td>
							<td class="azul">${eds.total_pontos}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			
		</div>	
	</div>
</body>
</html>
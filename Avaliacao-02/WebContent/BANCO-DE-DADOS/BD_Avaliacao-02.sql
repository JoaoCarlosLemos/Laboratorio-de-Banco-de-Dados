-- Avaliação 2 – Laboratório de Banco de Dados

-- Fazer em Java com SQL SERVER o seguinte cenário: (J2SE 0.0 - 9.0 | J2EE 0.0 - 10.0) O GP Brasil de Atletismo, 
-- é uma série de competições de atletismo, ocorrida no Brasil e é parte do IAAF World Challenge, sendo uma das 
-- classificatórias para a Final Mundial de Atletismo. Todos os atletas são cadastrados, independente da(s) prova(s) 
-- que participam, por uma numeração sequencial, a partir de 1. A numeração não tem relação com a(s) prova(s) que o 
-- atleta participa. Existe um cadastro de todos os países atualmente filiados ao COI 
-- (http://pt.wikipedia.org/wiki/Lista_de_pa%C3%ADses_por_c%C3%B3digo_do_COI) e cada atleta, além de seu código, nome 
-- e sexo, deve ter um vínculo com o país que representa.

-- PROVA                       SEXO  

-- ARREMESSO DE PESO 		-  FEMININO
-- LANÇAMENTO DE DARDO		-  FEMININO
-- LANÇAMENTO DE DISCO		-  MASCULINO
-- SALTO COM VARA			-  MASCULINO
-- SALTO EM DISTÂNCIA		-  MASCULINO
-- SALTO TRIPLO				-  FEMININO
-- 100 M					-  FEMININO
-- 100 M					-  MASCULINO
-- 200 M					-  FEMININO
-- 200 M					-  MASCULINO
-- 400 M					-  MASCULINO
-- 400 M COM BARREIRAS		-  MASCULINO
-- 800 M					-  FEMININO
-- 800 M					-  MASCULINO
-- 3000 M					-  MASCULINO
-- 3000 M COM OBSTÁCULOS	-  FEMININO

-- Todas as provas funcionam da seguinte forma:
-- Existe uma fase inicial onde todos os atletas competem entre si, em baterias, que determinam o tempo ou a distância 
-- (dependendo do tipo de prova). Os 8 melhores competem em uma fasefinal, onde as medalhas de ouro, prata e bronze são dadas
-- aos atletas que tem os 3 melhores desempenhos da fase final (O desempenho não é, obrigatoriamente, melhor que da fase inicial).
-- Ao final de cada ciclo de baterias de prova (Inicial ou Final), uma lista com o código do atleta, o nome, o nome do país e o 
-- resultado, ordenados por desempenho. Se for fase inicial, os 8 melhores devem estar marcados. Se for fase final, os 3 primeiros
-- devem estar marcados.
-- Todos os resultados de todas as provas devem estar em uma única tabela, tendo que se considerar que nas provas de corrida, o 
-- desempenho é dado em tempo (segundos e décimos de segundo), nas provas de salto ou lançamento, o desempenho é dado em distância 
-- (metros e centímetros).
-- Para a exibição da lista, os tempos, nas provas de corrida, devem vir no formato HH:mm:ss:ddd
-- Os resultados apresentados devem vir a partir de uma UDF (Function), mostrando os resultados dos atletas na bateria.

-- Como funcionam as baterias:

-- Provas de saltos e arremessos*: 6 saltos por bateria, armazenam-se todos, considera-se o melhor.
-- Provas de corrida**: 1 corrida por bateria.

-- A tabela com os resultados, bem como a de atletas e países não pode ser alterada ou excluída.
-- A database apresentada deve trazer o DER do projeto.
-- O usuário deve poder consultar qualquer bateria de qualquer prova em qualquer fase. Se a bateria não ocorreu ainda, o sistema 
-- deve mostrar uma mensagem.
-- Existe um recorde mundial e um recorde do evento, cadastrados, para cada evento. Se, em qualquer fase, um recorde for quebrado, 
-- esse desempenho deve aparecer com uma cor diferente na lista (Verde para mundial e azul para o do evento).
-- *Os atletas que falharem no salto ou no lançamento devem exibir FAULT na lista.
-- ** Os atletas que não concluírem a prova de corrida devem exibir DNF na lista. DNF – Did Not Finish (Não Terminou a Prova)
-- *** Criar Triggers que garantam a integridade do banco de dados 
-- Entrega : 16/11/2020
-- Para maiores informações, visitar: http://www.cbat.org.br/competicoes/gp_brasil/2017/resultados.asp

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------Data Base------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE gp_brasil_atletismo
GO
USE gp_brasil_atletismo

CREATE TABLE coi(
codigo_coi		VARCHAR(3),
pais_coi		VARCHAR(100)
PRIMARY KEY(codigo_coi))

CREATE TABLE prova(
codigo_prova	INT IDENTITY NOT NULL,
descricao		VARCHAR(100),
genero			VARCHAR(10),
horario			VARCHAR(5),
recorde_mundial	VARCHAR(15),
recorde_gp		VARCHAR(15)
PRIMARY KEY(codigo_prova))

CREATE TABLE atleta(
codigo_atleta	INT IDENTITY NOT NULL,
nome			VARCHAR(100),
sexo			VARCHAR(10),
codigo_coi		VARCHAR(3),
codigo_prova	INT
PRIMARY KEY(codigo_atleta)
FOREIGN KEY (codigo_coi) REFERENCES coi(codigo_coi),
FOREIGN KEY (codigo_prova) REFERENCES prova(codigo_prova))

CREATE TABLE  bateria_inicial(
codigo			INT IDENTITY,
codigo_tb       INT,
codigo_prova	INT,
codigo_atleta 	INT,
nome 			VARCHAR(100),
pais_coi		VARCHAR(100),
marca01			VARCHAR(15),
marca02			VARCHAR(15),
marca03			VARCHAR(15),
marca04			VARCHAR(15),
marca05			VARCHAR(15),
marca06			VARCHAR(15),
resultado		VARCHAR(15)
PRIMARY KEY(codigo)
FOREIGN KEY (codigo_prova) REFERENCES prova(codigo_prova),
FOREIGN KEY (codigo_atleta) REFERENCES atleta(codigo_atleta))


CREATE TABLE  bateria_final(
codigo			INT IDENTITY,
codigo_tb       INT,
codigo_prova	INT,
codigo_atleta 	INT,
nome 			VARCHAR(100),
pais_coi		VARCHAR(100),
marca01			VARCHAR(15),
marca02			VARCHAR(15),
marca03			VARCHAR(15),
marca04			VARCHAR(15),
marca05			VARCHAR(15),
marca06			VARCHAR(15),
resultado		VARCHAR(15)
PRIMARY KEY(codigo)
FOREIGN KEY (codigo_prova) REFERENCES prova(codigo_prova),
FOREIGN KEY (codigo_atleta) REFERENCES atleta(codigo_atleta))

---------------------------------------------------------------Insert's Tabelas--------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO coi VALUES
('ARG','Argentina'),
('BLR','Bielorrússia'),
('BRA','Brasil'),
('CHI','Chile'),
('COL','Colombia'),
('CRC','Costa rica'),
('ETH','Etiópia'),
('GBR','Reino Unido'),
('GHA','Gana'),
('HUN','Hungria'),
('JAM','Jamaica'),
('KAZ','Cazaquistão'),
('KEN','Quênia'),
('MAR','Marrocos'),
('NGR','Nigéria'),
('POR','Portugal'),
('SLE','Serra Leoa'),
('TKM','Turquemenistão'),
('TTO','Trinidad e Tobago'),
('URU','Uruguai'),
('USA','Estados Unidos'),
('VEN','Venezuela')

INSERT INTO prova VALUES
('ARREMESSO DE PESO ','FEMININO','14:00','22.63','22.33'),
('LANÇAMENTO DE DARDO','FEMININO','14:10','72.28','72.08'),
('LANÇAMENTO DE DISCO','MASCULINO','14:15','74.08','74.00'),
('SALTO COM VARA','MASCULINO','14:30','6.15','6.00'),
('SALTO EM DISTÂNCIA','MASCULINO','14:40','8.95','8.65'),
('SALTO TRIPLO','FEMININO','14:45','15.43','15.23'),
('100 M','FEMININO','15:00','00:00:10:490','00:00:10:600'),
('100 M','MASCULINO','15:05','00:00:09:580','00:00:09:690'),
('200 M','FEMININO','15:15','00:00:21:340','00:00:21:450'),
('200 M','MASCULINO','15:30','00:00:19:190','00:00:19:400'),
('400 M','MASCULINO','15:35','00:00:43:030','00:00:43:240'),
('400 M COM BARREIRAS','MASCULINO','15:40','00:00:46:780','00:00:46:890'),
('800 M','FEMININO','15:45','00:01:53:280','00:01:53:490'),
('800 M','MASCULINO','16:05','00:01:45:890','00:01:45:950'),
('3000 M','MASCULINO','16:20','00:07:53:630','00:07:53:840'),
('3000 M COM OBSTÁCULOS','FEMININO','16:35','00:08:58:810','00:08:58:960')

INSERT INTO atleta VALUES
('Abel Curtinove','Masculino','BRA',8),
('Adelaide Moura','Feminino','BRA',7),
('Adelly Santos','Feminino','BRA',13),
('Ahymará Espinoza','Feminino','VEN',16),
('Alan Fonteles ','Masculino','BRA',10),
('Alan Gusmão','Masculino','BRA',12),
('Aldemir Junior','Masculino','BRA',14),
('Alessandra Silva','Feminino','BRA',7),
('Alex Amankwah','Masculino','GHA',8),
('Alexsandro Melo','Masculino','BRA',5),
('Alfred Kipketer','Masculino','KEN',4),
('Alfredo Sepúlveda','Masculino','CHI',11),
('Aline Monteiro Castigo','Feminino','COL',16),
('Alison dos Santos','Masculino','BRA',8),
('Allan Wolski','Masculino','BRA',14),
('Amanda Scherer','Feminino','BRA',1),
('Ana Carolina Cunha','Feminino','ETH',9),
('Ana Lopes','Feminino','BRA',13),
('Andrea Rota Sieczkowski','Feminino','GBR',1),
('Andrea Vargas','Feminino','CRC',16),
('Andressa Morais','Feminino','BRA',7),
('Andrew Riley','Masculino','JAM',12),
('Angela Haensel','Feminino','GHA',9),
('Angélica Rojek','Feminino','CRC',13),
('Antonio Rodrigues','Masculino','BRA',5),
('Asafe Virgolino','Masculino','BRA',8),
('Audie Wyatt','Masculino','USA',10),
('Augusto Dutra','Masculino','BRA',14),
('Bence Halász','Masculino','HUN',4),
('Bernardo Baloyes','Masculino','COL',11),
('Beyenu Degefa','Feminino','ETH',7),
('Bruna de Villi Chaccur','Feminino','BRA',16),
('Bruno Spinelli','Masculino','BRA',5),
('Carla Fioratti','Feminino','MAR',1),
('Carmen Luisa Victoria Fonseca','Feminino','NGR',2),
('Cassandra Tate','Feminino','USA',7),
('Cássia Negretto','Feminino','POR',13),
('Catilene Oliveira','Feminino','SLE',2),
('Chayenne da Silva','Feminino','BRA',2),
('Christine Souza','Feminino','BRA',6),
('Chukwuebuka Enekwechi','Masculino','NGR',8),
('Cleopatra Borel','Feminino','TTO',2),
('Cornelius Tuwei','Masculino','KEN',12),
('Curtiss Jensen','Masculino','USA',14),
('Daisy Jepkemei','Feminino','KAZ',6),
('Daniela Bahdur','Feminino','BRA',7),
('Daniella Hill','Feminino','USA',7),
('Darlan Romani','Masculino','BRA',4),
('Dayseellen Dias','Feminino','BRA',13),
('Deolinda Magaly Fonseca','Feminino','BRA',16),
('Diogo Ferreira','Masculino','POR',8),
('Drew Piazza','Masculino','USA',8),
('Ebony Morrison','Feminino','USA',2),
('Eder Souza','Masculino','BRA',15),
('Edson Pinheiro ','Masculino','BRA',3),
('Eduardo Rodrigues','Masculino','BRA',5),
('Elcita Ramos','Feminino','BRA',7),
('Elenilze Ferraz','Feminino','BRA',13),
('Eliane Dornelles','Feminino','BRA',1),
('Elida Dembinski','Feminino','MAR',7),
('Emiliano Lasa','Masculino','URU',15),
('Erica Machado','Feminino','BRA',2),
('Erik Cardoso','Masculino','BRA',11),
('Evelyn Campos','Feminino','NGR',16),
('Evonne Britton','Feminino','USA',13),
('Fabiana Amaral','Feminino','POR',7),
('Fabiane Ruzante','Feminino','SLE',6),
('Fabio Queiroz','Masculino','BRA',14),
('Fabíola Ko Freitag','Feminino','BRA',13),
('Fanor Escobar','Masculino','COL',12),
('Fatima Santiago','Feminino','BRA',1),
('Fernanda Martins','Feminino','BRA',6),
('Gabriel Constantino','Masculino','BRA',10),
('Gabriela Lima','Feminino','BRA',7),
('Geisa Arcanjo','Feminino','BRA',6),
('German Chiaraviglio','Masculino','ARG',8),
('Gilmar Tenorio Rocha','Feminino','BRA',16),
('Giovana dos Santos','Feminino','BRA',13),
('Graziele Zarri','Feminino','BRA',1),
('Guilherme Kurtz','Masculino','BRA',4),
('Guilherme Orenhas','Masculino','BRA',8),
('Helen Spadari','Feminino','BRA',9),
('Heloiza Helena Lopes','Feminino','BRA',2),
('Hicham Akankam','Masculino','MAR',5),
('Hicham Ouladha','Masculino','MAR',11),
('Higor Alves','Masculino','BRA',15),
('Humberto Mansilla','Masculino','CHI',3),
('Ifeanyichukwu Otuonye','Masculino','TKM',3),
('Ines Maria Kleinowski','Feminino','MAR',1),
('Italo Araujo','Masculino','BRA',10),
('Ivanaldo Cunha','Masculino','BRA',14),
('Ivanilo Bonato','Masculino','BRA',12),
('Izabela da Silva','Feminino','BRA',2),
('Jacklyn Howell','Feminino','USA',9),
('Jamille Ponce Leon','Feminino','NGR',9),
('Janus Lucas Leite Silva','Masculino','BRA',5),
('Janus Silva','Masculino','BRA',4),
('Jaqueline Dias','Feminino','POR',13),
('Jarvis Gotch','Masculino','USA',11),
('Jeovana dos Santos','Feminino','BRA',16),
('Jerusa dos Santos - ','Feminino','BRA',2),
('Jessica da Silva','Feminino','BRA',6),
('Jessica Moreira','Feminino','BRA',9),
('Jessica Ramsey','Feminino','USA',13),
('Joao Caltabiano','Masculino','BRA',8),
('João Roberto Brito','Masculino','BRA',15),
('Joao Valmir','Masculino','COL',3),
('Joaquin Gomez','Masculino','ARG',14),
('Joeferson de Oliveira ','Masculino','BRA',11),
('Jonatan Chaves','Masculino','BRA',4),
('Jonathas Brito','Masculino','BRA',12),
('Jose Carlos de Oliveira','Masculino','ETH',5),
('Jose Carlos Pierucetti','Masculino','GBR',10),
('Jose Carlos Pierucetti','Masculino','BRA',15),
('Jose Flores Amaral','Masculino','CRC',3),
('Jose Junior','Masculino','BRA',3),
('José Lima Luz','Masculino','GHA',8),
('José Pinto','Masculino','BRA',3),
('Julia Camargo','Feminino','SLE',1),
('Julia da Rosa','Feminino','BRA',6),
('Julia Elizabete Gomes','Feminino','BRA',9),
('Julio Oliveira','Masculino','BRA',14),
('Júlio Redecker','Masculino','BRA',4),
('Katia Escobar','Feminino','BRA',16),
('Katiane Lima','Feminino','BRA',6),
('Keely Medeiros','Feminino','BRA',6),
('Kesley Teodoro ','Masculino','BRA',5),
('Kleyber Lima','Masculino','BRA',11),
('Lais Rodrigues','Feminino','BRA',1),
('Larissa Ferraz','Feminino','BRA',6),
('Leila Maria Oliveira Dos Santos','Feminino','BRA',16),
('Leticia da Silva','Feminino','BRA',13),
('Levi Leon','Masculino','BRA',15),
('Lidiane Cansian','Feminino','BRA',9),
('Liliana Cá','Feminino','POR',9),
('Lina Barbosa Cassol','Feminino','MAR',1),
('Lisiane Schubert','Feminino','NGR',2),
('Lorena Spoladore ','Feminino','BRA',6),
('Lourival Neto','Masculino','BRA',10),
('Lucas dos Santos','Masculino','BRA',12),
('Lucas Palomino Mattedi','Masculino','BRA',11),
('Lucas Prado ','Masculino','BRA',14),
('Lucas Vilar','Masculino','BRA',15),
('Luciana Siqueira Lana Angelis','Feminino','POR',2),
('Lucirio Garrido','Masculino','VEN',4),
('Luis da Silva','Masculino','BRA',11),
('Lutimar Paes','Masculino','BRA',5),
('Madalena Silva','Feminino','SLE',16),
('Maggie Barrie','Feminino','SLE',1),
('Mahau Suguimati','Masculino','BRA',12),
('Marcio Teles','Masculino','BRA',10),
('Maria de Sena','Feminino','BRA',6),
('Maria Elizabete Caballero','Feminino','BRA',9),
('Maria Isabel Gomes','Feminino','BRA',2),
('Maria Pía','Feminino','URU',9),
('Mariana Sell','Feminino','BRA',1),
('Mariana Simonetti Pereira','Feminino','BRA',16),
('Marlene dos Santos','Feminino','BRA',9),
('Marli Pedrosa Santos','Feminino','BRA',7),
('Michael Kibet','Masculino','KEN',14),
('Mikael de Jesus','Masculino','BRA',4),
('Mohammed Aman','Masculino','ETH',11),
('Nelson Wiebbelling','Masculino','BRA',15),
('Nick Miller','Masculino','GBR',15),
('Olen Oates','Masculino','USA',3),
('Paulo Cassiano Feliza ','Masculino','POR',5),
('Paulo César Pavi','Masculino','SLE',14),
('Paulo da Silva','Masculino','BRA',12),
('Paulo de Tarso Dresch da Silveira','Masculino','BRA',10),
('Paulo Oliveira','Masculino','BRA',4),
('Paulo Rogério Amoretty Souza','Masculino','SLE',3),
('Paulo Silveira','Masculino','BRA',5),
('Pavel Bareisha','Masculino','BLR',3),
('Pedro Augusto Caltabiano','Masculino','URU',12),
('Pedro Miguel Lomelino da Silva Abreu','Masculino','BRA',10),
('Petrucio dos Santos ','Masculino','BRA',11),
('Quincy Downing','Masculino','USA',15),
('Rafael Pereira','Masculino','BRA',3),
('Ralf Oliveira','Masculino','BRA',4),
('Raquel Warmiling','Masculino','BRA',12),
('Renato Ribeiro','Masculino','BRA',10),
('Renato Soares','Masculino','BRA',15),
('Ricardo Almeida','Masculino','BRA',3),
('Saymon Hoffmann','Masculino','BRA',11),
('Thiago André','Masculino','BRA',15),
('Thiago Braz','Masculino','COL',4),
('Thiago da Silva','Masculino','CRC',10),
('Vinicius Veloso','Masculino','ETH',5),
('Wellington Morais','Masculino','GBR',14),
('William Braido','Masculino','GHA',12),
('Willian Dourado','Masculino','BRA',10),
('Younéss Essalhi','Masculino','MAR',8)

---------------------------------------------------------------Select's Padrões--------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM coi
SELECT * FROM atleta
SELECT * FROM prova

---------------------------------------------------Criação da Procedure -sp_descricao_prova--------------------------------------------------- 
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_descricao_prova (@codigo_prova INT,@descricao VARCHAR(120) OUTPUT)
AS
	DECLARE @desc VARCHAR(100),@genero VARCHAR(10)
	SELECT @desc=descricao FROM prova WHERE codigo_prova=@codigo_prova
	SELECT @genero=genero FROM prova WHERE codigo_prova=@codigo_prova
	SET @descricao=(@desc+' - '+@genero);

-----------------------------------------------------Criação da Procedure -sp_recorde_gp------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_recorde_gp (@codigo_prova INT,@recorde_gp VARCHAR(15) OUTPUT)
AS
	SELECT @recorde_gp=recorde_gp FROM prova WHERE codigo_prova=@codigo_prova
	IF(@codigo_prova>0 AND @codigo_prova<7 )
	BEGIN
		SET @recorde_gp=@recorde_gp
	END

---------------------------------------------------Criação da Procedure -sp_recorde_mundial---------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_recorde_mundial (@codigo_prova INT,@recorde_mundial VARCHAR(15) OUTPUT)
AS
	SELECT @recorde_mundial=recorde_mundial FROM prova WHERE codigo_prova=@codigo_prova
	IF(@codigo_prova>0 AND @codigo_prova<7 )
	BEGIN
		SET @recorde_mundial=@recorde_mundial
	END

-----------------------------------------------------------VIEW - Numero Randomico------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW dbo.vwRand
AS SELECT RAND() AS [Rand]
GO

----------------------------------------------------Criação Function - fn_bateria_inicial----------------------------------------------------- 
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_bateria_inicial(@cod INT)
RETURNS @tbl_resultado TABLE(
	codigo_tb       INT Identity,
	codigo_prova	INT,
	codigo_atleta 	INT,
	nome 			VARCHAR(100),
	pais_coi		VARCHAR(100),
	marca01			VARCHAR(15),
	marca02			VARCHAR(15),
	marca03			VARCHAR(15),
	marca04			VARCHAR(15),
	marca05			VARCHAR(15),
	marca06			VARCHAR(15),
	resultado		VARCHAR(15)
	)
AS
BEGIN
	DECLARE @metro	INT,@centimetro INT,@marca01	VARCHAR(15),@marca02	VARCHAR(15),@marca03	VARCHAR(15),@marca04	VARCHAR(15),
			@marca05	VARCHAR(15),@marca06	VARCHAR(15),@resultado	VARCHAR(15),@saida	VARCHAR(15),@cont	INT,@mm	VARCHAR(2),
			@ss VARCHAR(2),@ddd VARCHAR(3),@codigo_prova	INT,@codigo_atleta 	INT,@Faul	INT

	INSERT @tbl_resultado (codigo_atleta,nome,pais_coi,codigo_prova) SELECT atleta.codigo_atleta,atleta.nome,coi.pais_coi,
		   atleta.codigo_prova FROM atleta INNER JOIN  coi	ON atleta.codigo_coi = coi.codigo_coi WHERE atleta.codigo_prova=@cod;


    --  UPDATE MARCA-01 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			IF(@cod>0 AND @cod<7)
			BEGIN
				SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
				IF(@Faul<1)
				BEGIN
					SET @marca01= '00.00'
				END
				ELSE
				BEGIN
					IF(@cod=1)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 75 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=2)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 40 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=3)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=4)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 17 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=5)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 98 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=6)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 45 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
				END
				

				UPDATE @tbl_resultado SET marca01 =@marca01 WHERE codigo_tb=@cont; 
				SET @cont=@cont+1
			END	


			IF(@cod>6 AND @cod<17)
			BEGIN
				SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
				IF(@Faul<1)
				BEGIN
					SET @marca01= '99:99:99:999'
				END
				ELSE
				BEGIN
					IF(@cod=7) 
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *3 AS INT)+10)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='44'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=8)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+9)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='58'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=9)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *3 AS INT)+21)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='34'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=10)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+19)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='19'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=11)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+43)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='02'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=12)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+46)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='78'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=13)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *1 AS INT)+1)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+53)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='28'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
					IF(@cod=14)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *1 AS INT)+1)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+45)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='89'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
					IF(@cod=15)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *2 AS INT)+7)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+53)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='63'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
					IF(@cod=16)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *2 AS INT)+8)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+58)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='81'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
				END
				UPDATE @tbl_resultado SET marca01 =@marca01 WHERE codigo_tb=@cont; 
				SET @cont=@cont+1
			END
		END

    --  UPDATE MARCA-02 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca02= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 20 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 90 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 40 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca02 =@marca02 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

    --  UPDATE MARCA-03 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca03= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 30 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 20 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 91 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 41 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca03 =@marca03 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

    --  UPDATE MARCA-04 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca04= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 40 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 92 AS INT))
					SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 42 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca04 =@marca04 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

    --  UPDATE MARCA-05 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca05= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 50 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 20 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 94 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 43 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca05 =@marca05 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END
	
    --  UPDATE MARCA-06 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca06= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 75 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 30 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 16 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 96 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 46 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca06 =@marca06 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

	-- UPDATE RESULTADO --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=12)
		BEGIN
			IF(@cod<7)
			BEGIN
				SET @marca01=(SELECT marca01 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca02=(SELECT marca02 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca03=(SELECT marca03 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca04=(SELECT marca04 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca05=(SELECT marca05 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca06=(SELECT marca06 FROM @tbl_resultado WHERE codigo_tb=@cont);

				IF(@marca01 >= @marca02)	BEGIN SET @saida = @marca01	END ELSE BEGIN SET @saida = @marca02 END
				IF(@saida   >= @marca03)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca03 END
				IF(@saida   >= @marca04)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca04 END
				IF(@saida   >= @marca05)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca05 END
				IF(@saida   >= @marca06)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca06 END

				SET @resultado=@saida
				UPDATE @tbl_resultado SET resultado =@resultado WHERE codigo_tb=@cont;
			END
			ELSE
			BEGIN
				SET @marca01=(SELECT marca01 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @resultado=@marca01
				UPDATE @tbl_resultado SET resultado =@resultado WHERE codigo_tb=@cont;
			END
			
			SET @cont=@cont+1	
		END
	RETURN
END

----------------------------------------------------Chamada Function - fn_bateria_inicial-----------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM fn_bateria_inicial(2) order by resultado desc
SELECT * FROM fn_bateria_inicial(16) order by resultado asc

--CODIGO_PROVA  DE 1 A 6
INSERT INTO bateria_inicial SELECT * FROM fn_bateria_inicial(1) order by resultado desc;

--CODIGO_PROVA  DE 7 A 16
INSERT INTO bateria_inicial SELECT * FROM fn_bateria_inicial(16) order by resultado asc;

----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------Criação Function - fn_bateria_final-------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_bateria_final(@cod INT)
RETURNS @tbl_resultado TABLE(
	codigo_tb       INT Identity,
	codigo_prova	INT,
	codigo_atleta 	INT,
	nome 			VARCHAR(100),
	pais_coi		VARCHAR(100),
	marca01			VARCHAR(15),
	marca02			VARCHAR(15),
	marca03			VARCHAR(15),
	marca04			VARCHAR(15),
	marca05			VARCHAR(15),
	marca06			VARCHAR(15),
	resultado		VARCHAR(15)
	)
AS
BEGIN
	DECLARE @metro	INT,@centimetro INT,@marca01	VARCHAR(15),@marca02	VARCHAR(15),@marca03	VARCHAR(15),@marca04	VARCHAR(15),
			@marca05	VARCHAR(15),@marca06	VARCHAR(15),@resultado	VARCHAR(15),@saida	VARCHAR(15),@cont	INT,@mm	VARCHAR(2),
			@ss VARCHAR(2),@ddd VARCHAR(3),@codigo_prova	INT,@codigo_atleta 	INT,@Faul	INT

	IF(@cod>0 AND @cod<7)
	BEGIN
		INSERT @tbl_resultado (codigo_prova,codigo_atleta,nome,pais_coi) SELECT TOP(8) codigo_prova,codigo_atleta, nome,pais_coi FROM  bateria_inicial 
		WHERE codigo_prova=@cod  ORDER BY resultado DESC
	END

	IF(@cod>6 AND @cod<17)
	BEGIN
		INSERT @tbl_resultado (codigo_prova,codigo_atleta,nome,pais_coi) SELECT TOP(8) codigo_prova,codigo_atleta, nome,pais_coi FROM  bateria_inicial 
		WHERE codigo_prova=@cod  ORDER BY resultado ASC
	END

 --  UPDATE MARCA-01 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			IF(@cod>0 AND @cod<7)
			BEGIN
				SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
				IF(@Faul<1)
				BEGIN
					SET @marca01= '00.00'
				END
				ELSE
				BEGIN
					IF(@cod=1)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 75 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=2)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 40 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=3)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=4)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 17 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=5)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 98 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
					IF(@cod=6)
					BEGIN
						SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
						SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 45 AS INT))
						IF(@centimetro<10)BEGIN  SET @marca01= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
						ELSE BEGIN               SET @marca01= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
					END
				END
				

				UPDATE @tbl_resultado SET marca01 =@marca01 WHERE codigo_tb=@cont; 
				SET @cont=@cont+1
			END	


			IF(@cod>6 AND @cod<17)
			BEGIN
				SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
				IF(@Faul<1)
				BEGIN
					SET @marca01= '99:99:99:999'
				END
				ELSE
				BEGIN
					IF(@cod=7) 
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *3 AS INT)+10)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='44'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=8)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+9)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='58'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=9)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *3 AS INT)+21)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='34'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=10)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+19)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='19'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=11)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+43)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='02'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=12)
					BEGIN
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+46)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='78'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:00:'+@ss+':'+@ddd
					END
					IF(@cod=13)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *1 AS INT)+1)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+53)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='28'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
					IF(@cod=14)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *1 AS INT)+1)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+45)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='89'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
					IF(@cod=15)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *2 AS INT)+7)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+53)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='63'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
					IF(@cod=16)
					BEGIN
						SET @mm = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *2 AS INT)+8)AS VARCHAR(2))
						IF(@mm<10)BEGIN SET @mm='0'+@mm END
						SET @ss = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *4 AS INT)+58)AS VARCHAR(2))
						IF(@ss<10)BEGIN SET @ss='0'+@ss END
						SET @ddd = CAST((SELECT CAST((SELECT [rand] FROM vwRand) *95 AS INT))AS VARCHAR(2))
						IF(@ddd<10)BEGIN SET @ddd='81'+@ddd END
						IF(@ddd>9 AND @ddd<96)BEGIN SET @ddd=@ddd+'0' END
						SET @marca01='00:'+@mm+':'+@ss+':'+@ddd
					END
				END
				UPDATE @tbl_resultado SET marca01 =@marca01 WHERE codigo_tb=@cont; 
				SET @cont=@cont+1
			END
		END

    --  UPDATE MARCA-02 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca02= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 20 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 90 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 40 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca02= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca02= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca02 =@marca02 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

    --  UPDATE MARCA-03 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca03= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 30 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 20 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 91 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 41 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca03= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca03= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca03 =@marca03 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

    --  UPDATE MARCA-04 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca04= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 40 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 10 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 92 AS INT))
					SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 42 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca04= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca04= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca04 =@marca04 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

    --  UPDATE MARCA-05 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca05= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 50 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 20 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 94 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 43 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca05= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca05= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca05 =@marca05 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END
	
    --  UPDATE MARCA-06 --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			SET @Faul = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
			IF(@Faul<1)
			BEGIN
				IF(@cod>0 AND @cod<7)
				BEGIN
					SET @marca06= '00.00'
				END
			END
			ELSE
			BEGIN
				IF(@cod=1)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+15)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 75 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=2)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 8 AS INT)+65)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 30 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=3)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT)+66)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=4)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 7 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 16 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=5)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 9 AS INT))
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 96 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
				IF(@cod=6)
				BEGIN
					SET @metro = (SELECT CAST((SELECT [rand] FROM vwRand) * 6 AS INT)+10)
					SET @centimetro = (SELECT CAST((SELECT [rand] FROM vwRand) * 46 AS INT))
					IF(@centimetro<10)BEGIN  SET @marca06= CAST((@metro)AS VARCHAR(2))+'.0'+CAST((@centimetro)AS VARCHAR(2))END
					ELSE BEGIN               SET @marca06= CAST((@metro)AS VARCHAR(2))+'.'+CAST((@centimetro)AS VARCHAR(2))END
				END
			END
			UPDATE @tbl_resultado SET marca06 =@marca06 WHERE codigo_tb=@cont;
			SET @cont=@cont+1	
		END

	-- UPDATE RESULTADO --------------------------------------------------------------------------------
	SET @cont=1;
	WHILE(@cont<=8)
		BEGIN
			IF(@cod<7)
			BEGIN
				SET @marca01=(SELECT marca01 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca02=(SELECT marca02 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca03=(SELECT marca03 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca04=(SELECT marca04 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca05=(SELECT marca05 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @marca06=(SELECT marca06 FROM @tbl_resultado WHERE codigo_tb=@cont);

				IF(@marca01 >= @marca02)	BEGIN SET @saida = @marca01	END ELSE BEGIN SET @saida = @marca02 END
				IF(@saida   >= @marca03)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca03 END
				IF(@saida   >= @marca04)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca04 END
				IF(@saida   >= @marca05)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca05 END
				IF(@saida   >= @marca06)	BEGIN SET @saida = @saida	END ELSE BEGIN SET @saida = @marca06 END

				SET @resultado=@saida
				UPDATE @tbl_resultado SET resultado =@resultado WHERE codigo_tb=@cont;
			END
			ELSE
			BEGIN
				SET @marca01=(SELECT marca01 FROM @tbl_resultado WHERE codigo_tb=@cont);
				SET @resultado=@marca01
				UPDATE @tbl_resultado SET resultado =@resultado WHERE codigo_tb=@cont;
			END
			
			SET @cont=@cont+1	
		END

	RETURN
END

----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT * FROM fn_bateria_final(3) order by resultado desc
SELECT * FROM fn_bateria_final(16) order by resultado asc


--CODIGO_PROVA  DE 1 A 6
INSERT INTO bateria_final SELECT * FROM fn_bateria_final(2) order by resultado desc;

--CODIGO_PROVA  DE 7 A 16
INSERT INTO bateria_final SELECT * FROM fn_bateria_final(7) order by resultado asc;



--------------------------------------------------------------------Controle de testes--------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------

select*from bateria_final WHERE codigo_prova=7;

CREATE TABLE bateria_final(codigo INT IDENTITY,codigo_tb INT,codigo_prova INT,codigo_atleta INT,nome VARCHAR(100),pais_coi VARCHAR(100),marca01 VARCHAR(15),
marca02	VARCHAR(15),marca03	VARCHAR(15),marca04	VARCHAR(15),marca05	VARCHAR(15),marca06	VARCHAR(15),resultado VARCHAR(15) PRIMARY KEY(codigo) FOREIGN KEY 
(codigo_prova) REFERENCES prova(codigo_prova), FOREIGN KEY (codigo_atleta) REFERENCES atleta(codigo_atleta))

BACKUP DATABASE gp_brasil_atletismo
TO DISK ='C:\TEST\gp_brasil_atletismo.bak';



-- Exercícios da Nona Aula LAB. DE BANCO DE DADOS - (Cursores) 26-10-2020

-------------------------------------------Exercício 10-A----------------------------------------------
-------------------------------------------------------------------------------------------------------

-- Exercício tirado de situação real.
-- A empresa tinha duas tabelas: Envio e Endereço, como listada abaixo.
-- No atributo NR_LINHA_ARQUIV, há um número que referencia a 
-- linha de incidência do endereço na tabela endereço.
-- Por exemplo: 

-- ENVIO:
-- |CPF		    |NR_LINHA_ARQUIV	|...
-- |11111111111	|1			        |
-- |11111111111	|2			        |

-- ENDEREÇO:
-- |CPF		    |CEP		|PORTA	|ENDEREÇO	|COMPLEMENTO		|BAIRRO			|CIDADE			|UF	|
-- |11111111111	|11111111	|10	    |Rua A		|			        |Pq A			|São Paulo		|SP	|
-- |11111111111	|22222222	|125	|Rua B		|			        |Pq B			|São Paulo		|SP	|

-- Portanto, o NR_LINHA_ARQUIV (1) referencia o registro do endereço da Rua A e o NR_LINHA_ARQUIV (2) 
-- referencia o endereço da Rua B.

-- Como se trata de uma estrutura completamente mal feita, o DBA solicitou
-- que se colcasse as colunas NM_ENDERECO, NR_ENDERECO, NM_COMPLEMENTO, NM_BAIRRO, NR_CEP,
-- NM_CIDADE, NM_UF varchar(2) e movesse os dados da tabela endereço para a tabela envio.

-- Fazer uma PROCEDURE, com cursor, que resolva esse problema

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

create table envio (
CPF varchar(20),
NR_LINHA_ARQUIV	int,
CD_FILIAL int,
DT_ENVIO datetime,
NR_DDD int,
NR_TELEFONE	varchar(10),
NR_RAMAL varchar(10),
DT_PROCESSAMENT	datetime,
NM_ENDERECO varchar(200),
NR_ENDERECO int,
NM_COMPLEMENTO	varchar(50),
NM_BAIRRO varchar(100),
NR_CEP varchar(10),
NM_CIDADE varchar(100),
NM_UF varchar(2)
)

create table endereço(
CPF varchar(20),
CEP	varchar(10),
PORTA	int,
ENDEREÇO	varchar(200),
COMPLEMENTO	varchar(100),
BAIRRO	varchar(100),
CIDADE	varchar(100),
UF Varchar(2))

---------------------------------Criação da Procedure - sp_insereenvio---------------------------------
-------------------------------------------------------------------------------------------------------

create procedure sp_insereenvio
as
declare @cpf as int
declare @cont1 as int
declare @cont2 as int
declare @conttotal as int
set @cpf = 11111
set @cont1 = 1
set @cont2 = 1
set @conttotal = 1
	while @cont1 <= @cont2 and @cont2 < = 100
			begin
				insert into envio (CPF, NR_LINHA_ARQUIV, DT_ENVIO)
				values (cast(@cpf as varchar(20)), @cont1,GETDATE())
				insert into endereço (CPF,PORTA,ENDEREÇO)
				values (@cpf,@conttotal,CAST(@cont2 as varchar(3))+'Rua '+CAST(@conttotal as varchar(5)))
				set @cont1 = @cont1 + 1
				set @conttotal = @conttotal + 1
				if @cont1 > = @cont2
					begin
						set @cont1 = 1
						set @cont2 = @cont2 + 1
						set @cpf = @cpf + 1
					end
	end

---------------------------------Chamada da Procedure - sp_insereenvio---------------------------------
-------------------------------------------------------------------------------------------------------

exec sp_insereenvio

------------------------------------------------Select's-----------------------------------------------
-------------------------------------------------------------------------------------------------------

select * from envio order by CPF,NR_LINHA_ARQUIV asc
select * from endereço order by CPF asc

----------------------------------Criação - Function fn_atualiza_envio---------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_atualiza_envio()
RETURNS @tabela TABLE (
CPF varchar(20),
NR_LINHA_ARQUIV	int,
CD_FILIAL int,
DT_ENVIO datetime,
NR_DDD int,
NR_TELEFONE	varchar(10),
NR_RAMAL varchar(10),
DT_PROCESSAMENT	datetime,
NM_ENDERECO varchar(200),
NR_ENDERECO int,
NM_COMPLEMENTO	varchar(50),
NM_BAIRRO varchar(100),
NR_CEP varchar(10),
NM_CIDADE varchar(100),
NM_UF varchar(2)
)
AS
BEGIN
	DECLARE @NR_LINHA_ARQUIV	INT,
			@ENDERECO			VARCHAR(200),
			@PORTA				INT,
			@CONT				INT

	INSERT @tabela (CPF,NR_LINHA_ARQUIV,CD_FILIAL,DT_ENVIO) SELECT CPF,NR_LINHA_ARQUIV,CD_FILIAL,DT_ENVIO FROM envio

	--INICIO CURSOR 1
	DECLARE cursorEnvio CURSOR FOR SELECT NR_LINHA_ARQUIV FROM envio 
	OPEN cursorEnvio
	FETCH NEXT FROM cursorEnvio INTO @NR_LINHA_ARQUIV

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--INICIO CURSOR 2
		DECLARE cursorEndereco CURSOR FOR SELECT PORTA,ENDEREÇO FROM endereço
		OPEN cursorEndereco
		FETCH NEXT FROM cursorEndereco INTO @PORTA, @ENDERECO

		SET @CONT=1;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF(@NR_LINHA_ARQUIV=@CONT)
			BEGIN
				UPDATE @tabela SET NR_ENDERECO =@PORTA WHERE NR_LINHA_ARQUIV=@CONT;
				UPDATE @tabela SET NM_ENDERECO =@ENDERECO WHERE NR_LINHA_ARQUIV=@CONT;
			END
			FETCH NEXT FROM cursorEndereco INTO @PORTA, @ENDERECO
			SET @CONT=@CONT+1;
		END
		CLOSE cursorEndereco
		DEALLOCATE cursorEndereco
		SET @CONT=1;
		--FINAL CURSOR 2

		FETCH NEXT FROM cursorEnvio INTO @NR_LINHA_ARQUIV
	END
	CLOSE cursorEnvio
	DEALLOCATE cursorEnvio
	--FINAL CURSOR 1

	RETURN
END

----------------------------------Chamada - Function fn_atualiza_envio---------------------------------
-------------------------------------------------------------------------------------------------------


SELECT CPF,NR_LINHA_ARQUIV,NM_ENDERECO,NR_ENDERECO FROM fn_atualiza_envio()

-- *********** OBS DEMOROU 6:18M PRA EXECUTAR  A FUNCTION ***********

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------




-------------------------------------------Exercício 10-C----------------------------------------------
-------------------------------------------------------------------------------------------------------

-- Considere as tabelas abaixo em uma database.

-- Tabela Curso
------------------------------------------------------------
-- Codigo	Nome									Duracao

-- 0		Análise e Desenvolvimento de Sistemas	2880
-- 1		Logistica								2880
-- 2		Polímeros								2880
-- 3		Comércio Exterior						2600
-- 4		Gestão Empresarial						2600
------------------------------------------------------------

-- Tabela Disciplinas
------------------------------------------------------------
-- Codigo	Nome				Carga_Horaria

-- 1		Algoritmos					80
-- 2		Administração				80
-- 3		Laboratório de Hardware		40
-- 4		Pesquisa Operacional		80
-- 5		Física I					80
-- 6		Físico Química				80
-- 7		Comércio Exterior			80
-- 8		Fundamentos de Marketing	80
-- 9		Informática					40
-- 10		Sistemas de Informação		80
------------------------------------------------------------

-- Tabela Disciplina_Curso
------------------------------------------------------------
-- Codigo_Disciplina	Codigo_Curso
-- 1					0
-- 2					0
-- 2					1
-- 2					3
-- 2					4
-- 3					0
-- 4					1
-- 5					2
-- 6					2
-- 7					1
-- 7					3
-- 8					1
-- 8					4
-- 9					1
-- 9					3
-- 10					0
-- 10					4
------------------------------------------------------------

-- Criar uma UDF (Function) cuja entrada é o código do curso e, com um cursor, monte uma tabela de saída com as informações 
-- do curso que é parâmetro de entrada.

-- (Código_Disciplina | Nome_Disciplina | Carga_Horaria_Disciplina | Nome_Curso)

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE escola
GO
USE escola

CREATE TABLE curso(
codigo_curso		INT,
nome				VARCHAR(100),
duracao				INT
PRIMARY KEY(codigo_curso))


CREATE TABLE disciplina(
codigo_disciplina	INT IDENTITY NOT NULL,
nome				VARCHAR(100),
carga_horaria		INT
PRIMARY KEY(codigo_disciplina))


CREATE TABLE  disciplina_curso(
codigo				INT IDENTITY,
codigo_disciplina	INT,
codigo_curso		INT
PRIMARY KEY(codigo)
FOREIGN KEY (Codigo_disciplina) REFERENCES disciplina(Codigo_disciplina),
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso))

--------------------------------------------Insert's Tabelas-------------------------------------------
-------------------------------------------------------------------------------------------------------

INSERT INTO curso VALUES
(0,'Análise e Desenvolvimento de Sistemas',2880),
(1,'Logistica',2880),
(2,'Polímeros',2880),
(3,'Comércio Exterior',2600),
(4,'Gestão Empresarial',2600)

INSERT INTO disciplina VALUES
('Algoritmos',80),
('Administração',80),
('Laboratório de Hardware',40),
('Pesquisa Operacional',80),
('Física I',80),
('Físico Química',80),
('Comércio Exterior',80),
('Fundamentos de Marketing',80),
('Informática',40),
('Sistemas de Informação',80)

INSERT INTO disciplina_curso VALUES
(1,0),
(2,0),
(2,1),
(2,3),
(2,4),
(3,0),
(4,1),
(5,2),
(6,2),
(7,1),
(7,3),
(8,1),
(8,4),
(9,1),
(9,3),
(10,0),
(10,4)

--------------------------------------------Select's Padrões-------------------------------------------
-------------------------------------------------------------------------------------------------------
SELECT *FROM curso  
SELECT *FROM disciplina
SELECT *FROM disciplina_curso

---------------------------------------Criação Function - fn_10c---------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_10c(@cod INT)
RETURNS @tabela TABLE (
codigo_disciplina			INT,
nome_disciplina				VARCHAR(100),
carga_horaria_disciplina	INT,
nome_curso					VARCHAR(100)
)
AS
BEGIN
	DECLARE @codigo_disciplina			INT,
			@codigo_curso				INT,
			@nome_disciplina			VARCHAR(100),
			@carga_horaria_disciplina	INT,
			@nome_curso					VARCHAR(100)

	DECLARE c CURSOR FOR SELECT codigo_disciplina, codigo_curso FROM disciplina_curso
	OPEN c
	FETCH NEXT FROM c INTO @codigo_disciplina, @codigo_curso

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(@codigo_curso=@cod)
		BEGIN
			SET @nome_disciplina=(SELECT nome FROM disciplina WHERE codigo_disciplina=@codigo_disciplina)
			SET @carga_horaria_disciplina=(SELECT carga_horaria FROM disciplina WHERE codigo_disciplina=@codigo_disciplina)
			SET @nome_curso=(SELECT nome FROM curso WHERE codigo_curso=@codigo_curso)

			INSERT @tabela (codigo_disciplina,nome_disciplina,carga_horaria_disciplina,nome_curso)VALUES
						   (@codigo_disciplina,@nome_disciplina,@carga_horaria_disciplina,@nome_curso)	
		END

		FETCH NEXT FROM c INTO @codigo_disciplina, @codigo_curso
	END
	CLOSE c
	DEALLOCATE c

	RETURN
END

---------------------------------------Chamada Function - fn_10c---------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM fn_10c(4)

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Exercícios da Oitava Aula LAB. DE BANCO DE DADOS - (Triggers e Functions) 19-10-2020

--------------------------------------------Exercício 01-----------------------------------------------
-------------------------------------------------------------------------------------------------------

-- Considere um quadrangular final de times de volei com 4 times
-- Time 1, Time 2 Time 3 e Time 4
-- Todos jogarão contra todos.
-- Os resultados dos jogos serão armazenados em uma tabela

-- Tabela times
-- (Cod Time | Nome Time)
-- 1 Time 1
-- 2 Time 2
-- 3 Time 3
-- 4 Time 4

-- Jogos
-- (Cod Time A | Cod Time B | Set Time A | Set Time B)

-- Considera-se vencedor o time que fez 3 de 5 sets.
-- Se a vitória for por 3 x 2, o time vencedor ganha 2 pontos e o time perdedor ganha 1.
-- Se a vitória for por 3 x 0 ou 3 x 1, o vencedor ganha 3 pontos e o perdedor, 0.

-- Fazer uma UDF que apresente:
-- (Nome Time | Total Pontos | Total Sets Ganhos | Total Sets Perdidos | Set Average (Ganhos - perdidos))

-- Fazer uma trigger que verifique se os inserts dos sets estão corretos (Máximo 5 sets, sendo que o vencedor 
-- tem no máximo 3 sets)

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE exercicio_Triggers_e_Functions
GO
USE exercicio_Triggers_e_Functions

CREATE TABLE times(
cod_time		INT IDENTITY NOT NULL,
nome_time		VARCHAR(100),
total_pontos	INT
PRIMARY KEY(cod_time))

CREATE TABLE jogos(
cod_jogo		INT IDENTITY NOT NULL,
cod_time_a		INT,
cod_time_b		INT,
set_time_a		INT,
set_time_b		INT 
PRIMARY KEY(cod_jogo)
FOREIGN KEY (cod_time_a) REFERENCES times(cod_time),
FOREIGN KEY (cod_time_b) REFERENCES times(cod_time))

-------------------------------------Inserção de Valores na Tabela-------------------------------------
-------------------------------------------------------------------------------------------------------

INSERT INTO times VALUES
	('TIME-01',0),
	('TIME-02',0),
	('TIME-03',0),
	('TIME-04',0)

--------------------------------------------Select's Padrão--------------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM times 
SELECT * FROM jogos

-----------------------------------Criação da Trigger - t_verifica_sets--------------------------------
-------------------------------------------------------------------------------------------------------

CREATE TRIGGER t_verifica_sets ON jogos
FOR INSERT
AS
BEGIN
	DECLARE @cod_time_a		INT,
			@cod_time_b		INT,
			@set_time_a		INT,
			@set_time_b		INT

	SET @cod_time_a = (SELECT cod_time_a FROM INSERTED)
	SET @cod_time_b = (SELECT cod_time_b FROM INSERTED)
	SET @set_time_a = (SELECT set_time_a FROM INSERTED)
	SET @set_time_b = (SELECT set_time_b FROM INSERTED)	

	IF (@set_time_a+@set_time_b>5)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('**ERRO** QUANTIDADE MÁXIMA DE SETS PERMITIDO = 5   **INSERT CANCELADO**', 16, 1)
	END

	IF (@set_time_a>3 OR @set_time_b>3)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('**ERRO** QUANTIDADE MÁXIMA DE SETS GANHOS PERMITIDO = 3   **INSERT CANCELADO**', 16, 1)
	END
END

------------------------------Criação da Procedure -sp_insert_jogos_pontos-----------------------------
-------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_insert_jogos_pontos (@cod_time_a INT,@cod_time_b INT)

AS
	DECLARE @set_time_a INT,
			@set_time_b INT

	SET @set_time_a= (SELECT CAST(RAND() * 4 AS INTEGER));

	IF(@set_time_a!=3)
	BEGIN
		SET @set_time_b=3;
	END
	ELSE
	BEGIN
		SET @set_time_b= (SELECT CAST(RAND() * 3 AS INTEGER));
	END

	INSERT INTO jogos VALUES (@cod_time_a,@cod_time_b,@set_time_a,@set_time_b)


	IF((@set_time_a=3 AND @set_time_b=0) OR (@set_time_a=3 AND @set_time_b=1) )
	BEGIN
		UPDATE times SET total_pontos = ((SELECT total_pontos FROM times WHERE cod_time=@cod_time_a)+3)WHERE cod_time=@cod_time_a;
	END
	IF(@set_time_a=3 AND @set_time_b=2)
	BEGIN
		UPDATE times SET total_pontos = ((SELECT total_pontos FROM times WHERE cod_time=@cod_time_a)+2)WHERE cod_time=@cod_time_a;
		UPDATE times SET total_pontos = ((SELECT total_pontos FROM times WHERE cod_time=@cod_time_b)+1)WHERE cod_time=@cod_time_b;
	END


	IF((@set_time_b=3 AND @set_time_a=0) OR (@set_time_b=3 AND @set_time_a=1) )
	BEGIN
		UPDATE times SET total_pontos = ((SELECT total_pontos FROM times WHERE cod_time=@cod_time_b)+3)WHERE cod_time=@cod_time_b;
	END
	IF(@set_time_b=3 AND @set_time_a=2)
	BEGIN
		UPDATE times SET total_pontos = ((SELECT total_pontos FROM times WHERE cod_time=@cod_time_b)+2)WHERE cod_time=@cod_time_b;
		UPDATE times SET total_pontos = ((SELECT total_pontos FROM times WHERE cod_time=@cod_time_a)+1)WHERE cod_time=@cod_time_a;
	END


-----------------------------Chamada da Procedure-sp_insert_jogos_pontos-------------------------------
-------------------------------------------------------------------------------------------------------

EXEC sp_insert_jogos_pontos 1,2;
EXEC sp_insert_jogos_pontos 1,3;
EXEC sp_insert_jogos_pontos 4,1;
EXEC sp_insert_jogos_pontos 2,3;
EXEC sp_insert_jogos_pontos 2,4;
EXEC sp_insert_jogos_pontos 3,4;


-------------------------------------Função - fn_tabela_resultado--------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_tabela_resultado()
RETURNS @tbl_resultado TABLE(
	nome_time		VARCHAR(100),
	total_pontos	INT,
	sets_ganhos		INT,
	sets_perdidos	INT,
	sets_average	INT
	)

AS
BEGIN

	INSERT @tbl_resultado (nome_time,total_pontos) SELECT nome_time,total_pontos FROM times; 

	UPDATE @tbl_resultado SET sets_ganhos =((SELECT SUM (set_time_a) FROM jogos WHERE cod_time_a = 1)+(SELECT SUM (set_time_b) FROM jogos WHERE cod_time_b = 1))WHERE nome_time = 'TIME-01';
	UPDATE @tbl_resultado SET sets_ganhos =((SELECT SUM (set_time_a) FROM jogos WHERE cod_time_a = 2)+(SELECT SUM (set_time_b) FROM jogos WHERE cod_time_b = 2))WHERE nome_time = 'TIME-02';
	UPDATE @tbl_resultado SET sets_ganhos =((SELECT SUM (set_time_a) FROM jogos WHERE cod_time_a = 3)+(SELECT SUM (set_time_b) FROM jogos WHERE cod_time_b = 3))WHERE nome_time = 'TIME-03';
	UPDATE @tbl_resultado SET sets_ganhos =((SELECT SUM (set_time_a) FROM jogos WHERE cod_time_a = 4)+(SELECT SUM (set_time_b) FROM jogos WHERE cod_time_b = 4))WHERE nome_time = 'TIME-04';

	UPDATE @tbl_resultado SET sets_perdidos =((SELECT SUM (set_time_b) FROM jogos WHERE cod_time_a = 1)+(SELECT SUM (set_time_a) FROM jogos WHERE cod_time_b = 1))WHERE nome_time = 'TIME-01';
	UPDATE @tbl_resultado SET sets_perdidos =((SELECT SUM (set_time_b) FROM jogos WHERE cod_time_a = 2)+(SELECT SUM (set_time_a) FROM jogos WHERE cod_time_b = 2))WHERE nome_time = 'TIME-02';
	UPDATE @tbl_resultado SET sets_perdidos =((SELECT SUM (set_time_b) FROM jogos WHERE cod_time_a = 3)+(SELECT SUM (set_time_a) FROM jogos WHERE cod_time_b = 3))WHERE nome_time = 'TIME-03';
	UPDATE @tbl_resultado SET sets_perdidos =((SELECT SUM (set_time_b) FROM jogos WHERE cod_time_a = 4)+(SELECT SUM (set_time_a) FROM jogos WHERE cod_time_b = 4))WHERE nome_time = 'TIME-04';

	UPDATE @tbl_resultado SET sets_average =((SELECT sets_ganhos FROM @tbl_resultado WHERE nome_time = 'TIME-01')-(SELECT sets_perdidos FROM @tbl_resultado WHERE nome_time = 'TIME-01'))WHERE nome_time = 'TIME-01';
	UPDATE @tbl_resultado SET sets_average =((SELECT sets_ganhos FROM @tbl_resultado WHERE nome_time = 'TIME-02')-(SELECT sets_perdidos FROM @tbl_resultado WHERE nome_time = 'TIME-02'))WHERE nome_time = 'TIME-02';
	UPDATE @tbl_resultado SET sets_average =((SELECT sets_ganhos FROM @tbl_resultado WHERE nome_time = 'TIME-03')-(SELECT sets_perdidos FROM @tbl_resultado WHERE nome_time = 'TIME-03'))WHERE nome_time = 'TIME-03';
	UPDATE @tbl_resultado SET sets_average =((SELECT sets_ganhos FROM @tbl_resultado WHERE nome_time = 'TIME-04')-(SELECT sets_perdidos FROM @tbl_resultado WHERE nome_time = 'TIME-04'))WHERE nome_time = 'TIME-04';		

	RETURN
END

---------------------------------Chamada Função - fn_tabela_resultado----------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM fn_tabela_resultado() ORDER BY  total_pontos desc
-- Exercício da Quarta Aula LAB. DE BANCO DE DADOS - (Query Dinâmica em SQL-Server) 14-09-2020


---------------------------------------------Exercício 01----------------------------------------------
-------------------------------------------------------------------------------------------------------

-- Dada a database abaixo, criar uma procedure que receba idProduto, nome,
-- valor e tipo(e para entrada e s para saída) e determine se vai para a tabela 
-- de compras (entrada) ou de vendas (saída). Não há necessidade de usar 
-- Try..Catch 

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------



-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE querydinamica
GO
USE querydinamica

CREATE TABLE produto(
idProduto INT NOT NULL,
nome VARCHAR(100),
valor DECIMAL(7,2),
tipo CHAR(1) DEFAULT('e')
PRIMARY KEY (idProduto))

CREATE TABLE compra(
codigo INT NOT NULL,
produto INT NOT NULL,
qtd INT NOT NULL,
vl_total DECIMAL(7,2)
PRIMARY KEY (codigo, produto)
FOREIGN KEY (produto) REFERENCES produto (idProduto))

CREATE TABLE venda(
codigo INT NOT NULL,
produto INT NOT NULL,
qtd INT NOT NULL,
vl_total DECIMAL(7,2)
PRIMARY KEY (codigo, produto)
FOREIGN KEY (produto) REFERENCES produto (idProduto))



--------------------------------------Procedure Insere Registro----------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_insere_registro(@idProduto INT,@nome VARCHAR(100),@valor DECIMAL(7,2),@tipo CHAR(1))
AS
	DECLARE 	@tabela		VARCHAR(10),
			@query		VARCHAR(MAX),
			@erro		VARCHAR(MAX),
			@codigo 	INT,
			@produto 	INT,
			@qtd 		INT,
			@vl_total 	DECIMAL(7,2)

	SET @codigo=@idProduto+1
	SET @produto=@idProduto
	SET @qtd=2
	SET @vl_total=@valor*@qtd
	
	IF(@tipo='e' OR @tipo='E')
	BEGIN
		SET @tabela = 'compra'
	END
	ELSE
	BEGIN
		IF(@tipo='s' OR @tipo='S')
		BEGIN
			SET @tabela = 'venda'
		END
		ELSE
		BEGIN
			RAISERROR('ATRIBUTO - TIPO - SÓ ACEITA OS VALORES (E) OU (S)', 16, 1)
		END
	END

	INSERT INTO produto VALUES(@idProduto,@nome,@valor,@tipo);

	
	SET @query = 'INSERT INTO '+@tabela+' VALUES('+CAST(@codigo AS VARCHAR(5))+
		','+CAST(@produto AS VARCHAR(10))+','+CAST(@qtd AS VARCHAR(3))+','+CAST(@vl_total AS VARCHAR(10))+')'

	PRINT @query

	BEGIN TRY
		EXEC (@query)
	END TRY
	BEGIN CATCH
		SET @erro = ERROR_MESSAGE()
		IF (@erro LIKE '%PRIMARY%')
		BEGIN
			RAISERROR('************* ERRO DE CHAVE PRIMÁRIA DUPLICADA *************', 16, 1)
		END
		ELSE
		BEGIN
			RAISERROR('************** ERRO DE PROCESSAMENTO **************', 16, 1)
		END
	END CATCH


----------------------------------Chamada da procedure insere Registro---------------------------------
-------------------------------------------------------------------------------------------------------

EXEC sp_insere_registro 1,'XBOX ONE','1000','E'
EXEC sp_insere_registro 2,'PS 5','1200','S'
EXEC sp_insere_registro 3,'NINTENDO SWITCH','1300','E'


--------------------------------------------Select's Padrões-------------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM produto
SELECT * FROM compra 
SELECT * FROM venda




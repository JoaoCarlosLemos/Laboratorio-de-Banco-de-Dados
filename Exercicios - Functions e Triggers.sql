
-- Exerc�cios da Setima Aula LAB. DE BANCO DE DADOS - (Functions e Triggers) 05-10-2020

--------------------------------------------Exerc�cio 01-A---------------------------------------------
-------------------------------------------------------------------------------------------------------
--Considere o seguinte cen�rio:


--  Produto						 Estoque					 Venda
--		C�digo						Codigo_Produto				Nota_Fiscal
--		Nome						Qtd_Estoque					Codigo_Produto
--		Descri��o					Estoque_Minimo				Quantidade
--		Valor Unit�rio

	
--Fazer uma TRIGGER AFTER na tabela Venda que, uma vez feito um INSERT, verifique se a quantidade est� 
--dispon�vel em estoque.Caso esteja, a venda se concretiza, caso contr�rio, a venda dever� ser cancelada 
--e uma mensagem de erro dever� ser enviada.A mesma TRIGGER dever� validar, caso a venda se concretize, 
--se o estoque est� abaixo do estoque m�nimo determinado ou se ap�s a venda, ficar� abaixo do estoque 
--considerado m�nimo e dever� lan�ar um print na tela avisando das duas situa��es.

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE exercicioTriggers
GO
USE exercicioTriggers

CREATE TABLE produto(
codigo			INT IDENTITY NOT NULL,
nome			VARCHAR(100),
descricao		VARCHAR(200),
valor_unitario	DECIMAL(7,2)
PRIMARY KEY(codigo))

CREATE TABLE estoque(
codigo			INT IDENTITY NOT NULL,
codigo_produto	INT,
qtd_estoque		INT,
estoque_minimo	INT 
PRIMARY KEY(codigo)
FOREIGN KEY (codigo_produto) REFERENCES produto(codigo))

CREATE TABLE venda(
nota_fiscal		INT IDENTITY NOT NULL,
codigo_produto	INT,
quantidade		INT 
PRIMARY KEY(nota_fiscal)
FOREIGN KEY (codigo_produto) REFERENCES produto(codigo))

-------------------------------------Inser��o de Valores na Tabela-------------------------------------
-------------------------------------------------------------------------------------------------------

INSERT INTO produto VALUES
	('NotteBook HP','I-5 500HD 8GB ',2499.99),
	('NotteBook DEL','I-3 1000HD 8GB ',2399.99),
	('NotteBook ACER','I-3 500HD 16GB ',2499.99),
	('NotteBook ASUS','I-7 500HD 8GB ',2550.00)

INSERT INTO estoque VALUES
	(1,10,2),
	(2,7,2),
	(3,8,2),
	(4,6,2)

--------------------------------------------Select's Padr�o--------------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM produto
SELECT * FROM estoque
SELECT * FROM venda

-----------------------------------Cria��o da Trigger - t_insert_venda---------------------------------
-------------------------------------------------------------------------------------------------------

CREATE TRIGGER t_insert_venda ON venda
FOR INSERT
AS
BEGIN
	DECLARE @nota_fiscal		INT,
			@codigo_produto		INT,
			@quantidade			INT,
			@qtd_estoque		INT,
			@estoque_minimo		INT

	SET @nota_fiscal = (SELECT nota_fiscal FROM INSERTED)
	SET @codigo_produto = (SELECT codigo_produto FROM INSERTED)
	SET @quantidade = (SELECT quantidade FROM INSERTED)
	SET @qtd_estoque=(SELECT qtd_estoque FROM estoque WHERE codigo_produto= @codigo_produto)
	SET @estoque_minimo=(SELECT estoque_minimo FROM estoque WHERE codigo_produto= @codigo_produto)

	IF (@qtd_estoque>=@quantidade)
	BEGIN
		IF(@qtd_estoque<@estoque_minimo)
		BEGIN
			PRINT('**ALERTA !** ESTOQUE EST� ABAIXO DO ESTOQUE M�NIMO DETERMINADO ** ANTES DA VENDA **');
		END

		UPDATE estoque SET qtd_estoque = @qtd_estoque -@quantidade WHERE codigo_produto = @codigo_produto
		SET @qtd_estoque=(SELECT qtd_estoque FROM estoque WHERE codigo_produto= @codigo_produto)

		IF(@qtd_estoque<@estoque_minimo)
		BEGIN
			PRINT('**ALERTA !** ESTOQUE EST� ABAIXO DO ESTOQUE M�NIMO DETERMINADO ** P�S VENDA **');
		END
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('**ERRO** QUANTIDADE SOLICITADA MAIOR QUE DISPON�VEL NO ESTOQUE  **VENDA CANCELADA**', 16, 1)
	END
END

-------------------------------------------Testes de Inser��o------------------------------------------
-------------------------------------------------------------------------------------------------------

--venda onde quantidade<qtd_estoque 
INSERT INTO venda VALUES(1,1)

--venda onde quantidade>qtd_estoque
INSERT INTO venda VALUES(1,10)

--venda onde quantidade<qtd_estoque AND qtd_estoque<estoque_minimo =p�s venda
INSERT INTO venda VALUES(1,8)


--venda onde quantidade<qtd_estoque AND qtd_estoque<estoque_minimo =antes da venda
INSERT INTO venda VALUES(1,1)

SELECT * FROM produto
SELECT * FROM estoque
SELECT * FROM venda

--------------------------------------------Exerc�cio 01-B---------------------------------------------
-------------------------------------------------------------------------------------------------------

--Fazer uma UDF (User Defined Function) Multi Statement Table, que apresente, para uma dada nota fiscal, 
--a seguinte sa�da:(Nota_Fiscal | Codigo_Produto | Nome_Produto | Descricao_Produto | Valor_Unitario | 
--Quantidade | Valor_Total*) Considere que Valor_Total = Valor_Unit�rio * Quantidade

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

----------------------------------Cria��o da Fun��o - fn_calculo_total---------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_calculo_total(@codigo_produto	INT,@nota_fiscal INT) 
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @qtd			INT,
			@valor_unitario	DECIMAL(7,2),
			@valor_total	DECIMAL(7,2)
		
	SET @qtd=(SELECT quantidade FROM venda WHERE nota_fiscal=@nota_fiscal AND codigo_produto=@codigo_produto)
	SET @valor_unitario=(SELECT valor_unitario FROM produto WHERE codigo=@codigo_produto)
	SET @valor_total = @qtd*@valor_unitario
	RETURN (@valor_total)
END
 
--------------------------------------Cria��o da Fun��o - fn_venda-------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_venda()
RETURNS @tabela TABLE(
nota_fiscal			INT,
codigo_produto		INT,
nome_produto		VARCHAR(100),
descricao_produto	VARCHAR(200),
valor_unitario		DECIMAL(7,2),
quantidade			INT,
valor_total			DECIMAL(7,2)
)

AS
BEGIN
	INSERT @tabela (nota_fiscal, codigo_produto, quantidade)SELECT nota_fiscal, codigo_produto, quantidade FROM venda

	UPDATE @tabela SET nome_produto = (SELECT nome FROM produto WHERE codigo_produto=codigo)
	UPDATE @tabela SET descricao_produto = (SELECT descricao FROM produto WHERE codigo_produto=codigo)
	UPDATE @tabela SET valor_unitario = (SELECT valor_unitario FROM produto WHERE codigo_produto=codigo)

	UPDATE @tabela SET valor_total = (SELECT dbo.fn_calculo_total(codigo_produto,nota_fiscal))
					                                                                                     
	RETURN
END
 
--------------------------------------Chamada da Fun��o - fn_venda-------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM fn_venda()
 

















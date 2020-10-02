-- Exercícios da Sexta Aula LAB. DE BANCO DE DADOS - (Funções Definidas pelo Usuário (UDF) - Functions) 28-09-2020

--------------------------------------------Exercício 01-A---------------------------------------------
-------------------------------------------------------------------------------------------------------

-- a)Fazer uma Function que verifique, na tabela produtos (codigo, nome, valor unitário e qtd estoque)
--   Quantos produtos estão com estoque abaixo de um valor de entrada

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE exercicio_functions
GO
USE exercicio_functions
 
CREATE TABLE produtos (
codigo			INT NOT NULL,
nome			VARCHAR(100),
valor_unitario	DECIMAL(7,2),
qtd_estoque		INT
PRIMARY KEY (codigo))

-------------------------------------Inserção de Valores na Tabela-------------------------------------
-------------------------------------------------------------------------------------------------------

INSERT INTO produtos VALUES 
(1,'Call Of Duty: Warzone',156.87,1),
(2,'Nioh 2',89.99,2), 
(3,'Mortal Kombat 11',110.00,3),
(4,'Ori & The Will Of The Wisps',70.00,4),
(5,'Final Fantasy VII Remake',181.55,5),
(6,'The Last Of Us Part II',199.99,6),
(7,'DOOM Eternal',89.90,7), 
(8,'Cyberpunk 2077',270.77,8),
(9,'Horizon Zero Dawn',69.80,9),
(10,'Red Dead Redemption 2',95.70,10)

--------------------------------------------Select Padrão----------------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM produtos

--------------------------------Criação Function - fn_qtd_estoque_baixo--------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_qtd_estoque_baixo(@qtd INT)
RETURNS INT 
AS
BEGIN
	DECLARE @qtd_total	INT
	
	SET @qtd_total=(SELECT COUNT (qtd_estoque) FROM produtos WHERE qtd_estoque<@qtd);
	RETURN @qtd_total
END

-------------------------------Chamada da Function - fn_qtd_estoque_baixo------------------------------
-------------------------------------------------------------------------------------------------------

SELECT dbo.fn_qtd_estoque_baixo(8) AS QTD_BAIXA




--------------------------------------------Exercício 01-B---------------------------------------------
-------------------------------------------------------------------------------------------------------

-- b)Fazer uma function que liste o código, o nome e a quantidade dos produtos que estão com o estoque 
--   abaixo de um valor de entrada

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-------------------------------Criação Function - fn_tabela_estoque_baixo------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_tabela_estoque_baixo(@qtd INT)
RETURNS @tbl_estoque_baixo TABLE(
codigo				INT,
nome				VARCHAR(100),
qtd_estoque_baixo	INT
)

AS
BEGIN
	INSERT @tbl_estoque_baixo (codigo, nome, qtd_estoque_baixo)SELECT codigo, nome, qtd_estoque 
	FROM produtos WHERE qtd_estoque < @qtd

 
	RETURN
END

------------------------------Chamada da Function - fn_tabela_estoque_baixo----------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM fn_tabela_estoque_baixo(8)



--------------------------------------------Exercício 03-----------------------------------------------
-------------------------------------------------------------------------------------------------------

-- 3) A partir das tabelas abaixo, faça:
-- Funcionário (Código, Nome, Salário)
--Dependendente (Código_Funcionário, Nome_Dependente, Salário_Dependente)

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE TABLE funcionarios (
codigo			INT NOT NULL,
nome			VARCHAR(100),
salario			DECIMAL(7,2),
PRIMARY KEY (codigo))

create table dependentes (
codigo_funcionario	INT,
codigo_dependente	INT NOT NULL,
nome_dependente		VARCHAR(100),
salario_dependente	DECIMAL(7,2)
primary key (codigo_dependente),
foreign key (codigo_funcionario) references funcionarios (codigo))

------------------------------------Inserção de Valores nas Tabelas------------------------------------
-------------------------------------------------------------------------------------------------------

INSERT INTO funcionarios VALUES 
(1,'FUNCIONARIO-01',1000),
(2,'FUNCIONARIO-02',2000),
(3,'FUNCIONARIO-03',3000),
(4,'FUNCIONARIO-04',4000),
(5,'FUNCIONARIO-05',5000)

INSERT INTO dependentes VALUES 
(1,100,'DEPENDENTE-01',100),
(1,200,'DEPENDENTE-02',200),
(2,300,'DEPENDENTE-03',300),
(2,400,'DEPENDENTE-04',400),
(3,500,'DEPENDENTE-05',500),
(3,600,'DEPENDENTE-06',600),
(4,700,'DEPENDENTE-07',700),
(4,800,'DEPENDENTE-08',800),
(5,900,'DEPENDENTE-09',900),
(5,1000,'DEPENDENTE-10',1000)

-------------------------------------------Select's Padrõe---------------------------------------------
-------------------------------------------------------------------------------------------------------

SELECT * FROM funcionarios;
SELECT * FROM dependentes;

--------------------------------------------Exercício 03-A---------------------------------------------
-------------------------------------------------------------------------------------------------------
-- a) Uma Function que Retorne uma tabela:(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, 
--    Salário_Dependente) 
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

--------------------------------Criação Function - fn_tabela_func_depen--------------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_tabela_func_depen()
RETURNS @tbl_func_depen TABLE(
codigo_funcionario	INT,
codigo_dependente	INT,
nome_funcionario	VARCHAR(100),
nome_dependente		VARCHAR(100),
salario_funcionario	DECIMAL(7,2),
salario_dependente	DECIMAL(7,2)
)

AS
BEGIN

	INSERT @tbl_func_depen (codigo_funcionario,codigo_dependente,nome_dependente, salario_dependente)
	SELECT codigo_funcionario,codigo_dependente,nome_dependente, salario_dependente FROM dependentes; 

	UPDATE @tbl_func_depen SET nome_funcionario = (SELECT nome FROM funcionarios WHERE codigo_funcionario = codigo);
	UPDATE @tbl_func_depen SET salario_funcionario = (SELECT salario FROM funcionarios WHERE codigo_funcionario = codigo);

	RETURN
END

------------------------------Chamada da Function - fn_tabela_func_depen()-----------------------------
-------------------------------------------------------------------------------------------------------

SELECT nome_funcionario,nome_dependente,salario_funcionario,salario_dependente FROM fn_tabela_func_depen();


--------------------------------------------Exercício 03-B---------------------------------------------
-------------------------------------------------------------------------------------------------------
-- b) Uma Scalar Function que Retorne a soma dos Salários dos dependentes, mais a do funcionário.
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

----------------------------Criação Function - fn_soma_salarios_func_depen()---------------------------
-------------------------------------------------------------------------------------------------------

CREATE FUNCTION fn_soma_salarios_func_depen(@codigo_funcionario INT)
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @soma_total DECIMAL(7,2) 
	SET @soma_total = (SELECT salario FROM funcionarios WHERE codigo=@codigo_funcionario)+
					  (SELECT sum(salario_dependente) FROM dependentes WHERE codigo_funcionario=@codigo_funcionario)
	RETURN @soma_total		
END

---------------------------Chamada da Function - fn_soma_salarios_func_depen()-------------------------
-------------------------------------------------------------------------------------------------------

SELECT dbo.fn_soma_salarios_func_depen(1) AS Smona_salarios

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

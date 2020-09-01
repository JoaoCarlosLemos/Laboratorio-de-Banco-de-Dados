-- Exercícios da Terceira Aula LAB. DE BANCO DE DADOS - (Procedure em SQL-Server) 31-08-2020

-------------------------------------------------------------------------------------------------------
---------------------------------------------Exercício 01----------------------------------------------

-- Criar um database, fazer uma tabela cadastro (cpf, nome, rua, numero e cep)
-- com uma procedure que só permitirá a inserção dos dados se o CPF for válido, 
-- caso contrário retornar uma mensagem de erro

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------



-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE ExercicioProcedureCpf
GO
USE ExercicioProcedureCpf

CREATE TABLE cadastro (
cpf		            VARCHAR(11)		NOT NULL,
nome		        VARCHAR(70)	    NOT NULL,
rua  	            VARCHAR(70)		NOT NULL,
numero  	        INT     		NOT NULL,
cep  	            VARCHAR(8)		NOT NULL
PRIMARY KEY (cpf))                       

--------------------------------------Procedure Validação de CPF---------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_validacao_cpf (@cpf VARCHAR(11),@resultado VARCHAR(8) OUTPUT)
AS
	DECLARE   @indice    INT,
			  @soma      INT,
			  @digito1   INT,
			  @digito2   INT
          

	--Cálculo do 1º dígito

	SET @soma = 0
	SET @indice = 1

	WHILE (@indice <= 9)
	BEGIN
		SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@cpf,@indice,1)) * (11 - @indice);
		SET @indice = @indice + 1
	END

	SET @digito1 = 11 - (@soma % 11)

	IF @digito1 > 9
	BEGIN
		SET @digito1 = 0;
	END

	-- Cálculo do 2º dígito 

	SET @soma = 0
	SET @indice = 1

	WHILE (@indice <= 10)
	BEGIN
		SET @Soma = @Soma + CONVERT(INT,SUBSTRING(@cpf,@indice,1)) * (12 - @indice);
		SET @indice = @indice + 1
	END

	SET @digito2 = 11 - (@soma % 11)

	IF @digito2 > 9
	BEGIN
		SET @digito2 = 0;
	END

	-- Validacão

	IF (@digito1 = SUBSTRING(@cpf,LEN(@cpf)-1,1)) AND (@digito2 = SUBSTRING(@cpf,LEN(@cpf),1))
	BEGIN
		SET @resultado = 'VALIDO'
		--PRINT @resultado
	END
	ELSE
	BEGIN
		SET @resultado = 'INVALIDO'
		--PRINT @resultado
	END


----------------------------------Procedure Insert na tabela Cadastro----------------------------------
-------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_inset_cadastro (@cpf VARCHAR(11),@nome VARCHAR(70),@rua VARCHAR(70),@numero INT,
									@cep VARCHAR(8))
AS
	DECLARE @out VARCHAR(8)

	EXEC sp_validacao_cpf @cpf, @out OUTPUT


	IF(@out = 'VALIDO')
	BEGIN
		INSERT INTO cadastro VALUES
		(@cpf,@nome,@rua,@numero,@cep)
	END
	ELSE
	BEGIN
		IF(@out = 'INVALIDO')
		BEGIN
			RAISERROR('CPF INVÁLIDO, NÃO FOI POSSÍVEL INSERIR O REGISTRO', 16, 1)
		END
	END


----------------------------------Chamada da procedure insert_cadastro---------------------------------
-------------------------------------------------------------------------------------------------------

-- CPF Válido
EXEC sp_inset_cadastro '22233366638','João Carlos Lemos','Flor de Indio',138,'08061230'

-- CPF Inválido
EXEC sp_inset_cadastro '22233366639','Maria da Silva','Flor de Noiva',764,'08061265'


SELECT * FROM cadastro


-------------------------------------------------------------------------------------------------------
---------------------------------------------Exercício 02----------------------------------------------

/*
Criar uma database chamada academia, com 3 tabelas como seguem:

Aluno
|Codigo_aluno|Nome|

Atividade
|Codigo|Descrição|IMC|

Atividade
codigo      descricao                           imc
----------- ----------------------------------- --------
1           Corrida + Step                       18.5
2           Biceps + Costas + Pernas             24.9
3           Esteira + Biceps + Costas + Pernas   29.9
4           Bicicleta + Biceps + Costas + Pernas 34.9
5           Esteira + Bicicleta                  39.9                                                                                                                                                                    

Atividadesaluno
|Codigo_aluno|Altura|Peso|IMC|Atividade|

IMC = Peso (Kg) / Altura² (M)

Atividade: Buscar a PRIMEIRA atividade referente ao IMC imediatamente acima do calculado.
* Caso o IMC seja maior que 40, utilizar o código 5.

Criar uma Stored Procedure (sp_alunoatividades), com as seguintes regras:
 - Se, dos dados inseridos, o código for nulo, mas, existirem nome, altura, peso, deve-se inserir um 
 novo registro nas tabelas aluno e aluno atividade com o imc calculado e as atividades pelas 
 regras estabelecidas acima.
 - Se, dos dados inseridos, o nome for (ou não nulo), mas, existirem código, altura, peso, deve-se 
 verificar se aquele código existe na base de dados e atualizar a altura, o peso, o imc calculado e 
 as atividades pelas regras estabelecidas acima.
*/

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------


-----------------------------------------------DataBase------------------------------------------------
-------------------------------------------------------------------------------------------------------


CREATE DATABASE Academia
GO
USE Academia


CREATE TABLE aluno (
codigo_aluno  	    INT     		NOT NULL,
nome		        VARCHAR(70)	    NULL
PRIMARY KEY (Codigo_aluno)) 


CREATE TABLE atividade (
codigo_atividade  	    INT     		NOT NULL,
descricao		        VARCHAR(70)	    NOT NULL,
imc                     DECIMAL(7,1)	NULL
PRIMARY KEY (Codigo_atividade))


CREATE TABLE Atividadesaluno (
codigo_aluno		INT				NOT NULL,
altura				DECIMAL(7,2)	NULL,
peso				DECIMAL(7,2)    NULL,
imc					DECIMAL(7,1)    NULL,
codigo_atividade  	INT			    NOT NULL
PRIMARY KEY (codigo_aluno,codigo_atividade),
FOREIGN KEY (codigo_aluno) REFERENCES aluno (codigo_aluno),
FOREIGN KEY (codigo_atividade) REFERENCES atividade (codigo_atividade))


-----------------------------------------Inserção de Regidtros-----------------------------------------
-------------------------------------------------------------------------------------------------------

INSERT INTO atividade VALUES 
(1, 'Corrida + Step',18.5),
(2, 'Biceps + Costas + Pernas',24.9),
(3, 'Esteira + Biceps + Costas + Pernas ',29.9),
(4, 'Bicicleta + Biceps + Costas + Pernas',34.9),
(5, 'Esteira + Bicicleta',39.9)

INSERT INTO aluno VALUES 
(1, 'João Carlos'),
(2,'Ana Maria')

--------------------------------------Procedure do Calculo do IMC--------------------------------------
-------------------------------------------------------------------------------------------------------


CREATE PROCEDURE sp_calculo_imc (@altura DECIMAL(7,2),@peso	DECIMAL(7,2),@imc DECIMAL(7,1) OUTPUT)
AS
	SET @imc= @peso/(POWER(@altura,2))


----------------------------Procedure de inserção na tabela atividadeAluno-----------------------------
-------------------------------------------------------------------------------------------------------


CREATE PROCEDURE sp_alunoatividades (@codigo_aluno INT,@nome VARCHAR(70),@altura DECIMAL(7,2),@peso DECIMAL(7,2))
AS	
	DECLARE @imc								DECIMAL(7,1),    
			@codigo_atividade		 			INT,
			@verificacao_codigo_aluno			INT
		


	-- Condicional (codigo_aluno = NULL) AND (nome,altura,peso = IS NOT NULL)
	IF(@codigo_aluno IS NULL AND @nome IS NOT NULL AND @altura IS NOT NULL AND @peso IS NOT NULL)
	BEGIN
		SET @codigo_aluno= (SELECT MAX(codigo_aluno)FROM aluno) +1
		INSERT INTO aluno VALUES (@codigo_aluno,@nome)
	END
	ELSE
	BEGIN
		--verificar se aquele código existe na tabela aluno
		SET @verificacao_codigo_aluno= (SELECT COUNT(codigo_aluno) FROM aluno WHERE codigo_aluno=@codigo_aluno)

		--se não existir, fazer INSERT na tabela aluno
		IF(@verificacao_codigo_aluno=0)
		BEGIN
			INSERT INTO aluno VALUES (@codigo_aluno,@nome)
			SET @verificacao_codigo_aluno=NULL
		END
	END

	-- Chamada da Procedure do calculo do imc
	EXEC sp_calculo_imc @altura,@peso, @imc OUTPUT

	-- Condicional ((nome = NULL) OR (nome = IS NOT NULL)) AND (codigo_aluno,altura,peso = IS NOT NULL)
	IF(@nome IS NOT NULL OR @nome IS NULL AND @codigo_aluno IS NOT NULL AND @altura IS NOT NULL AND @peso IS NOT NULL)
	BEGIN

		--verificar se aquele código existe na base de dados
		SET @verificacao_codigo_aluno= (SELECT COUNT(codigo_aluno) FROM Atividadesaluno WHERE codigo_aluno=@codigo_aluno)

		-- se existir o codigo, fazer UPDATE
		IF(@verificacao_codigo_aluno=1)
		BEGIN
			IF(@imc>=18.5 AND @imc<24.9)
			BEGIN
				SET @codigo_atividade=1
				UPDATE Atividadesaluno SET altura=@altura, peso=@peso,imc=@imc,codigo_atividade=@codigo_atividade WHERE codigo_aluno=@codigo_aluno
			END
			ELSE
			BEGIN
				IF(@imc>=24.9 AND @imc<29.9)
				BEGIN
					SET @codigo_atividade=2
					UPDATE Atividadesaluno SET altura=@altura, peso=@peso,imc=@imc,codigo_atividade=@codigo_atividade WHERE codigo_aluno=@codigo_aluno
				END
				ELSE
				BEGIN
					IF(@imc>=29.9 AND @imc<34.9)
					BEGIN
						SET @codigo_atividade=3
						UPDATE Atividadesaluno SET altura=@altura, peso=@peso,imc=@imc,codigo_atividade=@codigo_atividade WHERE codigo_aluno=@codigo_aluno
					END
					ELSE
					BEGIN
						IF(@imc>=34.9 AND @imc<39.9)
						BEGIN
							SET @codigo_atividade=4
							UPDATE Atividadesaluno SET altura=@altura, peso=@peso,imc=@imc,codigo_atividade=@codigo_atividade WHERE codigo_aluno=@codigo_aluno
						END
						ELSE
						BEGIN
							IF(@imc>=39.9)
							BEGIN
								SET @codigo_atividade=5
								UPDATE Atividadesaluno SET altura=@altura, peso=@peso,imc=@imc,codigo_atividade=@codigo_atividade WHERE codigo_aluno=@codigo_aluno
							END
						END
					END
				END
			END
		END

		-- se não existir o codigo, fazer INSERT
		ELSE
		BEGIN
			IF(@imc>=18.5 AND @imc<24.9)
			BEGIN
				SET @codigo_atividade=1
				INSERT INTO Atividadesaluno VALUES(@codigo_aluno,@altura,@peso,@imc,@codigo_atividade)
			END
			ELSE
			BEGIN
				IF(@imc>=24.9 AND @imc<29.9)
				BEGIN
					SET @codigo_atividade=2
					INSERT INTO Atividadesaluno VALUES(@codigo_aluno,@altura,@peso,@imc,@codigo_atividade)
				END
				ELSE
				BEGIN
					IF(@imc>=29.9 AND @imc<34.9)
					BEGIN
						SET @codigo_atividade=3
						INSERT INTO Atividadesaluno VALUES(@codigo_aluno,@altura,@peso,@imc,@codigo_atividade)
					END
					ELSE
					BEGIN
						IF(@imc>=34.9 AND @imc<39.9)
						BEGIN
							SET @codigo_atividade=4
							INSERT INTO Atividadesaluno VALUES(@codigo_aluno,@altura,@peso,@imc,@codigo_atividade)
						END
						ELSE
						BEGIN
							IF(@imc>=39.9)
							BEGIN
								SET @codigo_atividade=5
								INSERT INTO Atividadesaluno VALUES(@codigo_aluno,@altura,@peso,@imc,@codigo_atividade)
							END
						END
					END
				END
			END
		END
	END 

			 
--------------------------------------View (v_atividades_alunos)---------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE VIEW v_atividades_alunos
AS

SELECT Atividadesaluno.codigo_aluno,aluno.nome,Atividadesaluno.altura,Atividadesaluno.peso,Atividadesaluno.imc,
       Atividadesaluno.codigo_atividade,atividade.descricao AS 'descrição_atividade'FROM atividadesaluno
INNER JOIN aluno     ON  aluno.codigo_aluno         = Atividadesaluno.codigo_aluno
INNER JOIN atividade ON  atividade.codigo_atividade = Atividadesaluno.codigo_atividade


-------------------------------Chamada da Procedure (sp_alunoatividades)-------------------------------
-------------------------------------------------------------------------------------------------------

--Parâmetros = codigo_aluno INT, nome VARCHAR(70), altura DECIMSAL(7,2), peso DECIMAL(7,2)

--codigo existente na tabela aluno
EXEC sp_alunoatividades 1,'João Carlos',1.80,129

--codigo não existente na tabela aluno
EXEC sp_alunoatividades 5,'mariana',1.60,71

----------------------------------Chamada View (v_atividades_alunos)-----------------------------------
----------------------------------------------Select (aluno)-------------------------------------------

SELECT * FROM v_atividades_alunos
SELECT * FROM aluno

--------------------------------------------------------------------------------------------------------
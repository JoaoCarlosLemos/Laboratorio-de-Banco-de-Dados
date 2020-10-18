-- AVALIAÇÃO - 01 LAB. DE BANCO DE DADOS - (19-10-2020)

---------------------------------------------------------------AVALIAÇÃO - 01----------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
/*
No Carnaval 2013 da cidade de São Paulo, participaram 14 Escolas de Samba (Acadêmicos do Tatuapé, Rosas de Ouro, Mancha Verde, Vai‐Vai, 
X‐9 Paulistana, Dragões da Real, Águia de Ouro, Nenê de Vila Matilde, Gaviões da Fiel, Mocidade Alegre, Tom Maior, Unidos de Vila Maria, 
Acadêmicos do Tucuruvi, Império de Casa Verde). Para melhorar a interatividade com o espectador, canais de televisão e sites de internet, 
fizeram sistemas de atualização dos totais, nota a nota. A proposta é como segue: 
O sistema precisa ter uma base de dados para os 9 quesitos (id e nome), que foram, Comissão de Frente, Evolução, Fantasia, Bateria, Alegoria, 
Harmonia, Samba‐Enredo, Mestre‐Sala e Porta‐Bandeira e Enredo. É necessário uma base de dados para os jurados, que julgarão um ou mais 
quesitos e, precisa‐se saber, para o quesito que o jurado julgará, se ele é o 1º, 2º, 3º, 4º ou 5º jurado. Como se percebe, cada escola 
terá 5 notas por quesito. É preciso também, persistir as escolas de samba, por um id e nome e total de pontos. 
Por regra deste ano, das 5 notas que cada escola receberá, por quesito, serão descartadas a maior e a menor, sendo que, as 3 restantes, 
somadas, farão a composição da nota do quesito 
Cada quesito virará uma tabela que leva o id da escola, as 5 notas, a menor descartada, a maior descartada e a nota total. 
A inserção de dados nas tabelas quesitos, se dará por uma Stored Procedure que segue as especificações da emissora que detém os direitos de 
transmissão do evento. As notas são inseridas, uma a uma, por jurado em cada quesito. A partir da inserção das notas do 3º jurado de cada 
quesito, a tabela já deverá conter também quais notas serão descartadas e a nota final, que deverão se atualizar no momento da inserção das 
notas dos jurados 4 e 5. No momento da atualização da coluna de nota total, a coluna total de pontos da tabela escola também deve ser 
atualizada. 
Para agilizar o processo, uma vez que transmissão de televisão deve ser dinâmica,  os     ComboBox devem ir, automaticamente, mudando seus 
valores, conforme a inserção. Uma vez selecionado o primeiro quesito, o  ComboBox Jurado deve identificar o primeiro jurado daquele quesito 
e a primeira escola a receber nota. Uma vez que a primeira escola receber a nota,   o   ComboBox Escola deve mostrar a segunda escola e, 
assim sucessivamente, até a última escola daquele jurado. Nesse momento, o JComboBox deve trazer o segundo jurado e, assim sucessivamente, 
até que todas as notas dos jurados, daquele quesito, tenham sido inseridas, onde  o  ComboBox Quesito deverá trazer o próximo quesito. 
A qualquer instante, o usuário pode clicar em Ver Quesito e receber  umA tela com as notas de todas as escolas naquele quesito, inclusive as 
descartadas e o total, se já houverem. 
A qualquer instante, o usuário pode clicar em Ver Total e recebber uma tela com as notas totais, somadas, de todos os quesitos, ordenadas 
pela maior nota (ordenação deverá vir do Banco de Dados). 
** Desenvolvido por até 2 alunos. Códigos repetidos  em avaliações diferentes anularão todas as que apresentarem o código repetido.
Data da entrega do projeto, apresentação da execução do software, workspace eclipse e base de dados SQL Server para avaliação do professor:

19/10
Avaliações feitas em J2SE ( 0,0 - 9,0)
Avaliações feitas em J2EE (0,0 - 10,0)
*/

------------------------------------------------------------------DataBase-------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

Create Database CARNAVAL_vs1
GO
Use CARNAVAL_vs1

Create Table Escola_de_Samba(
		id Int Identity Not Null Primary Key,
		nome Varchar(100),
		total_pontos Decimal (5,1))
		
Create  Table Jurados(                       
		id Int Not Null Primary Key,
		nome varchar (100))

Create Table Quesito(
		id Int Identity Not Null Primary Key,
		nome varchar (100))

Create Table Apuracao(
	id Int  Not Null Primary Key,
	id_jurado Int Not Null references Jurados (id),
	id_escola Int Not Null references Escola_de_Samba (id),
	id_Quesito Int Not Null references Quesito (id),
	nota_1 Decimal(5,1),
	nota_2 Decimal(5,1),
	nota_3 Decimal(5,1),
	nota_4 Decimal(5,1),
	nota_5 Decimal(5,1),
	menor Decimal(5,1),
	maior Decimal(5,1),
	total Decimal(5,1))

--------------------------------------------------------Inserção de Valores na Tabela--------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

Insert Into Escola_de_Samba Values
	('Acadêmicos do Tatuapé',0),
	('Acadêmicos do Tucuruvi',0),
	('Águia de Ouro',0),
	('Dragões da Real',0),
	('Gaviões da Fiel',0),
	('Império de Casa Verde',0),
	('Mancha Verde',0),
	('Mocidade Alegre',0),
	('Nenê de Vila Matilde',0),
	('Rosas de Ouro',0),
	('Tom Maior',0),
	('Unidos de Vila Maria',0),
	('Vai-Vai',0),
	('X-9 Paulistana',0)

Insert Into Jurados values 
(1,'ana'), (2,'pedro'), (3,'maria'), (4,'carlos'), (5,'edna')
		
Insert Into Quesito Values 
('Comissão de Frente'),
('Evolução'),
('Fantasia'),
('Bateria'),
('Alegoria'),
('Harmonia'),
('Samba-Enredo'),
('Mestre-Sala e Porta-Bandeira'),
('Enredo')

-----------------------------------------------------------Procedure - Proóximo ID-----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_proximoid(@proximoId INT OUTPUT)
AS
	DECLARE	@cont INT
 
	SET @cont = (SELECT COUNT(*) FROM Apuracao)
	IF (@cont = 0)
	BEGIN
		SET @proximoId = 1
	END
	ELSE
	BEGIN
		SET @proximoId = (SELECT MAX(id) + 1 FROM Apuracao)
	END

------------------------------------------------------Procedure - Verifica a Maior Nota------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_maior( @nota_1 DECIMAL(5,1), @nota_2 DECIMAL(5,1), @saida DECIMAL(5,1) OUTPUT)
AS 
	IF(@nota_2 >= @nota_1)
	BEGIN
		SET @saida = @nota_2			
	END
	ELSE
	BEGIN
		SET @saida = @nota_1
	END

------------------------------------------------------Procedure - Verifica a Menor Nota------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_menor( @nota_1 DECIMAL(5,1), @nota_2 DECIMAL(5,1),@saida DECIMAL(5,1) OUTPUT)
AS 
	IF(@nota_2 <= @nota_1)
	BEGIN
		SET @saida = @nota_2				
	END
	ELSE
	BEGIN
		SET @saida = @nota_1
	END

-------------------------------------------------------Procedure - Calcula Nota Total--------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE sp_calculaTotal( @id_escola DECIMAL (5,1) )
AS 
	DECLARE @nota_total DECIMAL (5,1)
	
	SET @nota_total = (SELECT SUM (Apuracao.total) FROM Apuracao  INNER JOIN Escola_de_Samba  
	ON Escola_de_Samba.id = Apuracao.id_escola WHERE id_escola = @id_escola)

	UPDATE Escola_de_Samba
	SET total_pontos = @nota_total WHERE id=@id_escola

--------------------------------------------------------Procedure - Apuração dos votos-------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 
CREATE PROCEDURE sp_apuracao (@id_jurado INT, @id_escola INT,@id_quesito INT,@nota DECIMAL(5,1))
AS
	DECLARE @proximoId	INT,
			@nota_1		Decimal(5,1),
			@nota_2		Decimal(5,1),
			@nota_3		Decimal(5,1),
			@nota_4		Decimal(5,1),
			@nota_5		Decimal(5,1),
			@menor		Decimal(5,1),
			@maior		Decimal(5,1),
			@saida		Decimal(5,1),
			@total		Decimal(5,1),
			@totalGeral Decimal(5,1)
 
	IF(@id_jurado=1)
	BEGIN
		EXEC sp_proximoid @proximoId OUTPUT
		INSERT INTO Apuracao (id, id_jurado, id_escola,id_quesito,nota_1) VALUES (@proximoId, @id_jurado, @id_escola, @id_quesito, @nota)
	END
	ELSE
	BEGIN
		IF(@id_jurado=2)
		BEGIN
			UPDATE Apuracao 
			SET id_escola=@id_escola,id_quesito=@id_quesito,nota_2=@nota
			WHERE (id_escola=@id_escola AND id_quesito=@id_quesito)
		END
		ELSE
		BEGIN
			IF(@id_jurado=3)
			BEGIN
			 
				SET @nota_1=(SELECT nota_1 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
				SET @nota_2=(SELECT nota_2 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
				SET @nota_3=@nota

				EXEC sp_maior @nota_1, @nota_2, @saida OUTPUT
				SET @maior=@saida
				EXEC sp_maior @maior, @nota_3, @saida OUTPUT
				SET @maior=@saida
				SET @saida=0

				EXEC sp_menor @nota_1, @nota_2, @saida OUTPUT
				SET @menor=@saida
				EXEC sp_menor @menor, @nota_3, @saida OUTPUT
				SET @menor=@saida

				SET @total= @nota_1+@nota_2+@nota_3-(@maior+@menor)

				UPDATE Apuracao 
				SET id_escola=@id_escola,id_quesito=@id_quesito,nota_3=@nota,menor=@menor,maior=@maior,total=@total
				WHERE (id_escola=@id_escola AND id_quesito=@id_quesito)
				EXEC sp_calculaTotal @id_escola 
			END
			ELSE
			BEGIN
				IF(@id_jurado=4)
				BEGIN
					
					SET @nota_1=(SELECT nota_1 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_2=(SELECT nota_2 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_3=(SELECT nota_3 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_4=@nota
					SET @maior=(SELECT maior FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @menor=(SELECT menor FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))

					EXEC sp_maior @maior, @nota_4, @saida OUTPUT
					SET @maior=@saida
					SET @saida=0
					EXEC sp_menor @menor, @nota_4, @saida OUTPUT
					SET @menor=@saida

					SET @total= @nota_1+@nota_2+@nota_3+@nota_4-(@maior+@menor)

					UPDATE Apuracao 
					SET id_escola=@id_escola,id_quesito=@id_quesito,nota_4=@nota,menor=@menor,maior=@maior,total=@total
					WHERE (id_escola=@id_escola AND id_quesito=@id_quesito)
					EXEC sp_calculaTotal @id_escola 
				END
				ELSE
				BEGIN
					SET @nota_1=(SELECT nota_1 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_2=(SELECT nota_2 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_3=(SELECT nota_3 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_4=(SELECT nota_4 FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @nota_5=@nota
					SET @maior=(SELECT maior FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))
					SET @menor=(SELECT menor FROM Apuracao WHERE (id_escola=@id_escola AND id_quesito=@id_quesito))

					EXEC sp_maior @maior, @nota_5, @saida OUTPUT
					SET @maior=@saida
					SET @saida=0
					EXEC sp_menor @menor, @nota_5, @saida OUTPUT
					SET @menor=@saida

					SET @total= @nota_1+@nota_2+@nota_3+@nota_4+@nota_5-(@maior+@menor)
					
					UPDATE Apuracao 
					SET id_escola=@id_escola,id_quesito=@id_quesito,nota_5=@nota,menor=@menor,maior=@maior,total=@total
					WHERE (id_escola=@id_escola AND id_quesito=@id_quesito)
					EXEC sp_calculaTotal @id_escola 
				END
			END
		END
	END
		
---------------------------------------------------------------Select's Padrões--------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
 
SELECT * FROM Apuracao
SELECT * FROM Escola_de_Samba
SELECT * FROM Jurados
SELECT * FROM Quesito

-----------------------------------------------------------Select's de Verificação-----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

SELECT  Escola_de_Samba.nome AS Escola,Apuracao.nota_1,Apuracao.nota_2,Apuracao.nota_3,Apuracao.nota_4,Apuracao.nota_5,
		Apuracao.menor,Apuracao.maior,Apuracao.total FROM Apuracao
INNER JOIN  Jurados			ON Jurados.id = Apuracao.id_jurado
INNER JOIN Escola_de_Samba	ON Apuracao.id_escola = Escola_de_Samba.id
INNER JOIN Quesito			ON Apuracao.id_quesito = Quesito.id
 WHERE Quesito.id=1
ORDER BY Escola_de_Samba.nome

SELECT  Escola_de_Samba.nome AS Escola,Escola_de_Samba.total_pontos AS Total FROM Escola_de_Samba
ORDER BY  Escola_de_Samba.total_pontos DESC



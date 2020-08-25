
-- Exerc�cios da Segunda Aula LAB. DE BANCO DE DADOS - (Programa��o em SQL-Server) 24-08-2020


------------------------------------------------------------------------------------------------------
-- Exerc�cio 01 - Fazer um algoritmo que, dado 1 n�mero, mostre se � m�ltiplo de 2,3,5 ou nenhum deles
------------------------------------------------------------------------------------------------------

DECLARE @numero INT
SET @numero = 7

IF (@numero % 2 = 0 )
BEGIN
	PRINT CAST(@numero AS CHAR(2))+' � MULTIPLO DE 2'
END
ELSE
BEGIN
	PRINT CAST(@numero AS CHAR(2))+' N�O � MULTIPLO DE 2'
END


IF (@numero % 3 = 0 )
BEGIN
	PRINT CAST(@numero AS CHAR(2))+' � MULTIPLO DE 3'
END
ELSE
BEGIN
	PRINT CAST(@numero AS CHAR(2))+' N�O � MULTIPLO DE 3'
END

IF (@numero % 5 = 0 )
BEGIN
	PRINT CAST(@numero AS CHAR(2))+' � MULTIPLO DE 5'
END
ELSE
BEGIN
	PRINT CAST(@numero AS CHAR(2))+' N�O � MULTIPLO DE 5'
END


------------------------------------------------------------------------------------
-- Exerc�cio 02 - Fazer um algoritmo que, dados 3 n�meros, mostre o maior e o menor
------------------------------------------------------------------------------------

DECLARE @numero_a INT,
        @numero_b INT,
		@numero_c INT

SET @numero_a = 10
SET @numero_b = 9
SET @numero_c = 8

IF(@numero_a > @numero_b AND @numero_a > @numero_c)
BEGIN
	PRINT CAST(@numero_a AS CHAR(2))+' � O MAIOR NUMERO'
END
ELSE
BEGIN
	IF(@numero_b > @numero_a AND @numero_b > @numero_c)
	BEGIN
		PRINT CAST(@numero_b AS CHAR(2))+' � O MAIOR NUMERO'
	END
	ELSE
	BEGIN
		PRINT CAST(@numero_c AS CHAR(2))+' � O MAIOR NUMERO'
	END
END

IF(@numero_a < @numero_b AND @numero_a < @numero_c)
BEGIN
	PRINT CAST(@numero_a AS CHAR(2))+' � O MENOR NUMERO'
END
ELSE
BEGIN
	IF(@numero_b < @numero_a AND @numero_b < @numero_c)
	BEGIN
		PRINT CAST(@numero_b AS CHAR(2))+' � O MENOR NUMERO'
	END
	ELSE
	BEGIN
		PRINT CAST(@numero_c AS CHAR(2))+' � O MENOR NUMERO'
	END
END

------------------------------------------------------------------------------------------------------------------------------
-- Exerc�cio 03 - Fazer um algoritmo que calcule os 15 primeiros termos da s�rie de Fibonacci e a soma dos 15 primeiros termos
------------------------------------------------------------------------------------------------------------------------------

DECLARE @v1   INT,
        @v2   INT,
		@v3   INT,
		@cont INT 

SET @v1  = -1
SET @v2  =  1
SET @cont=  0

WHILE (@cont < 15)
BEGIN
	SET @v3=@v1+@v2
	SET @v1=@v2
	SET @v2=@V3
	PRINT @v3
	SET @cont=@cont+1
END

------------------------------------------------------------------------------------------------------------------------------------------
-- Exerc�cio 04 - Fazer um algoritmo que separa uma frase, imprimindo todas as letras em mai�sculo e, depois imprimindo todas em min�sculo
------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @frase VARCHAR(MAX),
        @letra CHAR(1),
		@cont  INT,
		@i     INT,
		@limite INT

SET @cont = 0
SET @i    = 0
SET @frase='-Jo�o Carlos-'
SET @limite=LEN(@frase) 

WHILE (@cont < @limite)
BEGIN
	SET @letra=SUBSTRING(@frase,@cont+1,1)

	IF(@i<=@limite)
	BEGIN
		PRINT UPPER(@letra)
		SET @i=@i+1

		IF(@i=@limite)
		BEGIN
			SET @cont=-1
			SET @i=@i+1
		END

	END
	ELSE
	BEGIN
		PRINT LOWER(@letra)
	END

	SET @cont=@cont+1
END

---------------------------------------------------------------------------------------------
-- Exerc�cio 05 - Fazer um algoritmo que verifica, dada uma palavra, se �, ou n�o, pal�ndromo
---------------------------------------------------------------------------------------------


/*
	Um pal�ndromo � uma palavra, frase ou qualquer outra sequ�ncia de unidades que tenha a 
	propriedade de poder ser lida tanto da direita para a esquerda como da esquerda para a 
	direita

	Exemplos

	----------------------------------------palavras----------------------------------------

	ele - esse - oco - osso - ovo - radar - reviver - rir - rodador - saias - salas - socos

	-----------------------------------------frases-----------------------------------------

	o lobo ama o bolo - a sacada da casa - a torre da derrota

	----------------------------------------------------------------------------------------
*/

DECLARE @frase VARCHAR(MAX),
	    @juncao VARCHAR(MAX),
		@reverso VARCHAR(MAX)

SET @frase='O Lobo Ama o Bolo'
SET @juncao=LOWER(REPLACE(@frase,' ',''))
SET @reverso=REVERSE(@juncao)

PRINT 'O INVERSO DE: '+CAST(@juncao AS VARCHAR(MAX))+ '  �: '+CAST(@reverso AS VARCHAR(MAX))

IF(@juncao=@reverso)
BEGIN
	PRINT '************ TEMOS UM PALINDROMO ************'
END
ELSE
BEGIN
	PRINT'*********** N�O TEMOS UM PALINDROMO **********'
END

-----------------------------------------------------------------------
-- Exerc�cio 06 - Fazer um algoritmo que, dado um CPF diga se � v�lido
-----------------------------------------------------------------------

DECLARE   @indice    INT,
          @soma      INT,
          @digito1   INT,
          @digito2   INT,
          @cpf       VARCHAR(11),
          @resultado VARCHAR(8)
          
SET @cpf='22233366638'

--C�lculo do 1� d�gito

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

-- C�lculo do 2� d�gito 

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

-- Validac�o

IF (@digito1 = SUBSTRING(@cpf,LEN(@cpf)-1,1)) AND (@digito2 = SUBSTRING(@cpf,LEN(@cpf),1))
BEGIN
	SET @resultado = 'VALIDO'
	PRINT @resultado
END
ELSE
BEGIN
	SET @resultado = 'INVALIDO'
	PRINT @resultado
END

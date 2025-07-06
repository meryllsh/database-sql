--1
ALTER PROCEDURE sp_num @num1 INTEGER,
@num2 INTEGER,
@letter CHAR(1)
AS
BEGIN
DECLARE @A INTEGER, @S INTEGER, @M INTEGER, @D INTEGER;
IF @letter = 'A'
BEGIN
SET @A = @num1 + @num2;
END
ELSE IF @letter = 'S'
BEGIN
SET @S = @num1 - @num2;
END
ELSE IF @letter = 'M'
BEGIN
SET @M = @num1 * @num2;
END
ELSE IF @letter = 'D'
BEGIN
SET @D = @num1 / @num2;
END
ELSE 
BEGIN
PRINT 'Invalid value for @letter. Please use A, S, M, or D.';
END
PRINT 'The addition is ' + CAST(@A AS VARCHAR(4));
PRINT 'The subtraction is ' + CAST(@S AS VARCHAR(4));
PRINT 'The multiplication is ' + CAST(@M AS VARCHAR(4));
PRINT 'The division is ' + CAST(@D AS VARCHAR(4));
END;

EXEC sp_num 10, 20, A

--2
ALTER PROCEDURE sp_f2c @fhr FLOAT
AS
BEGIN
DECLARE @cnt FLOAT;
SET @cnt = ( ( 5 * @fhr ) - 160 ) / 9;
PRINT 'The value from fahrenheit to Centigrade is: ' + CAST(@cnt AS VARCHAR(4));
END;

ALTER PROCEDURE sp_c2f @cnt FLOAT
AS
BEGIN
DECLARE @fhr FLOAT;
SET @fhr = ( ( 9 * @cnt ) + 160 ) / 5;
PRINT 'The value from Centigrade to fahrenheit is: ' + CAST(@fhr AS VARCHAR(4));
END;

EXEC sp_f2c 32 
EXEC sp_c2f 32

--3
CREATE PROCEDURE sp_convert @letter CHAR(1),
@num FLOAT
AS
BEGIN
DECLARE @fhr FLOAT, @cnt FLOAT;
IF @letter = 'C'
BEGIN
SET @fhr = ( ( 9 * @num ) + 160 ) / 5;
PRINT 'The value from Centigrade to fahrenheit is: ' + CAST(@fhr AS VARCHAR(20));
END
ELSE IF @letter = 'F'
BEGIN
SET @cnt = ( ( 5 * @num ) - 160 ) / 9;
PRINT 'The value from fahrenheit to Centigrade is: ' + CAST(@cnt AS VARCHAR(20));
END 
ELSE 
BEGIN
PRINT 'Invalid @letter. Please type C or F for conversion.';
END
END;

EXEC sp_convert F, 32

--4
CREATE PROCEDURE sp_perimeter @form VARCHAR(20),
@num1 FLOAT,
@num2 FLOAT,
@num3 FLOAT
AS 
BEGIN
IF @form='square'
BEGIN
DECLARE @square FLOAT;
SET @square = @num1*4;
PRINT 'The perimenter is ' + CAST(@square AS VARCHAR(10));
END
ELSE IF @form='circle'
BEGIN 
DECLARE @circle FLOAT;
SET @circle = 2 * 3.142 * @num1;
PRINT 'The perimeter is ' + CAST(@circle AS VARCHAR(10));
END
ELSE IF @form='triangle'
BEGIN
DECLARE @triangle FLOAT;
SET @triangle = @num1 + @num2 + @num3;
PRINT 'The perimeter is ' + CAST(@triangle AS VARCHAR(10));
END
END;

EXEC sp_perimeter square, 5, 0, 0

--5
ALTER PROCEDURE sp_vat @sentence VARCHAR(20),
@price FLOAT
AS
BEGIN
DECLARE @num FLOAT, @num1 FLOAT;
IF (@sentence = 'Medicine' OR @sentence = 'Baby Food')
BEGIN
PRINT 'The final price is ' + CAST(@price AS VARCHAR(4));
END
ELSE IF (@sentence = 'Food' OR @sentence = 'Clothing')
BEGIN
SET @num = ( 0.10 * @price ) + @price;
PRINT 'The final price is ' + CAST(@num AS VARCHAR(4));
END
ELSE
BEGIN
SET @num1 = ( 0.15 * @price ) + @price;
PRINT 'The final price is ' + CAST(@num1 AS VARCHAR(4));
END
END;

EXEC sp_vat M, 200

--6
ALTER PROCEDURE sp_sum_all @num1 INTEGER,
@num2 INTEGER
AS
BEGIN
DECLARE @sum1 INTEGER, @total INTEGER;
SET @sum1=0; 
SET @total=0;
WHILE @num1<=@num2
BEGIN
SET @sum1 = @num1 * @num1;
SET @total = @total + @sum1;
SET @num1 = @num1 + 1;
END
PRINT 'The sum are: ' + CAST(@total AS VARCHAR(4));
END;

EXEC sp_sum_all 2, 5 

--7
ALTER PROCEDURE sp_square_integer_loop @num1 INTEGER
AS
BEGIN
WHILE @num1<=1000
BEGIN
SET @num1 = @num1 * @num1;
END
PRINT 'The sum is: ' + CAST(@num1 AS VARCHAR(30));
END;

EXEC sp_square_integer_loop 3



















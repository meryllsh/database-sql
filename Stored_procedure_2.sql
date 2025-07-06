CREATE TABLE book
( 
  isbn integer NOT NULL,
  title VARCHAR(40) NOT NULL,
  author_id integer,
  cpright_date datetime,
  CONSTRAINT books_pkey PRIMARY KEY (isbn)
)
;

CREATE TABLE author
(
  a_id integer NOT NULL,
  lastname VARCHAR(20) NOT NULL,
  firstname VARCHAR(20),
  email VARCHAR(30),
  CONSTRAINT author_pkey PRIMARY KEY (a_id)
)
;

CREATE TABLE publisher
(
  isbn integer NOT NULL,
  publ_name VARCHAR(30) NOT NULL,
  sugg_price real,
  CONSTRAINT publisher_pkey PRIMARY KEY (isbn, publ_name),
  CONSTRAINT publisher_isbn_key UNIQUE (isbn)
)
;

INSERT INTO book VALUES (8741205, 'The Cat in the Hat', 110, '1972-04-29');
INSERT INTO book VALUES (2567841, 'Little Women', 231, '1980-02-15');
INSERT INTO book VALUES (214872, 'Franklin in the Dark', 142, '1986-09-22');
INSERT INTO book VALUES (602071,  'Goodnight Moon', 136, '1991-04-01');
INSERT INTO book VALUES (355184,  'Bartholomew and the Oobleck', 110, '1997-02-01');
INSERT INTO book VALUES (676883,  'The Velveteen Rabbit', 220, '1958-02-06');

INSERT INTO author VALUES(136, 'Brown', 'Margaret W.', 'mwbrown@littletykes.com');
INSERT INTO author VALUES(220, 'Williams', 'Margary', 'mwilliams@goto.com');
INSERT INTO author VALUES(142, 'Burgeous', 'Paulette', 'pburgeous@yahoo.com');
INSERT INTO author VALUES(110, 'Seuss', 'Johnathan', 'jseuss@childprodigy.com');
INSERT INTO author VALUES(231, 'Alcott', 'Louisa May', 'lalcott@bestbooks.com');


INSERT INTO publisher VALUES(2567841, 'ODG Books', 12.99);
INSERT INTO publisher VALUES(8741205, 'Children''s Books', 19.99);
INSERT INTO publisher VALUES(602071, 'ABC Books', 4.55);
INSERT INTO publisher VALUES(676883, 'Reading Rainbow', 13.29);
INSERT INTO publisher VALUES(355184, 'ABC Books', 16.85);
INSERT INTO publisher VALUES(214872, 'Young Readers', 6.00);


CREATE TABLE squares(
    Number INTEGER,
    Square INTEGER,
);


--1
ALTER PROCEDURE sp_numSquares @numLast INTEGER
AS
BEGIN
DELETE FROM squares
DECLARE @count INTEGER, @square INTEGER;
SET @count=1;
WHILE @count<=@numLast
BEGIN
SET @square=@count*@count;
INSERT INTO squares VALUES(@count,@square);
SET @count=@count+1;
END
END;

EXEC sp_numSquares 6
SELECT * FROM squares

--2
ALTER PROCEDURE sp_disp_title @isbn INTEGER
AS
BEGIN
SELECT title
FROM book
WHERE @isbn=isbn
END;

EXEC sp_disp_title 8741205

--3
ALTER PROCEDURE sp_disp_auth @isbn INTEGER
AS
BEGIN
DECLARE @firstname VARCHAR(20), @lastname VARCHAR(20);
SELECT @firstname=author.firstname, @lastname=author.lastname
FROM author, book
WHERE author.a_id=book.author_id
AND isbn=@isbn
PRINT 'The author is ' + CONCAT(@firstname,' ',@lastname)
END;

EXEC sp_disp_auth 8741205


--4
ALTER PROCEDURE sp_ins_book_details @lname VARCHAR(20), @fname VARCHAR(20), @isbn INTEGER, @title VARCHAR(40), @cpright_date DATE, @publ_name VARCHAR(30), @sugg_price FLOAT
AS
BEGIN
DECLARE @mauthorid INTEGER, @a_id INTEGER

SET @a_id=(SELECT a_id
FROM author
WHERE @fname=firstname
AND @lname=lastname)

IF @@ROWCOUNT=0
BEGIN
SET @mauthorid=(SELECT MAX(a_id) FROM author)

INSERT INTO book(isbn, title, author_id, cpright_date)
VALUES(@isbn, @title, @mauthorid+1, @cpright_date)

INSERT INTO author(a_id, lastname, firstname, email)
VALUES(@mauthorid+1, @lname, @fname, NULL)

INSERT INTO publisher(isbn, publ_name, sugg_price)
VALUES(@isbn, @publ_name, @sugg_price)

PRINT 'The values have successfully been inserted'
END

ELSE
BEGIN
PRINT @a_id
END
END

EXEC sp_ins_book_details 'Alcott','Luoisa May',255850,'Good Wives','1998-01-31','ODG Books',18.96;
SELECT * FROM book;

SELECT * FROM author;
DELETE 
FROM book
WHERE isbn=255850;

 ALTER PROCEDURE sp_ins_book_details @lname VARCHAR(30) , @fname VARCHAR(30), @isbn INTEGER, @title VARCHAR(30) , @cdate DATE, @publi VARCHAR(30),@bprice DECIMAL
 AS
 BEGIN
  DECLARE @Ea_id INTEGER;
  SET @Ea_id = (
   SELECT COUNT(a_id)
   FROM  author 
   WHERE @lname= lastname 
   AND  @fname = firstname);

   IF (@Ea_id) = 0
    BEGIN 
    DECLARE @Mid INTEGER
    SET @Mid = 
    (SELECT MAX(a_id)
     FROM author);

    
     INSERT INTO author (a_id,lastname,firstname,email)
     VALUES ((@Mid+1) ,@lname,@fname,NULL);	 

	 INSERT INTO book (isbn,title,author_id,cpright_date)
     VALUES (@isbn ,@title,(@Mid+1),@cdate);	 

	 INSERT INTO publisher (isbn,publ_name,sugg_price)
     VALUES (@isbn ,@publi,@bprice);
	 
	 PRINT 'insert successful';

	 END;
   ELSE 
	BEGIN
	 PRINT 'author already exist';
	 
	 DECLARE @Na_id INTEGER;
     SET @Na_id = (
     SELECT a_id
     FROM  author 
     WHERE lastname = @lname 
     AND  firstname = @fname );

	 INSERT INTO book (isbn,title,author_id,cpright_date)
     VALUES (@isbn ,@title,@Na_id,@cdate);	 

	 INSERT INTO publisher (isbn,publ_name,sugg_price)
     VALUES (@isbn ,@publi,@bprice);
	 
	 PRINT @Na_id;
	 
	END;
 END;

  --EXEC sp_ins_book_details 'Alcott','Louisa May',255850,'Good Wives','1998-01-31','ODG Books',18.96;


  --SELECT * 
  --FROM book;

  --QU5

ALTER PROCEDURE sp_upd_price @firstname VARCHAR(30), @lastname VARCHAR(30), @x FLOAT
AS
BEGIN
UPDATE publisher
SET sugg_price=(1+(@x/100)) * sugg_price
FROM publisher p, book b , author a
WHERE b.isbn = p.isbn
AND b.author_id = a.a_id
AND a.lastname = @lastname
AND a.firstname = @firstname
END;

EXEC sp_upd_price 'Paulette', 'Burgeous', 5;
SELECT * FROM publisher;



ALTER PROCEDURE sp_upd_price @Afname VARCHAR(30) , @Alname VARCHAR(30) , @Iperc FLOAT
AS
BEGIN
 UPDATE publisher
 SET sugg_price = sugg_price * (1+ (@Iperc/ 100.00))
 FROM publisher p, book b , author a
 WHERE b.author_id = a.a_id
 AND b.isbn = p.isbn
 AND a.lastname = @Alname
 AND a.firstname = @Afname;
END;      

 --SELECT *
 --FROM publisher p, book b , author a
 --WHERE b.author_id = a.a_id
 --AND b.isbn = p.isbn
 --AND a.lastname = 'Alcott'
 --AND a.firstname = 'Louisa May';

 --EXEC sp_upd_price 'Louisa May','Alcott',25;

 --QU6

ALTER PROCEDURE sp_disp_book
AS
BEGIN
SELECT b.title AS book_title, CONCAT(a.firstname,' ',a.lastname) AS book_author, ROUND(p.sugg_price,0) AS book_price
FROM book b, author a, publisher p
WHERE b.isbn=p.isbn
AND b.author_id=a.a_id
END;

EXEC sp_disp_book


ALTER PROCEDURE sp_disp_book
AS
BEGIN
 SELECT b.title AS Booktitle , a.lastname AS Author_Lastname ,a.firstname AS Author_Firstname , ROUND (p.sugg_price,0) AS Price
 FROM publisher p, book b , author a
 WHERE b.author_id = a.a_id
  AND b.isbn = p.isbn
END;      


 EXEC sp_disp_book ;

-- QU7
ALTER PROCEDURE sp_check_price @firstname VARCHAR(20), @lastname VARCHAR(20)
AS 
BEGIN
UPDATE publisher
SET sugg_price=15.85
FROM publisher p, author a, book b 
WHERE p.isbn=b.isbn
AND b.author_id=a.a_id
AND lastname=@lastname
AND firstname=@firstname
AND p.sugg_price<10.00
END

EXEC sp_check_price 'Margaret W.', 'Brown'

ALTER PROCEDURE sp_if_upd_price @Afname VARCHAR(30) , @Alname VARCHAR(30) 
AS
BEGIN
 UPDATE publisher
 SET sugg_price = 15.85
 FROM publisher p, book b , author a
 WHERE p.isbn =  (SELECT p.isbn
                  FROM publisher p, book b , author a
                  WHERE b.author_id = a.a_id
                  AND b.isbn = p.isbn
                  AND a.lastname = @Alname
                  AND a.firstname = @Afname
				  AND sugg_price < 10.00);
END; 

EXEC sp_if_upd_price 'Louisa May','Alcott';
EXEC sp_if_upd_price  'Paulette','Burgeous';

SELECT *
FROM publisher




CREATE TRIGGER tg_ref_int
ON employee
INSTEAD OF INSERT
AS
BEGIN
DECLARE @ssn INTEGER, @fname VARCHAR(40),.....
--Retrieve values inserted
SELECT @ssn = ssn, @fname = fname, @lname = lname, @dno=dno
FROM INSERTED;
--Check whether dno exists in department table
SELECT *
FROM department
WHERE dno = @dno;
--If not, display an error message and do not insert
IF @@ROWCOUNT = 0
        PRINT 'Error!!!'
--Else: allow the insert
ELSE
        INSERT INTO employee VALUES (@ssn, @fname, @lname, ..., @dno,..);

END;

INSERT INTO employee VALUES ('223', 'Tom', 'Hanks',...., 5,...);

SELECT user_name()





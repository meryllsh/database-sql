--(1)Write a trigger which checks data being inserted in the 'author' table. An appropriate error
--message is displayed in the following cases:

--◦ If the first name of the author is left blank
--◦ If the author already exists in the table (check firstname and lastname)
--◦ If the email address is not valid (missing @ and .)

CREATE TRIGGER tg_chk_author
ON author
INSTEAD OF INSERT
AS
DECLARE @firstname VARCHAR(20)
DECLARE @lastname VARCHAR(20)
DECLARE @email VARCHAR(30)

SET @firstname = (SELECT fname FROM INSERTED);
SELECT @firstname=fname FROM INSERTED;
IF (@firstname is NULL)
    BEGIN
    PRINT 'The firstname of the author is left blank'
    RETURN
    END

SELECT @firstname=fname, @lastname=lname FROM INSERTED
IF EXISTS (SELECT @firstname=fname, @lastname=lname FROM INSERTED)
    BEGIN
    PRINT 'The author does not exist in the author table'
    RETURN
    END

SELECT @email=email 
FROM INSERTED
WHERE @email LIKE '%@%.%'
IF (@email is NULL)
    BEGIN
    PRINT 'The email address is not valid'
    RETURN 
    END

    INSERT INTO author (firstname, lastname, email)
    SELECT firstname, lastname, email FROM INSERTED
END

--(2)Write a trigger procedure that ensures that all deleted records from the 'sm.book' table are
--kept in the table 'book_old' with the following fields: isbn, title and date_deleted.

CREATE TABLE book_old
(isbn integer NOT NULL,
  title VARCHAR(40) NOT NULL,
  GETDATE() INTEGER not null);


CREATE TRIGGER tg_dlt_book
ON book_old
AFTER DELETE
AS

IF (@@ROWCOUNT = 0) RETURN

IF EXISTS (SELECT * FROM DELETED)
INSERT INTO book_old(isbn, title, date_deleted)
SELECT isbn, title, GETDATE() FROM DELETED

--(3)Each time a record is inserted in the publisher table, the suggested price entered should be
--checked. If the publisher name is Children's Books, the suggested price should be less then
--100, otherwise, an error message is printed. If the publisher name is ABC Books, then, the
--suggested price should be increased by 10%. Write a trigger which does this.

CREATE TRIGGER tg_chk_pbl
ON publisher
INSTEAD OF INSERT
AS
DECLARE @isbn INTEGER
DECLARE @publ_name VARCHAR(30)
DECLARE @sugg_price REAL

SELECT @publ_name = publ_name, @sugg_price=sugg_price FROM INSERTED
IF ((@publ_name="Children's Books") AND (@sugg_price>=100))
   BEGIN
   PRINT "The sugg_price for Children's Books is not less than 100"
   RETURN
   END

SELECT @publ_name = publ_name, @sugg_price=sugg_price FROM INSERTED
IF (@publ_name="ABC Books")
    BEGIN
    SET @sugg_price=@sugg_price*1.1
    PRINT "The sugg_price has increased by 10%"
    RETURN
    END

--(4)Write a trigger such that when a new book is added in the 'book' table, the author's details
--are displayed as follows: New book booktitle had author firstname lastname, who can be
--contacted on email.

CREATE TRIGGER tg_new_book
ON book, author
AFTER INSERT
AS

IF (@@ROWCOUNT = 0) RETURN
DECLARE @isbn INTEGER
DEClARE @title VARCHAR(40) 
DECLARE @author_id integer
DECLARE @cpright_date datetime
DECLARE @lastname VARCHAR(20)
DECLARE @firstname VARCHAR(20)
DECLARE @email VARCHAR(30)

SELECT @title=title, @firstname=firstname, @lastname=lastname, @email=email
FROM book AS b, author AS a
WHERE @author_id=author_id AND b.author_id=a.a_id

PRINT "New book " + @title + " had author " + @firstname + @lastname + " who can be conctacted on " + CAST(@email AS VARCHAR(50))

--(5)Every change in the 'sugg_price' field of the publisher table should be recorded in the
--'price_audit' table (isbn, publ_name, oldprice, newprice, user_changed, date_changed).
--User_changed is the current_user who has made the change and date_changed is the date
--that the title has changed in the table. Write a trigger to cater for this.

CREATE TRIGGER tg_change_price
ON publisher
AFTER INSERT
AS

IF (@@ROWCOUNT = 0) RETURN


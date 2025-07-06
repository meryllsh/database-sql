CREATE TABLE employee (

fname VARCHAR(15),
minit CHAR(1),
lname VARCHAR(15),
ssn SMALLINT NOT NULL PRIMARY KEY,
bdate DATE,
address VARCHAR(30),
sex CHAR(1) CHECK(sex IN('M', 'F')),
salary INTEGER CHECK(salary>10000),
superssn SMALLINT,
dno SMALLINT CHECK(dno<10));


CREATE TABLE department (

dname VARCHAR(20),
dnumber SMALLINT CHECK(dnumber<10) PRIMARY KEY,
mgrssn SMALLINT FOREIGN KEY REFERENCES employee,
mgrstartdate DATE);


CREATE TABLE department_locations (

dnumber SMALLINT CHECK(dnumber<10) FOREIGN KEY REFERENCES department(dnumber),
dlocation VARCHAR(15) CHECK(dlocation IN('Houston',
'Stafford', 'Bellaire', 'Sugarland')),
PRIMARY KEY (dnumber, dlocation));


CREATE TABLE project (

pname VARCHAR(20),
pnumber SMALLINT PRIMARY KEY,
plocation VARCHAR(15) CHECK(plocation IN('Houston',
'Stafford', 'Bellaire', 'Sugarland')),
dnum SMALLINT CHECK(dnum<10) FOREIGN KEY REFERENCES department(dnumber));



CREATE TABLE works_on (

essn SMALLINT FOREIGN KEY REFERENCES employee(ssn),
pno SMALLINT FOREIGN KEY REFERENCES project(pnumber),
hours FLOAT CHECK (hours>0),
PRIMARY KEY (essn, pno));


CREATE TABLE dependent (

essn SMALLINT FOREIGN KEY REFERENCES employee(ssn),
dependent_name VARCHAR(15),
sex CHAR(1) CHECK(sex IN('M','F')),
bdate DATE,
relationship VARCHAR(10) CHECK(relationship IN('Spouse', 'Son', 'Daughter')),
PRIMARY KEY(essn, dependent_name));


INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('John', 'B', 'Smith', 1234, '1965-01-09', 'Houston', 'M', 30000, null, null); 
              
INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Franklin', 'T', 'Wong', 3334, '1955-12-08', 'Houston', 'M', 40000, null, null);
               
INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Alicia', 'J', 'Zelaya', 9998, '1968-01-19', 'Spring', 'F', 25000, null, null);
               
INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Jennifer', 'S', 'Wallace', 9876, '1941-06-20', 'Bellaire', 'F', 43000, null, null);
               
INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Ramesh', 'K', 'Narayen', 6668, '1962-09-15', 'Humble', 'M', 38000, null, null);
               
INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Joyce', 'A', 'English', 4534, '1972-07-31', 'Houston', 'F', 25000, null, null);
               
INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Ahmad', 'V', 'Jabbar', 9879, '1969-03-29', 'Houston', 'M', 25000, null, null);

INSERT INTO employee (fname, minit, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('James', 'E', 'Borg', 8886, '1937-11-10', 'Houston', 'M', 55000, null, null);

--1
			   SELECT * FROM EMPLOYEE;  

ALTER TABLE employee
ADD FOREIGN KEY(superssn)
REFERENCES employee(ssn);

ALTER TABLE employee
ADD FOREIGN KEY(dno)
REFERENCES department(dnumber);

UPDATE employee
SET superssn=3334, dno=5
WHERE ssn=1234;

UPDATE employee
SET superssn=8886, dno=5
WHERE ssn=3334;

UPDATE employee
SET superssn=9876, dno=4
WHERE ssn=9998;

UPDATE employee 
SET superssn=8886, dno=4
WHERE ssn=9876;

UPDATE employee
SET superssn=3334, dno=5
WHERE ssn=6668;

UPDATE employee
SET superssn=3334, dno=5
WHERE ssn=4534;

UPDATE employee
SET superssn=9876, dno=4
WHERE ssn=9879;

UPDATE employee
SET superssn=null, dno=1
WHERE ssn=8886;




INSERT INTO department (dname, dnumber, mgrssn, mgrstartdate)
VALUES ('Research', 5, 3334, '1988-05-22');
               
INSERT INTO department (dname, dnumber, mgrssn, mgrstartdate)
VALUES ('Administration', 4, 9876, '1995-01-01');

INSERT INTO department (dname, dnumber, mgrssn, mgrstartdate)
VALUES('Headquarters', 1, 8886, '1981-06-19');

             SELECT * FROM DEPARTMENT;

INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES ('ProductX', 1, 'Bellaire', 5);
               
INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES ('ProductY', 2, 'Sugarland', 5);
               
INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES ('ProductZ', 3, 'Houston', 5);
               
INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES ('Computerization', 10, 'Stafford', 4);
               
INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES ('Reorganization', 20, 'Houston', 1);
               
INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES ('Newbenefits', 30, 'Stafford', 4);

               SELECT * FROM PROJECT;

INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(3334, 'Alice', 'F', '1986-04-05', 'Daughter');
              
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(3334, 'Theodore', 'M', '1983-10-25', 'Son');
              
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(3334, 'Joy', 'F', '1958-05-03', 'Spouse');
              
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(9876, 'Abner', 'M', '1942-02-28', 'Spouse');
              
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(1234, 'Michael', 'M', '1988-01-04', 'Son');
              
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(1234, 'Alice', 'F', '1988-12-30', 'Daughter');
              
INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES(1234, 'Elizabeth', 'F', '1967-05-05', 'Spouse');
              
                SELECT * FROM DEPENDENT;

INSERT INTO department_locations (dnumber, dlocation)
VALUES(1, 'Houston');
             
INSERT INTO department_locations (dnumber, dlocation)
VALUES(4, 'Stafford');
              
INSERT INTO department_locations (dnumber, dlocation)
VALUES(5, 'Bellaire');
              
INSERT INTO department_locations (dnumber, dlocation)
VALUES(5, 'Sugarland');
              
INSERT INTO department_locations (dnumber, dlocation)
VALUES(5, 'Houston');

                  SELECT * FROM DEPARTMENT_LOCATIONS;




INSERT INTO works_on (essn, pno, hours)
VALUES(1234, 1, 32.5);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(1234, 2, 7.5);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(6668, 3, 40);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(4534, 1, 20);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(4534, 2, 20);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(3334, 2, 10);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(3334, 3, 10);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(3334, 10, 10);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(3334, 20, 10);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(9998, 30, 30);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(9998, 10, 10);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(9879, 10, 35);
                
INSERT INTO works_on (essn, pno, hours)
VALUES(9879, 30, 5);

INSERT INTO works_on (essn, pno, hours)
VALUES(9876, 30, 20);

INSERT INTO works_on (essn, pno, hours)
VALUES(9876, 20, 15);

INSERT INTO works_on (essn, pno, hours)
VALUES(8886, 20, null);

           SELECT * FROM WORKS_ON;
--Labsheet 2
--2(a)
UPDATE employee
SET salary = 56000
WHERE fname='James';

UPDATE employee
SET bdate = '1969-03-30'
WHERE fname= 'Ahmad';
--2(c)
UPDATE employee
SET lname='English-Herald'
WHERE ssn=4534;
--2(d)
DELETE FROM dependent
WHERE dependent_name='Theodore';

--Labsheet 3
--2
SELECT dname, mgrssn
FROM department;
--3
SELECT pname
FROM project
WHERE plocation='Houston';
--4
SELECT fname, lname
FROM employee
WHERE sex='F' AND salary<40000;
--5
SELECT pname
FROM project
WHERE dnum<>5;
--6
SELECT DISTINCT plocation
FROM project;
--7
SELECT essn
FROM works_on
WHERE pno=10 AND hours>30 AND hours<40;
--8
SELECT pname
FROM project
WHERE dnum=5 AND plocation='Sugarland' OR plocation='Bellaire';
--9
SELECT essn, dependent_name
FROM dependent
WHERE bdate LIKE '1988%';
--10
SELECT fname, lname, address
FROM employee
WHERE bdate>LIKE '1960%' AND bdate<LIKE '1969%';
--11
SELECT fname, lname, address
FROM employee
WHERE bdate LIKE '%01%';
--13
SELECT fname, lname
FROM employee
WHERE sex='M' AND address='Houston' AND salary>25000;
--14
SELECT fname, lname
FROM employee
WHERE superssn=null;
--15
SELECT ssn, fname, lname
salary*1.05 AS 'future_salary'
FROM employee
WHERE dno=5;
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
WHERE bdate BETWEEN '01-Jan-1988' AND '31-Dec-1988';
--10
SELECT fname, lname, address
FROM employee
WHERE bdate BETWEEN '01-Jan-1960' AND '31-Dec-1969';
--11
SELECT fname, lname, address
FROM employee
WHERE DATENAME(m, bdate)='January';
--or WHERE DATEPART(m, bdate)=1
--12
SELECT fname, lname, address
FROM employee
WHERE DATENAME(dw ,bdate)='Sunday';
--13
SELECT fname, lname
FROM employee
WHERE sex='M' AND address='Houston' AND salary>25000;
--14
SELECT fname, lname
FROM employee
WHERE superssn IS NULL;
--15
SELECT ssn, fname, lname,
(salary*1.05) AS 'future_salary'
FROM employee
WHERE dno=5;
--16
SELECT essn, pno,
(hours*200) AS bonus
FROM works_on
WHERE hours>10;
--17
SELECT essn 
FROM works_on
WHERE pno=10 OR pno=20 OR pno=30;
--18
SELECT pname
FROM project
WHERE plocation NOT IN('Sugarland','Bellaire','Stafford');
--19
SELECT dependent_name
FROM dependent
WHERE essn=3334
ORDER BY dependent_name ASC;
--20
SELECT fname, lname
FROM employee
WHERE fname LIKE '%e%e%' OR fname LIKE '%E%E%' OR lname LIKE '%e%e%' OR lname LIKE '%E%E%';
--21
SELECT fname, lname
FROM employee
WHERE fname LIKE 'A____%';
--22
SELECT ssn 
FROM employee
WHERE fname LIKE '______%';
--23
SELECT ssn, fname, lname
FROM employee
WHERE fname+lname LIKE '%e%e%'
OR fname+lname LIKE '%E%E%';
--24
SELECT ssn,LEN(CONCAT(fname,lname)) 
AS Number_of_letters 
FROM employee;

--Labsheet 4
--Aggregate functions
--1
SELECT SUM(salary) AS Total_Salary
FROM employee;
--2
SELECT COUNT(pname) AS Number_of_projects
FROM project;
--3
SELECT COUNT(pno) AS Number_of_employees_assigned_on_pno10, SUM(hours) AS total_number_of_hours_spent_on_pno10
FROM works_on
WHERE pno=10;
--4
SELECT COUNT(DISTINCT dlocation) AS number_of_different_cities_where_departments_are_located
FROM department_locations;
--5
SELECT dnumber, COUNT(dlocation) AS number_of_location
FROM department_locations
GROUP BY dnumber;
--6
SELECT COUNT(superssn) AS total_number_of_supervisors
FROM employee;
--7
SELECT essn, COUNT(dependent_name) AS number_of_children
FROM dependent 
GROUP BY essn;
--8
SELECT DISTINCT dno, COUNT(sex) AS number_of_female_employees, MAX(salary) AS max_salary
FROM employee
WHERE sex='F'
GROUP BY dno;
--9//
SELECT dno, sex, COUNT(ssn), COUNT(sex) AS number_of_employees, AVG(salary) AS average_salary
FROM employee
GROUP BY dno, sex;
--10
SELECT dnum, plocation, COUNT(pname) AS number_of_projects_located_in_each_city
FROM project
GROUP BY dnum, plocation;
--11
SELECT essn, COUNT(pno) AS number_of_projects, SUM(hours) AS total_number_of_hours_spent
FROM works_on
GROUP BY essn;
--12
SELECT essn, COUNT(dependent_name) AS number_of_dependent_child
FROM dependent
GROUP BY essn
HAVING COUNT(dependent_name)>1;
--13
SELECT dno, SUM(salary) AS Total_number_of_salary
FROM employee
WHERE address='Houston'
GROUP BY dno
HAVING COUNT(salary)>1;
--14
SELECT superssn, COUNT(sex) AS number_of_employees_supervised_by_each_supervisor
FROM employee
WHERE sex='M' 
AND superssn IS NOT NULL
GROUP BY superssn
HAVING SUM(salary)>35000;
--15
SELECT pno
FROM works_on
GROUP BY pno
HAVING COUNT(essn)>2 AND SUM(hours)>40;
--16
SELECT fname, lname
FROM employee
WHERE ssn IN(SELECT mgrssn
FROM department
WHERE dname='Research');
--17//
--18
SELECT fname, lname
FROM employee
WHERE ssn IN(SELECT superssn
FROM employee
WHERE fname='John' AND lname='Smith');
--19//
SELECT fname, lname
FROM employee
WHERE DATENAME(m, date)=(SELECT DATENAME(m, bdate)
FROM dependent
--20
SELECT fname, lname
FROM employee
WHERE dno IN (SELECT dnum
FROM project
WHERE pname='Computerization');
--21//
SELECT hours
FROM works_on
WHERE pno=(SELECT pnumber
FROM project
WHERE pname='ProductY')
--22
SELECT pname
FROM project
WHERE plocation='Houston' AND dnum IN(SELECT dno
FROM employee
WHERE salary>=40000);
--23
SELECT fname, lname
FROM employee
WHERE ssn IN(SELECT essn
FROM dependent;)
--24


--Labsheet5
--1
SELECT fname, lname, dname
FROM employee, department
WHERE employee.dno=department.dnumber;
--2
SELECT fname, lname
FROM employee
WHERE ssn IN(SELECT mgrssn
FROM department 
WHERE dname='Research');

SELECT fname, lname 
FROM employee, department
WHERE employee.ssn=department.mgrssn
AND dname='Research';
--3
SELECT dlocation 
FROM department_locations
WHERE dnumber IN(SELECT dno
FROM employee
WHERE fname='John');

SELECT dlocation
FROM department_locations, employee
WHERE department_locations.dnumber=employee.dno
AND fname='John';
--4
SELECT dname
FROM department 
WHERE dnumber IN(SELECT dnum
FROM project
WHERE pname='Reorganization');

SELECT dname 
FROM department, project
WHERE department.dnumber=project.dnum
AND pname='Reorganization';
--5
SELECT COUNT(fname) AS number_of_employees_working_for_the_Research_department
FROM employee, department
WHERE employee.dno=department.dnumber
AND dname='Research';
--6
SELECT fname, lname
FROM employee e JOIN dependent d
ON month(e.bdate)=month(d.bdate)
AND e.ssn=d.essn;
--7
SELECT SUM(hours) AS total_number_of_hours_spent_on_the_Newbenefits_project
FROM works_on w JOIN project p
ON w.pno=p.pnumber
WHERE p.pname='Newbenefits';
--8
SELECT dname, COUNT(fname) AS number_of_employees_working_for_that_department, AVG(salary) AS average_salary
FROM department d LEFT JOIN employee e 
ON d.dnumber=e.dno
GROUP BY dname;
--9
SELECT CONCAT(fname,' ',lname) AS full_name_of_employees
FROM employee;
--10
SELECT pname AS pname_Franklin_works
FROM project p JOIN employee e
ON p.dnum=e.dno
WHERE fname='Franklin';
--11
SELECT fname, lname
FROM project, employee
WHERE employee.dno=project.dnum
AND employee.address=project.plocation;
--12//
SELECT DISTINCT(fname), lname, salary+(25*hours) AS total_income
FROM employee, project, works_on
WHERE employee.dno=project.dnum
AND project.pnumber=works_on.pno;
--13
SELECT fname, lname, dependent_name
FROM employee e LEFT JOIN dependent d
ON e.ssn=d.essn;
--14
SELECT fname, lname, COUNT(dependent_name) AS number_of_dependents_they_each_have
FROM employee e LEFT JOIN dependent d
ON e.ssn=d.essn
GROUP BY fname, lname;
--15//
--16
SELECT fname, lname
FROM employee

--Labsheet 6
--1
--a)
SELECT fname, lname
FROM employee e
WHERE EXISTS(SELECT *
FROM dependent d
WHERE e.ssn=d.essn);
--b)
SELECT pname 
FROM project p
WHERE EXISTS(SELECT *
FROM employee e
WHERE p.dnum=e.dno
AND fname='John');
--c)
SELECT fname, lname
FROM employee e
WHERE NOT EXISTS(SELECT *
FROM project p
WHERE e.dno=p.dnum
AND e.address=p.plocation);










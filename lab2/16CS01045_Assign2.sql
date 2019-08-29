/* source Desktop/6thSem/DSlab/lab2/Assign2.sql; */

-- ------------------------------------------------------------------------------------------------------------------------------------------------
use Assignment2;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

drop table DEPENDENT;
drop table WORKS_ON;
drop table PROJECT;
drop table DEPT_LOCATIONS;
drop table EMPLOYEE;
drop table DEPARTMENT;
drop table RESULT1;
drop table RESULT2;
drop table RESULT3;
drop table RESULT4;
drop table RESULT5_1;
drop table RESULT5_2;
drop table RESULT6;
drop table RESULT7;
drop table RESULT8;
drop table RESULT9;
drop table RESULT10;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table DEPARTMENT(
	Dname varchar(20) not null,
	Dnumber int not null,
	Mgr_ssn varchar(20),
	Mgr_start_date date not null,

	primary key(Dnumber)
);

create table EMPLOYEE(
	Fname varchar(20) not null,
	Minit char not null,
	Lname varchar(20) not null,
	Ssn varchar(20) not null,
	Bdate varchar(20) not null,
	Address varchar(30) not null,
	Sex char not null,
	Salary int not null, 
	Super_ssn varchar(20),
	Dno int not null,

	primary key(Ssn),
	foreign key(Dno) references DEPARTMENT(Dnumber)
);

create table DEPT_LOCATIONS(
	Dnumber int not null,
	Dlocation varchar(20) not null,

	foreign key(Dnumber) references DEPARTMENT(Dnumber)
);

create table PROJECT(
	Pname varchar(20) not null,
	Pnumber int not null,
	Plocation varchar(20) not null,
	Dnum int not null,

	primary key(Pnumber),
	foreign key(Dnum) references DEPARTMENT(Dnumber)
);

create table WORKS_ON(
	Essn varchar(20) not null,
	Pno int not null,
	Hours float,

	foreign key(Essn) references EMPLOYEE(Ssn),
	foreign key(Pno) references PROJECT(Pnumber)
);/* Question-5 */

create table DEPENDENT(
	Essn varchar(20) not null,
	Dependent_name varchar(20) not null,
	Sex char not null,
	Bdate varchar(20) not null,
	Relationship varchar(20) not null,

	foreign key(Essn) references EMPLOYEE(Ssn)
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

insert into DEPARTMENT values('Research', '5', '333445555', '1988-05-22');
insert into DEPARTMENT values('Administration', '4', '987654321', '1995-01-01');
insert into DEPARTMENT values('Headquarters', '1', '888665555', '1981-06-19');

insert into EMPLOYEE values('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', '30000', '333445555', '5');
insert into EMPLOYEE values('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', '40000', '888665555', '5');
insert into EMPLOYEE values('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', '25000', '987654321', '4');
insert into EMPLOYEE values('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', '43000', '888665555', '4');
insert into EMPLOYEE values('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', '38000', '333445555', '5');
insert into EMPLOYEE values('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', '25000', '333445555', '5');
insert into EMPLOYEE values('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', '25000', '987654321', '4');
insert into EMPLOYEE values('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', '55000', NULL, '1');

insert into DEPT_LOCATIONS values('1', 'Housten');
insert into DEPT_LOCATIONS values('4', 'Stafford');
insert into DEPT_LOCATIONS values('5', 'Bellaire');
insert into DEPT_LOCATIONS values('5', 'Sugarland');
insert into DEPT_LOCATIONS values('5', 'Housten');

insert into PROJECT values('ProductX', '1', 'Bellaire', '5');
insert into PROJECT values('ProductY', '2', 'Sugarland', '5');
insert into PROJECT values('ProductZ', '3', 'Houston', '5');
insert into PROJECT values('Computerization', '10', 'Stafford', '4');
insert into PROJECT values('Reorganization', '20', 'Houston', '1');
insert into PROJECT values('Newbenefits', '30', 'Stafford', '4');

insert into WORKS_ON values('123456789', '1', '32.5');
insert into WORKS_ON values('123456789', '2', '7.5');
insert into WORKS_ON values('666884444', '3', '40.0');
insert into WORKS_ON values('453453453', '1', '20.0');
insert into WORKS_ON values('453453453', '2', '20.0');
insert into WORKS_ON values('333445555', '2', '10.0');
insert into WORKS_ON values('333445555', '3', '10.0');
insert into WORKS_ON values('333445555', '10', '10.0');
insert into WORKS_ON values('333445555', '20', '10.0');
insert into WORKS_ON values('999887777', '30', '30.0');
insert into WORKS_ON values('999887777', '10', '10.0');
insert into WORKS_ON values('987987987', '10', '35.0');
insert into WORKS_ON values('987987987', '30', '5.0');
insert into WORKS_ON values('987654321', '30', '20.0');
insert into WORKS_ON values('987654321', '20', '15.0');
insert into WORKS_ON values('888665555', '20', NULL);

insert into DEPENDENT values('333445555', 'Alice', 'F', '1986-04-05', 'Daughter');
insert into DEPENDENT values('333445555', 'Theodore', 'M', '1983-10-25', 'Son');
insert into DEPENDENT values('333445555', 'Joy', 'F', '1958-05-03', 'Spouse');
insert into DEPENDENT values('987654321', 'Abner', 'M', '1942-02-28', 'Spouse');
insert into DEPENDENT values('123456789', 'Michael', 'M', '1988-01-04', 'Son');
insert into DEPENDENT values('123456789', 'Alice', 'F', '1988-12-30', 'Daughter');
insert into DEPENDENT values('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-1 */

create table RESULT1 as
select 
	PROJECT.Pname, DEPARTMENT.Dname, concat(EMPLOYEE.Fname, ' ', EMPLOYEE.Lname) as MName, Address, Bdate
from
	PROJECT inner join DEPARTMENT on PROJECT.Dnum = DEPARTMENT.Dnumber
			inner join EMPLOYEE on EMPLOYEE.Dno = DEPARTMENT.Dnumber and EMPLOYEE.Ssn = DEPARTMENT.Mgr_ssn
where 
	PROJECT.Plocation = 'Stafford'; 

select * from RESULT1;	

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-2 */

create table RESULT2 as
select 
	concat(Fname, ' ', Lname) as EName, Salary as Current_Salary, Salary*1.1 as Raised_Salary
from
	EMPLOYEE
where
	EMPLOYEE.Ssn
	in 
	(select 
		WORKS_ON.Essn
	 from	
	 	PROJECT inner join WORKS_ON on PROJECT.Pnumber = WORKS_ON.Pno
	 where
	 	PROJECT.Pname = 'ProductX'); 

select * from RESULT2;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-3 */

create table RESULT3 as
select 
	concat(EMPLOYEE.Fname, ' ', EMPLOYEE.Lname) as EName, PROJECT.Pname
from
	WORKS_ON inner join PROJECT on WORKS_ON.Pno = PROJECT.Pnumber inner join EMPLOYEE on WORKS_ON.Essn = EMPLOYEE.Ssn inner join DEPARTMENT on DEPARTMENT.Dnumber = EMPLOYEE.Dno
order by 
	DEPARTMENT.Dname, EMPLOYEE.Lname, EMPLOYEE.Fname;

select * from RESULT3;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-4 */

create table RESULT4 as
select 
	concat(EMPLOYEE.Fname, ' ', EMPLOYEE.Lname) as EName, MName
from
	EMPLOYEE

	natural join

	(select 
		concat(EMPLOYEE.Fname, ' ', EMPLOYEE.Lname) as Mname, Dno
	from
		EMPLOYEE inner join DEPARTMENT on DEPARTMENT.Mgr_ssn = EMPLOYEE.Ssn) as X
where
	Dno = '5' 

	and 

	EMPLOYEE.Ssn 
	in 
	(select 
		WORKS_ON.Essn 
	from 
		EMPLOYEE inner join WORKS_ON on EMPLOYEE.Ssn = WORKS_ON.Essn inner join PROJECT on PROJECT.Pnumber = WORKS_ON.Pno 
	where 
		PROJECT.Pname = 'ProductX' and WORKS_ON.Hours > 10);

select * from RESULT4;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-5 */

create table RESULT5_1 as
select
	WORKS_ON.Essn
from
	WORKS_ON inner join WORKS_ON as W on WORKS_ON.Pno = W.Pno and WORKS_ON.Hours = W.Hours and WORKS_ON.Essn <> W.Essn
where
	WORKS_ON.Pno 
	in 
	(select 
		Pno 
	from 
		WORKS_ON 
	where 
		Essn = '123456789'); 

select * from RESULT5_1;

-- (or)

create table RESULT5_2 as
select 
	distinct Essn
from
	WORKS_ON
where
	Essn <> '123456789'
	and
	(Pno, Hours) 
	in
	(select
		Pno, Hours
	from
		WORKS_ON
	where
		Essn = '123456789');

select * from RESULT5_2; 

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-6 */

create table RESULT6 as
select
	concat(EMPLOYEE.Fname, ' ', EMPLOYEE.Lname) as EName
from
	EMPLOYEE inner join DEPENDENT on EMPLOYEE.Ssn = DEPENDENT.Essn
where
	EMPLOYEE.Sex = DEPENDENT.Sex and EMPLOYEE.Fname = DEPENDENT.Dependent_name
group by
	EName;

select * from RESULT6;

-- ------------------------------------------------------------------------------------------------------------------------------------------------	

/* Question-7 */

create table RESULT7 as
select
	sum(Salary) as SumSalaries, min(Salary) as MinSalary, max(Salary) as MaxSalary, avg(Salary) as AvgSalary
from
	EMPLOYEE inner join DEPARTMENT on EMPLOYEE.Dno = DEPARTMENT.Dnumber
where
	DEPARTMENT.Dname = 'Research';

select * from RESULT7;	

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-8 */

create table RESULT8 as
select 
	Dno, EC1 as EGT
from
	(select 
		Dno, count(Fname) as EC1
	from
		EMPLOYEE
	where 
		Salary > 30000	
	group by
		Dno) as X 

	natural join 

	(select 
		Dno, count(Fname) as EC2
	from 
		EMPLOYEE 
	group by 
		Dno) as Y 
where 
	Y.EC2 >= 3;

select * from RESULT8;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-9 */

-- Step(1)-Updating
update 
	EMPLOYEE
set 
	Salary = Salary*1.1
where
	EMPLOYEE.Ssn
	in 
	(select 
		DEPENDENT.Essn
	 from	
	 	DEPENDENT
	 where
	 	DEPENDENT.Relationship = 'Daughter');	

-- Step(2)-Printing
create table RESULT9 as
select
	concat(EMPLOYEE.Fname, ' ',EMPLOYEE.Lname) as EName, EMPLOYEE.Salary
from
	EMPLOYEE
where
	EMPLOYEE.Ssn
	in 
	(select 
		DEPENDENT.Essn
	 from	
	 	DEPENDENT
	 where
	 	DEPENDENT.Relationship = 'Daughter');

select * from RESULT9;	

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-10 */

-- Step(1)-Updating
update
	EMPLOYEE, DEPT_LOCATIONS
set
	EMPLOYEE.Dno = DEPT_LOCATIONS.Dnumber
where
	DEPT_LOCATIONS.Dlocation = 'Stafford' and EMPLOYEE.Bdate like '1965%';

-- Step(2)-Printing
create table RESULT10 as
select
	concat(EMPLOYEE.Fname, ' ', EMPLOYEE.Lname) as EName, EMPLOYEE.Dno
from
	EMPLOYEE, DEPT_LOCATIONS
where 
	DEPT_LOCATIONS.Dlocation = 'Stafford' and EMPLOYEE.Bdate like '1965%';

select * from RESULT10;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Solutions :
-- ------------------------------------------------------------------------------------------------------------------------------------------------
/*

Solution(1)

+-----------------+----------------+------------------+-------------------------+------------+
| Pname           | Dname          | MName            | Address                 | Bdate      |
+-----------------+----------------+------------------+-------------------------+------------+
| Computerization | Administration | Jennifer Wallace | 291 Berry, Bellaire, TX | 1941-06-20 |
| Newbenefits     | Administration | Jennifer Wallace | 291 Berry, Bellaire, TX | 1941-06-20 |
+-----------------+----------------+------------------+-------------------------+------------+


Solution(2)

+---------------+----------------+---------------+
| EName         | Current_Salary | Raised_Salary |
+---------------+----------------+---------------+
| John Smith    |          30000 |       33000.0 |
| Joyce English |          25000 |       27500.0 |
+---------------+----------------+---------------+


Solution(3)

+------------------+-----------------+
| EName            | Pname           |
+------------------+-----------------+
| Ahmad Jabbar     | Newbenefits     |
| Ahmad Jabbar     | Computerization |
| Jennifer Wallace | Reorganization  |
| Jennifer Wallace | Newbenefits     |
| Alicia Zelaya    | Computerization |
| Alicia Zelaya    | Newbenefits     |
| James Borg       | Reorganization  |
| Joyce English    | ProductX        |
| Joyce English    | ProductY        |
| Ramesh Narayan   | ProductZ        |
| John Smith       | ProductX        |
| John Smith       | ProductY        |
| Franklin Wong    | ProductY        |
| Franklin Wong    | Computerization |
| Franklin Wong    | ProductZ        |
| Franklin Wong    | Reorganization  |
+------------------+-----------------+


Solution(4)

+---------------+---------------+
| EName         | Mname         |
+---------------+---------------+
| John Smith    | Franklin Wong |
| Joyce English | Franklin Wong |
+---------------+---------------+


Solution(5)

+-----------+
| Essn      |
+-----------+
| 123456789 |
+-----------+


Solution(6)

Empty set (0.00 sec)


Solution(7)

+-------------+-----------+-----------+------------+
| SumSalaries | MinSalary | MaxSalary | AvgSalary  |
+-------------+-----------+-----------+------------+
|      133000 |     25000 |     40000 | 33250.0000 |
+-------------+-----------+-----------+------------+


Solution(8)

+-----+-----+
| Dno | EGT |
+-----+-----+
|   4 |   1 |
|   5 |   2 |
+-----+-----+


Solution(9)

+---------------+--------+
| EName         | Salary |
+---------------+--------+
| Franklin Wong |  44000 |
| John Smith    |  33000 |
+---------------+--------+


Solution(10)

+------------+-----+
| EName      | Dno |
+------------+-----+
| John Smith |   4 |
+------------+-----+

-- ------------------------------------------------------------------------------------------------------------------------------------------------
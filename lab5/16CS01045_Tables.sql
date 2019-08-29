-- ------------------------------------------------------------------------------------------------------------------------------------------------

set lines 256
set trimout on
set tab off
set pagesize 200
set colsep "| "
column name format a10
column address format a20
column telephone format 9999999999

set serveroutput on

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table Student(
	roll varchar(20) not null primary key,
	name varchar(20), 
	department varchar(20), 
	batch varchar(20), 
	email varchar(20)
);

create table Course(
	courseno varchar(20) not null primary key,
	cname varchar(50), 
	offering_dept varchar(20), 
	semester_no number(1), 
	course_type varchar(20), 
	credit number(3)
);

create table Prerequisite(
	courseno varchar(20) references Course(courseno),
	prcourseno varchar (20)
);

create table Registration(
	roll varchar(20) references Student(roll),
	courseno varchar(20) references Course(courseno),
	semester_no number(1)
);

create table Grades(
	roll varchar(20) references Student(roll),
	courseno varchar(20) references Course(courseno),
	grades number(6,3)
);

create table Attendance(
	courseno varchar(20) references Course(courseno),
	roll varchar(20) references Student(roll),
	dates date, 
	status char
);

create table attendance_warning(
	roll varchar(20) references Student(roll), 
	courseno varchar(20) references Course(courseno)
);

create table deregistration(
	roll varchar(20) references Student(roll),
	courseno varchar(20) references Course(courseno),
	date_deregistered date
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table Emp(
	eno number not null primary key,
	ename varchar(30),
	sal number,
	comm real,
	dept_no number,
	job_type varchar(30),
	joining_date date
);

create table Dept(
	dno number not null primary key,
	dname varchar(30),
	location varchar(30),
	dmgrno references Emp(eno)
);

create table Manpower_Budget(
	dno number references Dept(dno),
	year number(4),
	cost real
);

create table salary_hike(
	eno number references Emp(eno),
	ename varchar(30),
	date_of_increment date,
	increment_amount number
);

create table Employee_history(
	eno number references Emp(eno), 
	ename varchar(30), 
	sal number, 
	comm real, 
	dept_no number references Dept(dno), 
	job_type varchar(30), 
	joining_date date, 
	leaving_date date
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table patient(
	patient_id int not null primary key,
	patient_name varchar(30),
	dob date,
	sex varchar(5) not null
);

create table doctor(
	doctor_id int not null primary key,
	name varchar(30),
	specialisation varchar(30),
	unit varchar(20)
);

create table opd_schedule(
	doctor_id int not null references doctor(doctor_id),
	opd_date timestamp not null,
	fees int not null
);

create table appointment(
	appointment_no int not null,
	patient_id int not null references patient(patient_id),
	doctor_id int not null references doctor(doctor_id),
	appt_date timestamp not null
);

create table opd_payments(
	appointment_no int not null,
	patient_id int not null references patient(patient_id),
	amt int not null,
	date_payment timestamp not null
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table student_(
	sroll int not null primary key,
 	name varchar(30) not null,
 	branch varchar(30) not null,
 	batch int not null,
 	programme varchar(20) not null
);

create table course_(
	cid varchar(10) not null primary key,
	cname varchar(30) not null,
	teacher varchar(30) not null
);

create table attendance_(
	sroll int not null references student_(sroll),
	course_id varchar(10) not null references course_(cid),
	period varchar(20),
	total int not null,
	percent int not null
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

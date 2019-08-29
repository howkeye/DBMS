/* source Desktop/6thSem/DSlab/lab1/Assign1.sql; */

-- ------------------------------------------------------------------------------------------------------------------------------------------------
use Assignment1;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

drop table GRADE_REPORT;
drop table PREREQUISITE;
drop table SECTION;
drop table STUDENT;
drop table COURSE;
drop table RESULT1;
drop table RESULT2;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table STUDENT(
	Name varchar(20) not null,
	Student_number int not null,
	Class int not null,
	Major varchar(20),

	primary key(Student_number)
);

create table COURSE(
	Course_name varchar(25) not null,
	Course_number varchar(20) not null,
	Credit_hours int not null,
	Department varchar(10) not null,

	primary key(Course_number)
);

create table SECTION(
	Section_identifier int not null,
	Course_number varchar(20) not null,
	Semester varchar(20) not null,
	Year varchar(10) not null,
	Instructor varchar(20) not null,

	primary key(Section_identifier),
	foreign key(Course_number) references COURSE(Course_number)
);

create table GRADE_REPORT(
	Student_number int not null,
	Section_identifier int not null,
	Grade char not null,

	foreign key(Student_number) references STUDENT(Student_number),
	foreign key(Section_identifier) references SECTION(Section_identifier)
);

create table PREREQUISITE(
	Course_number varchar(20),
	Prerequisite_number varchar(20),

	foreign key(Course_number) references COURSE(Course_number)
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

insert into STUDENT values('Smith', '17', '1', 'CS');
insert into STUDENT values('Brown', '8', '2', 'CS');

insert into COURSE values('Intro to CS', 'CS1310', '4', 'CS');
insert into COURSE values('Data Structures', 'CS3320', '4', 'CS');
insert into COURSE values('Discrete Mathematics', 'MATH2410', '3', 'MATH');
insert into COURSE values('Database', 'CS3380', '3', 'CS');

insert into SECTION values('85', 'MATH2410', 'Fall', '07', 'King');
insert into SECTION values('92', 'CS1310', 'Fall', '07', 'Anderson');
insert into SECTION values('102', 'CS3320', 'Spring', '08', 'Knuth');
insert into SECTION values('112', 'MATH2410', 'Fall', '08', 'Chang');
insert into SECTION values('119', 'CS1310', 'Fall', '08', 'Anderson');
insert into SECTION values('135', 'CS3380', 'Fall', '08', 'Stone');

insert into GRADE_REPORT values('17', '112', 'B');
insert into GRADE_REPORT values('17', '119', 'C');
insert into GRADE_REPORT values('8', '85', 'A');
insert into GRADE_REPORT values('8', '92', 'A');
insert into GRADE_REPORT values('8', '102', 'B');
insert into GRADE_REPORT values('8', '135', 'A');

insert into PREREQUISITE values('CS3380', 'CS3320');
insert into PREREQUISITE values('CS3380', 'MATH2410');
insert into PREREQUISITE values('CS3320', 'CS1310');

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-1 */

create table RESULT1 as 
select 
	Name, Course_number, Grade, Semester, Year, Section_identifier 
from 
	STUDENT natural join SECTION natural join GRADE_REPORT
order by
	Name
DESC;

select * from RESULT1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-2 */

create table RESULT2 as
select 
	Course_name, Course_number, Prerequisite_number
from
	COURSE natural join PREREQUISITE
order by
	Course_name
DESC;	

select * from RESULT2;	

-- ------------------------------------------------------------------------------------------------------------------------------------------------
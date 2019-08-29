-- ------------------------------------------------------------------------------------------------------------------------------------------------

set lines 256
set trimout on
set tab off
set pagesize 200
set colsep "| "
column name format a10
column address format a20
column telephone format 999999999

set serveroutput on

-- ------------------------------------------------------------------------------------------------------------------------------------------------

drop table Emp_change;
drop table JOB_HISTORY;
drop table DEPARTMENTS;
drop table EMPLOYEES;
drop table JOBS;
drop table LOCATIONS;
drop table COUNTRIES;
drop table REGIONS;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table REGIONS(
	Region_id int not null primary key,
	Region_name varchar(30) not null
);

create table COUNTRIES(
  	Country_id varchar(2) not null primary key,
  	Country_name varchar(30) default null,
  	Region_id int references REGIONS(Region_id)
);

create table LOCATIONS(
	Location_id int not null primary key,
	Street_address varchar(30) not null,
	Postal_code varchar(20) default null,
	City varchar(20) not null,
	State_province varchar(20) default null,
	Country_id varchar(2) references COUNTRIES(Country_id)
);

create table JOBS(
	Job_id varchar(10) not null primary key,
	Job_title varchar(40) not null,
	Min_salary int not null,
	Max_salary int not null
);

create table EMPLOYEES(
	Employee_id int not null primary key,
	First_name varchar(15) not null,
	Last_name varchar(15) not null,
	Email varchar(15) not null,
	Phone_number varchar(20) not null,
	Hire_date varchar(15) not null,
	Job_id varchar(10) references JOBS(Job_id),
	Salary int not null,
	Commission_pct float not null,
	Manager_id int default null,
	Department_id int default null
);

create table DEPARTMENTS(
	Department_id int not null primary key,
	Department_name varchar(30) not null,
	Manager_id int references EMPLOYEES(Employee_id),
	Location_id int references LOCATIONS(Location_id)
);

create table JOB_HISTORY(
	Employee_id int references EMPLOYEES(Employee_id),
	Start_date varchar(15) not null,
	End_date varchar(15) not null,
	Job_id varchar(10) references JOBS(Job_id),
	Department_id int references DEPARTMENTS(Department_id)
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

insert into REGIONS(Region_id, Region_name) values('1', 'Europe');
insert into REGIONS(Region_id, Region_name) values('2', 'America');
insert into REGIONS(Region_id, Region_name) values('3', 'Asia');
insert into REGIONS(Region_id, Region_name) values('4', 'Middle East and Africa');


insert into COUNTRIES(Country_id, Country_name, Region_id) values('AR', 'Argentina', '2');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('AU', 'Australia', '3');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('BE', 'Belgium', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('BR', 'Brazil', '2');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('CA', 'Canada', '2');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('CH', 'Switzerland', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('CN', 'China', '3');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('DE', 'Germany', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('DK', 'Denmark', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('EG', 'Egypt', '4');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('FR', 'France', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('IL', 'Israel', '4');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('IN', 'India', '3');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('IT', 'Italy', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('JP', 'Japan', '3');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('KW', 'Kuwait', '4');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('ML', 'Malaysia', '3');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('MX', 'Mexico', '2');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('NG', 'Nigeria', '4');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('NL', 'Netherlands', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('SG', 'Singapore', '3');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('UK', 'United Kingdom', '1');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('US', 'United States of America', '2');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('ZM', 'Zambia', '4');
insert into COUNTRIES(Country_id, Country_name, Region_id) values('ZW', 'Zimbabwe', '4');


insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1000', '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1100', '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1200', '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefectur', 'JP');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1300', '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1400', '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1500', '2011 Interiors Blvd', '99236', 'South San Franc', 'California', 'US');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1600', '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1700', '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1800', '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('1900', '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2000', '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2100', '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2200', '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2300', '198 Clementi North', '540198', 'Singapore', NULL, 'SG');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2400', '8204 Arthur St', NULL, 'London', NULL, 'UK');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2500', 'Magdalen Centre, The Oxford Sc', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2600', '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2700', 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2800', 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('2900', '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('3000', 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('3100', 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values('3200', 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federa', 'MX');


insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('AC_ACCOUNT', 'Public Accountant', '4200', '9000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('AC_MGR', 'Accounting Manager', '8200', '16000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('AD_ASST', 'Administration Assistant', '3000', '6000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('AD_PRES', 'President', '20080', '40000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('AD_VP', 'Administration Vice President', '15000', '30000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('FI_ACCOUNT', 'Accountant', '4200', '9000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('FI_MGR', 'Finance Manager', '8200', '16000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('HR_REP', 'Human Resources Representative', '4000', '9000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('IT_PROG', 'Programmer', '4000', '10000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('MK_MAN', 'Marketing Manager', '9000', '15000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('MK_REP', 'Marketing Representative', '4000', '9000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('PR_REP', 'Public Relations Representative', '4500', '10500');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('PU_CLERK', 'Purchasing Clerk', '2500', '5500');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('PU_MAN', 'Purchasing Manager', '8000', '15000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('SA_MAN', 'Sales Manager', '10000', '20080');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('SA_REP', 'Sales Representative', '6000', '12008');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('SH_CLERK', 'Shipping Clerk', '2500', '5500');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('ST_CLERK', 'Stock Clerk', '2008', '5000');
insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values('ST_MAN', 'Stock Manager', '5500', '8500');


insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('100', 'Steven', 'King', 'SKING', '515.123.4567', '17-Jun-03', 'AD_PRES', '24000', '0.000', NULL, '90');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('101', 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '21-Sep-05', 'AD_VP', '17000', '0.000', '100', '90');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '13-Jan-01', 'AD_VP', '17000', '0.000', '100', '90');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '3-Jan-06', 'IT_PROG', '9000', '0.000', '102', '60');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '21-May-07', 'IT_PROG', '6000', '0.000', '103', '60');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('105', 'David', 'Austin', 'DAUSTIN', '590.423.4569', '25-Jun-05', 'IT_PROG', '4800', '0.000', '103', '60');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('106', 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '5-Feb-06', 'IT_PROG', '4800', '0.000', '103', '60');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('107', 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '7-Feb-07', 'IT_PROG', '4200', '0.000', '103', '60');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('108', 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '17-Aug-02', 'FI_MGR', '12008', '0.000', '101', '100');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('109', 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '16-Aug-02', 'FI_ACCOUNT', '9000', '0.000', '108', '100');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('110', 'John', 'Chen', 'JCHEN', '515.124.4269', '28-Sep-05', 'FI_ACCOUNT', '8200', '0.000', '108', '100');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('111', 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '30-Sep-05', 'FI_ACCOUNT', '7700', '0.000', '108', '100');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('112', 'Jose Manue', 'Urman', 'JMURMAN', '515.124.4469', '7-Mar-06', 'FI_ACCOUNT', '7800', '0.000', '108', '100');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('113', 'Luis', 'Popp', 'LPOPP', '515.124.4567', '7-Dec-07', 'FI_ACCOUNT', '6900', '0.000', '108', '100');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('114', 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '7-Dec-02', 'PU_MAN', '11000', '0.000', '100', '30');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('115', 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '18-May-03', 'PU_CLERK', '3100', '0.000', '114', '30');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('116', 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '24-Dec-05', 'PU_CLERK', '2900', '0.000', '114', '30');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('117', 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '24-Jul-05', 'PU_CLERK', '2800', '0.000', '114', '30');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('118', 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '15-Nov-06', 'PU_CLERK', '2600', '0.000', '114', '30');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('119', 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '10-Aug-07', 'PU_CLERK', '2500', '0.000', '114', '30');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('120', 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '18-Jul-04', 'ST_MAN', '8000', '0.000', '100', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('121', 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '10-Apr-05', 'ST_MAN', '8200', '0.000', '100', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('122', 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '1-May-03', 'ST_MAN', '7900', '0.000', '100', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('123', 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '10-Oct-05', 'ST_MAN', '6500', '0.000', '100', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('124', 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '16-Nov-07', 'ST_MAN', '5800', '0.000', '100', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('125', 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '16-Jul-05', 'ST_CLERK', '3200', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('126', 'Irene', 'Mikkilinen', 'IMIKKILI', '650.124.1224', '28-Sep-06', 'ST_CLERK', '2700', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('127', 'James', 'Landry', 'JLANDRY', '650.124.1334', '14-Jan-07', 'ST_CLERK', '2400', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('128', 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '8-Mar-08', 'ST_CLERK', '2200', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('129', 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '20-Aug-05', 'ST_CLERK', '3300', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('130', 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '30-Oct-05', 'ST_CLERK', '2800', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('131', 'James', 'Marlow', 'JAMRLOW', '650.124.7234', '16-Feb-05', 'ST_CLERK', '2500', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('132', 'TJ', 'Olson', 'TJOLSON', '650.124.8234', '10-Apr-07', 'ST_CLERK', '2100', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('133', 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '14-Jun-04', 'ST_CLERK', '3300', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('134', 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '26-Aug-06', 'ST_CLERK', '2900', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('135', 'Ki', 'Gee', 'KGEE', '650.127.1734', '12-Dec-07', 'ST_CLERK', '2400', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('136', 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '6-Feb-08', 'ST_CLERK', '2200', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('137', 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '14-Jul-03', 'ST_CLERK', '3600', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('138', 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '26-Oct-05', 'ST_CLERK', '3200', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('139', 'John', 'Seo', 'JSEO', '650.121.2019', '12-Feb-06', 'ST_CLERK', '2700', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('140', 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '6-Apr-06', 'ST_CLERK', '2500', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('141', 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '17-Oct-03', 'ST_CLERK', '3500', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('142', 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '29-Jan-05', 'ST_CLERK', '3100', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('143', 'Randall', 'Matos', 'RMATOS', '650.121.2874', '15-Mar-06', 'ST_CLERK', '2600', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('144', 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '9-Jul-06', 'ST_CLERK', '2500', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('145', 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '1-Oct-04', 'SA_MAN', '14000', '0.400', '100', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('146', 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '5-Jan-05', 'SA_MAN', '13500', '0.300', '100', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('147', 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '10-Mar-05', 'SA_MAN', '12000', '0.300', '100', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('148', 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '15-Oct-07', 'SA_MAN', '11000', '0.300', '100', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('149', 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '29-Jan-08', 'SA_MAN', '10500', '0.200', '100', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('150', 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '30-Jan-05', 'SA_REP', '10000', '0.300', '145', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('151', 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '24-Mar-05', 'SA_REP', '9500', '0.250', '145', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('152', 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '20-Aug-05', 'SA_REP', '9000', '0.250', '145', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('153', 'Christophe', 'Olsen', 'COLSEN', '011.44.1344.498718', '30-Mar-06', 'SA_REP', '8000', '0.200', '145', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('154', 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '9-Dec-06', 'SA_REP', '7500', '0.200', '145', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('155', 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '23-Nov-07', 'SA_REP', '7000', '0.150', '145', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('156', 'Janette', 'King', 'JKING', '011.44.1345.429268', '30-Jan-04', 'SA_REP', '10000', '0.350', '146', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('157', 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '4-Mar-04', 'SA_REP', '9500', '0.350', '146', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('158', 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '1-Aug-04', 'SA_REP', '9000', '0.350', '146', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('159', 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '10-Mar-05', 'SA_REP', '8000', '0.300', '146', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('160', 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '15-Dec-05', 'SA_REP', '7500', '0.300', '146', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('161', 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '3-Nov-06', 'SA_REP', '7000', '0.250', '146', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('162', 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '11-Nov-05', 'SA_REP', '10500', '0.250', '147', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('163', 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '19-Mar-07', 'SA_REP', '9500', '0.150', '147', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('164', 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '24-Jan-08', 'SA_REP', '7200', '0.100', '147', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('165', 'David', 'Lee', 'DLEE', '011.44.1346.529268', '23-Feb-08', 'SA_REP', '6800', '0.100', '147', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('166', 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '24-Mar-08', 'SA_REP', '6400', '0.100', '147', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('167', 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '21-Apr-08', 'SA_REP', '6200', '0.100', '147', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('168', 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '11-Mar-05', 'SA_REP', '11500', '0.250', '148', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('169', 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '23-Mar-06', 'SA_REP', '10000', '0.200', '148', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('170', 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '24-Jan-06', 'SA_REP', '9600', '0.200', '148', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('171', 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '23-Feb-07', 'SA_REP', '7400', '0.150', '148', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('172', 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '24-Mar-07', 'SA_REP', '7300', '0.150', '148', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('173', 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '21-Apr-08', 'SA_REP', '6100', '0.100', '148', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('174', 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '11-May-04', 'SA_REP', '11000', '0.300', '149', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('175', 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '19-Mar-05', 'SA_REP', '8800', '0.250', '149', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('176', 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '24-Mar-06', 'SA_REP', '8600', '0.200', '149', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('177', 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '23-Apr-06', 'SA_REP', '8400', '0.200', '149', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('178', 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '24-May-07', 'SA_REP', '7000', '0.150', '149', NULL);
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('179', 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '4-Jan-08', 'SA_REP', '6200', '0.100', '149', '80');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('180', 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '24-Jan-06', 'SH_CLERK', '3200', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('181', 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '23-Feb-06', 'SH_CLERK', '3100', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('182', 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '21-Jun-07', 'SH_CLERK', '2500', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('183', 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '3-Feb-08', 'SH_CLERK', '2800', '0.000', '120', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('184', 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '27-Jan-04', 'SH_CLERK', '4200', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('185', 'Alexis', 'Bull', 'ABULL', '650.509.2876', '20-Feb-05', 'SH_CLERK', '4100', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('186', 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '24-Jun-06', 'SH_CLERK', '3400', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('187', 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '7-Feb-07', 'SH_CLERK', '3000', '0.000', '121', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('188', 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '14-Jun-05', 'SH_CLERK', '3800', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('189', 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '13-Aug-05', 'SH_CLERK', '3600', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('190', 'Timothy', 'Gates', 'TGATES', '650.505.3876', '11-Jul-06', 'SH_CLERK', '2900', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('191', 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '19-Dec-07', 'SH_CLERK', '2500', '0.000', '122', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('192', 'Sarah', 'Bell', 'SBELL', '650.501.1876', '4-Feb-04', 'SH_CLERK', '4000', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('193', 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '3-Mar-05', 'SH_CLERK', '3900', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('194', 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '1-Jul-06', 'SH_CLERK', '3200', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('195', 'Vance', 'Jones', 'VJONES', '650.501.4876', '17-Mar-07', 'SH_CLERK', '2800', '0.000', '123', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('196', 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '24-Apr-06', 'SH_CLERK', '3100', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('197', 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '23-May-06', 'SH_CLERK', '3000', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('198', 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '21-Jun-07', 'SH_CLERK', '2600', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('199', 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '13-Jan-08', 'SH_CLERK', '2600', '0.000', '124', '50');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('200', 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '17-Sep-03', 'AD_ASST', '4400', '0.000', '101', '10');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('201', 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '17-Feb-04', 'MK_MAN', '13000', '0.000', '100', '20');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('202', 'Pat', 'Fay', 'PFAY', '603.123.6666', '17-Aug-05', 'MK_REP', '6000', '0.000', '201', '20');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('203', 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '7-Jun-02', 'HR_REP', '6500', '0.000', '101', '40');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('204', 'Hermann', 'Baer', 'HBAER', '515.123.8888', '7-Jun-02', 'PR_REP', '10000', '0.000', '101', '70');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('205', 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '7-Jun-02', 'AC_MGR', '12008', '0.000', '101', '110');
insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values('206', 'William', 'Gietz', 'WGIETZ', '515.123.8181', '7-Jun-02', 'AC_ACCOUNT', '8300', '0.000', '205', '110');


insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('10', 'Administration', '200', '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('20', 'Marketing', '201', '1800');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('30', 'Purchasing', '114', '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('40', 'Human Resources', '203', '2400');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('50', 'Shipping', '121', '1500');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('60', 'IT', '103', '1400');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('70', 'Public Relations', '204', '2700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('80', 'Sales', '145', '2500');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('90', 'Executive', '100', '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('100', 'Finance', '108', '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('110', 'Accounting', '205', '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('120', 'Treasury', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('130', 'Corporate Tax', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('140', 'Control And Credit', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('150', 'Shareholder Services', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('160', 'Benefits', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('170', 'Manufacturing', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('180', 'Construction', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('190', 'Contracting', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('200', 'Operations', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('210', 'IT Support', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('220', 'NOC', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('230', 'IT Helpdesk', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('240', 'Government Sales', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('250', 'Retail Sales', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('260', 'Recruiting', NULL, '1700');
insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values('270', 'Payroll', NULL, '1700');


insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('101', '21-Sep-97', '27-Oct-01', 'AC_ACCOUNT', '110');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('101', '28-Oct-01', '15-Mar-05', 'AC_MGR', '110');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('102', '13-Jan-01', '24-Jul-06', 'IT_PROG', '60');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('114', '24-Mar-06', '31-Dec-07', 'ST_CLERK', '50');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('122', '1-Jan-07', '31-Dec-07', 'ST_CLERK', '50');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('176', '1-Jan-07', '31-Dec-07', 'SA_MAN', '80');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('176', '24-Mar-06', '31-Dec-06', 'SA_REP', '80');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('200', '1-Jul-02', '31-Dec-06', 'AC_ACCOUNT', '90');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('200', '17-Sep-95', '17-Jun-01', 'AD_ASST', '90');
insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values('201', '17-Feb-04', '19-Dec-07', 'MK_REP', '20');

-- -----------------------------------------------------------------------------------------------------------------------------------------------

create or replace procedure Q2(temp_id in Departments.Department_id%type, Emp_name out varchar, Department_name out varchar)
as 
begin
	select e.First_name||' '||e.Last_name, d.Department_name into Emp_name, Department_name from Employees e, Departments d where e.Department_id = d.Department_id and e.Employee_id = (select Manager_id from Employees where Employee_id = temp_id);
exception
	when no_data_found then 
		dbms_output.put_line('No data found..!');
end;
/

-- -----------------------------------------------------------------------------------------------------------------------------------------------

create table Emp_change(	
	Employee_id int not null references Employees(Employee_id),
	Old_job_id varchar(10) not null references Jobs(Job_id),
	New_job_id varchar(10) not null references Jobs(Job_id),
	Old_Salary int not null,
	New_Salary int not null,
	Change_date date
);

create or replace trigger Q4_1 after update on Employees for each row
declare
begin
	insert into Emp_change values(:new.Employee_id, :old.Job_id, :new.Job_id, :old.Salary, :new.Salary, to_char(sysdate, 'DD-MM-YY'));
end;
/

create or replace trigger Q4_2 before update of Salary on Employees for each row
declare
	temp_min Jobs.Min_salary%type;
	temp_max Jobs.Max_salary%type;
	exception exception1;
	exception exception2;
begin
	select Min_salary, Max_salary into temp_min, temp_max from Jobs where Job_id = :new.Job_id;
	if :old.Salary < :new.Salary and :new.Salary > temp_max then
		:new.Salary = :old.Salary;
		raise exception1;
	end if;

	if :old.Salary > :new.Salary and :new.Salary < temp_min then
		:new.Salary = :old.Salary;
		raise exception2;
	end if;
exception
	when exception1 then 
		dbms_output.put_line('Min-Max salary constraint violation..!');
	when exception2 then 
		dbms_output.put_line('Min-Max salary constraint violation..!');
	when others then 
		dbms_output.put_line('Some exception..!');
end;
/

-- -----------------------------------------------------------------------------------------------------------------------------------------------
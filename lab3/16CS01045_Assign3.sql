/* source Desktop/6thSem/DSlab/lab3/Assign3.sql; */

-- ------------------------------------------------------------------------------------------------------------------------------------------------
use Assignment3;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

drop table JOB_HISTORY;
drop table DEPARTMENTS;
drop table EMPLOYEES;
drop table JOBS;
drop table LOCATIONS;
drop table COUNTRIES;
drop table REGIONS;
drop table v4;
drop view v6,v7,v12;
drop view v13,v16;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create table REGIONS(
	Region_id int not null,
	Region_name varchar(30) not null,

	primary key(Region_id)
);

create table COUNTRIES(
  	Country_id varchar(2) not null,
  	Country_name varchar(30) default null,
  	Region_id int default null,

  	primary key(Country_id),
  	foreign key(Region_id) references REGIONS(Region_id)
);

create table LOCATIONS(
	Location_id int not null,
	Street_address varchar(30) not null,
	Postal_code varchar(20) default null,
	City varchar(20) not null,
	State_province varchar(20) default null,
	Country_id varchar(2) not null,

	primary key(Location_id),
	foreign key(Country_id) references COUNTRIES(Country_id)
);

create table JOBS(
	Job_id varchar(10) not null,
	Job_title varchar(40) not null,
	Min_salary int not null,
	Max_salary int not null,

	primary key(Job_id)
);

create table EMPLOYEES(
	Employee_id int not null,
	First_name varchar(15) not null,
	Last_name varchar(15) not null,
	Email varchar(15) not null,
	Phone_number varchar(20) not null,
	Hire_date varchar(15) not null,
	Job_id varchar(10) not null,
	Salary int not null,
	Commission_pct float not null,
	Manager_id int default null,
	Department_id int default null,

	primary key(Employee_id),
	foreign key(Job_id) references JOBS(Job_id)
);

create table DEPARTMENTS(
	Department_id int not null,
	Department_name varchar(30) not null,
	Manager_id int default null,
	Location_id int not null,

	primary key(Department_id),
	foreign key(Manager_id) references EMPLOYEES(Employee_id),
	foreign key(Location_id) references LOCATIONS(Location_id)
);

create table JOB_HISTORY(
	Employee_id int not null,
	Start_date varchar(15) not null,
	End_date varchar(15) not null,
	Job_id varchar(10) not null,
	Department_id int not null,

	primary key(Employee_id, Start_date),
	foreign key(Employee_id) references EMPLOYEES(Employee_id),
	foreign key(Job_id) references JOBS(Job_id),
	foreign key(Department_id) references DEPARTMENTS(Department_id)
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

insert into REGIONS(Region_id, Region_name) values
('1', 'Europe'),
('2', 'America'),
('3', 'Asia'),
('4', 'Middle East and Africa');


insert into COUNTRIES(Country_id, Country_name, Region_id) values
('AR', 'Argentina', '2'),
('AU', 'Australia', '3'),
('BE', 'Belgium', '1'),
('BR', 'Brazil', '2'),
('CA', 'Canada', '2'),
('CH', 'Switzerland', '1'),
('CN', 'China', '3'),
('DE', 'Germany', '1'),
('DK', 'Denmark', '1'),
('EG', 'Egypt', '4'),
('FR', 'France', '1'),
('IL', 'Israel', '4'),
('IN', 'India', '3'),
('IT', 'Italy', '1'),
('JP', 'Japan', '3'),
('KW', 'Kuwait', '4'),
('ML', 'Malaysia', '3'),
('MX', 'Mexico', '2'),
('NG', 'Nigeria', '4'),
('NL', 'Netherlands', '1'),
('SG', 'Singapore', '3'),
('UK', 'United Kingdom', '1'),
('US', 'United States of America', '2'),
('ZM', 'Zambia', '4'),
('ZW', 'Zimbabwe', '4');


insert into LOCATIONS(Location_id, Street_address, Postal_code, City, State_province, Country_id) values
('1000', '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
('1100', '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
('1200', '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefectur', 'JP'),
('1300', '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
('1400', '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
('1500', '2011 Interiors Blvd', '99236', 'South San Franc', 'California', 'US'),
('1600', '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
('1700', '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
('1800', '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
('1900', '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
('2000', '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
('2100', '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
('2200', '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
('2300', '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
('2400', '8204 Arthur St', NULL, 'London', NULL, 'UK'),
('2500', 'Magdalen Centre, The Oxford Sc', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
('2600', '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
('2700', 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
('2800', 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
('2900', '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
('3000', 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
('3100', 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
('3200', 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federa', 'MX');


insert into JOBS(Job_id, Job_title, Min_salary, Max_salary) values
('AC_ACCOUNT', 'Public Accountant', '4200', '9000'),
('AC_MGR', 'Accounting Manager', '8200', '16000'),
('AD_ASST', 'Administration Assistant', '3000', '6000'),
('AD_PRES', 'President', '20080', '40000'),
('AD_VP', 'Administration Vice President', '15000', '30000'),
('FI_ACCOUNT', 'Accountant', '4200', '9000'),
('FI_MGR', 'Finance Manager', '8200', '16000'),
('HR_REP', 'Human Resources Representative', '4000', '9000'),
('IT_PROG', 'Programmer', '4000', '10000'),
('MK_MAN', 'Marketing Manager', '9000', '15000'),
('MK_REP', 'Marketing Representative', '4000', '9000'),
('PR_REP', 'Public Relations Representative', '4500', '10500'),
('PU_CLERK', 'Purchasing Clerk', '2500', '5500'),
('PU_MAN', 'Purchasing Manager', '8000', '15000'),
('SA_MAN', 'Sales Manager', '10000', '20080'),
('SA_REP', 'Sales Representative', '6000', '12008'),
('SH_CLERK', 'Shipping Clerk', '2500', '5500'),
('ST_CLERK', 'Stock Clerk', '2008', '5000'),
('ST_MAN', 'Stock Manager', '5500', '8500');


insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values
('100', 'Steven', 'King', 'SKING', '515.123.4567', '17-Jun-03', 'AD_PRES', '24000', '0.000', NULL, '90'),
('101', 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '21-Sep-05', 'AD_VP', '17000', '0.000', '100', '90'),
('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '13-Jan-01', 'AD_VP', '17000', '0.000', '100', '90'),
('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '3-Jan-06', 'IT_PROG', '9000', '0.000', '102', '60'),
('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '21-May-07', 'IT_PROG', '6000', '0.000', '103', '60'),
('105', 'David', 'Austin', 'DAUSTIN', '590.423.4569', '25-Jun-05', 'IT_PROG', '4800', '0.000', '103', '60'),
('106', 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '5-Feb-06', 'IT_PROG', '4800', '0.000', '103', '60'),
('107', 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '7-Feb-07', 'IT_PROG', '4200', '0.000', '103', '60'),
('108', 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '17-Aug-02', 'FI_MGR', '12008', '0.000', '101', '100'),
('109', 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '16-Aug-02', 'FI_ACCOUNT', '9000', '0.000', '108', '100'),
('110', 'John', 'Chen', 'JCHEN', '515.124.4269', '28-Sep-05', 'FI_ACCOUNT', '8200', '0.000', '108', '100'),
('111', 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '30-Sep-05', 'FI_ACCOUNT', '7700', '0.000', '108', '100'),
('112', 'Jose Manue', 'Urman', 'JMURMAN', '515.124.4469', '7-Mar-06', 'FI_ACCOUNT', '7800', '0.000', '108', '100'),
('113', 'Luis', 'Popp', 'LPOPP', '515.124.4567', '7-Dec-07', 'FI_ACCOUNT', '6900', '0.000', '108', '100'),
('114', 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '7-Dec-02', 'PU_MAN', '11000', '0.000', '100', '30'),
('115', 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '18-May-03', 'PU_CLERK', '3100', '0.000', '114', '30'),
('116', 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '24-Dec-05', 'PU_CLERK', '2900', '0.000', '114', '30'),
('117', 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '24-Jul-05', 'PU_CLERK', '2800', '0.000', '114', '30'),
('118', 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '15-Nov-06', 'PU_CLERK', '2600', '0.000', '114', '30'),
('119', 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '10-Aug-07', 'PU_CLERK', '2500', '0.000', '114', '30'),
('120', 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '18-Jul-04', 'ST_MAN', '8000', '0.000', '100', '50'),
('121', 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '10-Apr-05', 'ST_MAN', '8200', '0.000', '100', '50'),
('122', 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '1-May-03', 'ST_MAN', '7900', '0.000', '100', '50'),
('123', 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '10-Oct-05', 'ST_MAN', '6500', '0.000', '100', '50'),
('124', 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '16-Nov-07', 'ST_MAN', '5800', '0.000', '100', '50'),
('125', 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '16-Jul-05', 'ST_CLERK', '3200', '0.000', '120', '50'),
('126', 'Irene', 'Mikkilinen', 'IMIKKILI', '650.124.1224', '28-Sep-06', 'ST_CLERK', '2700', '0.000', '120', '50'),
('127', 'James', 'Landry', 'JLANDRY', '650.124.1334', '14-Jan-07', 'ST_CLERK', '2400', '0.000', '120', '50'),
('128', 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '8-Mar-08', 'ST_CLERK', '2200', '0.000', '120', '50'),
('129', 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '20-Aug-05', 'ST_CLERK', '3300', '0.000', '121', '50'),
('130', 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '30-Oct-05', 'ST_CLERK', '2800', '0.000', '121', '50'),
('131', 'James', 'Marlow', 'JAMRLOW', '650.124.7234', '16-Feb-05', 'ST_CLERK', '2500', '0.000', '121', '50'),
('132', 'TJ', 'Olson', 'TJOLSON', '650.124.8234', '10-Apr-07', 'ST_CLERK', '2100', '0.000', '121', '50'),
('133', 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '14-Jun-04', 'ST_CLERK', '3300', '0.000', '122', '50'),
('134', 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '26-Aug-06', 'ST_CLERK', '2900', '0.000', '122', '50'),
('135', 'Ki', 'Gee', 'KGEE', '650.127.1734', '12-Dec-07', 'ST_CLERK', '2400', '0.000', '122', '50'),
('136', 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '6-Feb-08', 'ST_CLERK', '2200', '0.000', '122', '50'),
('137', 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '14-Jul-03', 'ST_CLERK', '3600', '0.000', '123', '50'),
('138', 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '26-Oct-05', 'ST_CLERK', '3200', '0.000', '123', '50'),
('139', 'John', 'Seo', 'JSEO', '650.121.2019', '12-Feb-06', 'ST_CLERK', '2700', '0.000', '123', '50'),
('140', 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '6-Apr-06', 'ST_CLERK', '2500', '0.000', '123', '50'),
('141', 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '17-Oct-03', 'ST_CLERK', '3500', '0.000', '124', '50'),
('142', 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '29-Jan-05', 'ST_CLERK', '3100', '0.000', '124', '50'),
('143', 'Randall', 'Matos', 'RMATOS', '650.121.2874', '15-Mar-06', 'ST_CLERK', '2600', '0.000', '124', '50'),
('144', 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '9-Jul-06', 'ST_CLERK', '2500', '0.000', '124', '50'),
('145', 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '1-Oct-04', 'SA_MAN', '14000', '0.400', '100', '80'),
('146', 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '5-Jan-05', 'SA_MAN', '13500', '0.300', '100', '80'),
('147', 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '10-Mar-05', 'SA_MAN', '12000', '0.300', '100', '80'),
('148', 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '15-Oct-07', 'SA_MAN', '11000', '0.300', '100', '80'),
('149', 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '29-Jan-08', 'SA_MAN', '10500', '0.200', '100', '80'),
('150', 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '30-Jan-05', 'SA_REP', '10000', '0.300', '145', '80'),
('151', 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '24-Mar-05', 'SA_REP', '9500', '0.250', '145', '80'),
('152', 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '20-Aug-05', 'SA_REP', '9000', '0.250', '145', '80'),
('153', 'Christophe', 'Olsen', 'COLSEN', '011.44.1344.498718', '30-Mar-06', 'SA_REP', '8000', '0.200', '145', '80'),
('154', 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '9-Dec-06', 'SA_REP', '7500', '0.200', '145', '80'),
('155', 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '23-Nov-07', 'SA_REP', '7000', '0.150', '145', '80'),
('156', 'Janette', 'King', 'JKING', '011.44.1345.429268', '30-Jan-04', 'SA_REP', '10000', '0.350', '146', '80'),
('157', 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '4-Mar-04', 'SA_REP', '9500', '0.350', '146', '80'),
('158', 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '1-Aug-04', 'SA_REP', '9000', '0.350', '146', '80'),
('159', 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '10-Mar-05', 'SA_REP', '8000', '0.300', '146', '80'),
('160', 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '15-Dec-05', 'SA_REP', '7500', '0.300', '146', '80'),
('161', 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '3-Nov-06', 'SA_REP', '7000', '0.250', '146', '80'),
('162', 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '11-Nov-05', 'SA_REP', '10500', '0.250', '147', '80'),
('163', 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '19-Mar-07', 'SA_REP', '9500', '0.150', '147', '80'),
('164', 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '24-Jan-08', 'SA_REP', '7200', '0.100', '147', '80'),
('165', 'David', 'Lee', 'DLEE', '011.44.1346.529268', '23-Feb-08', 'SA_REP', '6800', '0.100', '147', '80'),
('166', 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '24-Mar-08', 'SA_REP', '6400', '0.100', '147', '80'),
('167', 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '21-Apr-08', 'SA_REP', '6200', '0.100', '147', '80'),
('168', 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '11-Mar-05', 'SA_REP', '11500', '0.250', '148', '80'),
('169', 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '23-Mar-06', 'SA_REP', '10000', '0.200', '148', '80'),
('170', 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '24-Jan-06', 'SA_REP', '9600', '0.200', '148', '80'),
('171', 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '23-Feb-07', 'SA_REP', '7400', '0.150', '148', '80'),
('172', 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '24-Mar-07', 'SA_REP', '7300', '0.150', '148', '80'),
('173', 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '21-Apr-08', 'SA_REP', '6100', '0.100', '148', '80'),
('174', 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '11-May-04', 'SA_REP', '11000', '0.300', '149', '80'),
('175', 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '19-Mar-05', 'SA_REP', '8800', '0.250', '149', '80'),
('176', 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '24-Mar-06', 'SA_REP', '8600', '0.200', '149', '80'),
('177', 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '23-Apr-06', 'SA_REP', '8400', '0.200', '149', '80'),
('178', 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '24-May-07', 'SA_REP', '7000', '0.150', '149', NULL),
('179', 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '4-Jan-08', 'SA_REP', '6200', '0.100', '149', '80'),
('180', 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '24-Jan-06', 'SH_CLERK', '3200', '0.000', '120', '50'),
('181', 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '23-Feb-06', 'SH_CLERK', '3100', '0.000', '120', '50'),
('182', 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '21-Jun-07', 'SH_CLERK', '2500', '0.000', '120', '50'),
('183', 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '3-Feb-08', 'SH_CLERK', '2800', '0.000', '120', '50'),
('184', 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '27-Jan-04', 'SH_CLERK', '4200', '0.000', '121', '50'),
('185', 'Alexis', 'Bull', 'ABULL', '650.509.2876', '20-Feb-05', 'SH_CLERK', '4100', '0.000', '121', '50'),
('186', 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '24-Jun-06', 'SH_CLERK', '3400', '0.000', '121', '50'),
('187', 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '7-Feb-07', 'SH_CLERK', '3000', '0.000', '121', '50'),
('188', 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '14-Jun-05', 'SH_CLERK', '3800', '0.000', '122', '50'),
('189', 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '13-Aug-05', 'SH_CLERK', '3600', '0.000', '122', '50'),
('190', 'Timothy', 'Gates', 'TGATES', '650.505.3876', '11-Jul-06', 'SH_CLERK', '2900', '0.000', '122', '50'),
('191', 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '19-Dec-07', 'SH_CLERK', '2500', '0.000', '122', '50'),
('192', 'Sarah', 'Bell', 'SBELL', '650.501.1876', '4-Feb-04', 'SH_CLERK', '4000', '0.000', '123', '50'),
('193', 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '3-Mar-05', 'SH_CLERK', '3900', '0.000', '123', '50'),
('194', 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '1-Jul-06', 'SH_CLERK', '3200', '0.000', '123', '50'),
('195', 'Vance', 'Jones', 'VJONES', '650.501.4876', '17-Mar-07', 'SH_CLERK', '2800', '0.000', '123', '50'),
('196', 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '24-Apr-06', 'SH_CLERK', '3100', '0.000', '124', '50'),
('197', 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '23-May-06', 'SH_CLERK', '3000', '0.000', '124', '50'),
('198', 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '21-Jun-07', 'SH_CLERK', '2600', '0.000', '124', '50'),
('199', 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '13-Jan-08', 'SH_CLERK', '2600', '0.000', '124', '50'),
('200', 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '17-Sep-03', 'AD_ASST', '4400', '0.000', '101', '10'),
('201', 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '17-Feb-04', 'MK_MAN', '13000', '0.000', '100', '20'),
('202', 'Pat', 'Fay', 'PFAY', '603.123.6666', '17-Aug-05', 'MK_REP', '6000', '0.000', '201', '20'),
('203', 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '7-Jun-02', 'HR_REP', '6500', '0.000', '101', '40'),
('204', 'Hermann', 'Baer', 'HBAER', '515.123.8888', '7-Jun-02', 'PR_REP', '10000', '0.000', '101', '70'),
('205', 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '7-Jun-02', 'AC_MGR', '12008', '0.000', '101', '110'),
('206', 'William', 'Gietz', 'WGIETZ', '515.123.8181', '7-Jun-02', 'AC_ACCOUNT', '8300', '0.000', '205', '110');


insert into DEPARTMENTS(Department_id, Department_name, Manager_id, Location_id) values
('10', 'Administration', '200', '1700'),
('20', 'Marketing', '201', '1800'),
('30', 'Purchasing', '114', '1700'),
('40', 'Human Resources', '203', '2400'),
('50', 'Shipping', '121', '1500'),
('60', 'IT', '103', '1400'),
('70', 'Public Relations', '204', '2700'),
('80', 'Sales', '145', '2500'),
('90', 'Executive', '100', '1700'),
('100', 'Finance', '108', '1700'),
('110', 'Accounting', '205', '1700'),
('120', 'Treasury', NULL, '1700'),
('130', 'Corporate Tax', NULL, '1700'),
('140', 'Control And Credit', NULL, '1700'),
('150', 'Shareholder Services', NULL, '1700'),
('160', 'Benefits', NULL, '1700'),
('170', 'Manufacturing', NULL, '1700'),
('180', 'Construction', NULL, '1700'),
('190', 'Contracting', NULL, '1700'),
('200', 'Operations', NULL, '1700'),
('210', 'IT Support', NULL, '1700'),
('220', 'NOC', NULL, '1700'),
('230', 'IT Helpdesk', NULL, '1700'),
('240', 'Government Sales', NULL, '1700'),
('250', 'Retail Sales', NULL, '1700'),
('260', 'Recruiting', NULL, '1700'),
('270', 'Payroll', NULL, '1700');	


insert into JOB_HISTORY(Employee_id, Start_date, End_date, Job_id, Department_id) values
('101', '21-Sep-97', '27-Oct-01', 'AC_ACCOUNT', '110'),
('101', '28-Oct-01', '15-Mar-05', 'AC_MGR', '110'),
('102', '13-Jan-01', '24-Jul-06', 'IT_PROG', '60'),
('114', '24-Mar-06', '31-Dec-07', 'ST_CLERK', '50'),
('122', '1-Jan-07', '31-Dec-07', 'ST_CLERK', '50'),
('176', '1-Jan-07', '31-Dec-07', 'SA_MAN', '80'),
('176', '24-Mar-06', '31-Dec-06', 'SA_REP', '80'),
('200', '1-Jul-02', '31-Dec-06', 'AC_ACCOUNT', '90'),
('200', '17-Sep-95', '17-Jun-01', 'AD_ASST', '90'),
('201', '17-Feb-04', '19-Dec-07', 'MK_REP', '20');

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- select * from JOB_HISTORY;
-- select * from JOBS;
-- select * from LOCATIONS;
-- select * from DEPARTMENTS;
-- select * from EMPLOYEES;
-- select * from REGIONS;
-- select * from COUNTRIES;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-1 */

select 
	concat(First_name, ' ', Last_name) as Emp_name, Salary as Monthly_pay, Salary*12 as Annual_pay, Department_name
from
	EMPLOYEES, DEPARTMENTS
where
	EMPLOYEES.Department_id = DEPARTMENTS.Department_id
order by
	Salary DESC; 

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-2 */

select 
	concat(First_name, ' ', Last_name) as Emp_name, Salary*(Commission_pct+1) as Monthly_pay, Salary*(Commission_pct+1)*12 as Annual_pay, Department_name
from
	EMPLOYEES, DEPARTMENTS
where
	EMPLOYEES.Department_id = DEPARTMENTS.Department_id
order by
	(Salary+(Commission_pct*Salary)/100) DESC; 

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-3 */

select
	concat(First_name, ' ', Last_name) as Emp_name, YEAR(curdate())-YEAR(STR_TO_DATE(EMPLOYEES.Hire_date, "%d-%b-%y")) as Experience
from
	EMPLOYEES
order by
	Experience DESC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-4 */

create table v4 as
select 
	concat(First_name, ' ', Last_name) as Emp_name, Salary as Old_salary, Salary*1.1 as New_Salary, Department_id
from
	EMPLOYEES;

update
	v4
set 
	New_Salary = Old_salary
where
	v4.Department_id <> '90';	

select 
	Emp_name, Old_salary, New_Salary
from
	v4;

		-- or


-- alter table EMPLOYEES add column New_Salary int default null after Salary;

-- update
-- 	EMPLOYEES
-- set 
-- 	New_Salary = Salary;

-- update
-- 	EMPLOYEES
-- set
-- 	New_Salary = Salary*1.1
-- where
-- 	Department_id = '90';

-- select 
-- 	Employee_id, concat(First_name, ' ', Last_name) as Emp_name, Salary as Old_salary, New_Salary
-- from
-- 	EMPLOYEES;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-5 */

select 
	EMPLOYEES.Department_id, Department_name, sum(Salary) as Total_Salary
from
	EMPLOYEES, DEPARTMENTS
where 
	EMPLOYEES.Department_id = DEPARTMENTS.Department_id
group by 
	Department_id having Total_Salary > 100000;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-6 */

create view v6 as 
select 
	X.Job_id, X.Max_sal, Max_sal_emp, X.Min_sal, Min_sal_emp
from
	(select 
		JOBS.Job_id, max(Salary) as Max_sal, min(Salary) as Min_sal
	from
		JOBS inner join EMPLOYEES on EMPLOYEES.Job_id = JOBS.Job_id
	group by
		Job_id) as X

	inner join

	(select 
		concat(First_name, ' ', Last_name) as Max_sal_emp, Salary, Job_id
	from
		EMPLOYEES) as Y

	on X.Max_sal = Y.Salary and X.Job_id = Y.Job_id

	inner join

	(select 
		concat(First_name, ' ', Last_name) as Min_sal_emp, Salary, Job_id
	from
		EMPLOYEES) as Z

	on X.Min_sal = Z.Salary and X.Job_id = Z.Job_id;

select * from v6;

insert into EMPLOYEES(Employee_id, First_name, Last_name, Email, Phone_number, Hire_date, Job_id, Salary, Commission_pct, Manager_id, Department_id) values
('207', 'Methuku', 'Preetham', 'MPREETHAM', '515.123.8182', '5-Feb-01', 'AD_PRES', '25000', '0.000', NULL, '110');

select * from v6;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-7 */

create view v7 as
select 
	EMPLOYEES.Employee_id, DEPARTMENTS.Department_name, LOCATIONS.City, COUNTRIES.Country_name
from
	EMPLOYEES, DEPARTMENTS, LOCATIONS, COUNTRIES
where
	EMPLOYEES.Department_id = DEPARTMENTS.Department_id and DEPARTMENTS.Location_id = LOCATIONS.Location_id and LOCATIONS.Country_id = COUNTRIES.Country_id;	

select * from v7;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-8 */

select
	Department_id, year(str_to_date(EMPLOYEES.Hire_date, "%d-%b-%y")) as Year, count(*) as Num_Emp
from
	EMPLOYEES
group by
	Department_id, Year
order by
	Department_id, Year;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-9 */

select
	Employee_id, Emp_name, E_Hire_date, Manager_id, M_Hire_date
from
	(select
		concat(EMPLOYEES.First_name, ' ', EMPLOYEES.Last_name) as Emp_name, EMPLOYEES.Employee_id, EMPLOYEES.Hire_date as E_Hire_date, EMPLOYEES.Manager_id, E.Hire_date as M_Hire_date
	from
		EMPLOYEES inner join EMPLOYEES as E on EMPLOYEES.Manager_id = E.Employee_id) as X
where
	datediff(str_to_date(M_Hire_date, "%d-%b-%y"), str_to_date(E_Hire_date, "%d-%b-%y")) > 0;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-10 */

select 
	COUNTRIES.Country_name, LOCATIONS.City , count(EMPLOYEES.Department_id) as Num_Dept
from 
	EMPLOYEES, LOCATIONS, COUNTRIES, DEPARTMENTS
where 
	EMPLOYEES.Department_id = DEPARTMENTS.Department_id and DEPARTMENTS.Location_id = LOCATIONS.Location_id and COUNTRIES.Country_id = LOCATIONS.Country_id 
group by 
	EMPLOYEES.Department_id 
having 
	count(EMPLOYEES.Department_id)>5
order by
	Num_Dept ASC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-11 */

select
	Manager_id, M_Salary, count(*) as Team_size
from
	(select 
		EMPLOYEES.Manager_id, E.Salary as M_Salary
	from
		EMPLOYEES inner join EMPLOYEES as E on EMPLOYEES.Manager_id = E.Employee_id) as X
group by
	Manager_id
having 
	Team_size > 5;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-12 */

create view v12 as 
select
	Employee_id, YEAR(curdate())-YEAR(STR_TO_DATE(EMPLOYEES.Hire_date, "%d-%b-%y")) as Experience, Salary
from
	EMPLOYEES;

update 
	EMPLOYEES, v12
set 
	EMPLOYEES.Salary = v12.Salary*1.2
where 
	v12.Employee_id = EMPLOYEES.Employee_id and v12.Experience > 10;

update 
	EMPLOYEES, v12
set 
	EMPLOYEES.Salary = v12.Salary*1.1
where 
	v12.Employee_id = EMPLOYEES.Employee_id and v12.Experience > 5 and v12.Experience <= 10;

update 
	EMPLOYEES, v12
set 
	EMPLOYEES.Salary = v12.Salary*1.05
where 
	v12.Employee_id = EMPLOYEES.Employee_id and v12.Experience <= 5;

select 
	Employee_id, concat(First_name, ' ', Last_name) as Emp_name, Salary
from
	EMPLOYEES;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-13 */

create view v13 as
select
	year(str_to_date(EMPLOYEES.Hire_date, "%d-%b-%y")) as Year, count(*) as Num_Emp
from
	EMPLOYEES
group by
	Year;	

select * from v13;

select
	v13.Year as Max_Year
from
	v13
where
	v13.Year not in 
	(select
		X.Year
	from
		v13 as X

		inner join

		v13 as Y on X.Num_emp < Y.Num_emp);

		-- or

-- select 
-- 	v13.Year as Max_Year
-- from
-- 	v13
-- where
-- 	v13.Num_Emp in (select max(Num_Emp) from v13);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-14 */
select
	distinct X.Employee_id, X.Emp_name
from
	(select
		Employee_id, concat(First_name, ' ', Last_name) as Emp_name, Salary
	from
		EMPLOYEES
	where
		EMPLOYEES.Department_id = '10') as X

	inner join

	(select
		Employee_id, concat(First_name, ' ', Last_name) as Emp_name, Salary
	from
		EMPLOYEES
	where
		EMPLOYEES.Department_id = '30') as Y on X.Salary >= Y.Salary
group by
	X.Employee_id
having
	count(*) >= 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-15 */

-- select 
-- 	top 50 percent concat(First_name, ' ', Last_name) 
-- from 
-- 	EMPLOYEES 
-- order by 
-- 	Salary ASC;

-- 		or

select
	X.Employee_id, concat(X.First_name, ' ', X.Last_name) as Emp_name, count(*) as Rank, X.Salary
from
	EMPLOYEES as X, EMPLOYEES as Y
where
	X.Salary < Y.Salary
group by
	X.Employee_id
having 
	Rank < (select count(*)/2 from EMPLOYEES)
order by
	Rank ASC;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

/* Question-16 */

create view v16 as
select
	concat(First_name, ' ', Last_name) as Emp_name, Job_title, Commission_pct, Salary*(1+Commission_pct)*12 as Annual_pay
from
	EMPLOYEES, JOBS
where
	JOBS.Job_id = EMPLOYEES.Job_id and EMPLOYEES.Department_id = '20';

select* from v16;	

update
	EMPLOYEES
set 
	Salary = Salary*1.1;

select* from v16;

update
	EMPLOYEES
set 
	Commission_pct = 1.1
where
	EMPLOYEES.Job_id in (select Job_id from JOBS where Job_title like '%Clerk');

select * from v16;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Solutions :
-- ------------------------------------------------------------------------------------------------------------------------------------------------
/*

Solution(1)

+-------------------+-------------+------------+------------------+
| Emp_name          | Monthly_pay | Annual_pay | Department_name  |
+-------------------+-------------+------------+------------------+
| Steven King       |       24000 |     288000 | Executive        |
| Neena Kochhar     |       17000 |     204000 | Executive        |
| Lex De Haan       |       17000 |     204000 | Executive        |
| John Russell      |       14000 |     168000 | Sales            |
| Karen Partners    |       13500 |     162000 | Sales            |
| Michael Hartstein |       13000 |     156000 | Marketing        |
| Nancy Greenberg   |       12008 |     144096 | Finance          |
| Shelley Higgins   |       12008 |     144096 | Accounting       |
| Alberto Errazuriz |       12000 |     144000 | Sales            |
| Lisa Ozer         |       11500 |     138000 | Sales            |
| Den Raphaely      |       11000 |     132000 | Purchasing       |
| Gerald Cambrault  |       11000 |     132000 | Sales            |
| Ellen Abel        |       11000 |     132000 | Sales            |
| Eleni Zlotkey     |       10500 |     126000 | Sales            |
| Clara Vishney     |       10500 |     126000 | Sales            |
| Peter Tucker      |       10000 |     120000 | Sales            |
| Janette King      |       10000 |     120000 | Sales            |
| Harrison Bloom    |       10000 |     120000 | Sales            |
| Hermann Baer      |       10000 |     120000 | Public Relations |
| Tayler Fox        |        9600 |     115200 | Sales            |
| David Bernstein   |        9500 |     114000 | Sales            |
| Patrick Sully     |        9500 |     114000 | Sales            |
| Danielle Greene   |        9500 |     114000 | Sales            |
| Alexander Hunold  |        9000 |     108000 | IT               |
| Daniel Faviet     |        9000 |     108000 | Finance          |
| Peter Hall        |        9000 |     108000 | Sales            |
| Allan McEwen      |        9000 |     108000 | Sales            |
| Alyssa Hutton     |        8800 |     105600 | Sales            |
| Jonathon Taylor   |        8600 |     103200 | Sales            |
| Jack Livingston   |        8400 |     100800 | Sales            |
| William Gietz     |        8300 |      99600 | Accounting       |
| John Chen         |        8200 |      98400 | Finance          |
| Adam Fripp        |        8200 |      98400 | Shipping         |
| Matthew Weiss     |        8000 |      96000 | Shipping         |
| Christophe Olsen  |        8000 |      96000 | Sales            |
| Lindsey Smith     |        8000 |      96000 | Sales            |
| Payam Kaufling    |        7900 |      94800 | Shipping         |
| Jose Manue Urman  |        7800 |      93600 | Finance          |
| Ismael Sciarra    |        7700 |      92400 | Finance          |
| Nanette Cambrault |        7500 |      90000 | Sales            |
| Louise Doran      |        7500 |      90000 | Sales            |
| William Smith     |        7400 |      88800 | Sales            |
| Elizabeth Bates   |        7300 |      87600 | Sales            |
| Mattea Marvins    |        7200 |      86400 | Sales            |
| Oliver Tuvault    |        7000 |      84000 | Sales            |
| Sarath Sewall     |        7000 |      84000 | Sales            |
| Luis Popp         |        6900 |      82800 | Finance          |
| David Lee         |        6800 |      81600 | Sales            |
| Shanta Vollman    |        6500 |      78000 | Shipping         |
| Susan Mavris      |        6500 |      78000 | Human Resources  |
| Sundar Ande       |        6400 |      76800 | Sales            |
| Amit Banda        |        6200 |      74400 | Sales            |
| Charles Johnson   |        6200 |      74400 | Sales            |
| Sundita Kumar     |        6100 |      73200 | Sales            |
| Bruce Ernst       |        6000 |      72000 | IT               |
| Pat Fay           |        6000 |      72000 | Marketing        |
| Kevin Mourgos     |        5800 |      69600 | Shipping         |
| David Austin      |        4800 |      57600 | IT               |
| Valli Pataballa   |        4800 |      57600 | IT               |
| Jennifer Whalen   |        4400 |      52800 | Administration   |
| Diana Lorentz     |        4200 |      50400 | IT               |
| Nandita Sarchand  |        4200 |      50400 | Shipping         |
| Alexis Bull       |        4100 |      49200 | Shipping         |
| Sarah Bell        |        4000 |      48000 | Shipping         |
| Britney Everett   |        3900 |      46800 | Shipping         |
| Kelly Chung       |        3800 |      45600 | Shipping         |
| Renske Ladwig     |        3600 |      43200 | Shipping         |
| Jennifer Dilly    |        3600 |      43200 | Shipping         |
| Trenna Rajs       |        3500 |      42000 | Shipping         |
| Julia Dellinger   |        3400 |      40800 | Shipping         |
| Laura Bissot      |        3300 |      39600 | Shipping         |
| Jason Mallin      |        3300 |      39600 | Shipping         |
| Julia Nayer       |        3200 |      38400 | Shipping         |
| Stephen Stiles    |        3200 |      38400 | Shipping         |
| Winston Taylor    |        3200 |      38400 | Shipping         |
| Samuel McCain     |        3200 |      38400 | Shipping         |
| Alexander Khoo    |        3100 |      37200 | Purchasing       |
| Curtis Davies     |        3100 |      37200 | Shipping         |
| Jean Fleaur       |        3100 |      37200 | Shipping         |
| Alana Walsh       |        3100 |      37200 | Shipping         |
| Anthony Cabrio    |        3000 |      36000 | Shipping         |
| Kevin Feeney      |        3000 |      36000 | Shipping         |
| Shelli Baida      |        2900 |      34800 | Purchasing       |
| Michael Rogers    |        2900 |      34800 | Shipping         |
| Timothy Gates     |        2900 |      34800 | Shipping         |
| Sigal Tobias      |        2800 |      33600 | Purchasing       |
| Mozhe Atkinson    |        2800 |      33600 | Shipping         |
| Girard Geoni      |        2800 |      33600 | Shipping         |
| Vance Jones       |        2800 |      33600 | Shipping         |
| Irene Mikkilinen  |        2700 |      32400 | Shipping         |
| John Seo          |        2700 |      32400 | Shipping         |
| Guy Himuro        |        2600 |      31200 | Purchasing       |
| Randall Matos     |        2600 |      31200 | Shipping         |
| Donald OConnell   |        2600 |      31200 | Shipping         |
| Douglas Grant     |        2600 |      31200 | Shipping         |
| Karen Colmenares  |        2500 |      30000 | Purchasing       |
| James Marlow      |        2500 |      30000 | Shipping         |
| Joshua Patel      |        2500 |      30000 | Shipping         |
| Peter Vargas      |        2500 |      30000 | Shipping         |
| Martha Sullivan   |        2500 |      30000 | Shipping         |
| Randall Perkins   |        2500 |      30000 | Shipping         |
| James Landry      |        2400 |      28800 | Shipping         |
| Ki Gee            |        2400 |      28800 | Shipping         |
| Steven Markle     |        2200 |      26400 | Shipping         |
| Hazel Philtanker  |        2200 |      26400 | Shipping         |
| TJ Olson          |        2100 |      25200 | Shipping         |
+-------------------+-------------+------------+------------------+

Solution(2)

+-------------------+--------------------+--------------------+------------------+
| Emp_name          | Monthly_pay        | Annual_pay         | Department_name  |
+-------------------+--------------------+--------------------+------------------+
| Steven King       |              24000 |             288000 | Executive        |
| Neena Kochhar     |              17000 |             204000 | Executive        |
| Lex De Haan       |              17000 |             204000 | Executive        |
| John Russell      | 19600.000083446503 | 235200.00100135803 | Sales            |
| Karen Partners    |  17550.00016093254 |  210600.0019311905 | Sales            |
| Michael Hartstein |              13000 |             156000 | Marketing        |
| Alberto Errazuriz | 15600.000143051147 | 187200.00171661377 | Sales            |
| Nancy Greenberg   |              12008 |             144096 | Finance          |
| Shelley Higgins   |              12008 |             144096 | Accounting       |
| Lisa Ozer         |              14375 |             172500 | Sales            |
| Gerald Cambrault  | 14300.000131130219 | 171600.00157356262 | Sales            |
| Ellen Abel        | 14300.000131130219 | 171600.00157356262 | Sales            |
| Den Raphaely      |              11000 |             132000 | Purchasing       |
| Clara Vishney     |              13125 |             157500 | Sales            |
| Eleni Zlotkey     | 12600.000031292439 | 151200.00037550926 | Sales            |
| Janette King      | 13499.999940395355 | 161999.99928474426 | Sales            |
| Peter Tucker      |  13000.00011920929 | 156000.00143051147 | Sales            |
| Harrison Bloom    | 12000.000029802322 | 144000.00035762787 | Sales            |
| Hermann Baer      |              10000 |             120000 | Public Relations |
| Tayler Fox        |  11520.00002861023 | 138240.00034332275 | Sales            |
| Patrick Sully     | 12824.999943375587 | 153899.99932050705 | Sales            |
| David Bernstein   |              11875 |             142500 | Sales            |
| Danielle Greene   | 10925.000056624413 | 131100.00067949295 | Sales            |
| Allan McEwen      |  12149.99994635582 | 145799.99935626984 | Sales            |
| Peter Hall        |              11250 |             135000 | Sales            |
| Alexander Hunold  |               9000 |             108000 | IT               |
| Daniel Faviet     |               9000 |             108000 | Finance          |
| Alyssa Hutton     |              11000 |             132000 | Sales            |
| Jonathon Taylor   | 10320.000025629997 | 123840.00030755997 | Sales            |
| Jack Livingston   |  10080.00002503395 | 120960.00030040741 | Sales            |
| William Gietz     |               8300 |              99600 | Accounting       |
| John Chen         |               8200 |              98400 | Finance          |
| Adam Fripp        |               8200 |              98400 | Shipping         |
| Lindsey Smith     | 10400.000095367432 | 124800.00114440918 | Sales            |
| Christophe Olsen  |  9600.000023841858 |  115200.0002861023 | Sales            |
| Matthew Weiss     |               8000 |              96000 | Shipping         |
| Payam Kaufling    |               7900 |              94800 | Shipping         |
| Jose Manue Urman  |               7800 |              93600 | Finance          |
| Ismael Sciarra    |               7700 |              92400 | Finance          |
| Louise Doran      |  9750.000089406967 |  117000.0010728836 | Sales            |
| Nanette Cambrault |  9000.000022351742 |  108000.0002682209 | Sales            |
| William Smith     |  8510.000044107437 | 102120.00052928925 | Sales            |
| Elizabeth Bates   |   8395.00004351139 | 100740.00052213669 | Sales            |
| Mattea Marvins    |  7920.000010728836 |  95040.00012874603 | Sales            |
| Sarath Sewall     |               8750 |             105000 | Sales            |
| Oliver Tuvault    |  8050.000041723251 |  96600.00050067902 | Sales            |
| Luis Popp         |               6900 |              82800 | Finance          |
| David Lee         |   7480.00001013279 |  89760.00012159348 | Sales            |
| Shanta Vollman    |               6500 |              78000 | Shipping         |
| Susan Mavris      |               6500 |              78000 | Human Resources  |
| Sundar Ande       |  7040.000009536743 |  84480.00011444092 | Sales            |
| Amit Banda        |   6820.00000923872 |  81840.00011086464 | Sales            |
| Charles Johnson   |   6820.00000923872 |  81840.00011086464 | Sales            |
| Sundita Kumar     |  6710.000009089708 |   80520.0001090765 | Sales            |
| Bruce Ernst       |               6000 |              72000 | IT               |
| Pat Fay           |               6000 |              72000 | Marketing        |
| Kevin Mourgos     |               5800 |              69600 | Shipping         |
| David Austin      |               4800 |              57600 | IT               |
| Valli Pataballa   |               4800 |              57600 | IT               |
| Jennifer Whalen   |               4400 |              52800 | Administration   |
| Diana Lorentz     |               4200 |              50400 | IT               |
| Nandita Sarchand  |               4200 |              50400 | Shipping         |
| Alexis Bull       |               4100 |              49200 | Shipping         |
| Sarah Bell        |               4000 |              48000 | Shipping         |
| Britney Everett   |               3900 |              46800 | Shipping         |
| Kelly Chung       |               3800 |              45600 | Shipping         |
| Renske Ladwig     |               3600 |              43200 | Shipping         |
| Jennifer Dilly    |               3600 |              43200 | Shipping         |
| Trenna Rajs       |               3500 |              42000 | Shipping         |
| Julia Dellinger   |               3400 |              40800 | Shipping         |
| Laura Bissot      |               3300 |              39600 | Shipping         |
| Jason Mallin      |               3300 |              39600 | Shipping         |
| Julia Nayer       |               3200 |              38400 | Shipping         |
| Stephen Stiles    |               3200 |              38400 | Shipping         |
| Winston Taylor    |               3200 |              38400 | Shipping         |
| Samuel McCain     |               3200 |              38400 | Shipping         |
| Alexander Khoo    |               3100 |              37200 | Purchasing       |
| Curtis Davies     |               3100 |              37200 | Shipping         |
| Jean Fleaur       |               3100 |              37200 | Shipping         |
| Alana Walsh       |               3100 |              37200 | Shipping         |
| Anthony Cabrio    |               3000 |              36000 | Shipping         |
| Kevin Feeney      |               3000 |              36000 | Shipping         |
| Shelli Baida      |               2900 |              34800 | Purchasing       |
| Michael Rogers    |               2900 |              34800 | Shipping         |
| Timothy Gates     |               2900 |              34800 | Shipping         |
| Sigal Tobias      |               2800 |              33600 | Purchasing       |
| Mozhe Atkinson    |               2800 |              33600 | Shipping         |
| Girard Geoni      |               2800 |              33600 | Shipping         |
| Vance Jones       |               2800 |              33600 | Shipping         |
| Irene Mikkilinen  |               2700 |              32400 | Shipping         |
| John Seo          |               2700 |              32400 | Shipping         |
| Guy Himuro        |               2600 |              31200 | Purchasing       |
| Randall Matos     |               2600 |              31200 | Shipping         |
| Donald OConnell   |               2600 |              31200 | Shipping         |
| Douglas Grant     |               2600 |              31200 | Shipping         |
| Karen Colmenares  |               2500 |              30000 | Purchasing       |
| James Marlow      |               2500 |              30000 | Shipping         |
| Joshua Patel      |               2500 |              30000 | Shipping         |
| Peter Vargas      |               2500 |              30000 | Shipping         |
| Martha Sullivan   |               2500 |              30000 | Shipping         |
| Randall Perkins   |               2500 |              30000 | Shipping         |
| James Landry      |               2400 |              28800 | Shipping         |
| Ki Gee            |               2400 |              28800 | Shipping         |
| Steven Markle     |               2200 |              26400 | Shipping         |
| Hazel Philtanker  |               2200 |              26400 | Shipping         |
| TJ Olson          |               2100 |              25200 | Shipping         |
+-------------------+--------------------+--------------------+------------------+

Solution(3)

+-------------------+------------+
| Emp_name          | Experience |
+-------------------+------------+
| Lex De Haan       |         18 |
| Nancy Greenberg   |         17 |
| Daniel Faviet     |         17 |
| Den Raphaely      |         17 |
| Susan Mavris      |         17 |
| Hermann Baer      |         17 |
| Shelley Higgins   |         17 |
| William Gietz     |         17 |
| Steven King       |         16 |
| Alexander Khoo    |         16 |
| Payam Kaufling    |         16 |
| Renske Ladwig     |         16 |
| Trenna Rajs       |         16 |
| Jennifer Whalen   |         16 |
| Matthew Weiss     |         15 |
| Jason Mallin      |         15 |
| John Russell      |         15 |
| Janette King      |         15 |
| Patrick Sully     |         15 |
| Allan McEwen      |         15 |
| Ellen Abel        |         15 |
| Nandita Sarchand  |         15 |
| Sarah Bell        |         15 |
| Michael Hartstein |         15 |
| Neena Kochhar     |         14 |
| David Austin      |         14 |
| John Chen         |         14 |
| Ismael Sciarra    |         14 |
| Shelli Baida      |         14 |
| Sigal Tobias      |         14 |
| Adam Fripp        |         14 |
| Shanta Vollman    |         14 |
| Julia Nayer       |         14 |
| Laura Bissot      |         14 |
| Mozhe Atkinson    |         14 |
| James Marlow      |         14 |
| Stephen Stiles    |         14 |
| Curtis Davies     |         14 |
| Karen Partners    |         14 |
| Alberto Errazuriz |         14 |
| Peter Tucker      |         14 |
| David Bernstein   |         14 |
| Peter Hall        |         14 |
| Lindsey Smith     |         14 |
| Louise Doran      |         14 |
| Clara Vishney     |         14 |
| Lisa Ozer         |         14 |
| Alyssa Hutton     |         14 |
| Alexis Bull       |         14 |
| Kelly Chung       |         14 |
| Jennifer Dilly    |         14 |
| Britney Everett   |         14 |
| Pat Fay           |         14 |
| Alexander Hunold  |         13 |
| Valli Pataballa   |         13 |
| Jose Manue Urman  |         13 |
| Guy Himuro        |         13 |
| Irene Mikkilinen  |         13 |
| Michael Rogers    |         13 |
| John Seo          |         13 |
| Joshua Patel      |         13 |
| Randall Matos     |         13 |
| Peter Vargas      |         13 |
| Christophe Olsen  |         13 |
| Nanette Cambrault |         13 |
| Sarath Sewall     |         13 |
| Harrison Bloom    |         13 |
| Tayler Fox        |         13 |
| Jonathon Taylor   |         13 |
| Jack Livingston   |         13 |
| Winston Taylor    |         13 |
| Jean Fleaur       |         13 |
| Julia Dellinger   |         13 |
| Timothy Gates     |         13 |
| Samuel McCain     |         13 |
| Alana Walsh       |         13 |
| Kevin Feeney      |         13 |
| Bruce Ernst       |         12 |
| Diana Lorentz     |         12 |
| Luis Popp         |         12 |
| Karen Colmenares  |         12 |
| Kevin Mourgos     |         12 |
| James Landry      |         12 |
| TJ Olson          |         12 |
| Ki Gee            |         12 |
| Gerald Cambrault  |         12 |
| Oliver Tuvault    |         12 |
| Danielle Greene   |         12 |
| William Smith     |         12 |
| Elizabeth Bates   |         12 |
| Kimberely Grant   |         12 |
| Martha Sullivan   |         12 |
| Anthony Cabrio    |         12 |
| Randall Perkins   |         12 |
| Vance Jones       |         12 |
| Donald OConnell   |         12 |
| Steven Markle     |         11 |
| Hazel Philtanker  |         11 |
| Eleni Zlotkey     |         11 |
| Mattea Marvins    |         11 |
| David Lee         |         11 |
| Sundar Ande       |         11 |
| Amit Banda        |         11 |
| Sundita Kumar     |         11 |
| Charles Johnson   |         11 |
| Girard Geoni      |         11 |
| Douglas Grant     |         11 |
+-------------------+------------+

Solution(4)

+-------------------+------------+------------+
| Emp_name          | Old_salary | New_Salary |
+-------------------+------------+------------+
| Steven King       |      24000 |    26400.0 |
| Neena Kochhar     |      17000 |    18700.0 |
| Lex De Haan       |      17000 |    18700.0 |
| Alexander Hunold  |       9000 |     9000.0 |
| Bruce Ernst       |       6000 |     6000.0 |
| David Austin      |       4800 |     4800.0 |
| Valli Pataballa   |       4800 |     4800.0 |
| Diana Lorentz     |       4200 |     4200.0 |
| Nancy Greenberg   |      12008 |    12008.0 |
| Daniel Faviet     |       9000 |     9000.0 |
| John Chen         |       8200 |     8200.0 |
| Ismael Sciarra    |       7700 |     7700.0 |
| Jose Manue Urman  |       7800 |     7800.0 |
| Luis Popp         |       6900 |     6900.0 |
| Den Raphaely      |      11000 |    11000.0 |
| Alexander Khoo    |       3100 |     3100.0 |
| Shelli Baida      |       2900 |     2900.0 |
| Sigal Tobias      |       2800 |     2800.0 |
| Guy Himuro        |       2600 |     2600.0 |
| Karen Colmenares  |       2500 |     2500.0 |
| Matthew Weiss     |       8000 |     8000.0 |
| Adam Fripp        |       8200 |     8200.0 |
| Payam Kaufling    |       7900 |     7900.0 |
| Shanta Vollman    |       6500 |     6500.0 |
| Kevin Mourgos     |       5800 |     5800.0 |
| Julia Nayer       |       3200 |     3200.0 |
| Irene Mikkilinen  |       2700 |     2700.0 |
| James Landry      |       2400 |     2400.0 |
| Steven Markle     |       2200 |     2200.0 |
| Laura Bissot      |       3300 |     3300.0 |
| Mozhe Atkinson    |       2800 |     2800.0 |
| James Marlow      |       2500 |     2500.0 |
| TJ Olson          |       2100 |     2100.0 |
| Jason Mallin      |       3300 |     3300.0 |
| Michael Rogers    |       2900 |     2900.0 |
| Ki Gee            |       2400 |     2400.0 |
| Hazel Philtanker  |       2200 |     2200.0 |
| Renske Ladwig     |       3600 |     3600.0 |
| Stephen Stiles    |       3200 |     3200.0 |
| John Seo          |       2700 |     2700.0 |
| Joshua Patel      |       2500 |     2500.0 |
| Trenna Rajs       |       3500 |     3500.0 |
| Curtis Davies     |       3100 |     3100.0 |
| Randall Matos     |       2600 |     2600.0 |
| Peter Vargas      |       2500 |     2500.0 |
| John Russell      |      14000 |    14000.0 |
| Karen Partners    |      13500 |    13500.0 |
| Alberto Errazuriz |      12000 |    12000.0 |
| Gerald Cambrault  |      11000 |    11000.0 |
| Eleni Zlotkey     |      10500 |    10500.0 |
| Peter Tucker      |      10000 |    10000.0 |
| David Bernstein   |       9500 |     9500.0 |
| Peter Hall        |       9000 |     9000.0 |
| Christophe Olsen  |       8000 |     8000.0 |
| Nanette Cambrault |       7500 |     7500.0 |
| Oliver Tuvault    |       7000 |     7000.0 |
| Janette King      |      10000 |    10000.0 |
| Patrick Sully     |       9500 |     9500.0 |
| Allan McEwen      |       9000 |     9000.0 |
| Lindsey Smith     |       8000 |     8000.0 |
| Louise Doran      |       7500 |     7500.0 |
| Sarath Sewall     |       7000 |     7000.0 |
| Clara Vishney     |      10500 |    10500.0 |
| Danielle Greene   |       9500 |     9500.0 |
| Mattea Marvins    |       7200 |     7200.0 |
| David Lee         |       6800 |     6800.0 |
| Sundar Ande       |       6400 |     6400.0 |
| Amit Banda        |       6200 |     6200.0 |
| Lisa Ozer         |      11500 |    11500.0 |
| Harrison Bloom    |      10000 |    10000.0 |
| Tayler Fox        |       9600 |     9600.0 |
| William Smith     |       7400 |     7400.0 |
| Elizabeth Bates   |       7300 |     7300.0 |
| Sundita Kumar     |       6100 |     6100.0 |
| Ellen Abel        |      11000 |    11000.0 |
| Alyssa Hutton     |       8800 |     8800.0 |
| Jonathon Taylor   |       8600 |     8600.0 |
| Jack Livingston   |       8400 |     8400.0 |
| Kimberely Grant   |       7000 |     7700.0 |
| Charles Johnson   |       6200 |     6200.0 |
| Winston Taylor    |       3200 |     3200.0 |
| Jean Fleaur       |       3100 |     3100.0 |
| Martha Sullivan   |       2500 |     2500.0 |
| Girard Geoni      |       2800 |     2800.0 |
| Nandita Sarchand  |       4200 |     4200.0 |
| Alexis Bull       |       4100 |     4100.0 |
| Julia Dellinger   |       3400 |     3400.0 |
| Anthony Cabrio    |       3000 |     3000.0 |
| Kelly Chung       |       3800 |     3800.0 |
| Jennifer Dilly    |       3600 |     3600.0 |
| Timothy Gates     |       2900 |     2900.0 |
| Randall Perkins   |       2500 |     2500.0 |
| Sarah Bell        |       4000 |     4000.0 |
| Britney Everett   |       3900 |     3900.0 |
| Samuel McCain     |       3200 |     3200.0 |
| Vance Jones       |       2800 |     2800.0 |
| Alana Walsh       |       3100 |     3100.0 |
| Kevin Feeney      |       3000 |     3000.0 |
| Donald OConnell   |       2600 |     2600.0 |
| Douglas Grant     |       2600 |     2600.0 |
| Jennifer Whalen   |       4400 |     4400.0 |
| Michael Hartstein |      13000 |    13000.0 |
| Pat Fay           |       6000 |     6000.0 |
| Susan Mavris      |       6500 |     6500.0 |
| Hermann Baer      |      10000 |    10000.0 |
| Shelley Higgins   |      12008 |    12008.0 |
| William Gietz     |       8300 |     8300.0 |
+-------------------+------------+------------+

Solution(5)

+---------------+-----------------+--------------+
| Department_id | Department_name | Total_Salary |
+---------------+-----------------+--------------+
|            50 | Shipping        |       156400 |
|            80 | Sales           |       304500 |
+---------------+-----------------+--------------+

Solution(6)

+------------+---------+-------------------+---------+-------------------+
| Job_id     | Max_sal | Max_sal_emp       | Min_sal | Min_sal_emp       |
+------------+---------+-------------------+---------+-------------------+
| AC_ACCOUNT |    8300 | William Gietz     |    8300 | William Gietz     |
| AC_MGR     |   12008 | Shelley Higgins   |   12008 | Shelley Higgins   |
| AD_ASST    |    4400 | Jennifer Whalen   |    4400 | Jennifer Whalen   |
| AD_PRES    |   24000 | Steven King       |   24000 | Steven King       |
| AD_VP      |   17000 | Neena Kochhar     |   17000 | Neena Kochhar     |
| AD_VP      |   17000 | Neena Kochhar     |   17000 | Lex De Haan       |
| AD_VP      |   17000 | Lex De Haan       |   17000 | Neena Kochhar     |
| AD_VP      |   17000 | Lex De Haan       |   17000 | Lex De Haan       |
| FI_ACCOUNT |    9000 | Daniel Faviet     |    6900 | Luis Popp         |
| FI_MGR     |   12008 | Nancy Greenberg   |   12008 | Nancy Greenberg   |
| HR_REP     |    6500 | Susan Mavris      |    6500 | Susan Mavris      |
| IT_PROG    |    9000 | Alexander Hunold  |    4200 | Diana Lorentz     |
| MK_MAN     |   13000 | Michael Hartstein |   13000 | Michael Hartstein |
| MK_REP     |    6000 | Pat Fay           |    6000 | Pat Fay           |
| PR_REP     |   10000 | Hermann Baer      |   10000 | Hermann Baer      |
| PU_CLERK   |    3100 | Alexander Khoo    |    2500 | Karen Colmenares  |
| PU_MAN     |   11000 | Den Raphaely      |   11000 | Den Raphaely      |
| SA_MAN     |   14000 | John Russell      |   10500 | Eleni Zlotkey     |
| SA_REP     |   11500 | Lisa Ozer         |    6100 | Sundita Kumar     |
| SH_CLERK   |    4200 | Nandita Sarchand  |    2500 | Martha Sullivan   |
| SH_CLERK   |    4200 | Nandita Sarchand  |    2500 | Randall Perkins   |
| ST_CLERK   |    3600 | Renske Ladwig     |    2100 | TJ Olson          |
| ST_MAN     |    8200 | Adam Fripp        |    5800 | Kevin Mourgos     |
+------------+---------+-------------------+---------+-------------------+
23 rows in set (0.00 sec)

Query OK, 1 row affected (0.00 sec)

-- The Row having AD_PRES has been updated...!

+------------+---------+-------------------+---------+-------------------+
| Job_id     | Max_sal | Max_sal_emp       | Min_sal | Min_sal_emp       |
+------------+---------+-------------------+---------+-------------------+
| AC_ACCOUNT |    8300 | William Gietz     |    8300 | William Gietz     |
| AC_MGR     |   12008 | Shelley Higgins   |   12008 | Shelley Higgins   |
| AD_ASST    |    4400 | Jennifer Whalen   |    4400 | Jennifer Whalen   |
| AD_PRES    |   25000 | Methuku Preetham  |   24000 | Steven King       |
| AD_VP      |   17000 | Neena Kochhar     |   17000 | Neena Kochhar     |
| AD_VP      |   17000 | Neena Kochhar     |   17000 | Lex De Haan       |
| AD_VP      |   17000 | Lex De Haan       |   17000 | Neena Kochhar     |
| AD_VP      |   17000 | Lex De Haan       |   17000 | Lex De Haan       |
| FI_ACCOUNT |    9000 | Daniel Faviet     |    6900 | Luis Popp         |
| FI_MGR     |   12008 | Nancy Greenberg   |   12008 | Nancy Greenberg   |
| HR_REP     |    6500 | Susan Mavris      |    6500 | Susan Mavris      |
| IT_PROG    |    9000 | Alexander Hunold  |    4200 | Diana Lorentz     |
| MK_MAN     |   13000 | Michael Hartstein |   13000 | Michael Hartstein |
| MK_REP     |    6000 | Pat Fay           |    6000 | Pat Fay           |
| PR_REP     |   10000 | Hermann Baer      |   10000 | Hermann Baer      |
| PU_CLERK   |    3100 | Alexander Khoo    |    2500 | Karen Colmenares  |
| PU_MAN     |   11000 | Den Raphaely      |   11000 | Den Raphaely      |
| SA_MAN     |   14000 | John Russell      |   10500 | Eleni Zlotkey     |
| SA_REP     |   11500 | Lisa Ozer         |    6100 | Sundita Kumar     |
| SH_CLERK   |    4200 | Nandita Sarchand  |    2500 | Martha Sullivan   |
| SH_CLERK   |    4200 | Nandita Sarchand  |    2500 | Randall Perkins   |
| ST_CLERK   |    3600 | Renske Ladwig     |    2100 | TJ Olson          |
| ST_MAN     |    8200 | Adam Fripp        |    5800 | Kevin Mourgos     |
+------------+---------+-------------------+---------+-------------------+

Solution(7)

+-------------+------------------+-----------------+--------------------------+
| Employee_id | Department_name  | City            | Country_name             |
+-------------+------------------+-----------------+--------------------------+
|         100 | Executive        | Seattle         | United States of America |
|         101 | Executive        | Seattle         | United States of America |
|         102 | Executive        | Seattle         | United States of America |
|         103 | IT               | Southlake       | United States of America |
|         104 | IT               | Southlake       | United States of America |
|         105 | IT               | Southlake       | United States of America |
|         106 | IT               | Southlake       | United States of America |
|         107 | IT               | Southlake       | United States of America |
|         108 | Finance          | Seattle         | United States of America |
|         109 | Finance          | Seattle         | United States of America |
|         110 | Finance          | Seattle         | United States of America |
|         111 | Finance          | Seattle         | United States of America |
|         112 | Finance          | Seattle         | United States of America |
|         113 | Finance          | Seattle         | United States of America |
|         114 | Purchasing       | Seattle         | United States of America |
|         115 | Purchasing       | Seattle         | United States of America |
|         116 | Purchasing       | Seattle         | United States of America |
|         117 | Purchasing       | Seattle         | United States of America |
|         118 | Purchasing       | Seattle         | United States of America |
|         119 | Purchasing       | Seattle         | United States of America |
|         120 | Shipping         | South San Franc | United States of America |
|         121 | Shipping         | South San Franc | United States of America |
|         122 | Shipping         | South San Franc | United States of America |
|         123 | Shipping         | South San Franc | United States of America |
|         124 | Shipping         | South San Franc | United States of America |
|         125 | Shipping         | South San Franc | United States of America |
|         126 | Shipping         | South San Franc | United States of America |
|         127 | Shipping         | South San Franc | United States of America |
|         128 | Shipping         | South San Franc | United States of America |
|         129 | Shipping         | South San Franc | United States of America |
|         130 | Shipping         | South San Franc | United States of America |
|         131 | Shipping         | South San Franc | United States of America |
|         132 | Shipping         | South San Franc | United States of America |
|         133 | Shipping         | South San Franc | United States of America |
|         134 | Shipping         | South San Franc | United States of America |
|         135 | Shipping         | South San Franc | United States of America |
|         136 | Shipping         | South San Franc | United States of America |
|         137 | Shipping         | South San Franc | United States of America |
|         138 | Shipping         | South San Franc | United States of America |
|         139 | Shipping         | South San Franc | United States of America |
|         140 | Shipping         | South San Franc | United States of America |
|         141 | Shipping         | South San Franc | United States of America |
|         142 | Shipping         | South San Franc | United States of America |
|         143 | Shipping         | South San Franc | United States of America |
|         144 | Shipping         | South San Franc | United States of America |
|         145 | Sales            | Oxford          | United Kingdom           |
|         146 | Sales            | Oxford          | United Kingdom           |
|         147 | Sales            | Oxford          | United Kingdom           |
|         148 | Sales            | Oxford          | United Kingdom           |
|         149 | Sales            | Oxford          | United Kingdom           |
|         150 | Sales            | Oxford          | United Kingdom           |
|         151 | Sales            | Oxford          | United Kingdom           |
|         152 | Sales            | Oxford          | United Kingdom           |
|         153 | Sales            | Oxford          | United Kingdom           |
|         154 | Sales            | Oxford          | United Kingdom           |
|         155 | Sales            | Oxford          | United Kingdom           |
|         156 | Sales            | Oxford          | United Kingdom           |
|         157 | Sales            | Oxford          | United Kingdom           |
|         158 | Sales            | Oxford          | United Kingdom           |
|         159 | Sales            | Oxford          | United Kingdom           |
|         160 | Sales            | Oxford          | United Kingdom           |
|         161 | Sales            | Oxford          | United Kingdom           |
|         162 | Sales            | Oxford          | United Kingdom           |
|         163 | Sales            | Oxford          | United Kingdom           |
|         164 | Sales            | Oxford          | United Kingdom           |
|         165 | Sales            | Oxford          | United Kingdom           |
|         166 | Sales            | Oxford          | United Kingdom           |
|         167 | Sales            | Oxford          | United Kingdom           |
|         168 | Sales            | Oxford          | United Kingdom           |
|         169 | Sales            | Oxford          | United Kingdom           |
|         170 | Sales            | Oxford          | United Kingdom           |
|         171 | Sales            | Oxford          | United Kingdom           |
|         172 | Sales            | Oxford          | United Kingdom           |
|         173 | Sales            | Oxford          | United Kingdom           |
|         174 | Sales            | Oxford          | United Kingdom           |
|         175 | Sales            | Oxford          | United Kingdom           |
|         176 | Sales            | Oxford          | United Kingdom           |
|         177 | Sales            | Oxford          | United Kingdom           |
|         179 | Sales            | Oxford          | United Kingdom           |
|         180 | Shipping         | South San Franc | United States of America |
|         181 | Shipping         | South San Franc | United States of America |
|         182 | Shipping         | South San Franc | United States of America |
|         183 | Shipping         | South San Franc | United States of America |
|         184 | Shipping         | South San Franc | United States of America |
|         185 | Shipping         | South San Franc | United States of America |
|         186 | Shipping         | South San Franc | United States of America |
|         187 | Shipping         | South San Franc | United States of America |
|         188 | Shipping         | South San Franc | United States of America |
|         189 | Shipping         | South San Franc | United States of America |
|         190 | Shipping         | South San Franc | United States of America |
|         191 | Shipping         | South San Franc | United States of America |
|         192 | Shipping         | South San Franc | United States of America |
|         193 | Shipping         | South San Franc | United States of America |
|         194 | Shipping         | South San Franc | United States of America |
|         195 | Shipping         | South San Franc | United States of America |
|         196 | Shipping         | South San Franc | United States of America |
|         197 | Shipping         | South San Franc | United States of America |
|         198 | Shipping         | South San Franc | United States of America |
|         199 | Shipping         | South San Franc | United States of America |
|         200 | Administration   | Seattle         | United States of America |
|         201 | Marketing        | Toronto         | Canada                   |
|         202 | Marketing        | Toronto         | Canada                   |
|         203 | Human Resources  | London          | United Kingdom           |
|         204 | Public Relations | Munich          | Germany                  |
|         205 | Accounting       | Seattle         | United States of America |
|         206 | Accounting       | Seattle         | United States of America |
|         207 | Accounting       | Seattle         | United States of America |
+-------------+------------------+-----------------+--------------------------+

Solution(8)

+---------------+------+---------+
| Department_id | Year | Num_Emp |
+---------------+------+---------+
|          NULL | 2007 |       1 |
|            10 | 2003 |       1 |
|            20 | 2004 |       1 |
|            20 | 2005 |       1 |
|            30 | 2002 |       1 |
|            30 | 2003 |       1 |
|            30 | 2005 |       2 |
|            30 | 2006 |       1 |
|            30 | 2007 |       1 |
|            40 | 2002 |       1 |
|            50 | 2003 |       3 |
|            50 | 2004 |       4 |
|            50 | 2005 |      12 |
|            50 | 2006 |      13 |
|            50 | 2007 |       9 |
|            50 | 2008 |       4 |
|            60 | 2005 |       1 |
|            60 | 2006 |       2 |
|            60 | 2007 |       2 |
|            70 | 2002 |       1 |
|            80 | 2004 |       5 |
|            80 | 2005 |      10 |
|            80 | 2006 |       7 |
|            80 | 2007 |       5 |
|            80 | 2008 |       7 |
|            90 | 2001 |       1 |
|            90 | 2003 |       1 |
|            90 | 2005 |       1 |
|           100 | 2002 |       2 |
|           100 | 2005 |       2 |
|           100 | 2006 |       1 |
|           100 | 2007 |       1 |
|           110 | 2001 |       1 |
|           110 | 2002 |       2 |
+---------------+------+---------+

Solution(9)

+-------------+------------------+-------------+------------+-------------+
| Employee_id | Emp_name         | E_Hire_date | Manager_id | M_Hire_date |
+-------------+------------------+-------------+------------+-------------+
|         102 | Lex De Haan      | 13-Jan-01   |        100 | 17-Jun-03   |
|         105 | David Austin     | 25-Jun-05   |        103 | 3-Jan-06    |
|         108 | Nancy Greenberg  | 17-Aug-02   |        101 | 21-Sep-05   |
|         109 | Daniel Faviet    | 16-Aug-02   |        108 | 17-Aug-02   |
|         114 | Den Raphaely     | 7-Dec-02    |        100 | 17-Jun-03   |
|         122 | Payam Kaufling   | 1-May-03    |        100 | 17-Jun-03   |
|         131 | James Marlow     | 16-Feb-05   |        121 | 10-Apr-05   |
|         137 | Renske Ladwig    | 14-Jul-03   |        123 | 10-Oct-05   |
|         141 | Trenna Rajs      | 17-Oct-03   |        124 | 16-Nov-07   |
|         142 | Curtis Davies    | 29-Jan-05   |        124 | 16-Nov-07   |
|         143 | Randall Matos    | 15-Mar-06   |        124 | 16-Nov-07   |
|         144 | Peter Vargas     | 9-Jul-06    |        124 | 16-Nov-07   |
|         156 | Janette King     | 30-Jan-04   |        146 | 5-Jan-05    |
|         157 | Patrick Sully    | 4-Mar-04    |        146 | 5-Jan-05    |
|         158 | Allan McEwen     | 1-Aug-04    |        146 | 5-Jan-05    |
|         168 | Lisa Ozer        | 11-Mar-05   |        148 | 15-Oct-07   |
|         169 | Harrison Bloom   | 23-Mar-06   |        148 | 15-Oct-07   |
|         170 | Tayler Fox       | 24-Jan-06   |        148 | 15-Oct-07   |
|         171 | William Smith    | 23-Feb-07   |        148 | 15-Oct-07   |
|         172 | Elizabeth Bates  | 24-Mar-07   |        148 | 15-Oct-07   |
|         174 | Ellen Abel       | 11-May-04   |        149 | 29-Jan-08   |
|         175 | Alyssa Hutton    | 19-Mar-05   |        149 | 29-Jan-08   |
|         176 | Jonathon Taylor  | 24-Mar-06   |        149 | 29-Jan-08   |
|         177 | Jack Livingston  | 23-Apr-06   |        149 | 29-Jan-08   |
|         178 | Kimberely Grant  | 24-May-07   |        149 | 29-Jan-08   |
|         179 | Charles Johnson  | 4-Jan-08    |        149 | 29-Jan-08   |
|         184 | Nandita Sarchand | 27-Jan-04   |        121 | 10-Apr-05   |
|         185 | Alexis Bull      | 20-Feb-05   |        121 | 10-Apr-05   |
|         192 | Sarah Bell       | 4-Feb-04    |        123 | 10-Oct-05   |
|         193 | Britney Everett  | 3-Mar-05    |        123 | 10-Oct-05   |
|         196 | Alana Walsh      | 24-Apr-06   |        124 | 16-Nov-07   |
|         197 | Kevin Feeney     | 23-May-06   |        124 | 16-Nov-07   |
|         198 | Donald OConnell  | 21-Jun-07   |        124 | 16-Nov-07   |
|         200 | Jennifer Whalen  | 17-Sep-03   |        101 | 21-Sep-05   |
|         203 | Susan Mavris     | 7-Jun-02    |        101 | 21-Sep-05   |
|         204 | Hermann Baer     | 7-Jun-02    |        101 | 21-Sep-05   |
|         205 | Shelley Higgins  | 7-Jun-02    |        101 | 21-Sep-05   |
+-------------+------------------+-------------+------------+-------------+

Solution(10)

+--------------------------+-----------------+----------+
| Country_name             | City            | Num_Dept |
+--------------------------+-----------------+----------+
| United States of America | Seattle         |        6 |
| United States of America | Seattle         |        6 |
| United Kingdom           | Oxford          |       34 |
| United States of America | South San Franc |       45 |
+--------------------------+-----------------+----------+

Solution(11)

+------------+----------+-----------+
| Manager_id | M_Salary | Team_size |
+------------+----------+-----------+
|        100 |    24000 |        14 |
|        120 |     8000 |         8 |
|        121 |     8200 |         8 |
|        122 |     7900 |         8 |
|        123 |     6500 |         8 |
|        124 |     5800 |         8 |
|        145 |    14000 |         6 |
|        146 |    13500 |         6 |
|        147 |    12000 |         6 |
|        148 |    11000 |         6 |
|        149 |    10500 |         6 |
+------------+----------+-----------+

Solution(12)

+-------------+-------------------+--------+
| Employee_id | Emp_name          | Salary |
+-------------+-------------------+--------+
|         100 | Steven King       |  28800 |
|         101 | Neena Kochhar     |  20400 |
|         102 | Lex De Haan       |  20400 |
|         103 | Alexander Hunold  |  10800 |
|         104 | Bruce Ernst       |   7200 |
|         105 | David Austin      |   5760 |
|         106 | Valli Pataballa   |   5760 |
|         107 | Diana Lorentz     |   5040 |
|         108 | Nancy Greenberg   |  14410 |
|         109 | Daniel Faviet     |  10800 |
|         110 | John Chen         |   9840 |
|         111 | Ismael Sciarra    |   9240 |
|         112 | Jose Manue Urman  |   9360 |
|         113 | Luis Popp         |   8280 |
|         114 | Den Raphaely      |  13200 |
|         115 | Alexander Khoo    |   3720 |
|         116 | Shelli Baida      |   3480 |
|         117 | Sigal Tobias      |   3360 |
|         118 | Guy Himuro        |   3120 |
|         119 | Karen Colmenares  |   3000 |
|         120 | Matthew Weiss     |   9600 |
|         121 | Adam Fripp        |   9840 |
|         122 | Payam Kaufling    |   9480 |
|         123 | Shanta Vollman    |   7800 |
|         124 | Kevin Mourgos     |   6960 |
|         125 | Julia Nayer       |   3840 |
|         126 | Irene Mikkilinen  |   3240 |
|         127 | James Landry      |   2880 |
|         128 | Steven Markle     |   2640 |
|         129 | Laura Bissot      |   3960 |
|         130 | Mozhe Atkinson    |   3360 |
|         131 | James Marlow      |   3000 |
|         132 | TJ Olson          |   2520 |
|         133 | Jason Mallin      |   3960 |
|         134 | Michael Rogers    |   3480 |
|         135 | Ki Gee            |   2880 |
|         136 | Hazel Philtanker  |   2640 |
|         137 | Renske Ladwig     |   4320 |
|         138 | Stephen Stiles    |   3840 |
|         139 | John Seo          |   3240 |
|         140 | Joshua Patel      |   3000 |
|         141 | Trenna Rajs       |   4200 |
|         142 | Curtis Davies     |   3720 |
|         143 | Randall Matos     |   3120 |
|         144 | Peter Vargas      |   3000 |
|         145 | John Russell      |  16800 |
|         146 | Karen Partners    |  16200 |
|         147 | Alberto Errazuriz |  14400 |
|         148 | Gerald Cambrault  |  13200 |
|         149 | Eleni Zlotkey     |  12600 |
|         150 | Peter Tucker      |  12000 |
|         151 | David Bernstein   |  11400 |
|         152 | Peter Hall        |  10800 |
|         153 | Christophe Olsen  |   9600 |
|         154 | Nanette Cambrault |   9000 |
|         155 | Oliver Tuvault    |   8400 |
|         156 | Janette King      |  12000 |
|         157 | Patrick Sully     |  11400 |
|         158 | Allan McEwen      |  10800 |
|         159 | Lindsey Smith     |   9600 |
|         160 | Louise Doran      |   9000 |
|         161 | Sarath Sewall     |   8400 |
|         162 | Clara Vishney     |  12600 |
|         163 | Danielle Greene   |  11400 |
|         164 | Mattea Marvins    |   8640 |
|         165 | David Lee         |   8160 |
|         166 | Sundar Ande       |   7680 |
|         167 | Amit Banda        |   7440 |
|         168 | Lisa Ozer         |  13800 |
|         169 | Harrison Bloom    |  12000 |
|         170 | Tayler Fox        |  11520 |
|         171 | William Smith     |   8880 |
|         172 | Elizabeth Bates   |   8760 |
|         173 | Sundita Kumar     |   7320 |
|         174 | Ellen Abel        |  13200 |
|         175 | Alyssa Hutton     |  10560 |
|         176 | Jonathon Taylor   |  10320 |
|         177 | Jack Livingston   |  10080 |
|         178 | Kimberely Grant   |   8400 |
|         179 | Charles Johnson   |   7440 |
|         180 | Winston Taylor    |   3840 |
|         181 | Jean Fleaur       |   3720 |
|         182 | Martha Sullivan   |   3000 |
|         183 | Girard Geoni      |   3360 |
|         184 | Nandita Sarchand  |   5040 |
|         185 | Alexis Bull       |   4920 |
|         186 | Julia Dellinger   |   4080 |
|         187 | Anthony Cabrio    |   3600 |
|         188 | Kelly Chung       |   4560 |
|         189 | Jennifer Dilly    |   4320 |
|         190 | Timothy Gates     |   3480 |
|         191 | Randall Perkins   |   3000 |
|         192 | Sarah Bell        |   4800 |
|         193 | Britney Everett   |   4680 |
|         194 | Samuel McCain     |   3840 |
|         195 | Vance Jones       |   3360 |
|         196 | Alana Walsh       |   3720 |
|         197 | Kevin Feeney      |   3600 |
|         198 | Donald OConnell   |   3120 |
|         199 | Douglas Grant     |   3120 |
|         200 | Jennifer Whalen   |   5280 |
|         201 | Michael Hartstein |  15600 |
|         202 | Pat Fay           |   7200 |
|         203 | Susan Mavris      |   7800 |
|         204 | Hermann Baer      |  12000 |
|         205 | Shelley Higgins   |  14410 |
|         206 | William Gietz     |   9960 |
|         207 | Methuku Preetham  |  30000 |
+-------------+-------------------+--------+

Solution(13)

+----------+
| Max_Year |
+----------+
|     2005 |
+----------+

Solution(14)

+-------------+-----------------+
| Employee_id | Emp_name        |
+-------------+-----------------+
|         200 | Jennifer Whalen |
+-------------+-----------------+

Solution(15)

+-------------+-------------------+------+--------+
| Employee_id | Emp_name          | Rank | Salary |
+-------------+-------------------+------+--------+
|         100 | Steven King       |    1 |  28800 |
|         101 | Neena Kochhar     |    2 |  20400 |
|         102 | Lex De Haan       |    2 |  20400 |
|         145 | John Russell      |    4 |  16800 |
|         146 | Karen Partners    |    5 |  16200 |
|         201 | Michael Hartstein |    6 |  15600 |
|         108 | Nancy Greenberg   |    7 |  14410 |
|         205 | Shelley Higgins   |    7 |  14410 |
|         147 | Alberto Errazuriz |    9 |  14400 |
|         168 | Lisa Ozer         |   10 |  13800 |
|         174 | Ellen Abel        |   11 |  13200 |
|         148 | Gerald Cambrault  |   11 |  13200 |
|         114 | Den Raphaely      |   11 |  13200 |
|         162 | Clara Vishney     |   14 |  12600 |
|         149 | Eleni Zlotkey     |   14 |  12600 |
|         169 | Harrison Bloom    |   16 |  12000 |
|         156 | Janette King      |   16 |  12000 |
|         204 | Hermann Baer      |   16 |  12000 |
|         150 | Peter Tucker      |   16 |  12000 |
|         170 | Tayler Fox        |   20 |  11520 |
|         151 | David Bernstein   |   21 |  11400 |
|         157 | Patrick Sully     |   21 |  11400 |
|         163 | Danielle Greene   |   21 |  11400 |
|         152 | Peter Hall        |   24 |  10800 |
|         103 | Alexander Hunold  |   24 |  10800 |
|         158 | Allan McEwen      |   24 |  10800 |
|         109 | Daniel Faviet     |   24 |  10800 |
|         175 | Alyssa Hutton     |   28 |  10560 |
|         176 | Jonathon Taylor   |   29 |  10320 |
|         177 | Jack Livingston   |   30 |  10080 |
|         206 | William Gietz     |   31 |   9960 |
|         110 | John Chen         |   32 |   9840 |
|         121 | Adam Fripp        |   32 |   9840 |
|         120 | Matthew Weiss     |   34 |   9600 |
|         153 | Christophe Olsen  |   34 |   9600 |
|         159 | Lindsey Smith     |   34 |   9600 |
|         122 | Payam Kaufling    |   37 |   9480 |
|         112 | Jose Manue Urman  |   38 |   9360 |
|         111 | Ismael Sciarra    |   39 |   9240 |
|         160 | Louise Doran      |   40 |   9000 |
|         154 | Nanette Cambrault |   40 |   9000 |
|         171 | William Smith     |   42 |   8880 |
|         172 | Elizabeth Bates   |   43 |   8760 |
|         164 | Mattea Marvins    |   44 |   8640 |
|         161 | Sarath Sewall     |   45 |   8400 |
|         155 | Oliver Tuvault    |   45 |   8400 |
|         178 | Kimberely Grant   |   45 |   8400 |
|         113 | Luis Popp         |   48 |   8280 |
|         165 | David Lee         |   49 |   8160 |
|         203 | Susan Mavris      |   50 |   7800 |
|         123 | Shanta Vollman    |   50 |   7800 |
|         166 | Sundar Ande       |   52 |   7680 |
|         179 | Charles Johnson   |   53 |   7440 |
|         167 | Amit Banda        |   53 |   7440 |
+-------------+-------------------+------+--------+

Solution(16)

+-------------------+--------------------------+----------------+------------+
| Emp_name          | Job_title                | Commission_pct | Annual_pay |
+-------------------+--------------------------+----------------+------------+
| Michael Hartstein | Marketing Manager        |              0 |     187200 |
| Pat Fay           | Marketing Representative |              0 |      86400 |
+-------------------+--------------------------+----------------+------------+
2 rows in set (0.01 sec)

Query OK, 108 rows affected (0.00 sec)
Rows matched: 108  Changed: 108  Warnings: 0

+-------------------+--------------------------+----------------+------------+
| Emp_name          | Job_title                | Commission_pct | Annual_pay |
+-------------------+--------------------------+----------------+------------+
| Michael Hartstein | Marketing Manager        |              0 |     205920 |
| Pat Fay           | Marketing Representative |              0 |      95040 |
+-------------------+--------------------------+----------------+------------+

-- ------------------------------------------------------------------------------------------------------------------------------------------------
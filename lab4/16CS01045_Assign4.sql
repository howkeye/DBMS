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

declare
	n number;
	sal number;
	name varchar(10);
begin
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-1');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	select First_name, Salary into name, sal from EMPLOYEES where Employee_id = '130';
	dbms_output.put_line(name || '(old)-> ' || sal);	

	select count(*) into n from EMPLOYEES where First_name = 'Joe';
	dbms_output.put_line('n value -> ' || n);

	if(n = 0) then
		update EMPLOYEES set Salary = (select avg(Salary) from EMPLOYEES) where Employee_id = '130';
	elsif(n > 1) then
		update EMPLOYEES set Salary = (select min(Salary) from EMPLOYEES where First_name = 'Joe') where EMPLOYEE_id = '130';
	elsif(n = 1) then
		update EMPLOYEES set Salary = (select Salary from EMPLOYEES where First_name = 'Joe') where Employee_id = '130';
	end if;

	select First_name, Salary into name, sal from EMPLOYEES where Employee_id = '130';
	dbms_output.put_line(name || '(new)-> ' || sal);
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

declare
	c_id EMPLOYEES.Employee_id % type;
	c_fname EMPLOYEES.First_name % type;
	c_lname EMPLOYEES.Last_name % type;
	cursor res is select Employee_id, First_name, Last_name from EMPLOYEES;
begin
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-2');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	open res;
	loop
		exit when res%notfound;
		fetch res into c_id, c_fname, c_lname;
		
		if res%rowcount = 5 or res%rowcount = 10 then
			dbms_output.put_line(c_id || '->' || c_fname || ' ' || c_lname);
		end if;
		exit when res%rowcount = 11;
	end loop;
	close res;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

declare
begin
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-3');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	update EMPLOYEES 
	set Salary = Salary *(case 
			       	   		when Department_id = 40 and nvl(Commission_pct, 0) <= 0.3 then 1.1
				   			when Department_id = 40 and nvl(Commission_pct, 0) <= 0.3 then 1.15
				   			when (Department_id = 40 or Department_id = 70) and nvl(Commission_pct, 0) > 0.3 then 1.05
				   			else 1
			      		  end);
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace function Q4(Dept_id in DEPARTMENTS.Department_id%type) 
return varchar as
   	Mfname EMPLOYEES.First_name%type; 
	Mlname EMPLOYEES.Last_name%type;
begin
	select First_name, Last_name into Mfname, Mlname 
	from EMPLOYEES 
	where EMPLOYEE_id = (select Manager_id from DEPARTMENTS where DEPARTMENTS.Department_id = Dept_id);
	
	return Mfname|| ' ' || Mlname;
end Q4;
/

declare
begin
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-4');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	dbms_output.put_line(Q4(&Department_id));
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace procedure Q5(Dept_id in DEPARTMENTS.Department_id%type) as
	Mgr_id DEPARTMENTS.Manager_id%type;
	Emp_id EMPLOYEES.Employee_id%type;
begin
	select Employee_id into Emp_id 
	from EMPLOYEES 
	where EMPLOYEES.Salary = (select max(Salary) from EMPLOYEES where Department_id = Dept_id) and Department_id = Dept_id;

	update DEPARTMENTS 
	set Manager_id = Emp_id 
	where Department_id = Dept_id;
end Q5;
/

declare
	Dept_id DEPARTMENTS.Department_id%type;
	Mgr_id DEPARTMENTS.Manager_id%type;
begin
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-5');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	Dept_id := &Department_id;
	Q5(Dept_id);

	dbms_output.put_line(Q4(Dept_id));
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q6 
before update on EMPLOYEES 
for each row

declare
begin
	if :new.Salary < :old.Salary then
		:new.Salary := :old.Salary;
		dbms_output.put_line('Salary cannot be decreased..!');
	end if;
end;
/

declare
	Emp_sal EMPLOYEES.Salary%type;
	Emp_id EMPLOYEES.Employee_id%type;
	Temp_id EMPLOYEES.Employee_id%type;
begin
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-6');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	Temp_id := &Employee_id;	
	
	select Employee_id, Salary into Emp_id, Emp_sal 
	from EMPLOYEES 
	where Employee_id = Temp_id;

	dbms_output.put_line(Emp_id || ' -> ' || Emp_sal);

	update EMPLOYEES 
	set Salary = Salary-1000
	where Employee_id = Temp_id;

	select Employee_id, Salary into Emp_id, Emp_sal
	from EMPLOYEES 
	where Employee_id = Temp_id;

	dbms_output.put_line(Emp_id || ' -> ' || Emp_sal);
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q7
before insert on EMPLOYEES
for each row

declare
	mini EMPLOYEES.Salary%type;
	maxi EMPLOYEES.Salary%type;
begin
	select Min_salary, Max_salary into mini, maxi 
	from JOBS 
	where Job_id = :new.Job_id;

	if :new.Salary < mini or :new.Salary > maxi then
		dbms_output.put_line('This can violate min-max constraint...!');
	end if;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

declare
	J_title JOBS.Job_title%type;
	date_g EMPLOYEES.Hire_date%type;
	Emp_id EMPLOYEES.Employee_id%type;
	cursor res is select * from EMPLOYEES;
	record res%rowtype;
	Dept_id DEPARTMENTS.Department_id%type;
	Temp_id DEPARTMENTS.Department_id%type;
begin

	date_g := &Date_h;
	Dept_id := &Department_id;

	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-9');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	open res;
	loop
		begin
			exit when res%notfound;
			fetch res into record;

			select EMPLOYEES.Department_id into Temp_id from EMPLOYEES where EMPLOYEES.Employee_id = record.Manager_id;

			if to_date(record.Hire_date, 'DD-MM-YYYY') > to_date(date_g, 'DD-MM-YYYY') and Temp_id = Dept_id then
				select Job_title into J_title
				from JOBS 
				where Job_id = record.Job_id;
				dbms_output.put_line('Name : ' || record.First_name || ' ' || record.Last_name || ', Job Title: ' || J_title);
			end if;

		exception
			when no_data_found then continue;

		end;

	end loop;
	close res;

end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q10 
before update on EMPLOYEES 
for each row

declare
	maxi EMPLOYEES.Salary%type;
begin
	select Max_salary into maxi
	from JOBS
	where Job_id = :new.Job_id;

	if :new.Salary > maxi then
		dbms_output.put_line('Too high salary for Employee_id: ' || :new.Employee_id); 
	end if;
end;
/

declare
	cursor c is select * from EMPLOYEES;
	Emp_name varchar(30);
	record c%rowtype;
begin

	dbms_output.put_line('----------------------------------------------------------------------------------------------------');
	dbms_output.put_line('Question-10');
	dbms_output.put_line('----------------------------------------------------------------------------------------------------');

	open c;
	loop
		begin
			exit when c%notfound;
			fetch c into record;

			select EMPLOYEES.First_name || ' ' || EMPLOYEES.Last_name into Emp_name 
			from EMPLOYEES 
			where EMPLOYEES.Employee_id = record.Manager_id;

			if Emp_name like '%King' then
				update EMPLOYEES
				set Salary = Salary*1.1
				where Employee_id = record.Employee_id;
			end if;

		exception
			when no_data_found then continue;

		end;
	end loop;

	close c;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace procedure Q12(Val in EMPLOYEES.Salary%type, Dept_id in DEPARTMENTS.Department_id%type) as
begin
	update EMPLOYEES
	set Salary = Salary+Val
	where Department_id = Dept_id;
end;
/


declare
begin
	Q12(&Val, &Dept_id);
end;
/
-- ------------------------------------------------------------------------------------------------------------------------------------------------

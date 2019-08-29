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
-- question-1
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(a)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q1_a
before insert or update on Registration 
for each row

declare
	cursor c is select prcourseno from Prerequisite where courseno = :new.courseno;
	record c%rowtype;
	num_courses int;
	curr_credits int;
	total_credits int;
	flag boolean := false;  
	exception_1  EXCEPTION;
	exception_2  EXCEPTION;
	exception_3  EXCEPTION;
	exception_4  EXCEPTION;
	pre_grade Grades.grades%type;
	ctype Course.course_type%type;
	elec_course Course.courseno%type;
begin
	select count(*), sum(c.credit) into num_courses, total_credits
	from Registration r, Course c 
	where r.roll = :new.roll and r.courseno = c.courseno and r.semester_no = :new.semester_no;

	select c.credit into curr_credits 
	from Course c 
	where c.courseno = :new.courseno;

	if(num_courses >= 6) then 
		raise exception_1;
	end if;

	if((total_credits+curr_credits) > 24) then
		raise exception_2;
	end if;

	select c.course_type into ctype 
	from Course c 
	where c.courseno = :new.courseno;

	if(ctype = 'elective') then
		flag := true;
	end if;	

	open c;
	loop
		exit when c%notfound;
		fetch c into record;

		select grades into pre_grade 
		from Grades 
		where roll = : new.roll  and courseno = record.prcourseno;
		
		if(pre_grade < 6) then
			raise exception_3;
		end if;
		
		if(flag) then
			begin
				select courseno into elec_course 
				from Registration 
				where roll = :new.roll and courseno = record.prcourseno; 
			exception
				when no_data_found then 
					raise exception_4;
			end;
		end if;

	end loop;
	close c;

exception
	when exception_1 then
		dbms_output.put_line('The number of courses should not be more than 6');
	when exception_2 then
		dbms_output.put_line('The number of credits should not be more than 24');
	when exception_3 then
		dbms_output.put_line('Your prerequisites'' grades are less than required');
	when exception_4 then
		dbms_output.put_line('You did not get registered for prerequisite courses');
	when others then
		dbms_output.put_line('Some no data found error has occurred');
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(b)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q1_b_AttWarning
before insert or update on Attendance 
for each row

declare
	num_days number;
	num_days_present number;
begin
	select count(*) into num_days
	from Attendance 
	where roll = :new.roll and courseno = :new.courseno;

	select count(*) into num_days_present
	from Attendance 
	where roll = :new.roll and courseno = :new.courseno and status = 'p';

	if(mod(num_days, 5) != 0 or num_days = 0) then 
		goto jump;
	end if;

	if((num_days_present/num_days)*100 < 80) then
		insert into attendance_warning values(:new.roll, :new.courseno);
	end if;

	<<jump>>
	dbms_output.put_line(num_days);
end;
/

create or replace trigger Q1_b_Deregistration
before insert or update on attendance_warning
for each row

declare
	num_warnings number;
begin
	select count(*) into num_warnings
	from attendance_warning
	where roll = :new.roll and courseno = :new.courseno;

	if(num_warnings > 0) then
		insert into deregistration values (:new.roll, :new.courseno, sysdate);
		delete from registration where roll = :new.roll and courseno = :new.courseno;
		delete from attendance_warning where roll = :new.roll and courseno = :new.courseno;
	end if;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(c)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select s.roll, s.name, c.semester_no as sem_no, avg(grades) as sem_grade
from Student s, Course c, Grades g
where s.roll = g.roll and g.courseno = c.courseno
group by semester_no, s.roll, s.name;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(d)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select batch, max(sem_grade) as max_grade
from (select s.roll, s.name, c.semester_no as sem_no, avg(grades) as sem_grade, s.batch
	 from Student s, Course c, Grades g
	 where s.roll = g.roll and g.courseno = c.courseno
	 group by semester_no, s.roll, s.name, s.batch) X
group by batch;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(e)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q1_e as 
select s.roll, avg(grades) as sem_grade, semester_no
from Student s, Course c, Grades g
where s.roll = g.roll and c.courseno = g.courseno
group by s.roll, s.name, semester_no;

select roll, avg(sem_grade) as deg_grade
from Q1_e
group by roll
having count(*) >= 8;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(f)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q1_f as
select roll, avg(sem_grade) as deg_grade
from Q1_e
group by roll
having count(*) >= 8;

select Q1_f.roll, s.batch
from Q1_f, Student s
where Q1_f.roll = s.roll and Q1_f.deg_grade in (select max(deg_grade)
											  from Q1_f, Student s
											  where Q1_f.roll = s.roll
											  group by s.batch);

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(g)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select count(*) as dept_wise_count
from Q1_f, Student s
where Q1_f.roll = s.roll and Q1_f.deg_grade > 9
group by s.department;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(h)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q1_h as 
select *
from Course;

select * from Course;
select * from Q1_h;

update Q1_h
set cname ='dbms' 
where cname ='database management';

select * from Course;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
drop view Q1_e;
drop view Q1_f;
drop view Q1_h;
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- question-2
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(a)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace procedure Q2_a as
	cursor c is select * from Emp;
	record c%rowtype;
	days number;
	num number;
begin
	open c;
	loop
		exit when c%notfound;
		fetch c into record;
		select sysdate - to_date(record.joining_date, 'YYYY/MM/DD') into days 
		from Emp;

		if(mod(days, 365) != 0 or days = 0) then 
			continue;
		end if;

		select count(*) into num from Dept where Dept.dmgrno = record.eno;

		if(num = 0) then
			case
				when record.job_type = 'Software Engineer' then 
					update Emp set sal = sal*1.1 where Eno = record.Eno;
				when record.job_type = 'Human Resource' then 
					update Emp set sal = sal*1.07 where Eno = record.Eno;
				when record.job_type = 'Production Engineer' then 
					update Emp set sal = sal*1.15 where Eno = record.Eno;
				when record.job_type = 'Development Engineer' then 
					update Emp set sal = sal*1.12 where Eno = record.Eno;
				else 
					update Emp set sal = sal*1.15 where Eno = record.Eno;
			end case;
		else
			case
				when record.job_type = 'Software Engineer' then 
					update Emp set sal = sal*1.15 where Eno = record.Eno;
				when record.job_type = 'Human Resource' then 
					update Emp set sal = sal*1.1 where Eno = record.Eno;
				when record.job_type = 'Production Engineer' then 
					update Emp set sal = sal*1.18 where Eno = record.Eno;
				when record.job_type = 'Development Engineer' then 
					update Emp set sal = sal*1.15 where Eno = record.Eno;
				else 
					update Emp set sal = sal*1.18 where Eno = record.Eno;
			end case;
		end if;

	end loop;
	close c;
end;
/

create or replace trigger Q2_a_t
before update on Emp
for each row

declare
	tot_sal number;
	cost_dept Manpower_Budget.cost%type;
begin
	select sum(sal) into tot_sal 
	from Emp
	where dept_no = :new.dept_no;

	tot_sal := tot_sal + :new.sal - :old.sal;

	select cost into cost_dept
	from Manpower_Budget
	where dno = :new.dept_no;

	if(tot_sal < cost_dept) then
		insert into salary_hike values(:new.eno, :new.ename, sysdate, :new.sal-:old.sal);
	else
		dbms_output.put_line('Salary cannot be incremented');
	end if;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(b)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace procedure Q2_b as
	cursor c is select dno from Dept order by dno;
	temp_dno Dept.dno%type;
begin
	open c;
	loop
		exit when c%notfound;
		fetch c into temp_dno;

		declare
			cursor c1 is select e1.ename from Emp e1, Emp e2 where e1.sal < e2.sal and e1.dept_no = temp_dno group by e1.eno having (1+count(e2.eno)) <= 3;
			temp_name Emp.ename%type;
		begin
			open c1;
			loop
				exit when c1%notfound;
				fetch c1 into temp_name;
				dbms_output.put_line(temp_name || '-> ' || temp_dno);
			end loop;
			close c1;
		end;

	end loop;
	close c;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(c)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q2_c as 
select *
from Dept;

select * from Dept;
select * from Q2_c;

update Q2_c
set location ='bbsr' 
where location = 'bhubaneswar';

select * from Q2_c;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(d)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q2_d_1 
after insert on Emp 
for each row

declare
begin
	insert into Employee_history values(:new.eno, :new.ename, :new.sal, :new.comm, :new.dept_no, :new.job_type, :new.joining_date, null);
end;
/

create trigger Q2_d_2 
after delete on Emp
for each row

declare
begin
	update Employee_history 
	set leaving_date = sysdate 
	where eno = :old.eno;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
drop view Q2_c;
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- question-3
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(a)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select distinct p.patient_id, p.patient_name
from patient p, appointment a1, appointment a2 
where abs(extract(hour from a1.appt_date-a2.appt_date)) < &period and abs(extract(hour from a1.appt_date - a2.appt_date)) != 0 and p.patient_id = a1.patient_id and a1.patient_id = a2.patient_id and a1.doctor_id = a2.doctor_id
group by p.patient_id, p.patient_name
having count(*) > 2;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(b)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q3_b
after insert on appointment 
for each row

declare
	fee opd_schedule.fees % type;
	birth patient.dob % type;
	gender patient.sex % type;
	n number;
begin
	select fees into fee 
	from opd_schedule 
	where opd_date = :new.appt_date;

	select dob, sex into birth, gender 
	from patient 
	where patient_id = :new.patient_id;
	
	if (extract(year from current_date)-extract(year from birth)) > 50 and gender = 'f' then
		fee := fee/2;
	end if;

	select count(*) into n 
	from appointment 
	where patient_id = :new.patient_id and (extract(day from appt_date)-extract(day from :new.appt_date)) <= 7 and appointment_no != :new.appointment_no;
	
	if n >= 1 then
		fee := 0;
	end if;

	insert into opd_payments values(:new.appointment_no, :new.patient_id, fee, :new.appt_date);

end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(c)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select count(*) as num_p, unit
from doctor, appointment
where appointment.doctor_id = doctor.doctor_id
group by doctor.unit;

select count(*) as num_p, appt_date
from doctor, appointment
where appointment.doctor_id = doctor.doctor_id
group by appointment.appt_date;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(d)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q3_d as 
select * from opd_schedule;

update Q3_d
set Q3_d.opd_date = &some_date
where Q3_d.doctor_id = &some_doctor;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(e)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q3_e as
select p.patient_name, extract(year from current_date)-extract(year from p.dob) age, opd.date_payment, d.name
from patient p, opd_payments opd, appointment a, doctor d
where a.appt_date >= &start_period and a.appt_date <= &end_period and opd.patient_id = p.patient_id and opd.appointment_no = a.appointment_no and a.doctor_id = d.doctor_id and opd.patient_id = a.patient_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(f)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q3_f as 
select * from opd_schedule;

update Q3_f
set fees = fees + &val;
where doctor_id = &doctor;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
drop view Q3_d;
drop view Q3_e;
drop view Q3_f;
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- question-4
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(a)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select s.name 
from student_ s,attendance_ a 
where a.sroll = s.sroll and a.percent < 80 and a.course_id = &cid;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(b)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q4_b as 
select s.sroll, s.name, a.course_id, a.percent 
from student_ s,attendance_ a 
where a.sroll = s.sroll and s.batch = &batch;

select * from Q4_b;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(c)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

select sroll, name 
from Q4_b 
where percent < 70;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(d)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create view Q4_d as 
select sroll, percent 
from attendance_ a 
where course_id = &cid;

select * from Q4_d;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(e)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

update Q4_d 
set percent = &new 
where sroll = &roll;

select * from attendance_;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(f)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace trigger Q4_f
after delete on student_
for each row

declare
begin
	delete from attendance_ where sroll = :old.sroll;
end;
/

select * from attendance_;
delete from student_ where sroll = '3';
select * from attendance_;

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- part-(g)
-- ------------------------------------------------------------------------------------------------------------------------------------------------

create or replace function Q4_g(roll in attendance_.sroll%type, cid in attendance_.course_id%type)
return int as 
	marks int;
begin
	select percent into marks 
	from attendance_
	where sroll = roll and course_id = cid;

	if(marks >= 95) then
		marks := 5;
	elsif(marks > 85) then
		marks := 4;
	elsif(marks > 75) then
		marks := 3;
	elsif(marks > 60) then
		marks := 2;
	else 
		marks := 2;
	end if;

	return marks;

end Q4_g;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
drop view Q4_b;
drop view Q4_d;
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- END
-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Name : Methuku Preetham
-- Roll : 16CS01045

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
-- Question-2
-- ------------------------------------------------------------------------------------------------------------------------------------------------

drop table Book_issue;
drop table Book_return;
drop table Book_stock;
drop table Fine;

create table Book_stock(
	Book_id number(6) not null primary key,
	Title varchar(30) not null,
	No_of_copies number(3)
);

create table Book_issue(
	Card_no number(6) not null,
	Cholder_name varchar(30) not null,
	Book_id number(6) not null references Book_stock(Book_id),
	Issue_date date not null,
	Due_date date not null,
	constraint PK_I primary key(Card_no, Book_id)
);

create table Book_return(
	Card_no number(6) not null,
	Cholder_name varchar(30) not null,
	Book_id number(6) not null references Book_stock(Book_id),
	Return_date date not null,
	Issue_date date not null,
	constraint PK_R primary key(Card_no, Book_id)
);

create or replace trigger question_1_a before insert on Book_issue for each row
declare
	n0 int := 0;
	n1 int := 0;
	n2 int := 0;
	exc0 exception;
	exc1 exception;
	exc2 exception;
begin
	select No_of_copies into n0 from Book_stock where Book_id = :new.Book_id;
	if n0 = 0 then
		raise exc0;
	end if;

	select count(*) into n1 from Book_issue where Card_no = :new.Card_no;
	if n1 = 5 then
		raise exc1;
	end if;

	select count(*) into n2 from Book_issue where Card_no = :new.Card_no and Book_id = :new.Book_id;
	if n2 = 1 then
		raise exc2;
	end if;

exception
	when exc0 then
		dbms_output.put_line('There is no stock of that book..!');
	when exc1 then
		dbms_output.put_line('You have already issued 5 books');
	when exc2 then
		dbms_output.put_line('You have already issued that book');
	when others then
		dbms_output.put_line('Error..!');
end;
/

create or replace trigger question_1_b after insert on Book_issue for each row
declare
	
begin
	update Book_stock set No_of_copies = No_of_copies-1 where Book_id = :new.Book_id;
end;
/

create or replace trigger question_1_c after insert on Book_return for each row
declare
	
begin
	update Book_stock set No_of_copies = No_of_copies+1 where Book_id = :new.Book_id;
end;
/


create table Fine(
	Card_no number(6) not null,
	Amount int not null
); 

create or replace trigger question_1_d before insert on Book_return for each row
declare
	Due_d Book_issue.Due_date%type;
begin
	select Due_date into Due_d from Book_issue where Card_no = :new.Card_no and Book_id = :new.Book_id;

	if :new.Return_date > Due_d then
		insert into Fine(Card_no, Amount) values(:new.Card_no, '50');
	end if;
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
-- Question-9
-- ------------------------------------------------------------------------------------------------------------------------------------------------

drop sequence Req;
drop table Request;
drop table Switch_table;
drop table Broadcast;

create sequence Req start with 1 increment by 1;

create table Request(
	Src_id number(4) not null,
	Dst_id number(4) not null,
	Req_no int not null,
	Src_interface_id number(4) not null
);

create table Switch_table(
	Src_id number(4) not null primary key,
	Src_interface_id number(4) not null
);

create table Broadcast(
	Req_no int not null,
	Src_id number(4) not null,
	Dst_id number(4) not null,
	sys_time varchar(20) not null
);

create or replace trigger question_9_a after insert on Request for each row
declare
	n_src int;
	n_dst int;
	temp_time varchar(20);
	Dst_interface Switch_table.Src_interface_id%type;
begin
	select count(*) into n_src from Switch_table where Src_id = :new.Src_id;

	if n_src = 0 then
		insert into Switch_table values(:new.Src_id, :new.Src_interface_id);
	end if;

	select count(*) into n_dst from Switch_table where Src_id = :new.Dst_id;

	if n_dst = 0 then
		select to_char(current_timestamp, 'HH:MI:SS') into temp_time from dual;
		insert into Broadcast values(:new.Req_no, :new.Src_id, :new.Dst_id, temp_time);
	else
		select Src_interface_id into Dst_interface from Switch_table where Src_id = :new.Dst_id;
		dbms_output.put_line('Req_no: '||:new.Req_no);
		dbms_output.put_line('Src_id: '||:new.Src_id);
		dbms_output.put_line('Forwarded to(Dst_interface_id): '||Dst_interface);
	end if;
end;
/

declare
	count1 int := 0;
	count2 int := 0;
begin
	dbms_output.put_line('-------------------------------------------------------------------------------');
	insert into Request values('1', '2', Req.nextval, '5');
	insert into Request values('3', '2', Req.nextval, '4');
	insert into Request values('4', '3', Req.nextval, '2');
	insert into Request values('2', '1', Req.nextval, '6');
	insert into Request values('5', '6', Req.nextval, '3');
	insert into Request values('6', '5', Req.nextval, '1');

	select count(*) into count1 from Broadcast;
	dbms_output.put_line('-----------------------------------------------');
	dbms_output.put_line('No of entries into Broadcast is(n1): '||count1);
	dbms_output.put_line('-----------------------------------------------');
	
	insert into Request values('1', '2', Req.nextval, '5');
	insert into Request values('3', '2', Req.nextval, '4');
	insert into Request values('4', '3', Req.nextval, '2');
	insert into Request values('2', '1', Req.nextval, '6');
	insert into Request values('5', '6', Req.nextval, '3');
	insert into Request values('6', '5', Req.nextval, '1');
	
	select count(*) into count2 from Broadcast;
	dbms_output.put_line('-----------------------------------------------');
	dbms_output.put_line('No of entries into Broadcast is(n2): '||(count2-count1));
	dbms_output.put_line('-----------------------------------------------');
end;
/

-- ------------------------------------------------------------------------------------------------------------------------------------------------
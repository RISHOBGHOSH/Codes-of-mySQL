create database ineuron
use ineuron

create table course1(
course_id int , 
course_desc varchar(50),
course_mentor varchar(60),
course_price int ,
course_discount int,
create_date date)


create table course_update(
course_metor_update varchar(50),
course_price_update int ,
course_discount_update int )


"before insert trigger"

delimiter //
create trigger course_before_insert
before insert
on course1 for each row
begin 
set new.create_date = sysdate();
end; //

select * from course1 

insert into course1(course_id,course_desc,course_mentor,course_price,course_discount)value(101,"FSDA","sudhanshu",4000,10)

create table course2(
course_id int , 
course_desc varchar(50),
course_mentor varchar(60),
course_price int ,
course_discount int,
create_date date,
user_info varchar(50) )


delimiter //
create trigger course_before_insert12
before insert
on course2 for each row
begin 
declare user_val varchar(50);
set new.create_date = sysdate();
select user() into user_val;
set new.user_info = user_val;

end; //

insert into course2(course_id,course_desc,course_mentor,course_price,course_discount)value(101,"FSDA","sudhanshu",4000,10)

select * from course2

select sysdate()


"reference table"

create table course3(
course_id int , 
course_desc varchar(50),
course_mentor varchar(60),
course_price int ,
course_discount int,
create_date date,
user_info varchar(50))


create table course_update1(
course_metor_update varchar(50),
course_price_update int ,
course_discount_update int )


delimiter //
create trigger course_before_insert11231
before insert
on course3 for each row
begin 
declare user_val varchar(50);
set new.create_date = sysdate();
select user() into user_val;
set new.user_info = user_val;
insert into ref_course values (sysdate() ,user_val);
end; //

create table ref_course(
record_insert_date date,
record_insert_user varchar(50)
)

select * from ref_course

select * from course3

insert into course3(course_id,course_desc,course_mentor,course_price,course_discount)value(101,"FSDA","sudhanshu",4000,10)


"Three tables without manual entering anything insertion in tables test2 & test3"

create table test1(
c1 varchar(50),
c2 date,
c3 int)

create table test2(
c1 varchar(50),
c2 date,
c3 int)


create table test3(
c1 varchar(50),
c2 date,
c3 int)

Delimiter //
create trigger to_update_others
before insert on test1 for each row
begin 
insert into test2 values("xyz",sysdate(),23354);
insert into test3 values("xyz",sysdate(),23354);

end; //

insert into test1 values ("sudhanshu",sysdate(),234234)

select * from test1;
select * from test2;
select * from test3;

"after insert trigger"

Delimiter //
create trigger to_update_others_table
after insert on test1 for each row
begin 
update test2 set c1 = 'abc' where c1 = 'xyz';
delete from test3 where c1 = 'xyz';

end; //

insert into test1 values ("krish",sysdate(),9007789)

select * from test1;
select * from test2;
select * from test3;

"after Delete trigger"

Delimiter //
create trigger to_delete_others_table
after delete on test1 for each row
begin 
insert into test3 values ("after delete",sysdate(),435456);

end; //

select * from test1;

delete from test1 where c1 = 'krish'

select * from test3;


"before delete trigger"

Delimiter //
create trigger to_delete_others_before
before delete on test1 for each row
begin 
insert into test3 values ("before delete",sysdate(),435456);

end; //

delete from test1 where c1 = 'sudhanshu'

select * from test3;

select * from test1;

"how to see the before delete opration"

Delimiter //
create trigger to_delete_others_before_observation
before delete on test1 for each row
begin 
insert into test2 values (old.c1 , old.c2 , old.c3);

end; //


insert into test1 values ("fds",sysdate(),234234)

select * from test1

 delete from test1 where c1 = 'adc'
 
select * from test2

"how to see the after and before delete opration"


create table test11(
c1 varchar(50),
c2 date,
c3 int)


create table test12(
c1 varchar(50),
c2 date,
c3 int )


create table test13(
c1 varchar(50),
c2 date,
c3 int )

delimiter //
create trigger to_delete_others_before_observation3
before delete on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end; //

insert into test11 values("after delete" , sysdate(), 435456);
insert into test11 values("sudhanshu" , sysdate(), 435456);
insert into test11 values("sudh" , sysdate(), 435456);
select * from test11

delete from test11 where c1 = 'sudh'

select * from test12

select * from test11

"how to see the after delete opration"

delimiter //
create trigger to_delete_others_before_observation4
after delete on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end; //


delete from test11 where c1 = 'sudhanshu'

"here both the after and before deletion triggers are working at a smae time"
select * from test12

select * from test11

"after and before update trigger"

delimiter //
create trigger to_upate_others
after update on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end; //

select * from test11;

insert into test11 values("sudh",sysdate(),234354)

update test11 set c1 = "after update" where c1 = "after delete"


select * from test12;

"before update trigger"

delimiter //
create trigger to_upate_others_before
before update on test11 for each row 
begin
	insert into test12(c1,c2,c3) values(new.c1, new.c2,new.c3);
end; //

update test11 set c1 = "insert new" where c1 = "sudh"

select * from test12;

select * from test11;


"questions"

1.create a table col = name , mail_id,phone_number , address , users_sys, time_sys,salary,incentive,final_salary
2.try to time all the time that users name should start with s for each and every insert operation

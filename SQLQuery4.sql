USE ORG;

CREATE TABLE TEST(
EID int,
EFName varchar(20),
ELName varchar(30)
);
--SEQUENCE
create sequence EmpID as int start with 50 increment by 2
insert into test values(NEXT VALUE FOR EmpID,'Sam', 'se')
insert into test values(NEXT VALUE FOR EmpID,'Damon', 'Salvatore')
insert into test values(NEXT VALUE FOR EmpID,'Shine', 'Salvatore')
insert into test values(NEXT VALUE FOR EmpID,'Bonnie','Bennett')

select * from test

--INDEX
create clustered index ID on test(EID)
create index FNAME on test(EFName)

--SYNONYM
CREATE SYNONYM Tes for test
select * from tes where EFName='Sam'

--VIEWS

CREATE VIEW work_dep
as
select * from Worker where DEPARTMENT ='HR'

select * from work_dep
select * from Worker
insert into work_dep values(75,'Mike', 'John',2500, 2010-01-08, 'Trainee')

select * from Worker

select w.WORKER_ID, w.FIRST_NAME, w.DEPARTMENT, b.BONUS_AMOUNT from Worker as w 
inner join test as t on w.WORKER_ID=t.EID;

--MATH FUNCTIONS
SELECT ABS(-1000.7675) as Abs_Output
SELECT LOG10(100) as Log10_Output
SELECT POWER(5,5) as Power_Output
SELECT SIN(0.5) as Sin_Output
SELECT CEILING(0.596) as Ceiling_Output
SELECT FLOOR(0.476) as Floor_Output
SELECT ROUND(34.954,2) as Round_Output
SELECT SQUARE(6) as Square_Output
SELECT RADIANS(180) as Radian_Output

--DATE AND TIME FUNCTIONS
create table DateTime_table
(
TID int,
Date_Time Date 
)

insert into DateTime_table values(next value for EmpID, '2022/09/15')
insert into DateTime_table values(next value for EmpID, '2022/04/09')
insert into DateTime_table values(next value for EmpID, '2021/08/07')
insert into DateTime_table values(next value for EmpID, '2019/11/06')
insert into DateTime_table values(next value for EmpID, '2020/01/10')

select * from DateTime_table
drop table DateTime_table

--print the only date of given value
SELECT DAY('2020-11-06 07:10:11') as Day_Output --as Month_Output, as Year_Output

--add the 2 year to the given year
SELECT DATEADD(year, 2, '2021/08/25') as DateAdd_Output

--Find the difference between the year
SELECT DATEDIFF(year, '2000/11/06', '2022/11/06') as DateDiff_Output

--Check if the enter date is valid or not
SELECT ISDATE('2022-10-07') as Valid_date_Output --1
SELECT ISDATE('Hello!') as Invalid_date_Output --0

--Gives the specific part of date
SELECT DATEPART(day, '2022/10/07') as DatePart_Output

--Gives the date from its part
SELECT DATEFROMPARTS(2022, 10, 31) as DateFrom_Output

--Gives the date and time of SQL server
SELECT SYSDATETIME() as SysDateTime_Output

--print the current date with time
SELECT CURRENT_TIMESTAMP as Current_Date_Time
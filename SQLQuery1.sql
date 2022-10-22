USE ORG

CREATE TABLE SALESMAN(
	salesman_id int primary key,
	name varchar(25) Not Null,
	city varchar(20) Not Null,
	commission float,
)

insert into SALESMAN values(5001, 'James Hoog','New York',0.15);
insert into SALESMAN values(5002, 'Nail Knite','Paris',0.13);
insert into SALESMAN values(5005, 'Pit Alex','London',0.11);
insert into SALESMAN values(5006, 'Mc Lyon','Paris',0.14);
insert into SALESMAN values(5007, 'Paul Adam','Rome',0.13);
insert into SALESMAN values(5003, 'Lauson Hen','San Jose',0.12);

select * from SALESMAN;

--Q1. From the following table, create a view for those salespeople who belong to the city of New York.
create view NewYorkemp
as
select * from SALESMAN where city='New York';

select * from NewYorkemp;

--Q2. From the following table, create a view for all salespersons. Return salesperson ID, name, and city.
create view salesPersons
as
select salesman_id,name,city from SALESMAN;

select * from salespersons;

--Q3. From the following table, create a view to count the number of salespeople in each city. Return city, number of salespersons.

create view CountNoOfstaff
as
select city,count(salesman_id) as count from SALESMAN group by city;

select * from CountNoOfstaff;


--Customer table
create table Customer(
	customer_id int primary key,
	cust_name varchar(25),
	city varchar(25),
	grade int,
	salesman_id int references SALESMAN(salesman_id)
)

insert into Customer values(3002,'Nick Rimando','New York',100,5001);
insert into Customer values(3007,'Brad Davis','New York',200,5001);
insert into Customer values(3005,'Graham Zusi','California',200,5002);
insert into Customer values(3008,'Julian Green','London',300,5002);
insert into Customer values(3004,'Fabian Johnson','Paris',300,5006);
insert into Customer values(3009,'Geoff Cameron','Berlin',100,5003);
insert into Customer values(3003,'Jozy Altidoc','Moscow',200,5007);

select * from Customer;


--Q4. From the following table, create a view that counts the number of customers in each grade.
create view CountNoOfCustomers
as
select grade, count(customer_id) as count from Customer group by grade;

select * from CountNoOfCustomers;



--Orders table
create table Orders(
	ord_no int primary key,
	purch_amt float,
	ord_date datetime,
	salesman_id int FOREIGN KEY references SALESMAN(salesman_id),
	customer_id int FOREIGN KEY references Customer(customer_id),
)

insert into Orders values (70001,150.5,'2012-10-05',5002,3005);
insert into Orders values (70009,270.65,'2012-09-10',5005,3004);
insert into Orders values (70002,65.26,'2012-10-05',5001,3002);
insert into Orders values (70004,110.5,'2012-08-17',5003,3009);
insert into Orders values (70007,948.5,'2012-09-10',5002,3005);
insert into Orders values (70005,2400.6,'2012-07-27',5001,3007);
insert into Orders values (70008,5760,'2012-09-10',5001,3002);

select * from Orders;
--Q5. From the following tables, create a view to get the salesperson and customer by name. Return order name, purchase amount, salesperson ID, name, customer name.

create view Detail
as
select o.ord_no,o.purch_amt,o.ord_date,s.salesman_id,s.name as salesman_name,c.cust_name 
from Orders o, SALESMAN s, Customer c 
where s.salesman_id=o.salesman_id and c.customer_id=o.customer_id;

select * from Detail;
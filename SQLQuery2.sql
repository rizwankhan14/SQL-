use org;


--1. Scalar Function with 2 parameters - any concept
create function Add1(@num1 int,@num2 int)
returns int
as
begin
	return @num1 + @num2
end

select dbo.Add1(7,9) as num

--2. Procedure with OUTPUT parameter
SELECT * FROM Worker2


create procedure AdminCount1(@ACount int OUTPUT)
as
Begin
	Select @ACount=count(WORKERID) from Worker2 where DEPARTMENT='Admin'
End

--execute the procedure with ouput parameter
Declare @Result int
exec AdminCount1 @Result OUTPUT
Print @Result


--3. Trigger to restrict DML access between 6:00PM to 10.00AM
select * from Bonus

create trigger Triggerdemo
on bonus -- table name
FOR INSERT, UPDATE, DELETE
as
begin
	if ((DATEPART(HH,GETDATE())>17) or (DATEPART(HH,GETDATE())<10))
	BEGIN
		print 'Between 6:00PM to 10.00AM you cannot perform DML Operations into the Bonus table '
		Rollback transaction 
	END
end


--Restricting the access for DML operations 
update Bonus set BONUS_AMOUNT=5000 where WORKER_REF_ID=2;
insert into Bonus values(4,6200,'12/09/2022');
delete from Bonus where WORKER_REF_ID=3;


--4. Server-scope trigger to restrict DDL access
create trigger server_ddl
on ALL Server
For Create_Table,Alter_Table,Drop_Table
as
Begin
	Print 'You cannot perform DDL on any Database'
	Rollback Transaction
End

--Inside same database
create table demo(
	tid int
)

--5. Working of explicit transaction with Save transaction
BEGIN TRANSACTION
	insert into TraineeSoftwareEngg values(103,'sush');
	SAVE TRANSACTION updateinsertion
	delete from TraineeSoftwareEngg where Tid=100;
	ROLLBACK TRANSACTION updateinsertion
COMMIT TRANSACTION

select * from TraineeSoftwareEngg;

--6. Difference between throw and Raiserror in exception handling
--Raiserror
print 'Raiserror in exception handling:'
print ' '

BEGIN TRY
  DECLARE @res INT
--Generate divide-by-zero error
  SET @res = 55/0
END TRY
BEGIN CATCH
--Get the details of the error
--that invoked the CATCH block
 DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH


print 'Throw in exception handling:'
print ' '

--throw
BEGIN TRY
  DECLARE @result INT
--Generate divide-by-zero error
  SET @result = 55/0
END TRY
BEGIN CATCH
    THROW
END CATCH
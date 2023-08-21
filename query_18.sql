--find the total charge for each employer.
--bill_rate shows the valid rate starting from this date to another date that assigned a new bill_rate.
--bill_hrs shows the number of hours this employer works with the bill_rate valid for this date.

create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)


--select * from billings
--select * from HoursWorked


with date_ranges as (
select *, 
lead(bill_date, 1, '9999-12-12') over(partition by emp_name order by bill_date) as lead_date
from billings)

select dr.emp_name, sum(bill_rate * bill_hrs) as total_charges
from date_ranges dr
inner join HoursWorked hw on dr.emp_name = hw.emp_name and hw.work_date between dr.bill_date and dr.lead_date
group by dr.emp_name

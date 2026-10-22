-- User Defined Functions & Case

-- 1.Create a function GetFullName that accepts an employee's first name and last name and returns the full name.

delimiter // 
create function full_name( first_name varchar(50), last_name varchar(50))
returns varchar(100)
deterministic
begin
declare name varchar(100);
set name=concat (first_name, " " , last_name);
return name;
end //
delimiter ;

select full_name("Harry","Potter");
select full_name("Peter","Parker");

-- 2.Create a function CalculateAnnualSalary that accepts a monthly salary and returns the annual salary.

delimiter //
create function calculate_annual_salary(monthly_salary decimal(10.2))
returns decimal(12.2)
deterministic
begin
return monthly_salary*12;
end // 
delimiter ;

select calculate_annual_salary(45000);
select calculate_annual_salary(20000);

-- 3.Create a function CalculateBonus that accepts a salary and bonus percentage and returns the bonus amount

DELIMITER $$

CREATE FUNCTION CalculateBonus(salary DECIMAL(10,2),bonus_percentage DECIMAL(5,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN salary * bonus_percentage / 100;
END $$
DELIMITER ;

SELECT CalculateBonus(50000, 10);
select calculatebonus(67000,20);

-- 4.Create a function GetSalaryWithBonus that accepts salary and bonus amounts and returns the total compensation

delimiter // 
create function Getsalarywithbonus(salary decimal(10.2), bonus decimal(12.2))
returns decimal(12.2)
deterministic
begin
return salary+bonus ;
end //
delimiter ;
select getsalarywithbonus(25000,500);

-- 5.Create a function GetNameLength that accepts an employee's name and returns the number of characters.

delimiter $$
create function get_name_length(emp_name varchar(60))
returns int
deterministic
begin
 return char_length(emp_name);
 end $$
 delimiter ;
 select get_name_length("millybobybrown");
 select get_name_length("zendya");
 
 -- 6.Create a function CalculateTax that accepts a salary and returns 10% of the salary.
 
 delimiter //
 create function calculatetax( salary decimal(10.2))
 returns decimal(12.2)
 deterministic
 begin
 return salary * 10/100;
 end //
 delimiter ;
 
 select calculatetax(87000);
 select calculatetax(50000);
 
 -- 7.Create a function GetExperienceYears that accepts a hire date and returns the number of completed years of experience.
 
 delimiter //
 create function get_experience_year(hire_date date)
 returns int 
 deterministic
 begin
 return  TIMESTAMPDIFF(YEAR, hire_date, CURDATE());
 end //
 delimiter ;
 select get_experience_year("2026-10-09");
 select get_experience_year("2005-12-31");
 
 -- 8.Create a function CalculateDiscount that accepts a product price and discount percentage and returns the discounted price.
 

DELIMITER //

CREATE FUNCTION CalculateDiscount(
    price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN price - (price * discount_percentage / 100);
END //
DELIMITER ;
SELECT CalculateDiscount(1000, 10);
select calculatediscount(6099,20); 
 
 -- 9. Create a function GetSalaryGrade that accepts a salary and returns a grade based on these conditions:
-- 	Salary greater than or equal to 90,000: A
-- 	Salary greater than or equal to 75,000: B
-- Salary greater than or equal to 60,000: C
-- 	Otherwise: D


delimiter //
create function getsalarygrade(salary decimal(10,2))
returns char(1)
deterministic
begin
declare graade char(1);
if salary>=90000 then set grade="A";
elseif salary>=75000 then set grade ="B";
elseif salary>=60000 then set grade ="C";
else  set grade="D";
end if;
return grade;
end//
delimiter ;


-- 10.Create a function IsEligibleForBonus that accepts a salary and returns 1 if the salary is at least 80,000; otherwise, return 0.
delimiter //
create function IsEligibleForBonus(salary decimal(10,2))
returns int
deterministic
begin
declare bonus int;
if salary >=80000 then set bonus =1;
else set bonus=0;
end if;
return bonus ;
end //
delimiter ;

select  IsEligibleForBonus (98000);
select  IsEligibleForBonus(5000)

-- 11 Create a function GetDepartmentCode that accepts a department name and returns a short code, such as Finance → FIN, IT → IT, HR → HR, and Marketing → MKT.

delimiter //
create function GetDepartmentCode (dept_name varchar(50))
returns varchar(10)
deterministic
begin
declare code varchar(10);
if dept_name ="finance" then set code= "FIN";
elseif dept_name="it" then set code= "IT";
elseif dept_name ="Hr" then set code="HR";
elseif dept_name="marketing" then set code ="MKT";
end if;
return code;
end //
delimiter ;

select GetDepartmentCode("finance");
select GetDepartmentCode("marketing");

-- 12.	Create a function CalculateNetSalary that accepts salary and tax percentage and returns the salary after deducting tax

delimiter //
create function CalculateNetSalary(salary decimal(10,2), tax_percentage decimal(5,2))
returns decimal(10,2)
deterministic
begin
declare net_salary decimal(10,2);
set net_salary= salary-(salary*tax_percentage/100);
return net_salary;
end //
delimiter ;
select calculatenetsalary(34000,10);
select calculatenetsalary(70000,5);

-- 13.	Create a function GetHireYear that accepts a hire date and returns the year of joining.
delimiter //
create function gethireyear(hire_date date)
returns year
deterministic
begin
return year(hire_date);
end //
delimiter ;

select gethireyear("2026-12-12");
select gethireyear("2027-02-21")

-- 14.Create a function CalculateAgeInMonths that accepts a number of years and returns the equivalent number of months
delimiter //
create function calculateageinmonths(years int)
returns int
deterministic
begin
return  years*12;
end //
delimiter ;
select calculateageinmonths(2);
select calculateageinmonths(9);

-- 15.Create a function GetSalaryDifference that accepts two salary values and returns the absolute difference between them

delimiter //
create function getsalarydifference(salary1 decimal(10,2) , salary2 decimal (10,2))
returns decimal(10,2)
deterministic
begin
return abs(salary1-salary2);
end //
delimiter ;
select  getsalarydifference(6000,2000);
select  getsalarydifference(8000,9000);



-- CASE statements

-- 1.Display employee names and a salary category: High for salaries of 80,000 or above; otherwise, Low.

select employee_name,
case 
when salary >=80000 then "Above"
else "Low" 
end as salary_category from employees;

-- 2.Display employee names and salary grades: A for 90,000 or above, B for 75,000–89,999, C for 60,000–74,999, and D below 60,000.

select employee_name,
case 
when salary>=90000 then "A"
when salary between 75000 and 89999 then "B"
when salary between 60000 and 74999 then "C"
when salary < 60000 then "D"
end as salary_grade from employees;

-- 3.Display employee names and classify their departments as Technical for IT, Finance Team for Finance, and Other Department for all remaining departments

select firstname ,
case 
when department ="IT" then "Technical"
when department ="finance" then "Finance Team"
else "other department"
end as dept_category
from emp;

-- 4.Display employee names and classify them as Experienced if hired before 2018, otherwise Recent Hire
select firstname,
case 
when hiredate<"2018-01-01" then "Experienced"
else "Recent hire"
end as experience_category
from emp;

-- 5.Use a simple CASE expression to display the full department name or a short label for each department

select department,
case department
when "IT" then "Information Technology"
when "HR" then "Human Resources"
when "sales" then "Sales Department"
when "marketing" then "Marketing Department"
when "python" then "Python Department"
when  "finance" then "finance Department"
end  as "dept_fullname" from emp;

-- 6.Display employee names, salaries, and a bonus category: 15% for salaries of at least 90,000, 10% for salaries of at least 75,000, and 5% otherwise.

select firstname, salary,
case
when salary>= 90000 then salary *15/100
when salary >=75000 then salary*10/100
else salary*5/100
end as Bonus_category from emp;

-- 7.Display employee names and salary after a proposed increase: 15% for Finance employees, 10% for IT employees, and 5% for all other departments

select firstname,salary,department,
case 
when department="finance"then  salary+(salary *15/100)
when department ="it" then salary+( salary*10/100)
else salary+(salary*5/100)
end as increased_salary from emp;

-- 8.Classify employees into experience groups based on completed years of service: Senior for 8 or more years, Mid-Level for 4–7 years, and Junior for fewer than 4 years

select firstname, hiredate,
timestampdiff(year,hiredate,curdate())
as Experience_years,
case
when timestampdiff( year,hiredate, curdate())>=8 then "Senior"
when timestampdiff(year, hiredate,curdate()) between 4 and 7 then "Mid-Level"
else "Junior"
end as Experience_group from emp;	


-- 9.Display employee names and a salary status: Above Average if salary is greater than the overall average salary, otherwise Below or Equal to Average.

select firstname,salary,
case
when salary> (select avg(salary)from emp)then "Above Average"
else "Below or Equal to average"
end as salary_status from emp;

-- 10.Display each employee's department and assign a priority label: Priority 1 for IT, Priority 2 for Finance, and Priority 3 for other departments.

select department,
case
when department = "it" then 1
when department ="finance" then 2
else 3
end as priority from emp;

-- 11.	Display employee names and their bonus eligibility: Eligible for salaries of at least 80,000 and Not Eligible otherwise

select firstname ,
case 
when salary>=80000 then "Eligible"
else "Not Eligible"
end as Bonus_eligibility from emp;

-- 12.Display employee names and salary bands, then sort the results by salary band and salary.

select firstname,salary,
case
when salary>=80000 then "High"
when salary >=50000 then "Medium"
else "low"
end as salary_band from emp;

-- 13.	Count the number of employees in each salary category: High (80,000 or above) and Low (below 80,000).

select
case 
when salary>80000 then "High"
when salary<80000 then "Low"
end as salary_category , count(*)as employee_count from emp
group by salary_category;

-- 14.Calculate the total salary paid to employees in each department, separating salaries into Above 75,000 and 75,000 or Below.

select department,
sum(case
when  salary>75000 then salary
else 0 
end) as Above_75000,
sum(case
when salary <75000 then salary
else 0
end) as salary_75000_or_below
from emp
group by department;

-- 15.	Count how many employees were hired before 2018 and from 2018 onward.

select 
case 
when hiredate<"2018-01-01" then "Before 2018"
else "2018 onwards"
end as hire_category,
count(*) as employee_count from emp
group by hire_category;

-- 16.	Calculate the total proposed bonus for each department using the bonus percentages specified in Question 6.

select department,
sum(case
when salary >=90000 then salary*15/100
when salary >=75000 then salary*10/100
else salary*5/100
end ) as total_proposed_bonus from emp
group by department;

-- 17.	Display each department's average salary and classify the department as High-Paying if the average is at least 75,000; otherwise, Standard-Paying.

select department, avg(salary)as average_salary,
case
 when avg(salary)>=75000 then "High paying"
else "Standard paying"
end as salary_category from emp
group by department;

-- 18.	Use a CASE expression in an UPDATE statement to assign a 15% salary increase to Finance employees, 10% to IT employees, and 5% to all others.
--  (Use a transaction or a test copy of the table.)

update emp 
set salary = case 
when department ="finance" then salary*1.15
when department ="it" then salary *	1.10
else salary*1.05
end ;

-- 19.	Sort employees by a custom department order: IT first, Finance second, HR third, Marketing fourth, and any remaining departments last.

select* from emp
order by 
case 
when department="it" then 1
when department ="finance" then 2
when department= "marketing" then 3
when department="sales" then 4
when department="hr" then 5
else 6
end;

-- 20.	Write a query using CASE to display a readable label for each employee's salary status and sort employees with High Salary first.

select *,
case
when salary>=80000 then "High salary"
else "Low salary"
end as salary_status
from emp 
order by 
case 
when salary>=80000 then 1
else 2
end;

-- 1.	Create a user-defined function that returns an employee's salary grade, then use it in a SELECT query.

delimiter //
 create function GetSalaryGrade(Salary DECIMAL(10,2))
returns varchar(10)
deterministic
begin
declare Grade Varchar(10);
    set Grade =
        CASE
when Salary >= 80000 then 'A'
when Salary >= 70000 then 'B'
when Salary >= 50000 then  'C'
else 'D'
END;
return Grade;
end //
delimiter ;
select firstname, salary,getsalarygrade(salary)as salarygrade from emp;

-- 2.Create a function that calculates years of experience and use it to classify employees with a CASE statement.

delimiter //
Create function GetExperience(hireDate date )
Returns int
deterministic
Begin 
return timestampdiff(Year, hireDate, curdate());
END // 
delimiter ;


SELECT firstname,hiredate,GetExperience(hiredate) AS Experience,
case 
when GetExperience(hiredate) >= 8 Then  'Senior'
when GetExperience(hiredate) >= 4 Then  'Mid-Level'
else 'Junior'
end as Experience_Category
from  Emp;

-- 3.	Use CASE with SUM() to calculate the total bonus amount for each department.

Select department,
SUM(
case
when salary >= 90000 Then  salary * 0.50
when salary >= 75000 then  salary * 0.10
else salary * 0.05
end)
as Total_Bonus
from  Emp
group by  department;

-- 4.	Create a view that includes employee name, salary grade, and bonus eligibility.
 
 create view  Employee_Salary as 
Select firstname,
case
when salary >= 90000 then  'A'
when salary >= 75000 then 'B'
when salary >= 60000 then  'C'
else 'D'
end as Salary_Grade,
case 
when salary >= 80000 then 'Eligible'
else 'Not Eligible'
end as Bonus_Eligibility
from emp;
select * from employee_salary;

-- 5.Write a query that combines CASE, a subquery, and aggregate functions to identify departments with above-average salary expenditure.

SELECT department,SUM(salary) AS Total_Salary,
CASE
WHEN SUM(salary) > (SELECT AVG(dept_total)FROM 
(SELECT SUM(salary) AS dept_total
FROM Employees
GROUP BY department) AS Department_Salaries)
THEN 'Above Average'
ELSE 'Average or Below'
END AS Salary_Expenditure_Status
FROM Employees
GROUP BY department;

SELECT AVG(dept_total)
FROM (
    SELECT SUM(salary) AS dept_total
    FROM Employees
    GROUP BY department
) AS Department_Salaries

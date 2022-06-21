use assignment; -- This my Database Name

select * from countries; -- To retrieve all the values from countries table
select * from departments; -- To retrieve all the values from departments table
select * from employees; -- To retrieve all the values from employees table
select * from job_history; -- To retrieve all the values from job_history table
select * from jobs; -- To retrieve all the values from jobs table
select * from locations; -- To retrieve all the values from locations table
select * from regions; -- To retrieve all the values from regions table



-- 1. Write a SQL query to find the salaries of all employees
/* Here I'm retriving the salaries of
all the employees by using select statement. And I added employee_id and name for better understanding.*/
select EMPLOYEE_ID,FIRST_NAME,SALARY from employees;

-- 2. Write a SQL query to find the unique designations of the employees. Return job name.
/* Here I put distinct to avoid duplicate values to retrive the 
unique designation for the employees*/
select DISTINCT JOB_TITLE from jobs;

-- 3. write a SQL query to list the employees’ name, increased their salary by 15%, and expressed as number of Dollars.
/*Here I'm retriving the salaries of all the employess increase by
15% and express as number of dollars*/
select concat(FIRST_NAME, ' ', LAST_NAME) AS Employee_Name, concat('$', round((15/100)*SALARY, 2)) AS "Salary in dollars" from employees; 

-- 4. Write a SQL query to list the employee's name and job name as a format of "Employee & Job".
/* Here I'm retriving the values of the employes and job by using where clause.*/
select concat(e.First_Name, '   ', j.JOB_TITLE) as "Employee & Job" From employees e, jobs j  WHERE e.JOB_ID = j.JOB_ID;

/*5. Write a SQL query to find those employees with hire date in the format like February 22, 1991. 
Return employee ID, employee name, salary, hire date */
/* Here I'm displaying employee id, employee name and the values of hire date in the format like month day, year*/
select Employee_ID, concat(FIRST_NAME,' ',LAST_NAME) as Employee_Name, Salary,  DATE_FORMAT(HIRE_DATE, '%M %d, %Y') AS "Hire Date" FROM employees;


/* 6. Write a SQL query to count the number of characters except the spaces for each employee name. 
Return employee name length.*/
-- Here I'm displaying the Employee name and total length of the employee name
select Concat(FIRST_NAME, ' ', LAST_NAME) AS Employee_Name, length(replace(first_name, ' ',''))+length(replace(last_name, ' ','')) as "Name length" from employees;

-- 7. Write a SQL query to find the employee ID, salary, and commission of all the employees. 
-- Here I'm displaying the emp id, salary along with the commission.
select EMPLOYEE_ID, SALARY,concat(FORMAT(COMMISSION_PCT*100, 'C'), '%') as 'commission' from employees;


-- 8. Write a SQL query to find the unique department with jobs. Return department ID, Job name. 
/* Here I'm displaying the department with their names by using where clause */
select DISTINCT e.DEPARTMENT_ID,  j.JOB_TITLE from employees e, jobs j where e.JOB_ID = j.JOB_ID;

-- 9. Write a SQL query to find those employees who joined before 1991. Return complete information about the employees.
/*Here I'm displaying the values of the employees who joined before 1991*/
select * from employees where HIRE_DATE<'1991-01-01';

-- 10. Write a SQL query to compute the average salary of those employees who work as ‘shipping clerk’. Return average salary.
/* Here I'm displaying the average salary of the employees who works as shipping clerk*/
select avg(SALARY) from employees where JOB_ID = ( select JOB_ID from jobs where JOB_TITLE = 'shipping clerk');




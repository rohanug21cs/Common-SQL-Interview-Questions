Create database org;
use org;
CREATE TABLE WORKER (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);

INSERT INTO WORKER
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    (001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
    (002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
    (003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
    (004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
    (005, 'Vivek', 'Bhati', 500000, '14-06-20 09.00.00', 'Admin'),
    (006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
    (007, 'Satish', 'Kumar', 75000, '14-02-20 09.00.00', 'Account'),
    (008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
    
SELECT * FROM WORKER;

CREATE TABLE BONUS (
	WORKER_REF_ID INT,
    BONUS_AMOUNT INT(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY(WORKER_REF_ID) REFERENCES WORKER(WORKER_ID)
    ON DELETE CASCADE
);
INSERT INTO BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(001, 5000, '16-02-20'),
(002, 3000, '16-06-11'),
(003, 4000, '16-02-20'),
(001, 4500, '16-02-20'),
(002, 3500, '16-06-11');

SELECT * FROM BONUS;

CREATE TABLE TITLE (
	WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY(WORKER_REF_ID) REFERENCES WORKER(WORKER_ID)
    ON DELETE CASCADE
);

INSERT INTO TITLE (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES 
(001, 'MANAGER', '2016-02-20 00:00:00'),
(002, 'EXECUTIVE', '2016-06-11 00:00:00'),
(008, 'EXECUTIVE', '2016-06-11 00:00:00'),
(005, 'MANAGER', '2016-06-11 00:00:00'),
(004, 'ASST. MANAGER', '2016-06-11 00:00:00'),
(007, 'EXECUTIVE', '2016-06-11 00:00:00'),
(006, 'LEAD', '2016-06-11 00:00:00'),
(003, 'LEAD', '2016-06-11 00:00:00');

SELECT * FROM TITLE;

-- 1. FETCH 'FIRST_NAME' FROM WORKER TABLE USING THE ALIAS NAME AS <WORKER_NAME>
select first_name AS WORKER_NAME FROM WORKER;

-- 2. FETCH 'FIRST_NAME' FROM WORKER TABLE IN UPPER CASE
select UPPER(first_name) FROM WORKER;

-- 3. FETCH UNIQUE VALUES OF DEPARTMENT FROM WORKER TABLE
select DISTINCT(department) FROM WORKER;

-- 4. PRINT THE FIRST THREE CHARACTERS OF 'FIRST_NAME' FROM WORKER TABLE
select substring(first_name, 1, 3) FROM WORKER;

-- 5. find the position of the alphabet 'b' in the first name column 'Amitabh' from worker table
select INSTR(first_name, 'b') from worker where first_name='Amitabh';

-- 6. print the first_name from WORKER table after removing whitespaces from the right side.
select RTRIM(first_name) from WORKER;

-- 7. print the first_name from WORKER table after removing whitespaces from the LEFT side.
select LTRIM(first_name) from WORKER;

-- 8. query that fetches the unique value of department from WORKER table and prints its length.
select distinct(department), length(department) from WORKER;

-- 9. print first_name from worker table after replacing 'a' with 'A'.
select REPLACE(first_name, 'a', 'A') from WORKER;

-- 10. print the first_name and last_name from the WORKER table as a single column COMPLETE_NAME.
-- a space char should separate them
select CONCAT(first_name, ' ', last_name) AS COMPLETE_NAME from WORKER;

-- 11. Sql query to print all the worker details from the worker table order by first_name ascending.
select * from WORKER ORDER BY first_name;

-- 12. Sql query to print all the worker details from the worker table order by first_name ascending and department descending.
 select * from WORKER ORDER BY first_name ASC, department DESC;
 
 -- 13. Sql query to print details of the workers from the worker table with first_name as 'Vipul' and 'Satish'.
 select * from WORKER WHERE first_name IN ('Satish', 'Vipul');
 
-- 14. Sql query to print details of the workers from the worker table excluding first_name as 'Vipul' and 'Satish'.
select * from WORKER WHERE first_name NOT IN ('Satish', 'Vipul');

-- 15. print details of the worker with department name as 'Admin'.
select * from WORKER WHERE DEPARTMENT LIKE 'Admin%'; -- focus here that why we used % because it is mention name to be as, not is. So, we used LIKE.

-- 16. SQL query to print details of the workers whose first name contains 'a'.
select * from WORKER WHERE first_name LIKE '%a%';

-- 17. SQL query to print details of the workers whose first_name ends with 'a'.
select * from WORKER WHERE first_name LIKE '%a';

-- 18. SQL query to print details of the workers whose first_name ends with 'h' and contains six alphabets.
select * from WORKER WHERE first_name LIKE '%h' and length(first_name)=6;

-- 19. SQL query to print details of the workers whose salary lies between 100000 and 500000.
select * from WORKER WHERE salary between 100000 and 500000;

-- 20. SQL query to print details of the workers who have joined in Feb'2014.
select * from WORKER WHERE YEAR(joining_date)=2014 and MONTH(joining_date)=02;

-- 21. SQL query to fetch the count of employees working in the department 'Admin'.
select department, count(*) from WORKER WHERE department='Admin';

-- 22. SQL query to fetch worker full name with salaries >=50000 and <=100000.
select concat(first_name, ' ', last_name) from WORKER WHERE salary between 50000 and 100000;

-- 23. SQL query to fetch the number of workers for each department in the descending order.
select department, count(worker_id) AS no_of_worker from WORKER group by department order by no_of_worker DESC;

-- 24. SQL query to print the details of the workers who are also manager.
select * from WORKER AS w INNER JOIN TITLE AS t on w.worker_id=t.worker_ref_id WHERE worker_title='Manager';

-- 25. SQL query to fetch number (more than 1) of different titles in the ORG.
select worker_title, count(*) AS number from TITLE group by worker_title having count(*)>1;

-- 26. SQL query to show only odd rows from the table.
select * from WORKER WHERE MOD(worker_id,2) != 0; -- we can also use <> in place of !=

-- 27. SQL query to show only even rows from the table.
select * from WORKER WHERE MOD(worker_id,2) = 0;

-- 28. SQL query to clone a new table from another table.
CREATE TABLE WORKER_CLONE LIKE WORKER;
INSERT INTO WORKER_CLONE SELECT * FROM WORKER;
SELECT * FROM WORKER_CLONE;

-- 29. SQL query to fetch intersection records of two tables.
SELECT  worker.* from worker_clone inner join worker using(worker_id);

-- 30. SQL query to show record from one table that another table doesn't have.
-- MINUS
select worker.* from worker left join worker_clone using(worker_id) WHERE worker_clone.worker_id is NULL;  
-- remember we need to make the joining parameter of right table as NULL in left join.

-- 31. SQL query to show current data and time.
select curdate();
select now();

-- 32. SQL query to show the top n (say 5) records of a table order by descending salary.
select * from WORKER order by SALARY desc LIMIT 5;

-- 33. SQL query to determine the nth (say n=5) highest salary from a table.
select * from WORKER order by SALARY desc LIMIT 4,1;  -- here 4 is exclusive ( leave 4th and then give 1 next)

-- 34. SQL query to determine the 5th highest salary without using the LIMIT keyword.
select salary from worker w1
WHERE 4 = (
select count(DISTINCT(w2.salary)) from worker w2 where w2.salary>=w1.salary
);

-- 35. SQL query to fetch the list of employees with the same salary.
select * from worker w1, worker w2 where w1.salary=w2.salary and w1.worker_id <> w2.worker_id;

-- 36. SQL query to show the second highest salary from the table worker using sub-queries. (Can't use LIMIT or corelated subqueries)
select max(salary) from worker 
where salary not in (select max(salary) from worker);

-- 37. SQL query to show one row twice in results from a table.
select * from worker 
UNION ALL             -- UNION will give distinct values only, so we have used UNION ALL.
select * from worker;  

-- 38. SQL query to list worker_id who does not get bonus.
select worker_id from worker where worker_id not in 
(select worker_ref_id from bonus);

-- 39. SQL query to fetch the first 50% records from the table.
select * from worker where worker_id <= (select count(worker_id)/2 from worker);

-- 40. SQL query to fetch the department that has less than 4 people in it.
select department, count(department) from worker group by department having count(department) < 4;

-- 41. SQL query to show all departments along with the number of people in there.
select department, count(department) as Number_of_people from worker group by department;

-- 42. SQL query to show the last record from a table.
select * from worker where worker_id = (select max(worker_id) from worker);

-- 43. SQL query to fetch the first row of a table.
select * from worker where worker_id = (select min(worker_id) from worker);

-- 44. SQL query to fetch the last five records from the table.
(select * from worker order by worker_id desc limit 5) order by worker_id;

-- 45. SQL query to print the name of employees having the highest salary in each department.
select department, first_name, last_name from worker where salary in (select max(salary) from worker group by department);
-- OR
select w.department, w.first_name, w.last_name from
(select max(salary) as maxSal, department from worker group by department) temp
inner join worker w on temp.department = w.department and temp.maxSal = w.salary;

-- 46. SQL query to fetch three max salaries from a table using co-related subqueries. 
select distinct(salary) from worker w1
where 3>= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;
-- w1 is the outer table, corresponding to which we run the inner query multiple times. And counting those distinct tuples whose w1.salary <= w2.salary and output those whose count is greater than 3.
select distinct salary from worker order by salary desc limit 3;


-- 47. SQL query to fetch three min salaries from a table using co-related subqueries.
select distinct(salary) from worker w1
where 3>= (select count(distinct salary) from worker w2 where w1.salary >= w2.salary) order by w1.salary desc;

-- 48. SQL query to fetch nth max salaries from a table.
select distinct(salary) from worker w1
where n>= (select count(distinct salary) from worker w2 where w1.salary <= w2.salary) order by w1.salary desc;

-- 49. SQL query to fetch departments along with the total salaries paid for each of them.
select department, sum(salary) as totalSal from worker group by department;

-- 50. SQL query to fetch the names of workers who earns the highest salary.
select first_name, salary from worker where salary = (select max(salary) from worker);

-- 51. Practice the question from code help lecture assignment where we have to remove the reverse pairs from the table.
-- solution (USING JOINS)
create table pairs (
A int,
B int
);
insert into pairs values (1,2),(2,4),(2,1),(3,2),(4,2),(5,6),(6,5),(7,8);

select * from pairs;

select * from pairs lt INNER JOIN pairs rt on lt.A=rt.B and lt.B=rt.A; -- this will give the reverse pairs join

select lt.* from pairs lt INNER JOIN pairs rt on lt.A=rt.B and lt.B=rt.A
where rt.A is NULL OR lt.A < rt.A;

-- solution (USING Co-related subqueries)
select * from pairs p1 WHERE not exists
(select * from pairs p2 WHERE p1.B=p2.A and p1.A=p2.B and p1.A >p2.A);
-- outer table p1 should not exist in the second co-related subquery

-- Homwork: Dry run all the above queries.


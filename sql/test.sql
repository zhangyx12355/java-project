SELECT '?§Û??',employee_id,last_name
  FROM employees;

DESC `order`;

SELECT * FROM employees WHERE department_id = 90;

SELECT * FROM employees WHERE last_name = 'King';

#1
SELECT employee_id , last_name , (salary + IFNULL(commission_pct,0)) * 12 "ANNAL" FROM employees;

#2
SELECT DISTINCT job_id  FROM employees;

#3
SELECT first_name , last_name , salary FROM employees  WHERE salary > 12000;

#4
SELECT last_name , first_name , department_id FROM employees WHERE employee_id = 176;

#5
DESC departments;
SELECT * FROM departments;

SELECT 10 * 10, 100 DIV 2 FROM DUAL;

SELECT last_name, first_name FROM employees WHERE employee_id % 2 = 0;

SELECT NULL = NULL FROM DUAL;

#???????
SELECT * FROM employees WHERE commission_pct = NULL;

# ???????(NULL <=> NULL ????1)
SELECT * FROM employees WHERE commission_pct <=> NULL;

SELECT * FROM employees WHERE commission_pct IS NOT NULL;

SELECT LEAST(1,2,3) FROM DUAL;

SELECT LEAST('a','b','c') FROM DUAL;

SELECT GREATEST('a','b','c') FROM DUAL;

SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct IS NULL;

SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct IS NOT NULL;

-- "<=>NULL" "ISNULL()"" "IS NULL" ???;
SELECT last_name,salary,commission_pct FROM employees WHERE ISNULL(commission_pct);

SELECT LEAST('g' ,'b ','t','m'),GREATEST('g','b','t','m') FROM DUAL;

SELECT LEAST(first_name ,last_name),LEAST(LENGTH(first_name) ,LENGTH(last_name)) FROM employees;

SELECT employee_id,last_name,salary FROM employees WHERE salary BETWEEN 6000 and 8000;

SELECT first_name,last_name,department_id FROM employees WHERE department_id IN (10,20,30);

-- "_"?????????????????"%"??????????????
SELECT first_name,last_name FROM employees WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

SELECT LEAST(first_name ,last_name) AS first_name from employees;

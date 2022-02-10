SELECT '尚硅谷',employee_id,last_name
  FROM employees;

DESC `order`;

SELECT * FROM employees WHERE department_id = 90;

SELECT * FROM employees WHERE last_name = 'King';

##练习3
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

## 4.运算符
SELECT 10 * 10, 100 DIV 2 FROM DUAL;

SELECT last_name, first_name FROM employees WHERE employee_id % 2 = 0;

SELECT NULL = NULL FROM DUAL;

#无返回结果
SELECT * FROM employees WHERE commission_pct = NULL;

# 安全等与(NULL <=> NULL 结果为1)
SELECT * FROM employees WHERE commission_pct <=> NULL;

SELECT * FROM employees WHERE commission_pct IS NOT NULL;

SELECT LEAST(1,2,3) FROM DUAL;

SELECT LEAST('a','b','c') FROM DUAL;

SELECT GREATEST('a','b','c') FROM DUAL;

SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct IS NULL;

SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct IS NOT NULL;

-- "<=>NULL" "ISNULL()"" "IS NULL" 相同;
SELECT last_name,salary,commission_pct FROM employees WHERE ISNULL(commission_pct);

SELECT LEAST('g' ,'b ','t','m'),GREATEST('g','b','t','m') FROM DUAL;

SELECT LEAST(first_name ,last_name),LEAST(LENGTH(first_name) ,LENGTH(last_name)) FROM employees;

SELECT employee_id,last_name,salary FROM employees WHERE salary BETWEEN 6000 and 8000;

SELECT first_name,last_name,department_id FROM employees WHERE department_id IN (10,20,30);

-- "_"代表一个不确定字符，"%"代表多个任意字符
SELECT first_name,last_name FROM employees WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

SELECT LEAST(first_name ,last_name) AS first_name from employees;

## 练习4
#1
SELECT first_name,last_name,salary FROM employees WHERE salary NOT BETWEEN 5000 AND 12000;
#2
# SELECT last_name,department_id FROM employees WHERE department_id = 20 || department_id = 80;
SELECT last_name,department_id FROM employees WHERE department_id IN (20,80);
#3
SELECT last_name,job_id FROM employees WHERE manager_id IS NULL;
#4
SELECT last_name,salary,commission_pct FROM employees WHERE commission_pct IS NOT NULL;
#5
SELECT first_name,last_name FROM employees WHERE  first_name LIKE '__a%';
#6
SELECT first_name,last_name FROM employees WHERE first_name LIKE '%a%' AND first_name LIKE '%k%';
#7
SELECT first_name,last_name FROM employees WHERE first_name LIKE '%e';
#8
SELECT last_name,job_id,department_id FROM employees WHERE department_id BETWEEN 80 AND 100;
#9
SELECT last_name,salary,manager_id FROM employees WHERE manager_id = 100 ||manager_id = 101 ||manager_id =110;
SELECT last_name,salary,manager_id FROM employees WHERE manager_id IN (100,101,110);

## 5.排序与分页
# 默认查询返回按照先后添加的顺序
SELECT * FROM employees;

# 升序 ASC ，降序DESC （默认ASC）
SELECT employee_id,last_name,salary FROM employees ORDER BY salary DESC ;
#ORDER BY 可以使用别名，WHERE不能用别名
SELECT employee_id, salary * 12 AS annual_sal
  FROM employees
 ORDER BY annual_sal;

#二级排序
#按照deaprtment降序排列，salary升序排列
SELECT employee_id, salary, department_id
  FROM employees
 WHERE department_id IN (110, 100, 90)
 ORDER BY department_id DESC, salary;

#分页 page1
SELECT employee_id,last_name
  FROM employees
 LIMIT 0,20;
# page2
SELECT employee_id, last_name
  FROM employees
 LIMIT 20,20;
#pageSize 公式：LIMIT (pageNo. - 1) * pageSize,pageSize

#2.2 'WHERE' 'ORDER BY' 'LIMIT' 顺序：
SELECT  employee_id,last_name,salary
FROM employees
WHERE salary > 6000
ORDER BY salary DESC
# LIMIT 0,10;
LIMIT 10;

#MYSQL8 LIMIT 第几条 OFFSET 偏移量

SELECT salary,last_name FROM employees ORDER BY salary DESC LIMIT 1;

## 练习5
#1
SELECT last_name, department_id, salary * 12
  FROM employees
 ORDER BY salary DESC, last_name;
#2
SELECT last_name, salary
  FROM employees
 WHERE salary NOT BETWEEN 8000 AND 17000
 ORDER BY salary DESC
  LIMIT 20,20;
#3
SELECT last_name, salary, email
  FROM employees
 WHERE email LIKE '%e%'
 ORDER BY LENGTH(email) DESC, department_id;

## 多表查询

DESC departments;

#查询员工名‘Abel’ 在哪工作
SELECT * FROM employees WHERE last_name = 'Abel';

SELECT * FROM departments WHERE department_id = 80;

SELECT city FROM locations WHERE location_id = 2500;

#2889 条（error）
SELECT employee_id, department_name FROM employees,departments;
## Answer
SELECT *
  FROM employees AS emp,
       departments AS dept,
       locations
 WHERE last_name = 'Abel'
   AND emp.department_id = dept.department_id
   AND dept.location_id = locations.location_id;

## 多表查询分类
/*
 等值连接 vs 非等值连接
 自连接 vs 非自连接
 内连接 vs 外连接
 */
# 1.非等值连接
# 非等值连接 example：

SELECT last_name,salary,grade_level
FROM employees,job_grades
WHERE employees.salary BETWEEN job_grades.lowest_sal AND job_grades.highest_sal;

# 2.自连接
SELECT *
  FROM employees;
#查询员工id，员工姓名，管理者id，管理者姓名
SELECT emp.employee_id, emp.last_name, boss.employee_id, boss.last_name
FROM employees AS emp,employees AS boss
WHERE emp.manager_id = boss.employee_id;

#3. 内连接和外连接
#外连接包括左外连接、右外连接、满外连接
#左外连接
# 查询所有员工last_name,department_name信息
SELECT e.last_name, d.department_name
  FROM employees e
           LEFT JOIN departments d
           ON e.department_id = d.department_id;
# 右外连接
SELECT e.last_name, d.department_name
  FROM employees e
           RIGHT JOIN departments d
           ON e.department_id = d.department_id;
#满外连接（mysql不支持FULL JOIN）
# SELECT e.last_name, d.department_name
#   FROM employees e
#            FULL JOIN departments d
#            ON e.department_id = d.department_id;

# UNION（去重）和UNION ALL（不去重）
#建议：UNION ALL

SELECT e.last_name, d.department_name
  FROM employees e
           LEFT JOIN departments d
           ON e.department_id = d.department_id
 UNION ALL
SELECT e.last_name, d.department_name
  FROM employees e
           RIGHT JOIN departments d
           ON e.department_id = d.department_id
 WHERE e.department_id IS NULL;

#自然连接
SELECT *
FROM employees NATURAL JOIN departments d;

##练习6-1
#1.显示 所有员工 的姓名，部门号和部门名称。
SELECT last_name, e.department_id, department_name
  FROM employees e
           LEFT JOIN departments d
           ON e.employee_id = d.manager_id;
#2.查询90号部门员工的job_id和90号部门的location_id
SELECT job_id,location_id
  FROM employees,departments
 WHERE employees.department_id =90 AND departments.department_id = 90;
# 3.选择 所有 有奖金的员工的 last_name , department_name , location_id , city
SELECT last_name, department_name, departments.location_id, locations.location_id, city
  FROM employees
           LEFT JOIN departments
           ON employees.department_id = departments.department_id
           LEFT JOIN locations
           ON departments.location_id = locations.location_id
 WHERE employees.commission_pct IS NOT NULL;
# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name
SELECT last_name , job_id,employees.department_id,department_name
  FROM employees,departments,locations
WHERE employees.department_id = departments.department_id
AND  departments.location_id = locations.location_id
AND  locations.city = 'Toronto';
# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’
SELECT department_name,street_address,last_name,job_id,salary
FROM employees,departments,locations
WHERE employees.department_id = departments.department_id
  AND departments.location_id = locations.location_id
AND department_name = 'Executive';
# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
#  employees Emp# manager Mgr#
#  kochhar 101 king 100
SELECT emp.last_name,mgr.last_name,emp.employee_id,mgr.employee_id
FROM employees emp LEFT JOIN employees mgr
ON emp.manager_id = mgr.employee_id;



##练习6-2
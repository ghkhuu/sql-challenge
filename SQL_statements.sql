
/*DATA ENGINEERING - Set up database*/

USE sql_challenge;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Dept_manager;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Employees (
    emp_no INT NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
    );

CREATE TABLE Departments (
    dept_no CHAR(10) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (dept_no)
    );

CREATE TABLE Dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(10) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)
		REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no)
		REFERENCES Departments(dept_no)
    );

CREATE TABLE Dept_manager (
    dept_no CHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)
		REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no)
		REFERENCES Departments(dept_no)
    );

CREATE TABLE Titles (
    emp_no INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)
		REFERENCES Employees(emp_no)
    );

CREATE TABLE Salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)
		REFERENCES Employees(emp_no)
    );


/*LOADING DATA INTO TABLES*/

SET autocommit=0; # these are done to improve performance of LOAD DATA INTO TABLE as seen here https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb-bulk-data-loading.html
SET unique_checks=0;
SET foreign_key_checks=0;

LOAD DATA LOCAL INFILE 'C:/Users/hungk/PycharmProjects/sql-challenge/EmployeeSQL/employees.csv'
into table Employees
fields terminated by ','
	enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(emp_no,birth_date,first_name,last_name,gender,hire_date);

LOAD DATA LOCAL INFILE 'C:/Users/hungk/PycharmProjects/sql-challenge/EmployeeSQL/departments.csv'
into table Departments
fields terminated by ','
	enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(dept_no,dept_name);

LOAD DATA LOCAL INFILE 'C:/Users/hungk/PycharmProjects/sql-challenge/EmployeeSQL/dept_emp.csv'
into table Dept_emp
fields terminated by ','
	enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(emp_no,dept_no,from_date,to_date);

LOAD DATA LOCAL INFILE 'C:/Users/hungk/PycharmProjects/sql-challenge/EmployeeSQL/dept_manager.csv'
into table Dept_manager
fields terminated by ','
	enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(dept_no,emp_no,from_date,to_date);

LOAD DATA LOCAL INFILE 'C:/Users/hungk/PycharmProjects/sql-challenge/EmployeeSQL/salaries.csv'
into table Salaries
fields terminated by ','
	optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(emp_no,salary,from_date,to_date);

LOAD DATA LOCAL INFILE 'C:/Users/hungk/PycharmProjects/sql-challenge/EmployeeSQL/titles.csv'
into table Titles
fields terminated by ','
	optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows
(emp_no,title,from_date,to_date);

COMMIT;
SET unique_checks=1;
SET foreign_key_checks=1;


/*DATA ANALYSIS*/

/*1. List the following details of each employee: employee number, last name, first name,
gender, and salary.*/
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary from Employees e, Salaries s
WHERE e.emp_no=s.emp_no;

/*2. List employees who were hired in 1986.*/
SELECT CONCAT(first_name,' ',last_name) AS "Employees hired in 1986" FROM Employees
WHERE YEAR(hire_date) = 1986;

/*3. List the manager of each department with the following information: department number,
department name, the manager's employee number, last name, first name, and start and end
employment dates.*/
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM Dept_manager dm
LEFT JOIN Departments d ON dm.dept_no=d.dept_no
LEFT JOIN Employees e ON dm.emp_no=e.emp_no;

/*4. List the department of each employee with the following information: employee number,
last name, first name, and department name.*/
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name FROM Dept_emp de
LEFT JOIN Employees e ON de.emp_no=e.emp_no
LEFT JOIN Departments d ON de.dept_no=d.dept_no;

/*5. List all employees whose first name is "Hercules" and last names begin with "B."*/
SELECT * FROM Employees
WHERE first_name="Hercules" and last_name LIKE "B%";

/*6. List all employees in the Sales department, including their employee number,
last name, first name, and department name.*/
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM Dept_emp de, Employees e, Departments d
WHERE de.emp_no=e.emp_no AND de.dept_no=d.dept_no AND d.dept_name="Sales";

/*7. List all employees in the Sales and Development departments, including their employee number,
last name, first name, and department name.*/
SELECT DISTINCT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM Dept_emp de
JOIN Employees e ON de.emp_no=e.emp_no
JOIN Departments d ON de.dept_no=d.dept_no
WHERE d.dept_name="Sales" OR d.dept_name='Development';

/*8. In descending order, list the frequency count of employee last names, i.e.,
how many employees share each last name.*/
SELECT last_name, COUNT(emp_no) AS "Count" from Employees
GROUP BY last_name
ORDER BY "Count" DESC;


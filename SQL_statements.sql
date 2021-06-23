/*DATA ENGINEERING*/

USE sql_challenge;

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Dept_manager;


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


/*DATA ANALYSIS*/



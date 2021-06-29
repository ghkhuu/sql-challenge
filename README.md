# Exploring Pewlett Hackard employment data
###A Data Analysis challenge from [deepenrp/sql-challenge](https://github.com/deepenrp/sql-challenge)

## Background

The project revolves around six .csv files as the remainder of the employees data from 1980s to 1990s. Using these 
files, I will try to set up a Database and establish an ETL pipeline for analysis and visualization.

### Data Modeling
Using the online tool at [Quick Database Diagram](http://www.quickdatabasediagrams.com), I generated an ERD showcasing
relationships among the entities through primary and foreign keys, as well as different table constraints.

![alt text](https://github.com/ghkhuu/sql-challenge/blob/master/ERD%20for%20database.png)

_ERD for the database schema containing 6 tables_

### Data Engineering

With the ERD diagram, I went ahead and create a local MySQL database and table schemas for each table. The data from 
each file is then loaded into corresponding table. 

At first, I used MySQL data import wizard to import the data but that approach quickly proved to be non-realistic 
due to the size of the datasets (4 out of 6 files contains more than 300k records, and importing with the wizard only 
imported ~4000 rows after 30 minutes).

After searching around for a better solution, it appears the LOAD DATA LOCAL INFILE method is the most efficient way to 
import large amount of data into MySQL database. Couple this with tweaking a few database setting for _auto_commit,
unique_checks, foreign_key_checks_, I was able to import all the data into the database in less than 1 minute. The SQL 
commands for this whole session can be found [here](https://github.com/ghkhuu/sql-challenge/blob/master/SQL_statements.sql)

### Data Analysis

With the database set up and ready, I challenged myself with writing some queries to perform exploratory analysis. 
Queries of the following 8 questions can be found in the "SQL_statement" file above.
1. List the following details of each employee: employee number, last name, first name, gender, and salary.
2. List employees who were hired in 1986.
3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
4. List the department of each employee with the following information: employee number, last name, first name, and department name.
5. List all employees whose first name is "Hercules" and last names begin with "B."
6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

#### SQL Alchemy

After initial analysis, the data is then brought into Jupyter notebook with SQLalchemy to be transformed and visualized.
Figure 1 shows that the majority of employees at Pewlett Hackard earns between $40k and 50K annually.

![alt text](https://github.com/ghkhuu/sql-challenge/blob/master/histogram.jpg)

_Figure 1: Histogram of salary ranges_

In another aspect, figure 2 reveals Sales department has the highest average salary, followed by Marketing and Finance.
Employees with title as Staff or Senior Staff are generally paid more than other job titles, and there are very little
difference in salary across the gender line.

![alt text](https://github.com/ghkhuu/sql-challenge/blob/master/average_salaries.jpg)

_Figure 2: Average salaries among different groups of employees_


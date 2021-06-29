# Exploring Pewlett Hackard employment data
###A Data Analysis challenge from [deepenrp/sql-challenge](https://github.com/deepenrp/sql-challenge)

## Background

The project revolves around six .csv files as the remainder of the employees data from 1980s to 1990s. Using these 
files, I will try to set up a Database and establish an ETL pipeline for analysis and visualization.

### Data Modeling
Using the online tool at [Quick Database Diagram](http://www.quickdatabasediagrams.com), I generated an ERD showcasing
relationships among the entities through primary and foreign keys, as well as different table constraints.

![alt text](https://github.com/ghkhuu/sql-challenge/blob/master/ERD%20for%20database.png "ERD diagram")

### Data Engineering
* Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.
* Import each CSV file into the corresponding SQL table.

### Data Analysis

1. List the following details of each employee: employee number, last name, first name, gender, and salary.
2. List employees who were hired in 1986.
3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
4. List the department of each employee with the following information: employee number, last name, first name, and department name.
5. List all employees whose first name is "Hercules" and last names begin with "B."
6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

### SQL Alchemy
* Import the SQL database into Pandas using the following:
   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```
* Create a histogram to visualize the most common salary ranges for employees.
* Create a bar chart of average salary by title.

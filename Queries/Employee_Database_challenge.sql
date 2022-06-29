-- Creating tables for Employee_Database_Challenge
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
-- Creating Employees table
CREATE TABLE employees (
	emp_no int NOT NULL,
	birth_date date NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NOT NULL,
	gender varchar NOT NULL,
	hire_date date NOT NULL,
	PRIMARY KEY (emp_no)
);

-- Creating Department Manager Table
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- Creating Salaries table

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

--Creating Department Employee Table
CREATE TABLE dept_emp(
	emp_no int NOT NULL,
	dept_no varchar(4) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no,emp_no)
);
-- Creating Employees Title Table
CREATE TABLE titles(
	emp_no int NOT NULL,
	title varchar NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no,title,from_date)
);

-- Create new table for retiring employees
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
				rt.first_name,
				rt.last_name,
				rt.title

INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT (ut.emp_no) DESC

SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

SELECT COUNT (e.emp_no),
	ti.title
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1963-01-01' AND '1965-12-31')
GROUP BY ti.title
ORDER BY COUNT (e.emp_no)DESC;

SELECT COUNT (e.emp_no),
	ti.title
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (ti.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1961-03-01' AND '1965-12-31')
GROUP BY ti.title
ORDER BY COUNT (e.emp_no)DESC;

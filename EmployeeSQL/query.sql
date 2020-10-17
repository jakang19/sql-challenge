-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp_no AS "Employee ID",
	last_name AS "Last Name",
	first_name AS "First Name",
	sex,
	(SELECT s.salary
	 FROM salaries s
	 WHERE e.emp_no = s.emp_no)
FROM employees e
--LIMIT 10
;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT last_name AS "Last Name",
	first_name AS "First Name",
	hire_date AS "Hire Date"
FROM employees
WHERE hire_date LIKE '%/1986'
--LIMIT 10
;
-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dm.dept_no AS "Dept Number",
	(SELECT d.dept_name
	 FROM departments d
	 WHERE dm.dept_no = d.dept_no) AS "Dept Name",
	dm.emp_no AS "Employee ID",
	e.last_name AS "Last Name",
	e.first_name AS "First Name"
FROM dept_manager dm
LEFT JOIN employees e
ON dm.emp_no = e.emp_no;

-- List the department of each employee with the following information:
--employee number, last name, first name, and department name.
SELECT emp_no AS "Employee ID",
	last_name AS "Last Name",
	first_name AS "First Name",
	(SELECT d.dept_name
	 FROM departments d
	 WHERE dept_no IN
	 	(SELECT dept_no
		FROM dept_emp
		WHERE e.emp_no = dept_emp.emp_no
		)
	) AS "Dept Name"
FROM employees e
--LIMIT 10
;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name AS "First Name",
	last_name AS "Last Name",
	sex
FROM employees
WHERE first_name = 'Hercules' 
	AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no AS "Employee ID",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	d.dept_name AS "Dept Name"
FROM employees e
LEFT JOIN dept_emp
ON dept_emp.emp_no = e.emp_no
LEFT JOIN departments d
ON dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';


-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no AS "Employee ID",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	d.dept_name AS "Dept Name"
FROM employees e
LEFT JOIN dept_emp
ON dept_emp.emp_no = e.emp_no
LEFT JOIN departments d
ON dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "Last Name", COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;


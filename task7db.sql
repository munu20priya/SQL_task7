CREATE DATABASE TechCompany;

USE TechCompany;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(dept_id)
);

INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Customer Support'),
(4, 'Finance');

INSERT INTO Employee (emp_id, emp_name, department_id, salary, hire_date) VALUES
(11, 'Vijay', 1, 50000.00, '2020-06-15'),
(12, 'Vinay', 2, 60000.00, '2019-07-01'),
(13, 'Vikas', 2, 70000.00, '2018-03-21'),
(14, 'David', 3, 65000.00, '2021-05-30'),
(15, 'Smith', 1, 55000.00, '2022-01-10');

-- VIEW 1
-- Creating the View with Complex SELECT (i.e, Join + Filter + Order)
CREATE VIEW HighSalary_IT_Employees AS
SELECT e.emp_name, e.salary, d.dept_name, e.hire_date
FROM Employee e
JOIN Department d ON e.department_id = d.dept_id
WHERE d.dept_name = 'HR' AND e.salary > 55000
ORDER BY e.salary DESC;

-- Using  the created View
SELECT * FROM HighSalary_IT_Employees;

-- View 2: This view shows the list of Employees hired after 2020
CREATE VIEW Recent_Hires AS
SELECT emp_name, hire_date, dept_name
FROM Employee e
JOIN Department d ON e.department_id = d.dept_id
WHERE hire_date > '2020-01-01'
ORDER BY hire_date DESC;

SELECT * FROM Recent_Hires;

-- View 3: This view shows the list of Department-wise average salary
CREATE VIEW Dept_Avg_Salary AS
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM Employee e
JOIN Department d ON e.department_id = d.dept_id
GROUP BY d.dept_name;

SELECT * FROM Dept_Avg_Salary;


-- View 4: This view shows the list of All employees with their department and experience in years
CREATE VIEW Employee_Experience AS
SELECT e.emp_name, d.dept_name,
       ROUND(DATEDIFF(CURDATE(), e.hire_date) / 365, 1) AS experience_years
FROM Employee e
JOIN Department d ON e.department_id = d.dept_id
ORDER BY experience_years DESC;

SELECT * FROM Employee_Experience;
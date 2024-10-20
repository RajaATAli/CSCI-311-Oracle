-- QUERY 1 which improves performance on employee_project

-- Original Explain Plan
EXPLAIN PLAN FOR 
SELECT project_id FROM employee_project WHERE employee_id = 738;
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, ''));

-- Create Index
CREATE INDEX idx_employee_project_emp_id ON employee_project (employee_id);

-- New Explain Plan
EXPLAIN PLAN FOR 
SELECT project_id FROM employee_project WHERE employee_id = 738;
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, ''));

-- Explanation:
-- The original explain plan showed a full table scan of the employee_project table.
-- Creating an index on the employee_id column allows the query to perform an INDEX RANGE SCAN, quickly finding rows with employee_id = 738, which reduces the query cost and improves performance.

-- Drop Index
DROP INDEX idx_employee_project_emp_id;

-- QUERY 2 which improves performance on employee-department join

-- Original Explain Plan
EXPLAIN PLAN FOR 
SELECT e.employee_name, d.department_name 
FROM employee e 
INNER JOIN department d 
ON e.department_id = d.department_id 
WHERE e.employee_name = 'Daisy';
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, ''));

-- Composite Index
CREATE INDEX idx_employee_name_dept_id ON employee (employee_name, department_id);

-- New Explain Plan
EXPLAIN PLAN FOR 
SELECT e.employee_name, d.department_name 
FROM employee e 
INNER JOIN department d 
ON e.department_id = d.department_id 
WHERE e.employee_name = 'Daisy';
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, ''));

-- Explanation:
-- The original plan indicated a nested loop join with a full table scan on employee.
-- By creating a composite index on employee_name and department_id, the query utilizes an INDEX RANGE SCAN, filtering by employee_name and optimizing the join, which reduces I/O and speeds up query execution.

-- Drop Index
DROP INDEX idx_employee_name_dept_id;

-- QUERY 3 which improves performance on finding MIN(hired_date) in the Finance department

-- Original Explain Plan
EXPLAIN PLAN FOR 
SELECT MIN(hired_date) 
FROM employee e 
INNER JOIN department d 
ON e.department_id = d.department_id 
WHERE d.department_name = 'Finance';
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, ''));

-- Create Indexes
CREATE INDEX idx_department_name ON department (department_name);
CREATE INDEX idx_employee_dept_hired_date ON employee (department_id, hired_date);

-- New Explain Plan
EXPLAIN PLAN FOR 
SELECT MIN(hired_date) 
FROM employee e 
INNER JOIN department d 
ON e.department_id = d.department_id 
WHERE d.department_name = 'Finance';
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', null, ''));

-- Explanation:
-- The original plan showed a full table scan on the employee and department tables.
-- Adding an index on department_name speeds up filtering on the department. 
-- Also, creating a composite index on department_id and hired_date helps the query find the minimum hired_date more efficiently, improving performance.

-- Drop Indexes
DROP INDEX idx_department_name;
DROP INDEX idx_employee_dept_hired_date;

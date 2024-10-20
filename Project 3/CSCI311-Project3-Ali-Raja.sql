-- Employees Who Aren't Assigned to Any Projects
SELECT e.employee_name
FROM employee e
LEFT JOIN employee_project ep ON e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL;

-- Employees Who Have Worked on Multiple Projects
SELECT e.employee_name
FROM employee e
JOIN employee_project ep ON e.employee_id = ep.employee_id
GROUP BY e.employee_name
HAVING COUNT(ep.project_id) > 1;

-- Employees in HR Hired Before 2023
SELECT e.employee_name, e.hired_date
FROM employee e
JOIN department d ON e.department_id = d.department_id
WHERE d.department_name = 'HR'
AND e.hired_date < TO_DATE('2023-01-01', 'YYYY-MM-DD');

-- Count Projects For Every Department
SELECT d.department_name, 
       COUNT(DISTINCT ep.project_id) AS project_count
FROM department d
LEFT JOIN employee e ON d.department_id = e.department_id
LEFT JOIN employee_project ep ON e.employee_id = ep.employee_id
GROUP BY d.department_name
ORDER BY project_count DESC, d.department_name;

-- Count Managers on Each Project
SELECT p.project_name, 
       COUNT(DISTINCT e.employee_id) AS manager_count
FROM project p
JOIN employee_project ep ON p.project_id = ep.project_id
JOIN employee e ON ep.employee_id = e.employee_id
WHERE e.employee_id IN (SELECT DISTINCT manager_employee_id FROM employee WHERE manager_employee_id IS NOT NULL)
GROUP BY p.project_name;

-- List All Potential Teams
SELECT it.employee_name AS it_employee_name, 
       finance.employee_name AS finance_employee_name, 
       hr.employee_name AS hr_employee_name
FROM employee it
JOIN department d1 ON it.department_id = d1.department_id AND d1.department_name = 'IT'
CROSS JOIN employee finance
JOIN department d2 ON finance.department_id = d2.department_id AND d2.department_name = 'Finance'
CROSS JOIN employee hr
JOIN department d3 ON hr.department_id = d3.department_id AND d3.department_name = 'HR';

-- b - innclude Daisy as HR and Union with Original Teams
SELECT it.employee_name AS it_employee_name, 
       finance.employee_name AS finance_employee_name, 
       'Daisy' AS hr_employee_name
FROM employee it
JOIN department d1 ON it.department_id = d1.department_id AND d1.department_name = 'IT'
CROSS JOIN employee finance
JOIN department d2 ON finance.department_id = d2.department_id AND d2.department_name = 'Finance'
WHERE finance.employee_name <> 'Daisy'
UNION ALL
SELECT it.employee_name AS it_employee_name, 
       finance.employee_name AS finance_employee_name, 
       hr.employee_name AS hr_employee_name
FROM employee it
JOIN department d1 ON it.department_id = d1.department_id AND d1.department_name = 'IT'
CROSS JOIN employee finance
JOIN department d2 ON finance.department_id = d2.department_id AND d2.department_name = 'Finance'
CROSS JOIN employee hr
JOIN department d3 ON hr.department_id = d3.department_id AND d3.department_name = 'HR';

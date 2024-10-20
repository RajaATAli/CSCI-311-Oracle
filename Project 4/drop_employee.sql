-- Drop the employee_project table first (no dependencies)
DROP TABLE employee_project;

-- Drop the employee table (depends on department and self-references)
DROP TABLE employee;

-- Drop the project table (no dependencies)
DROP TABLE project;

-- Drop the department table (independent table)
DROP TABLE department;

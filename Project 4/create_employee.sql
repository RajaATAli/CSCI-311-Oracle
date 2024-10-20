CREATE TABLE department (
    department_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL
);

CREATE TABLE employee (
    employee_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    employee_name VARCHAR2(100) NOT NULL,
    hired_date DATE NOT NULL,
    department_id NUMBER,
    manager_employee_id NUMBER,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    CONSTRAINT fk_manager FOREIGN KEY (manager_employee_id) 
    REFERENCES employee(employee_id) DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE project (
    project_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    project_name VARCHAR2(100) NOT NULL
);

CREATE TABLE employee_project (
    employee_project_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    employee_id NUMBER,
    project_id NUMBER,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

INSERT INTO department (department_name) VALUES ('HR');
INSERT INTO department (department_name) VALUES ('Finance');
INSERT INTO department (department_name) VALUES ('IT');
INSERT INTO department (department_name) VALUES ('Marketing');

INSERT INTO employee (employee_name, hired_date, department_id, manager_employee_id) 
VALUES ('Frank', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 1, 2);
INSERT INTO employee (employee_name, hired_date, department_id, manager_employee_id) 
VALUES ('Daisy', TO_DATE('2022-07-01', 'YYYY-MM-DD'), 2, 3);
INSERT INTO employee (employee_name, hired_date, department_id, manager_employee_id) 
VALUES ('Alice', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1, NULL);
INSERT INTO employee (employee_name, hired_date, department_id, manager_employee_id) 
VALUES ('Bob', TO_DATE('2021-03-10', 'YYYY-MM-DD'), 1, 1);
INSERT INTO employee (employee_name, hired_date, department_id, manager_employee_id) 
VALUES ('Charlie', TO_DATE('2021-05-20', 'YYYY-MM-DD'), 2, NULL);
INSERT INTO employee (employee_name, hired_date, department_id, manager_employee_id) 
VALUES ('Eve', TO_DATE('2023-02-18', 'YYYY-MM-DD'), 3, NULL);

INSERT INTO project (project_name) VALUES ('Project Alpha');
INSERT INTO project (project_name) VALUES ('Project Beta');
INSERT INTO project (project_name) VALUES ('Project Gamma');
INSERT INTO project (project_name) VALUES ('Project Delta');

INSERT INTO employee_project (employee_id, project_id) VALUES (1, 1);
INSERT INTO employee_project (employee_id, project_id) VALUES (2, 1);
INSERT INTO employee_project (employee_id, project_id) VALUES (2, 2);
INSERT INTO employee_project (employee_id, project_id) VALUES (3, 2);
INSERT INTO employee_project (employee_id, project_id) VALUES (4, 3);
INSERT INTO employee_project (employee_id, project_id) VALUES (5, 3);
INSERT INTO employee_project (employee_id, project_id) VALUES (1, 4);
COMMIT;
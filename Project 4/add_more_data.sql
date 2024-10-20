BEGIN
    FOR i IN 1..10000 LOOP
        INSERT INTO employee (
            employee_name,
            hired_date,
            manager_employee_id,
            department_id
        )
        VALUES (
            'Employee_' || i,
            TO_DATE('2020-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 365 * 4)),
            NULL,
            TRUNC(DBMS_RANDOM.VALUE(1, (SELECT MAX(department_id) FROM department)))
        );
    END LOOP;

    FOR i IN 7..10000 LOOP
        INSERT INTO employee_project (
            employee_id,
            project_id
        )
        VALUES (
            i,
            TRUNC(DBMS_RANDOM.VALUE(1, (SELECT MAX(project_id)+1 FROM project)))
        );
    END LOOP;

    COMMIT;
END;
/
